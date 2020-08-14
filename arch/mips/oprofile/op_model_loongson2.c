/*
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
 */
#include <linux/init.h>
#include <linux/oprofile.h>
#include <linux/interrupt.h>
#include <linux/smp.h>
#include <linux/spinlock.h>
#include <linux/proc_fs.h>
#include <asm/uaccess.h>

#include <irq.h>
#include "op_impl.h"

#define PERF_IRQ (MIPS_CPU_IRQ_BASE + 6 )

#define LOONGSON_COUNTER1_EVENT(event)	((event&0x0f) << 5)
#define LOONGSON_COUNTER1_SUPERVISOR	(1UL    <<  2)
#define LOONGSON_COUNTER1_KERNEL		(1UL    <<  1)
#define LOONGSON_COUNTER1_USER		(1UL    <<  3)
#define LOONGSON_COUNTER1_ENABLE		(1UL    << 4)
#define LOONGSON_COUNTER1_OVERFLOW	(1ULL    << 31)
#define LOONGSON_COUNTER1_EXL			(1UL	<< 0)

#define LOONGSON_COUNTER2_EVENT(event)	((event&0x0f) << 9)
#define LOONGSON_COUNTER2_SUPERVISOR	LOONGSON_COUNTER1_SUPERVISOR
#define LOONGSON_COUNTER2_KERNEL		LOONGSON_COUNTER1_KERNEL
#define LOONGSON_COUNTER2_USER		LOONGSON_COUNTER1_USER
#define LOONGSON_COUNTER2_ENABLE		LOONGSON_COUNTER1_ENABLE
#define LOONGSON_COUNTER2_OVERFLOW	(1ULL   << 31)
#define LOONGSON_COUNTER2_EXL			(1UL	<< 0 )
#define LOONGSON_COUNTER_EXL		    (1UL << 0)	

/* Loongson2 PerfCount performance counter register */
#define read_c0_perflo() __read_64bit_c0_register($24, 0)
#define write_c0_perflo(val) __write_64bit_c0_register($24, 0, val)
#define read_c0_perfhi() __read_64bit_c0_register($25, 0)
#define write_c0_perfhi(val) __write_64bit_c0_register($25, 0, val)

extern unsigned int loongson2_perfcount_irq;

static struct loongson2_register_config {
	unsigned int control;
	unsigned long long reset_counter1;
	unsigned long long reset_counter2;
	int ctr1_enable, ctr2_enable;
} reg;

#if 0
unsigned long ctr3_enable, ctr3_count;
#endif

DEFINE_SPINLOCK(sample_lock);

static char *oprofid = "LoongsonPerf";
static irqreturn_t loongson2_perfcount_handler(int irq, void * dev_id);
/* Compute all of the registers in preparation for enabling profiling.  */

static void loongson2_reg_setup(struct op_counter_config *ctr)
{
	unsigned int control = 0;

	reg.reset_counter1 = 0;
	reg.reset_counter2 = 0;
	/* Compute the performance counter control word.  */
	/* For now count kernel and user mode */
	if (ctr[0].enabled){
		control |= LOONGSON_COUNTER1_EVENT(ctr[0].event) |
					LOONGSON_COUNTER1_ENABLE;
		if(ctr[0].kernel)
			control |= LOONGSON_COUNTER1_KERNEL;
		if(ctr[0].user)
			control |= LOONGSON_COUNTER1_USER;
		reg.reset_counter1 = 0x80000000ULL - ctr[0].count;
	}

	if (ctr[1].enabled){
		control |= LOONGSON_COUNTER2_EVENT(ctr[1].event) |
		           LOONGSON_COUNTER2_ENABLE;
		if(ctr[1].kernel)
			control |= LOONGSON_COUNTER2_KERNEL;
		if(ctr[1].user)
			control |= LOONGSON_COUNTER2_USER;
		reg.reset_counter2 = (0x80000000ULL- ctr[1].count) ;
	}

	if(ctr[0].enabled ||ctr[1].enabled)
		control |= LOONGSON_COUNTER_EXL;

#if 0
	if(ctr[2].enabled){
		ctr3_enable = 1;
		ctr3_count = ctr[2].count;
	}
#endif

	reg.control = control;

	reg.ctr1_enable = ctr[0].enabled;
	reg.ctr2_enable = ctr[1].enabled;

}

/* Program all of the registers in preparation for enabling profiling.  */

static void loongson2_cpu_setup (void *args)
{
	uint64_t perfcount;

	perfcount = (reg.reset_counter2 << 32) |reg.reset_counter1; 
	write_c0_perfhi(perfcount);
}

static void loongson2_cpu_start(void *args)
{
	/* Start all counters on current CPU */
	if(reg.ctr1_enable || reg.ctr2_enable) {
		write_c0_perflo(reg.control);
	}
}

static void loongson2_cpu_stop(void *args)
{
	/* Stop all counters on current CPU */
	//ctr3_enable = 0;
	write_c0_perflo(0);
	memset(&reg, 0, sizeof(reg));
}

static irqreturn_t loongson2_perfcount_handler(int irq, void * dev_id)
{
	uint64_t counter, counter1, counter2;
	struct pt_regs *regs = get_irq_regs();
	int enabled;
	unsigned long flags;
	
	/*
	 * LOONGSON2 defines two 32-bit performance counters.
	 * To avoid a race updating the registers we need to stop the counters 
	 * while we're messing with
	 * them ...
	 */
	
	/* Check whether the irq belongs to me*/
	enabled = reg.ctr1_enable| reg.ctr2_enable;
	if(!enabled){
		return IRQ_NONE;
	}

	counter = read_c0_perfhi();
	counter1 = counter & 0xffffffff;
	counter2 = counter >> 32;

	spin_lock_irqsave(&sample_lock, flags);

	if (counter1 & LOONGSON_COUNTER1_OVERFLOW) {
		if(reg.ctr1_enable) 
			oprofile_add_sample(regs, 0);
		counter1 = reg.reset_counter1;
	}
	if (counter2 & LOONGSON_COUNTER2_OVERFLOW) {
		if(reg.ctr2_enable)
			oprofile_add_sample(regs, 1);
		counter2 = reg.reset_counter2;
	}

	spin_unlock_irqrestore(&sample_lock, flags);

	write_c0_perfhi((counter2 << 32) | counter1);

	return IRQ_HANDLED;
}

static int __init loongson2_init(void)
{
	return  request_irq(PERF_IRQ, loongson2_perfcount_handler,
	                   IRQF_SHARED, "Perfcounter", oprofid);
}

static void loongson2_exit(void)
{
	free_irq(PERF_IRQ, oprofid);
}

struct op_mips_model op_model_loongson2_ops = {
	.reg_setup	= loongson2_reg_setup,
	.cpu_setup	= loongson2_cpu_setup,
	.init		= loongson2_init,	
	.exit		= loongson2_exit,
	.cpu_start	= loongson2_cpu_start,
	.cpu_stop	= loongson2_cpu_stop,
	.cpu_type	= "mips/loongson2",
	.num_counters	= 2
};
