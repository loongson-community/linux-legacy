/* $Id: mips.c,v 1.3 2004/07/01 13:47:55 fxzhang Exp $
 * MIPS performance-monitoring counters driver.
 *
 * Copyright (C) 2004 Fuxin Zhang 
 */
#include <linux/config.h>
#define __NO_VERSION__
#include <linux/module.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/fs.h>
#include <linux/perfctr.h>
#include <linux/seq_file.h>
#include <asm/time.h>		
#include <asm/perfctr.h>		

#include "compat.h"
#include "mips_compat.h"
#include "mips_tests.h"

/* Support for lazy evntsel and perfctr SPR updates. */
struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
	union {
		unsigned int id;	/* cache owner id */
	} k1;
	/* Physically indexed cache of the CR_PCs. */
	unsigned int cr_pc;
} ____cacheline_aligned;
static struct per_cpu_cache per_cpu_cache[NR_CPUS] __cacheline_aligned;

/* Structure for counter snapshots, as 32-bit values. */
struct perfctr_low_ctrs {
	unsigned int tsc;
	unsigned int pmc[NPERFCTRS];
};

static unsigned int new_id(void)
{
	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
	static unsigned int counter;
	int id;

	spin_lock(&lock);
	id = ++counter;
	spin_unlock(&lock);
	return id;
}

#if !defined(PERFCTR_INTERRUPT_SUPPORT)
#define perfctr_cstatus_has_ictrs(cstatus)	0
#endif

static inline void set_isuspend_cpu(struct perfctr_cpu_state *state,
				    const struct per_cpu_cache *cache) { }
static inline int is_isuspend_cpu(const struct perfctr_cpu_state *state,
				  const struct per_cpu_cache *cache) { return 1; }
static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state) { }

/****************************************************************
 *								*
 * Driver procedures.						*
 *								*
 ****************************************************************/

/*
 * The Godson2 family.
 *
 * Common features
 * ---------------
 * Godson2C Has two performance counter,access via CP0 $25 register(CR_PCHI).
 * and CP0 $24 register(CR_PCLO).
 * CR_PCHI register is orginized as the following:
 *    -----------------------------------
 *    |   0 |evnt1  |evnt0 |IE|K|S|U|EXL|
 *    -----------------------------------
 *     31    12    9 8   5 4  3 2 1  0
 *
 * CR_PCLO contains two 32bit counters:
 *    -----------------------------------
 *    |      counter1     |  counter0   |      
 *    -----------------------------------
 *    63               32  31          0
 * the counter overflows at when bit31==1 || bit63==1 and trigger IP6 interrupt if IE==1
 * four bit evnt field specifies which event to count:
 *   
 *
 * RM7000 famlily:
 *   CP0 $22: control,
 *      -------------------------------------------------------
 *      |            0              |CE |UM | KM | 0 | CSF    |
 *      -------------------------------------------------------
 *      31                        11 10  9    8   7 5 4      0
 *   CP0 $25: 32 bit rw counter
 *   
 *
 * Driver notes
 * ------------
 */

static inline unsigned int read_pmc(unsigned int pmc)
{
  unsigned int counter;
#ifdef CONFIG_GODSON_SIMOS
  if (pmc==0) {
  __asm__ volatile (
      "mfc0 %0,$23\n\t"
      :"=r"(counter));
  }else{
  __asm__ volatile (
      "mfc0 %0,$24\n\t"
      :"=r"(counter));
  }
#elif CONFIG_CPU_GODSON2B
  __asm__ volatile (
      ".set mips3\n\t"
      ".set noat\n\t"
      "dmfc0 $1,$25\n\t"
      "dsra %0,$1,32\n\t"
      ".set at\n\t"
      ".set mips0\n\t"
      :"=r"(counter)
      );
#elif CONFIG_CPU_RM7000
  __asm__ volatile (
      "mfc0 %0,$25\n\t"
      :"=r"(counter));
#else /* godson2C */
  if (pmc==0) {
  __asm__ volatile (
      ".set mips3\n\t"
      "dmfc0 %0,$25\n\t"
      ".set mips0\n\t"
      :"=r"(counter)
      );
  }else{
  __asm__ volatile (
      ".set mips3\n\t"
      "dmfc0 %0,$25\n\t"
      "dsra %0,32\n\t"
      ".set mips0\n\t"
      :"=r"(counter)
      );
  }
#endif
  return counter;
}

static inline void write_pmc(unsigned int pmc,unsigned int counter)
{
#ifdef CONFIG_GODSON_SIMOS
  if (pmc==0) {
  __asm__ volatile (
      "mtc0 %0,$23\n\t"
      ::"r"(counter));
  }else{
  __asm__ volatile (
      "mtc0 %0,$24\n\t"
      ::"r"(counter));
  }
#elif CONFIG_CPU_GODSON2B
  __asm__ volatile (
      ".set mips3\n\t"
      ".set noat\n\t"
      "dmfc0 $1,$25\n\t"
      "dsll $1,32\n\t"
      "dsrl $1,32\n\t"
      "dsll $2,%0,32\n\t"
      "or $2,$2,$1\n\t"
      "dmtc0 $2,$25\n\t"
      ".set at\n\t"
      ".set mips0\n\t"
      :"=r"(counter)
      ::"$2"
      );
#elif CONFIG_CPU_RM7000
  __asm__ volatile (
      "mtc0 %0,$25\n\t"
      ::"r"(counter));
#else
  unsigned long long tmp;
  if (pmc==0) {
  __asm__ volatile (
      ".set mips3\n\t"
      "dmfc0 %0,$25\n\t"
      "dsrl %0,32\n\t"
      "dsll %0,32\n\t"
      "dadd %0,%0,%1\n\t"
      "dmtc0 %0,$25\n\t"
      ".set mips0\n\t"
      :"=r"(tmp):"r"(counter),"0"(tmp)
  );
  }else{
  __asm__ volatile (
      ".set mips3\n\t"
      "dmfc0 %0,$25\n\t"
      "dsrl %0,32\n\t"
      "dsll %1,%1,32\n\t"
      "or %0,%0,%1\n\t"
      "dmtc0 %0,$25\n\t"
      ".set mips0\n\t"
      :"=r"(tmp):"r"(counter),"0"(tmp)
  );
  }
#endif
  return;
}

static inline void write_control(unsigned int pmc,unsigned int op)
{
  unsigned int counter;

#ifdef CONFIG_GODSON_SIMOS
  __asm__ volatile (
      "mtc0 %0,$25\n\t"::"r"(op)
      );
#elif CONFIG_CPU_GODSON2B
  __asm__ volatile (
      ".set mips3\n\t"
      ".set noat\n\t"
      "dmfc0 $1,$25\n\t"
      "dsrl $1,32\n\t"
      "dsll $1,32\n\t"
      "or $1,$1,%1\n\t"
      "dmtc0 $1,$25\n\t"
      ".set at\n\t"
      ".set mips0\n\t"
      :"=r"(counter)
      :"r"(op)
      );
#elif CONFIG_CPU_RM7000
  __asm__ volatile (
      "mtc0 %0,$22\n\t"::"r"(op)
    );
#else
  __asm__ volatile (
      "mtc0 %0,$24\n\t"::"r"(op)
    );
#endif
  return;
}

static void mips_read_counters(/*const*/ struct perfctr_cpu_state *state,
			      struct perfctr_low_ctrs *ctrs)
{
	unsigned int cstatus, nrctrs, i;

	cstatus = state->cstatus;
	if( perfctr_cstatus_has_tsc(cstatus) )
		ctrs->tsc = read_c0_count();
	nrctrs = perfctr_cstatus_nractrs(cstatus);
	for(i = 0; i < nrctrs; ++i) {
		unsigned int pmc = state->pmc[i].map;
		ctrs->pmc[i] = read_pmc(pmc);
	}
}

static unsigned int pmc_max_event(unsigned int pmc)
{
  return 16;
}

static unsigned int get_nr_pmcs(void)
{
	switch( perfctr_info.cpu_type) {
	default: /* impossible, but silences gcc warning */
	case PERFCTR_RM7000:
	case PERFCTR_GODSON2B:
		return 1;
	case PERFCTR_GODSON2C:
		return NPERFCTRS;
	}
}

static int mips_check_control(struct perfctr_cpu_state *state)
{
	unsigned int i, nractrs, nrctrs, pmc_mask, pmc;
	unsigned int nr_pmcs, evntsel[NPERFCTRS];

	nr_pmcs = get_nr_pmcs();
	nractrs = state->control.nractrs;
	nrctrs = nractrs + state->control.nrictrs;
	if( nractrs > nrctrs || nrctrs > nr_pmcs )
		return -EINVAL;

	pmc_mask = 0;
	memset(evntsel, 0, sizeof evntsel);
	for(i = 0; i < nrctrs; ++i) {
		pmc = state->control.pmc_map[i];
		state->pmc[i].map = pmc;
		if( pmc >= nr_pmcs || (pmc_mask & (1<<pmc)) )
			return -EINVAL;
		pmc_mask |= (1<<pmc);

		evntsel[pmc] = state->control.evntsel[i];
		if( evntsel[pmc] > pmc_max_event(pmc) )
			return -EINVAL;
	}
	
#ifndef CONFIG_CPU_RM7000
	/* ?? evntsel -> cr_pc */
	state->cr_pc = (state->control.cr_pc & 0x1f) |
	                               evntsel[0]<<5 |
	                               evntsel[1]<<9; 
#else
	state->cr_pc = (state->control.cr_pc & 0x700) |
	  			       evntsel[0] & 0x1f;
#endif

	state->k1.id = new_id();

	return 0;
}

#if PERFCTR_INTERRUPT_SUPPORT
static void mips_isuspend(struct perfctr_cpu_state *state)
{
	struct per_cpu_cache *cache;
	unsigned int cstatus, nrctrs, i;

	cache = &per_cpu_cache[smp_processor_id()];
	cstatus = state->cstatus;
	nrctrs = perfctr_cstatus_nrctrs(cstatus);
	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
		unsigned int pmc, now;
		pmc = state->pmc[i].map;
		write_control(pmc,0);
		now = read_pmc(pmc);
		state->pmc[i].sum += now - state->pmc[i].start;
		state->pmc[i].start = now;
	}
	/* cache->k1.id is still == state->k1.id */
	set_isuspend_cpu(state, cache);
}

static void mips_iresume(const struct perfctr_cpu_state *state)
{
	struct per_cpu_cache *cache;
	unsigned int cstatus, nrctrs, i;

	cache = &per_cpu_cache[smp_processor_id()];
	if( cache->k1.id == state->k1.id ) {
		cache->k1.id = 0; /* force reload of cleared EVNTSELs */
		if( is_isuspend_cpu(state, cache) )
			return; /* skip reload of PERFCTRs */
	}
	cstatus = state->cstatus;
	nrctrs = perfctr_cstatus_nrctrs(cstatus);
	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
		unsigned int pmc = state->pmc[i].map;
		write_pmc(pmc,state->pmc[pmc].start);
	}
	/* cache->k1.id remains != state->k1.id */
}
#endif

static void mips_write_control(const struct perfctr_cpu_state *state)
{
	struct per_cpu_cache *cache;
	unsigned int value;

	cache = &per_cpu_cache[smp_processor_id()];
	if( cache->k1.id == state->k1.id ) {
		//debug_evntsel_cache(state, cache);
		return;
	}
	value = state->cr_pc;
	if( value != cache->cr_pc ) {
		cache->cr_pc = value;
		write_control(0, value);
	}
	cache->k1.id = state->k1.id;
}

static void mips_clear_counters(void)
{
  int i;
  for (i=0;i<NPERFCTRS;i++) {
    write_pmc(i, 0);
    write_control(i, 0);
  }
}

/*
 * Driver methods, internal and exported.
 */

static void perfctr_cpu_write_control(const struct perfctr_cpu_state *state)
{
	return mips_write_control(state);
}

static void perfctr_cpu_read_counters(/*const*/ struct perfctr_cpu_state *state,
				      struct perfctr_low_ctrs *ctrs)
{
	return mips_read_counters(state, ctrs);
}

#if PERFCTR_INTERRUPT_SUPPORT
static void perfctr_cpu_isuspend(struct perfctr_cpu_state *state)
{
	return mips_isuspend(state);
}

static void perfctr_cpu_iresume(const struct perfctr_cpu_state *state)
{
	return mips_iresume(state);
}

/* Call perfctr_cpu_ireload() just before perfctr_cpu_resume() to
   bypass internal caching and force a reload if the I-mode PMCs. */
void perfctr_cpu_ireload(struct perfctr_cpu_state *state)
{
#ifdef CONFIG_SMP
	clear_isuspend_cpu(state);
#else
	per_cpu_cache[smp_processor_id()].k1.id = 0;
#endif
} 

/* godson2b overflows at counter==0xffffffff, we reserve <1M value
 * for overflow identify
 */
#define GODSON2B_COUNTER_THRESHHOLD 0x100000

/* PRE: the counters have been suspended and sampled by perfctr_cpu_suspend() */
unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state *state)
{
	unsigned int cstatus, nrctrs, pmc, pmc_mask;

	cstatus = state->cstatus;
	pmc = perfctr_cstatus_nractrs(cstatus);
	nrctrs = perfctr_cstatus_nrctrs(cstatus);

	for(pmc_mask = 0; pmc < nrctrs; ++pmc) {
#ifdef CONFIG_CPU_GODSON2B
		if( (unsigned int)state->pmc[pmc].start < GODSON2B_COUNTER_THRESHHOLD) {
			/* XXX: "+=" to correct for overshots */
			state->pmc[pmc].start = state->control.ireset[pmc];
			pmc_mask |= (1 << pmc);
		}
#else
		if( (int)state->pmc[pmc].start < 0) {
			/* XXX: "+=" to correct for overshots */
			state->pmc[pmc].start = state->control.ireset[pmc];
			pmc_mask |= (1 << pmc);
		}

#endif
	}
	return pmc_mask;
}

static inline int check_ireset(const struct perfctr_cpu_state *state)
{
	unsigned int nrctrs, i;

	i = state->control.nractrs;
	nrctrs = i + state->control.nrictrs;
	for(; i < nrctrs; ++i)
#ifdef CONFIG_CPU_GODSON2B
		if( (unsigned int)state->control.ireset[i] < GODSON2B_COUNTER_THRESHHOLD)
#else
		if( (int)state->control.ireset[i] < 0)
#endif
			return -EINVAL;
	return 0;
}

static inline void setup_imode_start_values(struct perfctr_cpu_state *state)
{
	unsigned int cstatus, nrctrs, i;

	cstatus = state->cstatus;
	nrctrs = perfctr_cstatus_nrctrs(cstatus);
	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
		state->pmc[i].start = state->control.ireset[i];
}

static inline void debug_no_imode(const struct perfctr_cpu_state *state)
{
#ifdef CONFIG_PERFCTR_DEBUG
	if( perfctr_cstatus_has_ictrs(state->cstatus) )
		printk(KERN_ERR "perfctr/%s: BUG! updating control in"
		       " perfctr %p on cpu %u while it has cstatus %x"
		       " (pid %d, comm %s)\n",
		       __FILE__, state, smp_processor_id(), state->cstatus,
		       current->pid, current->comm);
#endif
}

#else	/* PERFCTR_INTERRUPT_SUPPORT */
static inline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state) { }
static inline void perfctr_cpu_iresume(const struct perfctr_cpu_state *state) { }
static inline int check_ireset(const struct perfctr_cpu_state *state) { return 0; }
static inline void setup_imode_start_values(struct perfctr_cpu_state *state) { }
static inline void debug_no_imode(const struct perfctr_cpu_state *state) { }
#endif	/* PERFCTR_INTERRUPT_SUPPORT */

static int check_control(struct perfctr_cpu_state *state)
{
	return mips_check_control(state);
}

unsigned long last_interval;

int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global)
{
	int err;

	debug_no_imode(state);
	clear_isuspend_cpu(state);
	state->cstatus = 0;

	/* disallow i-mode counters if we cannot catch the interrupts */
	if( !(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
	    && state->control.nrictrs )
		return -EPERM;

	err = check_ireset(state);
	if( err < 0 )
		return err;
	err = check_control(state); /* may initialise state->cstatus */
	if( err < 0 )
		return err;
	state->cstatus |= perfctr_mk_cstatus(state->control.tsc_on,
					     state->control.nractrs,
					     state->control.nrictrs);
	setup_imode_start_values(state);

	/* for dumpping ipc of different period */
	last_interval = 1;

	return 0;
}

void perfctr_cpu_suspend(struct perfctr_cpu_state *state)
{
	unsigned int i, cstatus, nractrs;
	struct perfctr_low_ctrs now;

	if( perfctr_cstatus_has_ictrs(state->cstatus) )
	    perfctr_cpu_isuspend(state);
	perfctr_cpu_read_counters(state, &now);
	cstatus = state->cstatus;
	if( perfctr_cstatus_has_tsc(cstatus) )
		state->tsc_sum += now.tsc - state->tsc_start;
	nractrs = perfctr_cstatus_nractrs(cstatus);
	for(i = 0; i < nractrs; ++i)
		state->pmc[i].sum += now.pmc[i] - state->pmc[i].start;
}

void perfctr_cpu_resume(struct perfctr_cpu_state *state)
{
	if( perfctr_cstatus_has_ictrs(state->cstatus) )
	    perfctr_cpu_iresume(state);
	perfctr_cpu_write_control(state);
	//perfctr_cpu_read_counters(state, &state->start);
	{
		struct perfctr_low_ctrs now;
		unsigned int i, cstatus, nrctrs;
		perfctr_cpu_read_counters(state, &now);
		cstatus = state->cstatus;
		if( perfctr_cstatus_has_tsc(cstatus) )
			state->tsc_start = now.tsc;
		nrctrs = perfctr_cstatus_nractrs(cstatus);
		for(i = 0; i < nrctrs; ++i)
			state->pmc[i].start = now.pmc[i];
	}
	/* XXX: if (SMP && start.tsc == now.tsc) ++now.tsc; */
}

void perfctr_cpu_sample(struct perfctr_cpu_state *state)
{
	unsigned int i, cstatus, nractrs;
	struct perfctr_low_ctrs now;

	perfctr_cpu_read_counters(state, &now);
	cstatus = state->cstatus;


	if( perfctr_cstatus_has_tsc(cstatus) ) {
		state->tsc_sum += now.tsc - state->tsc_start;
		state->tsc_start = now.tsc;
	}
	nractrs = perfctr_cstatus_nractrs(cstatus);
	for(i = 0; i < nractrs; ++i) {
		state->pmc[i].sum += now.pmc[i] - state->pmc[i].start;
		state->pmc[i].start = now.pmc[i];
	}

#if 0
	/* for dumpping ipc, must be counting committed instr. 
	 * a message is dump every 100M committed instruction
	 * count CANNOT increase more than 100M between each sample!
	 *
	 * we have no easy way to count other measures every 100M inst.
	 * so we use every 100M cycle instead
	 */
	if (state->pmc[0].sum > last_interval * 0x5f50000ULL) {
	//if (state->tsc_sum > last_interval * 50000000ULL) {
	  last_interval ++;
	  printk(KERN_INFO "cycl=%lld pmc=%lld\n",state->tsc_sum, state->pmc[0].sum);
	}
#endif
}

static void perfctr_cpu_clear_counters(void)
{
	struct per_cpu_cache *cache;

	cache = &per_cpu_cache[smp_processor_id()];
	memset(cache, 0, sizeof *cache);
	cache->k1.id = -1;

	mips_clear_counters();
}

/****************************************************************
 *								*
 * Processor detection and initialisation procedures.		*
 *								*
 ****************************************************************/

static int __init generic_init(void)
{
	static char generic_name[] __initdata = "Godson-2";
	unsigned int features;

	features = PERFCTR_FEATURE_RDTSC | PERFCTR_FEATURE_RDPMC | PERFCTR_FEATURE_PCINT;
	perfctr_info.cpu_features = features;
#ifdef CONFIG_CPU_GODSON2B
	perfctr_info.cpu_type = PERFCTR_GODSON2B;
#elif CONFIG_CPU_RM7000
	perfctr_info.cpu_type = PERFCTR_RM7000;
#else
	perfctr_info.cpu_type = PERFCTR_GODSON2C;
#endif
	perfctr_cpu_name = generic_name;
	perfctr_info.cpu_khz = mips_hpt_frequency / 1000 * 2;
	perfctr_info.tsc_to_cpu_mult = 2;
#ifdef CONFIG_PERFCTR_INIT_TESTS
	perfctr_mips_init_tests();
#endif
	return 0;
}

static void __init perfctr_cpu_init_one(void *ignore)
{
	/* PREEMPT note: when called via smp_call_function(),
	   this is in IRQ context with preemption disabled. */
	perfctr_cpu_clear_counters();
}

static void __exit perfctr_cpu_exit_one(void *ignore)
{
	/* PREEMPT note: when called via smp_call_function(),
	   this is in IRQ context with preemption disabled. */
	perfctr_cpu_clear_counters();
}

#if PERFCTR_INTERRUPT_SUPPORT
void perfctr_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	do_perfctr_interrupt(regs);
}
#endif

int __init perfctr_cpu_init(void)
{
	int err;

	preempt_disable();

	perfctr_info.cpu_features = 0;

	err = generic_init();
	if( err )
		goto out;

	perfctr_cpu_init_one(NULL);
	smp_call_function(perfctr_cpu_init_one, NULL, 1, 1);
	perfctr_cpu_set_ihandler(NULL);


#if PERFCTR_INTERRUPT_SUPPORT

#ifdef CONFIG_CPU_GODSON2B
	/* hw5. shared with timer irq */
	err = request_irq(27,perfctr_interrupt,SA_SHIRQ,"perfctr",&perfctr_interrupt);
#elif CONFIG_CPU_RM7000
	/* hw3. */
	err = request_irq(25,perfctr_interrupt,SA_SHIRQ,"perfctr",&perfctr_interrupt);
#else
	/* hw4. may shared with serial */
	err = request_irq(26,perfctr_interrupt,SA_SHIRQ,"perfctr",&perfctr_interrupt);
#endif
	if (err) {
		printk("PERFCTR:Error request irq!\n");
	}
#endif

 out:
	preempt_enable();
	return err;
}

void __exit perfctr_cpu_exit(void)
{
	preempt_disable();
	perfctr_cpu_exit_one(NULL);
	smp_call_function(perfctr_cpu_exit_one, NULL, 1, 1);
	perfctr_cpu_set_ihandler(NULL);
	preempt_enable();
}

/****************************************************************
 *								*
 * Hardware reservation.					*
 *								*
 ****************************************************************/

static const char *current_service = 0;

const char *perfctr_cpu_reserve(const char *service)
{
	if( current_service )
		return current_service;
	current_service = service;
	__module_get(THIS_MODULE);
	return 0;
}

static void perfctr_cpu_clear_one(void *ignore)
{
	/* PREEMPT note: when called via smp_call_function(),
	   this is in IRQ context with preemption disabled. */
	perfctr_cpu_clear_counters();
}

void perfctr_cpu_release(const char *service)
{
	if( service != current_service ) {
		printk(KERN_ERR "%s: attempt by %s to release while reserved by %s\n",
		       __FUNCTION__, service, current_service);
	} else {
		/* power down the counters */
		on_each_cpu(perfctr_cpu_clear_one, NULL, 1, 1);
		perfctr_cpu_set_ihandler(NULL);
		current_service = 0;
		module_put(THIS_MODULE);
	}
}
