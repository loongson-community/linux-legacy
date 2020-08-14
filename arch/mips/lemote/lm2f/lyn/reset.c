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
#include <i2c_oprate.h>

static void loongson2f_restart(char *command)
{
	i2c_write(0xb6, 1, 2);
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
		i2c_write(0xb6,1, 1);
		while(1);
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
