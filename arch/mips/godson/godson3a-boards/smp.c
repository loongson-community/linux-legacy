/*
 * Copyright (C) 2001 Broadcom Corporation
 * Copyright (C) 2004  Maciej W. Rozycki
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

#include <linux/init.h>
#include <linux/delay.h>
#include <linux/smp.h>
#include <linux/kernel_stat.h>

#include <asm/mmu_context.h>

#include "smp.h"
extern int ls3a_ht_int_cpumask[4];
extern void smp_call_function_interrupt(void);

/*
 * These are routines for dealing with the sb1250 smp capabilities
 * independent of board/firmware
 */


void *mailbox_set0_regs[16];		// addr for core_set0 reg,
void *mailbox_clear0_regs[16];		// addr for core_set0 reg,
void *mailbox_regs0[16];		// addr for core_set0 reg,
void *mailbox_en0_regs[16];		// addr for core_set0 reg,
void *mailbox_buf[16];		// addr for core_set0 reg,

void loongson3_raw_writeq(unsigned long action, void * addr)   // write a value to mem
{		// the value is action
	if(((long)addr&0xff)<0x20)
		*((unsigned int *)addr) = action;
	else
		*((unsigned long *)addr) = action;

	__asm__ __volatile__ (
			".set noreorder		\n"
			".set noat		\n"
			"lw $at, %0		\n"
			".set at		\n"
			".set reorder		\n"
			:
			:"m"(*addr)
			);
};

unsigned long loongson3_raw_readq(void * addr)		// read a value from mem
		{
	if(((long)addr&0xff)<0x20)
		return *((unsigned int *)addr);		// the value will be return
	else
		return *((unsigned long *)addr);		// the value will be return
};

void mailbox_set0_regs_init (void){		// addr for core_set0 reg,
	mailbox_set0_regs[0] = (void *)core0_SET0;		// which is a 32 bit reg
	mailbox_set0_regs[1] = (void *)core1_SET0;		// When the bit of core_set0 is 1,
	mailbox_set0_regs[2] = (void *)core2_SET0;		// the bit of core_status0 become 1
	mailbox_set0_regs[3] = (void *)core3_SET0;		// immediately
	mailbox_set0_regs[4] = (void *)core4_SET0;		// which is a 32 bit reg
	mailbox_set0_regs[5] = (void *)core5_SET0;		// When the bit of core_set0 is 1,
	mailbox_set0_regs[6] = (void *)core6_SET0;		// the bit of core_status0 become 1
	mailbox_set0_regs[7] = (void *)core7_SET0;		// immediately
	mailbox_set0_regs[8] = (void *)core8_SET0;		// which is a 32 bit reg
	mailbox_set0_regs[9] = (void *)core9_SET0;		// When the bit of core_set0 is 1
	mailbox_set0_regs[10] = (void *)coreA_SET0;		// the bit of core_status0 become 1
	mailbox_set0_regs[11] = (void *)coreB_SET0;		// immediately
	mailbox_set0_regs[12] = (void *)coreC_SET0;		// which is a 32 bit reg
	mailbox_set0_regs[13] = (void *)coreD_SET0;		// When the bit of core_set0 is 1
	mailbox_set0_regs[14] = (void *)coreE_SET0;		// the bit of core_status0 become 1
	mailbox_set0_regs[15] = (void *)coreF_SET0;		// immediately
}

void mailbox_clear0_regs_init (void){		// addr for core_clear0 reg,
	mailbox_clear0_regs[0] = (void *)core0_CLEAR0;		// which is a 32 bit reg
	mailbox_clear0_regs[1] = (void *)core1_CLEAR0;		// When the bit of core_clear0 is 1,
	mailbox_clear0_regs[2] = (void *)core2_CLEAR0;		// the bit of core_status0 become 0
	mailbox_clear0_regs[3] = (void *)core3_CLEAR0;		// immediately
	mailbox_clear0_regs[4] = (void *)core4_CLEAR0;		// which is a 32 bit reg
	mailbox_clear0_regs[5] = (void *)core5_CLEAR0;		// When the bit of core_clear0 is 1,
	mailbox_clear0_regs[6] = (void *)core6_CLEAR0;		// the bit of core_status0 become 0
	mailbox_clear0_regs[7] = (void *)core7_CLEAR0;		// immediately
	mailbox_clear0_regs[8] = (void *)core8_CLEAR0;		// which is a 32 bit reg
	mailbox_clear0_regs[9] = (void *)core9_CLEAR0;		// When the bit of core_clear0 is 1,
	mailbox_clear0_regs[10] = (void *)coreA_CLEAR0;		// the bit of core_status0 become 0
	mailbox_clear0_regs[11] = (void *)coreB_CLEAR0;		// immediately
	mailbox_clear0_regs[12] = (void *)coreC_CLEAR0;		// which is a 32 bit reg
	mailbox_clear0_regs[13] = (void *)coreD_CLEAR0;		// When the bit of core_clear0 is 1,
	mailbox_clear0_regs[14] = (void *)coreE_CLEAR0;		// the bit of core_status0 become 0
	mailbox_clear0_regs[15] = (void *)coreF_CLEAR0;		//immediately
}

void mailbox_regs0_init (void) {		// addr for core_status0 reg
	mailbox_regs0[0] = (void *)core0_STATUS0;		// which is a 32 bit reg
	mailbox_regs0[1] = (void *)core1_STATUS0;		// the reg is read only
	mailbox_regs0[2] = (void *)core2_STATUS0;
	mailbox_regs0[3] = (void *)core3_STATUS0;
	mailbox_regs0[4] = (void *)core4_STATUS0;		// which is a 32 bit reg
	mailbox_regs0[5] = (void *)core5_STATUS0;		// the reg is read only
	mailbox_regs0[6] = (void *)core6_STATUS0		;
	mailbox_regs0[7] = (void *)core7_STATUS0		;
	mailbox_regs0[8] = (void *)core8_STATUS0;		// which is a 32 bit reg
	mailbox_regs0[9] = (void *)core9_STATUS0;		// the reg is read only
	mailbox_regs0[10] = (void *)coreA_STATUS0		;
	mailbox_regs0[11] = (void *)coreB_STATUS0		;
	mailbox_regs0[12] = (void *)coreC_STATUS0;		// which is a 32 bit reg
	mailbox_regs0[13] = (void *)coreD_STATUS0;		// the reg is read only
	mailbox_regs0[14] = (void *)coreE_STATUS0;
	mailbox_regs0[15] = (void *)coreF_STATUS0;
}

void mailbox_en0_regs_init (void) {		// addr for core_set0 reg,
	mailbox_en0_regs[0] = (void *)core0_EN0;		// which is a 32 bit reg
	mailbox_en0_regs[1]	= (void *)core1_EN0;		// When the bit of core_set0 is 1,
	mailbox_en0_regs[2] = (void *)core2_EN0;		// the bit of core_status0 become 1
	mailbox_en0_regs[3] = (void *)core3_EN0;		// immediately
	mailbox_en0_regs[4] = (void *)core4_EN0;		// which is a 32 bit reg
	mailbox_en0_regs[5] = (void *)core5_EN0;		// When the bit of core_set0 is 1,
	mailbox_en0_regs[6] = (void *)core6_EN0;		// the bit of core_status0 become 1
	mailbox_en0_regs[7] = (void *)core7_EN0;		// immediately
	mailbox_en0_regs[8] = (void *)core8_EN0;		// which is a 32 bit reg
	mailbox_en0_regs[9] = (void *)core9_EN0;		// When the bit of core_set0 is 1,
	mailbox_en0_regs[10] = (void *)coreA_EN0;		// the bit of core_status0 become 1
	mailbox_en0_regs[11] = (void *)coreB_EN0;		// immediately
	mailbox_en0_regs[12] = (void *)coreC_EN0;		// which is a 32 bit reg
	mailbox_en0_regs[13] = (void *)coreD_EN0;		// When the bit of core_set0 is 1,
	mailbox_en0_regs[14] = (void *)coreE_EN0;		// the bit of core_status0 become 1
	mailbox_en0_regs[15] = (void *)coreF_EN0;		// immediately
}


void mailbox_buf_init (void) {		// addr for core_buf regs
	mailbox_buf[0] = (void *)core0_BUF;		// a group of regs with 0x40 byte size
	mailbox_buf[1] = (void *)core1_BUF;		// which could be used for
	mailbox_buf[2] = (void *)core2_BUF;		// transfer args , r/w , uncached
	mailbox_buf[3] = (void *)core3_BUF;
	mailbox_buf[4] = (void *)core4_BUF;		// a group of regs with 0x40 byte size
	mailbox_buf[5] = (void *)core5_BUF;		// which could be used for
	mailbox_buf[6] = (void *)core6_BUF;		// transfer args , r/w , uncached
	mailbox_buf[7] = (void *)core7_BUF;
	mailbox_buf[8] = (void *)core8_BUF;		// a group of regs with 0x40 byte size
	mailbox_buf[9] = (void *)core9_BUF;		// which could be used for
	mailbox_buf[10] = (void *)coreA_BUF;		// transfer args , r/w , uncached
	mailbox_buf[11] = (void *)coreB_BUF;
	mailbox_buf[12] = (void *)coreC_BUF;		// a group of regs with 0x40 byte size
	mailbox_buf[13] = (void *)coreD_BUF;		// which could be used for
	mailbox_buf[14] = (void *)coreE_BUF;		// transfer args , r/w , uncached
	mailbox_buf[15] = (void *)coreF_BUF;
}

/*
 * SMP init and finish on secondary CPUs
 */
void loongson3_smp_init(void)
{
	unsigned int imask = STATUSF_IP7 | STATUSF_IP6 | STATUSF_IP5 |
				STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 ;
	int i;

	mailbox_en0_regs_init();
	mailbox_set0_regs_init();
	mailbox_regs0_init();
	mailbox_clear0_regs_init();
	/* Set interrupt mask, but don't enable */
	change_c0_status(ST0_IM, imask);

#if 1 /* gx */
	printk("\n CPU#%d call smp_init!!!! \n", smp_processor_id());
	for (i = 0; i < nr_cpu_loongson; i++) {
		loongson3_raw_writeq(0xffffffff, mailbox_en0_regs[i]);
	}
	printk("\n CPU#%d done smp_init en=%x!!!! \n", smp_processor_id(),
			*(int *)(mailbox_en0_regs[smp_processor_id()]));
#endif
}

void loongson3_smp_finish(void)
{
	int tmp;
	int cpu = smp_processor_id();

	tmp = (read_c0_count() + 1000000);
	write_c0_compare(tmp);
	local_irq_enable();
	ls3a_ht_int_cpumask[0] &= ~ls3a_ht_int_cpumask[cpu];
	printk("\n %s, CPU#%d CP0_ST=%x\n", __FUNCTION__, smp_processor_id(), read_c0_status());
}

static void loongson3_send_ipi_single(int cpu, unsigned int action)
{
#if 0 /* gx */
	prom_printf("---cpu=%d, action=0x%lx\n", cpu, action);
	dump_stack();
#endif
	//mailbox_set0_regs_init();
	loongson3_raw_writeq((((u64)action)), mailbox_set0_regs[cpu]);
}

/*
 * Simple enough; everything is set up, so just poke the appropriate mailbox
 * register, and we should be set
 */
void core_send_ipi(int cpu, unsigned int action)
{
	loongson3_send_ipi_single(cpu, action);
}


void loongson3_ipi_interrupt(struct pt_regs *regs)
{

	int cpu = smp_processor_id();
	unsigned int action;
	unsigned int irqs;

	/* Load the mailbox register to figure out what we're supposed to do */
	action = loongson3_raw_readq(mailbox_regs0[cpu]);
	irqs = action >> 4;

	/* Clear the mailbox to clear the interrupt */
	loongson3_raw_writeq((u64)action,mailbox_clear0_regs[cpu]);

	/*
	 * Nothing to do for SMP_RESCHEDULE_YOURSELF; returning from the
	 * interrupt will do the reschedule for us
	 */
#if 0 /* gx */
	if (action & SMP_CALL_FUNCTION)
	prom_printf("cpu#%d IPI action =%x\n", smp_processor_id(), action);
#endif

	if (action & SMP_CALL_FUNCTION) {
		smp_call_function_interrupt();
	}

	if (irqs) {
		do_sb_bal_irq(irqs);
	}
#if 0 /* gx for time */
{
extern unsigned int abscount;
          if(!cpu) {
	   if (action & 0x4)  abscount = read_c0_count();
	    //while(1) printk("abscount=%u\n");
	  }
}
#endif
}


int loongson3_cpu_start(int cpu, void(*fn)(void), long sp, long gp, long a1)
{
	int res;
	volatile unsigned long long startargs[4];

	startargs[0] = (long)fn;
	startargs[1] = sp;
	startargs[2] = gp;
	startargs[3] = a1;

	mailbox_buf_init();
#if 1
	prom_printf("\n writeq buf is begin ! \n");
	prom_printf("\n CPU#%d mailbox_buf=%p ! \n", cpu, mailbox_buf[cpu]);
	prom_printf("fn=%p\n", fn);
	prom_printf("sp=%lx\n", sp);
	prom_printf("gp=%lx\n", gp);
	prom_printf("a1=%lx\n", a1);
#endif

	loongson3_raw_writeq(startargs[3], mailbox_buf[cpu]+0x18);
	loongson3_raw_writeq(startargs[2], mailbox_buf[cpu]+0x10);
	loongson3_raw_writeq(startargs[1], mailbox_buf[cpu]+0x8);
	loongson3_raw_writeq(startargs[0], mailbox_buf[cpu]+0x0);

#if 1
	prom_printf("\n readbackbuf is begin! \n");
	prom_printf("fn=%p\n", *((unsigned int *)(mailbox_buf[cpu]+0x0)));
	prom_printf("sp=%lx\n", *((unsigned int *)(mailbox_buf[cpu]+0x8)));
	prom_printf("gp=%lx\n", *((unsigned int *)(mailbox_buf[cpu]+0x10)));
	prom_printf("a1=%lx\n", *((unsigned int *)(mailbox_buf[cpu]+0x18)));
#endif
	res = 0;

	return res;
}

extern atomic_t cpus_booted;
extern atomic_t smp_commenced;

/*
 * Hook for doing final board-specific setup after the generic smp setup
 * is done
 */
asmlinkage void start_secondary(void)
{
	unsigned int cpu = smp_processor_id();

	cpu_probe();
	prom_init_secondary();
	per_cpu_trap_init();

	/*
	 * XXX parity protection should be folded in here when it's converted
	 * to an option instead of something based on .cputype
	 */
	pgd_current[cpu] = init_mm.pgd;
	cpu_data[cpu].udelay_val = loops_per_jiffy;
	prom_smp_finish();
	printk("Slave cpu booted successfully\n");
	CPUMASK_SETB(cpu_online_map, cpu);
	atomic_inc(&cpus_booted);
	while (!atomic_read(&smp_commenced));
	cpu_idle();
}

void __init smp_boot_cpus(void)
{
	int i;
	int cur_cpu = 0;

	smp_num_cpus = prom_setup_smp();
	init_new_context(current, &init_mm);
	current->processor = 0;
	cpu_data[0].udelay_val = loops_per_jiffy;
	cpu_data[0].asid_cache = ASID_FIRST_VERSION;
	CPUMASK_CLRALL(cpu_online_map);
	CPUMASK_SETB(cpu_online_map, 0);
	atomic_set(&cpus_booted, 1);  /* Master CPU is already booted... */
	init_idle();
	__cpu_number_map[0] = 0;
	__cpu_logical_map[0] = 0;
	/* smp_tune_scheduling();  XXX */

	/*
	 * This loop attempts to compensate for "holes" in the CPU
	 * numbering.  It's overkill, but general.
	 */
	for (i = 1; i < smp_num_cpus && cur_cpu < NR_CPUS; i++) {
		struct task_struct *p;
		struct pt_regs regs;
		printk("Starting CPU %d...\n", i);

		/* Spawn a new process normally.  Grab a pointer to
		   its task struct so we can mess with it */
		do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
		p = init_task.prev_task;

		/* Schedule the first task manually */
		p->processor = i;
		p->cpus_runnable = 1 << i; /* we schedule the first task manually */

		init_tasks[i] = p;

		del_from_runqueue(p);
		unhash_process(p);

		do {
			int status;

			/* Iterate until we find a CPU that comes up */
			cur_cpu++;
			status = prom_boot_secondary(cur_cpu,
						    (unsigned long)p +
						    KERNEL_STACK_SIZE - 32,
						    (unsigned long)p);
			if (status == 0) {
				__cpu_number_map[cur_cpu] = i;
				__cpu_logical_map[i] = cur_cpu;
				break;
			}
		} while (cur_cpu < NR_CPUS);
	}

	/* Wait for everyone to come up */
	while (atomic_read(&cpus_booted) != smp_num_cpus);
	smp_threads_ready = 1;
}

/* Boot all other cpus in the system, initialize them, and
   bring them into the boot fn */
int prom_boot_secondary(int cpu, unsigned long sp, unsigned long gp)
{
	int retval;
	
	retval = loongson3_cpu_start(cpu, smp_bootstrap, sp, gp, 0);
	if (retval != 0) {
		printk("cfe_start_cpu(%i) returned %i\n" , cpu, retval);
	}

	return retval;
}

void prom_init_secondary(void)
{
	extern void load_mmu(void);
	unsigned int imask = STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 |
		STATUSF_IP1 | STATUSF_IP0;

	/* cache and TLB setup */
	load_mmu();

	/* Enable basic interrupts */
	change_c0_status(ST0_IM, imask);
	set_c0_status(ST0_IE);
	loongson3_smp_init();
}

/*
 * Set up state, return the total number of cpus in the system, including
 * the master
 */
int prom_setup_smp(void)
{
	int i;
	int num_cpus = 1;

	/* Use CFE to find out how many CPUs are available */
	for (i=1; i<NR_CPUS; i++) {
		if (cfe_cpu_stop(i) == 0) {
			num_cpus++;
		}
	}
	printk("Detected %i available CPU(s)\n", num_cpus);
	return num_cpus;
}

void prom_smp_finish(void)
{
	loongson3_smp_finish();
}
