/* $Id: mips_tests.c,v 1.1 2004/06/01 08:45:11 fxzhang Exp $
 * Performance-monitoring counters driver.
 * Optional MIPS-specific init-time tests.
 *
 * Copyright (C) 2004  Fuxin Zhang
 */
#include <linux/config.h>
#define __NO_VERSION__
#include <linux/module.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/fs.h>
#include <linux/perfctr.h>
#include <asm/processor.h>
#include <asm/time.h>	
#include "mips_compat.h"
#include "mips_tests.h"

#define NITER	256

static void __init do_read_cp0(unsigned int unused)
{
	unsigned int i, dummy;
	for(i = 0; i < NITER/8; ++i)
		__asm__ __volatile__("mfc0 %0,$25":"=r"(dummy));
}

static void __init do_write_cp0(unsigned int arg)
{
	unsigned int i,dummy = 0;
	for(i = 0; i < NITER/8; ++i)
		__asm__ __volatile__("mtc0 %0,$25"::"r"(dummy));
}

static void __init do_empty_loop(unsigned int unused)
{
	unsigned i;
	for(i = 0; i < NITER/8; ++i)
		__asm__ __volatile__("" : : );
}

static unsigned __init run(void (*doit)(unsigned int), unsigned int arg)
{
	unsigned int start, stop;
	start = read_c0_count();
	(*doit)(arg);	/* should take < 2^32 cycles to complete */
	stop = read_c0_count();
	return (stop - start)*2;
}

static void __init init_tests_message(void)
{
	unsigned int prid = read_c0_prid();
	printk(KERN_INFO "Please email the following PERFCTR INIT lines "
	       "to mikpe@csd.uu.se\n"
	       KERN_INFO "To remove this message, rebuild the driver "
	       "with CONFIG_PERFCTR_INIT_TESTS=n\n");
	printk(KERN_INFO "PERFCTR INIT: PRID 0x%08x, CPU clock %u kHz\n",
	       prid,
	       perfctr_info.cpu_khz
	       );
}

static void __init
measure_overheads(void)
{
	int i;
	unsigned int loop, ticks[2];
	const char *name[2];

	name[0] = "mfc0";
	ticks[0] = run(do_read_cp0, 0);
	name[1] = "mtc0";
	ticks[1] = run(do_write_cp0, 0);

	loop = run(do_empty_loop, 0);

	init_tests_message();
	printk(KERN_INFO "PERFCTR INIT: NITER == %u\n", NITER);
	printk(KERN_INFO "PERFCTR INIT: loop overhead is %u cycles\n", loop);
	for(i = 0; i < ARRAY_SIZE(ticks); ++i) {
		unsigned int x;
		if( !ticks[i] )
			continue;
		x = ((ticks[i] - loop) * 10) / NITER;
		printk(KERN_INFO "PERFCTR INIT: %s cost is %u.%u cycles (%u total)\n",
		       name[i], x/10, x%10, ticks[i]);
	}
}

void __init perfctr_mips_init_tests(void)
{
	measure_overheads();
}
