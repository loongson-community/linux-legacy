/*
 * Copyright (C) 2000 RidgeRun, Inc.
 * Author: RidgeRun, Inc.
 *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
 *
 * Copyright 2001 MontaVista Software Inc.
 * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
 * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
 * Copyright (C) 2003 ICT CAS (guoyi@ict.ac.cn)
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
 *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
 *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
 *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  You should have received a copy of the  GNU General Public License along
 *  with this program; if not, write  to the Free Software Foundation, Inc.,
 *  675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/kernel_stat.h>
#include <linux/module.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/types.h>
#include <linux/interrupt.h>
#include <linux/ioport.h>
#include <linux/timex.h>
#include <linux/slab.h>
#include <linux/random.h>
#include <linux/irq.h>
#include <asm/bitops.h>
#include <asm/bootinfo.h>
#include <asm/io.h>
#include <asm/i8259.h>
#include <asm/mipsregs.h>
#include <asm/system.h>

#include <asm/atomic.h>

#include <linux/config.h>
#include <linux/kernel.h>

#include <asm/mach-loongson/loongson.h>
#include <asm/mach-loongson/boot_param.h>
#include <linux/bitops.h>
#include "irqregs.h"
extern asmlinkage void nb2005_handle_int(void);

#define MIPS_ASSERT(x)  if (!(x)) { panic("MIPS_ASSERT failed at %s:%d\n", __FILE__, __LINE__); }


extern void loongson3_ipi_interrupt(struct pt_regs *regs);
extern void ls2h_init_irq(void);
extern void rs780e_init_irq(void);
void disable_lslpc_irq(unsigned int irq_nr);
void enable_lslpc_irq(unsigned int irq_nr);

#define shutdown_lslpc_irq	disable_lslpc_irq
#define mask_and_ack_lslpc_irq	disable_lslpc_irq

extern char *board_info;

//-------------------------------------------
static struct irqaction cascade_irqaction =	{
	.handler = no_action,
	.flags = SA_INTERRUPT,
	.mask = 0,
	.name = "cascade_irqaction",
	.dev_id = NULL,
	.next = NULL
};

extern int remote_debug;

extern enum board_type board_type;

volatile int * lpc_int_regs_ctrl;
volatile int * lpc_int_regs_enable;
volatile int * lpc_int_regs_status;
volatile int * lpc_int_regs_clear;
void __init init_IRQ(void)
{
	/*
	 * Clear all of the interrupts while we change the able around a bit.
	 * int-handler is not on bootstrap
	 */
	clear_c0_status(ST0_IM | ST0_BEV);
	local_irq_disable();
	set_except_vector(0, nb2005_handle_int);

	switch(board_type){
#if 0
	case LS2H:
		ls2h_init_irq();
		break;
#endif
	case RS780E:
	default:
		rs780e_init_irq();
	};

	/* most bonito irq should be level triggered */
	/* init all controller
	 *   0-15         ------> i8259 interrupt
	 *   16-47        ------> bonito interrupt
	 *   NR_IRQS - 1  ------> r4k timer interrupt
	 */

	/* Sets the first-level interrupt dispatcher. */

	/* enable south chip irq */
	set_c0_status(STATUSF_IP3);

	/* cascade irq not used at this moment */
	setup_irq(56 + 3, &cascade_irqaction);

	/* cascade irq for msi */
	setup_irq(56 + 4, &cascade_irqaction);

	/* enable IPI interrupt */
	set_c0_status(STATUSF_IP6);

	/* Route the LPC interrupt to Core0 INT0 */
	writeb_addr64(_INT_router_regs_lpc_int,0x11);
	/* Enable LPC interrupts for CPU UART */
	writel_addr64(_IO_control_regs_Intenset,(0x1<<10));

	/* added for KBC attached on ls3 LPC controler  */
	printk("board_type:%08x,board_info:%s \n", board_type, board_info);
#if 0
	if (board_type == LS2H) {
		if (strstr(board_info,"3A")) {	/* 3A2H use 3A LPC */
			lpc_int_regs_ctrl	= (volatile int *)LS3_LPC_INT_regs_ctrl;
			lpc_int_regs_enable	= (volatile int *)LS3_LPC_INT_regs_enable;
			lpc_int_regs_status	= (volatile int *)LS3_LPC_INT_regs_status;
			lpc_int_regs_clear	= (volatile int *)LS3_LPC_INT_regs_clear;
		} else {	/* 3C2H use 2H LPC */
			lpc_int_regs_ctrl	= (volatile int *)LS2H_LPC_INT_regs_ctrl;
			lpc_int_regs_enable	= (volatile int *)LS2H_LPC_INT_regs_enable;
			lpc_int_regs_status	= (volatile int *)LS2H_LPC_INT_regs_status;
			lpc_int_regs_clear	= (volatile int *)LS2H_LPC_INT_regs_clear;
		}

		set_irq_chip_and_handler(1 , &lslpc_irq_chip, handle_level_irq);
		set_irq_chip_and_handler(12 , &lslpc_irq_chip, handle_level_irq);

		/* Enable the LPC interrupt */
		LPC_INT_regs_ctrl = 0x80000000;
		/* set the 18-bit interrpt enable bit for keyboard and mouse */
		LPC_INT_regs_enable = (0x1 << 0x1 | 0x1 << 12);
		/* clear all 18-bit interrpt bit */
		LPC_INT_regs_clear = 0x3ffff;
  	}

	set_irq_chip_and_handler(MIPS_CPU_IRQ_BASE + 2, &lslpc_irq_chip,
		handle_level_irq); /* maybe this sentence not needed */
#endif

	/* enable serial and lpc port irq */
	set_c0_status(STATUSF_IP2);

	printk("init_IRQ done.\n");

#ifdef CONFIG_KGDB
	if (remote_debug) {
#ifdef CONFIG_GDB_CONSOLE
		register_gdb_console();
#endif
		set_debug_traps();
		if(remote_debug>1)
		breakpoint();
	}
#endif
}


int putDebugChar(char byte);
char getDebugChar(void);

#define read_c0_epc()		__read_32bit_c0_register($14, 0)
unsigned long myepc;

asmlinkage int plat_irq_dispatch(struct pt_regs *regs)
{
	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
//	prom_printf("pending=%x\n",pending);
#ifdef CONFIG_KGDB
	if (remote_debug) {
		unsigned char volatile *p = 0xffffffffbff003f8ULL;
		long flags;
		static int gdbcnt = 0;
		if(p[5]&1)
		{
			hard_save_flags_and_cli(flags);
			if(!gdbcnt)
			{
			 myepc = read_c0_epc();
				if(myepc >putDebugChar || myepc< getDebugChar)
				{
				gdbcnt++;
				breakpoint();
				gdbcnt--;
				}
			}
			hard_restore_flags(flags);
		}
	}
#endif

#define MIPS_CPU_IRQ_BASE 56

	if (pending & CAUSEF_IP7) {
		do_IRQ(63, regs);
	} else if (pending & CAUSEF_IP2) {
#ifdef CONFIG_CPU_UART
		/* only needed for ls3a2h, ls3c2h don't need this */
		if (board_type == LS2H && strstr(board_info,"3A")) {
			int irq, irqs0 = LPC_INT_regs_enable & LPC_INT_regs_status & 0xfeff;
			if (irqs0 != 0)
				while ((irq = ffs(irqs0)) != 0) {
					do_IRQ(irq-1, regs);
					irqs0 &= ~(1<<(irq-1));
				}
			else
				do_IRQ(MIPS_CPU_IRQ_BASE + 2, regs);
		} else {
				do_IRQ(MIPS_CPU_IRQ_BASE + 2, regs);
		}
#endif
	} else if (pending & CAUSEF_IP3) {
		dispatch_msi_irq(regs);
		dispatch_ht_irq(regs);
	} else if (pending & CAUSEF_IP4) {
		dispatch_msi_irq(regs);
	} else if (pending & CAUSEF_IP5) {
		do_IRQ(56+5, regs);
#ifdef CONFIG_SMP
	} else if (pending & CAUSEF_IP6 /* 0x4000 */){  //smp ipi
		loongson3_ipi_interrupt(regs);
#endif
	} else 
	return -1; //will call spurious_interrup
	return 0;
}

