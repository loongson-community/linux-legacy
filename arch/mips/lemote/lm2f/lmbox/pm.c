/*
 * loongson-specific STR/Standby support
 *
 *  Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
 *  Author: Wu Zhangjin <wuzj@lemote.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include <linux/suspend.h>
#include <linux/interrupt.h>
#include <linux/pm.h>

#include <asm/i8259.h>
#include <asm/mipsregs.h>

#include <asm/mips-boards/bonito64.h>

#include "../common/cs5536_pci.h"
#include "../common/cs5536.h"

#define BONITO_CHIPCFG0	BONITO(BONITO_REGBASE + 0x80)

extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);
static u32 mfgpt_base, gpio_base, smb_base;

static unsigned int cached_master_mask;	/* i8259A */
static unsigned int cached_slave_mask;
static unsigned int cached_bonito_irq_mask; /* bonito */

void arch_suspend_disable_irqs(void)
{
	/* disable all mips eventss */
	local_irq_disable();

	/* disable all eventss of i8259A */
	cached_slave_mask = inb(PIC_SLAVE_IMR);
	cached_master_mask = inb(PIC_MASTER_IMR);

	outb(0xff, PIC_SLAVE_IMR);
	inb(PIC_SLAVE_IMR);
	outb(0xff, PIC_MASTER_IMR);
	inb(PIC_MASTER_IMR);

	/* disable all eventss of bonito */
	cached_bonito_irq_mask = BONITO_INTEN;
	BONITO_INTENCLR = 0xffff;
	(void)BONITO_INTENCLR;
}

void arch_suspend_enable_irqs(void)
{
	/* enable all mips eventss */
	local_irq_enable();

	/* only enable the cached eventss of i8259A */
	outb(cached_slave_mask, PIC_SLAVE_IMR);
	outb(cached_master_mask, PIC_MASTER_IMR);

	/* enable all cached eventss of bonito */
	BONITO_INTENSET = cached_bonito_irq_mask;
	(void)BONITO_INTENSET;
}

/* setup the board-specific events for waking up loongson from wait mode */
void __attribute__((weak)) setup_wakeup_events(void)
{
}

/* check wakeup events */
int __attribute__((weak)) wakeup_loongson(void)
{
	return 1;
}

/* if the events are really what we want to wakeup cpu, wake up it, otherwise,
 * we Put CPU into wait mode again.
 */
static void wait_for_wakeup_events(void)
{
	while (!wakeup_loongson())
		BONITO_CHIPCFG0 &= ~0x7;
}

/* stop all perf counters by default
 *   $24 is the control register of loongson perf counter
 */
static inline void stop_perf_counters(void)
{
	__write_64bit_c0_register($24, 0, 0);
}


static void loongson_suspend_enter(void)
{
	static unsigned int cached_cpu_freq;

	/* setup wakeup events via enabling the IRQs */
	setup_wakeup_events();

	/* stop all perf counters */
	stop_perf_counters();

	cached_cpu_freq = BONITO_CHIPCFG0;

	/* Put CPU into wait mode */
	BONITO_CHIPCFG0 &= ~0x7;

	/* wait for the given events to wakeup cpu from wait mode */
	wait_for_wakeup_events();

	BONITO_CHIPCFG0 = cached_cpu_freq;
	mmiowb();
}

#define MFGPT0_SETUP (mfgpt_base + 6)

void __attribute__((weak)) mach_suspend(void)
{
	/* disable mfgpt */
	outw(inw(MFGPT0_SETUP) & 0x7fff, MFGPT0_SETUP);
}

void __attribute__((weak)) mach_resume(void)
{
	/* enable mfgpt */
	outw(0xe310, MFGPT0_SETUP);
}

static int loongson_pm_enter(suspend_state_t state)
{
	/* mach specific suspend */
	mach_suspend();

	/* processor specific suspend */
	loongson_suspend_enter();

	/* mach specific resume */
	mach_resume();

	return 0;
}

static int loongson_pm_valid_state(suspend_state_t state)
{
	switch (state) {
	case PM_SUSPEND_ON:
	case PM_SUSPEND_STANDBY:
	case PM_SUSPEND_MEM:
		return 1;

	default:
		return 0;
	}
}

static int loongson_pm_prepare(void)
{
	u32 hi;

	/* get gpio_base */
	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &gpio_base);
	/* get mfgpt base */
	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &hi, &mfgpt_base);
	/* get smb base */
	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &smb_base);

	return 0;
}

static struct platform_suspend_ops loongson_pm_ops = {
	.prepare = loongson_pm_prepare,
	.valid	= loongson_pm_valid_state,
	.enter	= loongson_pm_enter,
};

static int __init loongson_pm_init(void)
{
	suspend_set_ops(&loongson_pm_ops);

	return 0;
}
arch_initcall(loongson_pm_init);
