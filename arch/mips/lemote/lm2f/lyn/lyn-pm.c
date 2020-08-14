/*
 * Loongson2F-specific STR/Standby
 *
 * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
 * Author: Wu Zhangjin <wuzj@lemote.com>
 * Author: Hongbing Hu <huhb@lemote.com>
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include <linux/delay.h>
#include <linux/i8042.h>
#include <linux/kernel.h>
#include <linux/suspend.h>

#include <asm/io.h>
#include <asm/mips-boards/bonito64.h>

#ifdef CONFIG_64BIT
#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long long)(p)))
#else
#define PTR_PAD(p) (p)
#endif

#define BONITO_INT_BIT_INT2     (1 << 13)

/* Implement in drivers/misc/loongson/lynloong_9003_bl.c */
extern void close_lcd(void); 
extern void open_lcd(void);

void shutdown_devices(void)
{
		close_lcd();
}

void poweron_devices(void)
{
		open_lcd();
}

void mach_irqs_disable(void)
{
}

void mach_irqs_enable(void)
{
}

int check_wakeup_event(void)
{
	int int_status;
	
	int_status = BONITO_INTISR & BONITO_INTEN;
	if(int_status & BONITO_INT_BIT_INT2)
		return 1;
	
	return 0;	
} 

static int ls2f_pm_standby(void)
{
	unsigned int cpu_freq;	

	mach_irqs_disable();
	shutdown_devices();
	cpu_freq = *(volatile u32*)PTR_PAD(0xbfe00180);
	/* Put CPU into wait mode zzzz....., wait for wakeup event */
	*(volatile u32*)PTR_PAD(0xbfe00180) &= ~0x7;
	*(volatile u32*)PTR_PAD(0xbfe00180) &= ~0x7;
	/* Wakeup......, restore CPU freq */
	*(volatile u32*)PTR_PAD(0xbfe00180) = cpu_freq;
	
wait:
        if (!check_wakeup_event()) {
                *(volatile u32*)PTR_PAD(0xbfe00180)&= ~0x7;
                goto wait;
        }
	
	poweron_devices();
	mach_irqs_enable();

	return 0;
}

/* Need to hardware support,later it will be ok -) */
static int ls2f_pm_mem(void)
{
	return 0;
}

/* For standby, for mem in the future */
static int ls2f_pm_valid_state(suspend_state_t state)
{
	return  state == PM_SUSPEND_MEM || state == PM_SUSPEND_STANDBY;
}

static int ls2f_pm_enter(suspend_state_t state)
{
	switch(state){
	case PM_SUSPEND_STANDBY:
			return ls2f_pm_standby();
	case PM_SUSPEND_MEM:
			return ls2f_pm_standby();
		//	return ls2f_pm_mem();
	default:
			return 0;
	}
}

struct platform_suspend_ops ls2f_pm_ops ={
	.valid = ls2f_pm_valid_state,
	.enter = ls2f_pm_enter,
};

static int __init ls2f_pm_init(void)
{
	printk(KERN_INFO "Loongson2F Power Management \n");
	suspend_set_ops(&ls2f_pm_ops);
	
	return 0;
}
arch_initcall(ls2f_pm_init);
