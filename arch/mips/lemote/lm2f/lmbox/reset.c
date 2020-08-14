/*
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 *
 * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
 * Author: Fuxin Zhang, zhangfx@lemote.com
 */

#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/processor.h>
#include <asm/reboot.h>
#include <asm/system.h>

#include <linux/sched.h>
#include <linux/mm.h>
#include <linux/pm.h>
#include <linux/delay.h>

extern void _wrmsr(u32 reg, u32 hi, u32 lo);
extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);

static void loongson2f_restart(char *command)
{
	u32 hi, lo;

#ifdef CONFIG_32BIT
	*(volatile u32*)0xbfe00180 |= 0x7;
#else
	*(volatile u32*)0xffffffffbfe00180 |= 0x7;
#endif
	_rdmsr(0xe0000014, &hi, &lo);
	lo |= 0x00000001;
	_wrmsr(0xe0000014, hi, lo);

	printk("Hard reset not take effect!!\n");
	__asm__ __volatile__ (
					".long 0x3c02bfc0\n"
					".long 0x00400008\n"
					:::"v0"
					);
}


static void delay(void)
{
	volatile int i;
	for (i=0; i<0x10000; i++);
}
static void loongson2f_halt(void)
{
#ifdef CONFIG_32BIT
	u32 base;
#else
	u64 base;
#endif
	u32 hi, lo, val;
	
	_rdmsr(0x8000000c, &hi, &lo);
#ifdef CONFIG_32BIT
	base = (lo & 0xff00) | 0xbfd00000;
#else
	base = (lo & 0xff00) | 0xffffffffbfd00000ULL;
#endif
	val = (val & ~(1 << (16 + 13))) | (1 << 13);
	delay();
	*(__volatile__ u32 *)(base + 0x04) = val;
	delay();
	val = (val & ~(1 << (13))) | (1 << (16 + 13));
	delay();
	*(__volatile__ u32 *)(base + 0x00) = val;
	delay();
}

static void loongson2f_power_off(void)
{
	loongson2f_halt();
}

void mips_reboot_setup(void)
{
	_machine_restart = loongson2f_restart;
	_machine_halt = loongson2f_halt;
	pm_power_off = loongson2f_power_off;
}
