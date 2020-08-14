/* $Id: setup.c,v 1.1.1.1 2006/01/05 06:08:34 root Exp $
 *
 * setup.c 
 *
 * Kevin Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 1999 MIPS Technologies, Inc.
 *
 * ########################################################################
 *
 *  This program is free software; you can distribute it and/or modify it
 *  under the terms of the GNU General Public License (Version 2) as
 *  published by the Free Software Foundation.
 *
 *  This program is distributed in the hope it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 *  for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * ########################################################################
 *
 */
#include <linux/config.h>
#include <linux/hdreg.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/mc146818rtc.h>
#include <linux/console.h>
#include <linux/pci.h>
#include <linux/ioport.h>
#include <linux/irq.h>

#include <asm/cpu.h>
#include <asm/bootinfo.h>
#ifdef CONFIG_BLK_DEV_IDE
#include <linux/ide.h>
#endif
//#include <asm/ide.h>
#include <asm/floppy.h>
#include <asm/keyboard.h>
#include <asm/irq.h>
#include <asm/godson/godson_sim.h>
#include <asm/godson/godson_sim_int.h>
#include <asm/godson/prom.h>
#include <asm/reboot.h>
#include <asm/dma.h>
#include <asm/time.h>
#include <asm/keyboard.h>


extern struct ide_ops std_ide_ops;
extern struct kbd_ops std_kbd_ops;
extern struct fdc_ops std_fd_ops;
//extern struct rtc_ops p6032_rtc_ops;

extern unsigned int mips_hpt_freq;

//#define GODSON_SIM_FRQ_MHZ	250
#ifdef CONFIG_GODSON_SIM
#define GODSON_SIM_FRQ_MHZ	200
#else
#define GODSON_SIM_FRQ_MHZ	200
#endif

unsigned int godson_cpu_freq= 200;

static void __init godson_sim_time_init(void)
{

        unsigned long est_freq;	

	est_freq = 1000000*godson_cpu_freq;

	mips_hpt_frequency = (est_freq >> 1);
}


static void __init godson_sim_timer_setup(struct irqaction *irq)
{
	unsigned int count;

	prom_printf("Setting up timer\n");
	/* we are using the cpu counter for timer interrupts */
	setup_irq(63, irq);

	/* to generate the first timer interrupt */
	count = read_c0_count();
	write_c0_count(count + 1000);

//	change_c0_status(ST0_IM, IE_IRQ0 | IE_IRQ1  | IE_IRQ2 | IE_IRQ5);
	change_c0_status(ST0_IM, IE_IRQ5);
	//set_c0_status(int_mask);
}

void __init godson_sim_setup(void)
{
	char *argptr;

	void godson_sim_restart(char *);
	void godson_sim_halt(void);
	void godson_sim_power_off(void);


	argptr = prom_getcmdline();
	if ((argptr = strstr(argptr, "nofpu")) != NULL) {
		prom_printf("Hardware FPU Inhibited\n");
		current_cpu_data.options &= ~MIPS_CPU_FPU;
	}

	argptr = prom_getcmdline();
	if ((argptr = strstr(argptr, "freq=")) != NULL) {
	  sscanf(argptr+5,"%d",&godson_cpu_freq);
	  prom_printf("Frequency set to %d\n",godson_cpu_freq);
	}

#if 0 //godson simulator has no such devices
#ifdef CONFIG_BLK_DEV_IDE
	ide_ops = &std_ide_ops;
#endif
#ifdef CONFIG_BLK_DEV_FD
	fd_ops = &std_fd_ops;
#endif
#ifdef CONFIG_VT
#if defined(CONFIG_VGA_CONSOLE)
	conswitchp = &vga_con;
#elif defined(CONFIG_DUMMY_CONSOLE)
	conswitchp = &dummy_con;
#endif
	kbd_ops = &std_kbd_ops;
#endif
	rtc_ops = &p6032_rtc_ops;
	p6032_rtc_init();
#endif

	/*
	 * IO/MEM resources. 
	 */
	ioport_resource.start = 0;
	ioport_resource.end = 0xffffffff;
	iomem_resource.start = 0x0;
	iomem_resource.end = 0xffffffff;

	board_time_init = godson_sim_time_init;
	board_timer_setup = godson_sim_timer_setup;

	_machine_restart = godson_sim_restart;
	_machine_halt = godson_sim_halt;
	_machine_power_off = godson_sim_power_off;

//	godson_sim_restart(NULL);
}

/*
 * These little functions deserve a file of their own someday.
 */

void godson_sim_halt(void)
{
	void (*goto_pmon)(void) = (void (*)(void))(KSEG0 + 0x1fc00000);

//	prom_printf("Halt: returning to PMON\n");
	printk("Halt: returning to PMON\n");
	(*goto_pmon)();
}

void godson_sim_restart(char *command)
{
//	prom_printf("Restart: halting\n");
	printk("Restart: halting\n");
	godson_sim_halt();
}

void godson_sim_power_off(void)
{
//	prom_printf("Power off: halting\n");
	printk("Power off: halting\n");
	godson_sim_halt();
}

