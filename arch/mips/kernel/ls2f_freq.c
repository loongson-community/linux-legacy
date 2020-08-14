/*
 * arch/mips/kernel/cpufreq.c
 *
 * cpufreq driver for the loongson-2f processors.
 *
 * Copyright (C) 2006 - 2008 Yanhua
 *
 *
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 */
#include <linux/types.h>
#include <linux/cpufreq.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/err.h>
#include <linux/cpumask.h>
#include <linux/smp.h>
#include <linux/sched.h>	/* set_cpus_allowed() */
#include <linux/clk.h>
#include <linux/delay.h>
#include <asm/delay.h>

#include <asm/clock.h>

static uint nowait = 0;

static struct clk *cpuclk;
extern unsigned long cpu_clock_freq;
extern struct cpufreq_frequency_table ls2f_clockmod_table[];

extern void (*cpu_wait)(void);
extern void ls2f_cpu_wait(void);
static void (*saved_cpu_wait)(void);

static int
ls2f_cpu_freq_notifier(struct notifier_block *nb, unsigned long val,
	void *data);

static struct notifier_block ls2f_cpufreq_notifier_block = {
	.notifier_call = ls2f_cpu_freq_notifier
};

static int
ls2f_cpu_freq_notifier(struct notifier_block *nb, unsigned long val, void *data)
{
	if (val == CPUFREQ_POSTCHANGE) {
		__udelay_val = loops_per_jiffy;
	}
	return 0;
}

static unsigned int ls2f_cpufreq_get(unsigned int cpu)
{
	return clk_get_rate(cpuclk);
}

/*
 * Here we notify other drivers of the proposed change and the final change.
 */
static int ls2f_cpufreq_target(struct cpufreq_policy *policy,
			     unsigned int target_freq,
			     unsigned int relation)
{
	unsigned int cpu = policy->cpu;
	unsigned int newstate = 0;
	cpumask_t cpus_allowed;
	struct cpufreq_freqs freqs;
	long freq;

	if (!cpu_online(cpu))
		return -ENODEV;

	cpus_allowed = current->cpus_allowed;
	set_cpus_allowed(current, cpumask_of_cpu(cpu));

#ifdef CONFIG_SMP
	BUG_ON(smp_processor_id() != cpu);
#endif

	if (cpufreq_frequency_table_target(policy, &ls2f_clockmod_table[0], target_freq, relation, &newstate))
		return -EINVAL;

	freq = cpu_clock_freq / 1000 * ls2f_clockmod_table[newstate].index / 8;
	if (freq < policy->min || freq > policy->max )
		return -EINVAL;

	pr_debug("cpufreq: requested frequency %u Hz\n", target_freq * 1000);

	freqs.cpu	= cpu;
	freqs.old	= ls2f_cpufreq_get(cpu);
	freqs.new	= freq;
	freqs.flags	= 0;

	if (freqs.new == freqs.old)
		return 0;

	/* notifiers */
	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);

	set_cpus_allowed(current, cpus_allowed);

	/* setting the cpu frequency */
	clk_set_rate(cpuclk, freq);

	/* notifiers */
	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);

	pr_debug("cpufreq: set frequency %lu kHz\n", freq);

	return 0;
}

static int ls2f_cpufreq_cpu_init(struct cpufreq_policy *policy)
{
	int i;
	int result;

	if (!cpu_online(policy->cpu))
		return -ENODEV;

	cpuclk = clk_get(NULL, "cpu_clk");
	if (IS_ERR(cpuclk)) {
		printk(KERN_ERR "cpufreq: couldn't get CPU clk\n");
		return PTR_ERR(cpuclk);
	}
	
	cpuclk->rate = cpu_clock_freq / 1000;
	if(!cpuclk->rate)
		return -EINVAL;

	/* clock table init */
	for (i=2; (ls2f_clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
		ls2f_clockmod_table[i].frequency = (cpuclk->rate * i)/8;
	}

	policy->cur	= ls2f_cpufreq_get(policy->cpu);

	cpufreq_frequency_table_get_attr(&ls2f_clockmod_table[0], policy->cpu);

	result = cpufreq_frequency_table_cpuinfo(policy, &ls2f_clockmod_table[0]);
	if (result)
		return (result);

	return 0;
}

static int ls2f_cpufreq_verify(struct cpufreq_policy *policy)
{
	return cpufreq_frequency_table_verify(policy, &ls2f_clockmod_table[0]);
}

static int ls2f_cpufreq_exit(struct cpufreq_policy *policy)
{
	clk_put(cpuclk);
	return 0;
}

static struct freq_attr* ls2f_table_attr[] = {
	&cpufreq_freq_attr_scaling_available_freqs,
	NULL,
};

static struct cpufreq_driver ls2f_cpufreq_driver = {
	.owner		= THIS_MODULE,
	.name		= "ls2f",
	.init		= ls2f_cpufreq_cpu_init,
	.verify		= ls2f_cpufreq_verify,
	.target		= ls2f_cpufreq_target,
	.get		= ls2f_cpufreq_get,
	.exit		= ls2f_cpufreq_exit,
	.attr		= ls2f_table_attr,
};

static int __init ls2f_cpufreq_module_init(void)
{
	struct cpuinfo_mips *c = &cpu_data[0];
	int result;
	
	if (c->processor_id != 0x6303)
		return -ENODEV;

	printk(KERN_INFO "cpufreq: Loongson-2F CPU frequency driver.\n");
	result =  cpufreq_register_driver(&ls2f_cpufreq_driver);

	if(!result && !nowait) {
		saved_cpu_wait = cpu_wait;
		cpu_wait = ls2f_cpu_wait;
	}

	cpufreq_register_notifier(&ls2f_cpufreq_notifier_block,
				CPUFREQ_TRANSITION_NOTIFIER);
	return result;
}

static void __exit ls2f_cpufreq_module_exit(void)
{
	if(!nowait && saved_cpu_wait)
		cpu_wait = saved_cpu_wait;
	cpufreq_unregister_driver(&ls2f_cpufreq_driver);
	cpufreq_unregister_notifier(&ls2f_cpufreq_notifier_block, 
				CPUFREQ_TRANSITION_NOTIFIER);
}

//late_initcall(ls2f_cpufreq_module_init);
module_init(ls2f_cpufreq_module_init);
module_exit(ls2f_cpufreq_module_exit);

module_param(nowait, uint, 0644);
MODULE_PARM_DESC(nowait, "Disable Loongson-2F specific wait");

MODULE_AUTHOR("Yanhua <yanh@lemote.com>");
MODULE_DESCRIPTION("cpufreq driver for Loongson2F");
MODULE_LICENSE("GPL");
