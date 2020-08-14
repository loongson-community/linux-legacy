/*
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 *
 * Copyright (C) 1997, 2001 Ralf Baechle
 * Copyright 2001 MontaVista Software Inc.
 * Copyright 2003 ICT CAS
 * Author: jsun@mvista.com or jsun@junsun.net
 *         guoyi@ict.ac.cn
 */
#include <linux/sched.h>
#include <linux/mm.h>
#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/processor.h>
#include <asm/reboot.h>
#include <asm/system.h>
#include <linux/delay.h>

void godsonev2a_restart(char *command)
{
#ifdef CONFIG_GODSON2F_SM502_GOLDING
        __asm__ __volatile__("move $26,%0;jr\t$26"::"r"(0xffffffffbfc00000):"$26");
#else

#ifdef CONFIG_MIPS32	
	*(unsigned long *)0xbfe00104 &= ~(1<<2);
	*(unsigned long *)0xbfe00104 |= (1<<2);
#else
	*(unsigned long *)0xffffffffbfe00104 &= ~(1<<2);
	*(unsigned long *)0xffffffffbfe00104 |= (1<<2);
#endif

#endif
}

void godsonev2a_halt(void)
{
	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
#ifndef CONFIG_CPU_GODSON2
	while (1)
		__asm__(".set\tmips3\n\t"
	                "wait\n\t"
			".set\tmips0");
#else
	{
volatile int *p=0xffffffffbfe00104;
p[0]=8;
	}
	while(1);
#endif
}

void godsonev2a_power_off(void)
{
	godsonev2a_halt();
}
