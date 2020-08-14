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
#ifdef CONFIG_32BIT
	*(volatile u32*)0xbfe00180 |= 0x7;
#else
	*(volatile u32*)0xffffffffbfe00180 |= 0x7;
#endif

#ifdef	CONFIG_64BIT
	*((volatile u8*)(0xffffffffbfd00381)) = 0xf4;
	*((volatile u8*)(0xffffffffbfd00382)) = 0xec;
	*((volatile u8*)(0xffffffffbfd00383)) = 0x01;
#else
	*((volatile u8*)(0xbfd00381)) = 0xf4;
	*((volatile u8*)(0xbfd00382)) = 0xec;
	*((volatile u8*)(0xbfd00383)) = 0x01;
#endif

	while (1);
	/* Wait the system reset completely */
#if 0
	__asm__ __volatile__ (
					".long 0x3c02bfc0\n"
					".long 0x00400008\n"
					:::"v0"
					);
#endif
}

static void loongson2f_halt(void)
{
#ifdef	CONFIG_64BIT
	/* cpu-gpio0 output low */
	*((volatile u32*)(0xffffffffbfe0011c)) &= ~0x00000001;
	/* cpu-gpio0 as output */
	*((volatile u32*)(0xffffffffbfe00120)) &= ~0x00000001;
#else
	/* cpu-gpio0 output low */
	*((volatile u32*)(0xbfe0011c)) &= ~0x00000001;
	/* cpu-gpio0 as output */
	*((volatile u32*)(0xbfe00120)) &= ~0x00000001;
#endif

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
