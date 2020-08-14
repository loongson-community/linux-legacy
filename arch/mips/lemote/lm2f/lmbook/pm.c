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

#include <asm/i8259.h>
#include <asm/io.h>
#include <asm/mips-boards/bonito64.h>

#include "../../../../../drivers/misc/loongson/ec.h"

#define KBD_ENABLE   0x01
#define I8042_KBD_IRQ  1
#define SCI_IRQ_NUM  10

#ifdef CONFIG_64BIT
#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long long)(p)))
#else
#define PTR_PAD(p) (p)
#endif

static unsigned int cached_master_mask; /* i8259A */
static unsigned int cached_slave_mask;
static unsigned int cached_bonito_irq_mask; /* bonito */

extern void ec_write(unsigned short addr, unsigned char val);
extern unsigned char ec_read(unsigned short addr);
extern int i8042_flush();

void shutdown_devices(void)
{
	unsigned int value;

	/* close crt output */
	outb(0x21, 0x3c4);
	value = inb(0x3c5);
	value |= (1 << 7);
	outb(0x21, 0x3c4);
	outb(value, 0x3c5);

	/* close lcd output */
	outb(0x31, 0x3c4);
	value = inb(0x3c5);
	value = (value & 0xf8) | 0x02;
	outb(0x31, 0x3c4);
	outb(value, 0x3c5);

	/* LCD backlight off */
	ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_OFF);

	/* shutdown three usb ports */
	ec_write(0xf461,0x00);
	ec_write(0xf462,0x00);
	ec_write(0xf463,0x00);
}

void poweron_devices(void)
{
	unsigned int value;

	/* open lcd output */
	outb(0x31, 0x3c4);
	value = inb(0x3c5);
	value = (value & 0xf8) | 0x03;
	outb(0x31, 0x3c4);
	outb(value, 0x3c5);

	/* LCD backlight on */
	ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_ON);

	/* three usb ports power on */
	ec_write(0xf461,0x01);
	ec_write(0xf462,0x01);
	ec_write(0xf463,0x01);
}

void mach_irqs_disable(void)
{
	/* disable all interrupts of i8259A */
	cached_slave_mask = inb(PIC_SLAVE_IMR);
	cached_master_mask = inb(PIC_MASTER_IMR);

	outb(0xff, PIC_SLAVE_IMR);
	inb(PIC_SLAVE_IMR);
	outb(0xff, PIC_MASTER_IMR);
	inb(PIC_MASTER_IMR);

	/* disable all interrupts of bonito */
	cached_bonito_irq_mask = BONITO_INTEN;
	BONITO_INTENCLR = 0xffff;
	(void)BONITO_INTENCLR;
	mmiowb();
}

void mach_irqs_enable(void)
{
	/* only enable the cached interrupts of i8259A */
	outb(cached_slave_mask, PIC_SLAVE_IMR);
	outb(cached_master_mask, PIC_MASTER_IMR);

	/* enable all cached interrupts of bonito */
	BONITO_INTENSET = cached_bonito_irq_mask;
	(void)BONITO_INTENSET;
	mmiowb();
}
extern int sci_get_event_num(void);
extern int ec_query_seq(unsigned char cmd);

int check_wakeup_event(void)
{
	int irq, isr;

	/* query the interrupt number */
	isr = inb(0x20) | (inb(0xa0) << 8);
	isr &= ~0x4; // irq2 for cascade
        isr &= ~(cached_master_mask|cached_slave_mask << 8);
        irq = ffs(isr) - 1;

        if (irq < 0)
                return 0;
        printk("irq = %d\n", irq);

        if (irq == I8042_KBD_IRQ)
                return 1;
#if 0
        else if (irq == SCI_IRQ_NUM) {
                int ret, sci_event;
                /* query the event number */
                ret = ec_query_seq(CMD_GET_EVENT_NUM);
                if (ret < 0)
                        return 0;
                sci_event = sci_get_event_num();
                if (sci_event < 0)
                        return 0;
       			if (sci_event == SCI_EVENT_NUM_LID) {
                        int lid_status;
                        /* check the LID status */
                        lid_status = ec_read(REG_LID_DETECT);
                        /* wakeup cpu when people open the LID */
                        if (lid_status == BIT_LID_DETECT_ON)
                                return 1;
                }
        }
#endif
        return 0;
} 

static int ls2f_pm_standby(void)
{
	unsigned int cpu_freq, hi, lo, error, irq_mask;	
	unsigned char kbd = KBD_ENABLE;

	mach_irqs_disable();	
	shutdown_devices();
	/* Enable kbd to wakeup cpu */	
	outb((0xff & ~(1 << I8042_KBD_IRQ)), PIC_MASTER_IMR);
	inb(PIC_MASTER_IMR);
	error = i8042_command(&kbd, I8042_CMD_CTL_WCTR);
	if(error){
		printk(KERN_ERR "Can't enable kbd\n");
		return error;
	}
#if 0
	/* Enable the feature that open notebook to wakeup cpu */ 
	irq_mask = inb(PIC_MASTER_IMR);
	outb(irq_mask & ~(1 << (SCI_IRQ_NUM - 8)), PIC_MASTER_IMR);
	inb(PIC_MASTER_IMR);
	outb(0xff & ~(1 << (SCI_IRQ_NUM - 8)), PIC_SLAVE_IMR);
	inb(PIC_SLAVE_IMR);
#endif
	cpu_freq = *(volatile u32*)PTR_PAD(0xbfe00180);
	/* Put CPU into wait mode zzzz....., wait for wakeup event */
	*(volatile u32*)PTR_PAD(0xbfe00180) &= ~0x7;
	i8042_flush();
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
	return  state == PM_SUSPEND_STANDBY || state == PM_SUSPEND_MEM; 
}

static int ls2f_pm_enter(suspend_state_t state)
{
	switch(state){
	case PM_SUSPEND_STANDBY:
	case PM_SUSPEND_MEM:		
			return ls2f_pm_standby();
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
