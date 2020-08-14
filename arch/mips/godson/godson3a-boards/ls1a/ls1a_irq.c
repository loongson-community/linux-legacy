/*
 *
 * BRIEF MODULE DESCRIPTION
 *	SB2F BOARD interrupt/setup routines.
 *
 * Copyright 2000,2001 MontaVista Software Inc.
 * Author: MontaVista Software, Inc.
 *         	ppopov@mvista.com or source@mvista.com
 *
 * Part of this file was derived from Carsten Langgaard's 
 * arch/mips/ite-boards/generic/init.c.
 *
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
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
#include <linux/serial_reg.h>

#include <asm/bitops.h>
#include <asm/bootinfo.h>
#include <asm/io.h>
#include <asm/mipsregs.h>
#include <asm/system.h>
#include <asm/mach-ls2f1a/ls2f1a.h>
#include <asm/mach-ls2f1a/ls2f1a_int.h>
#include <asm/mach-ls2f1a/ls2f1a_dbg.h>
#include <linux/bitops.h>

#undef DEBUG_IRQ
#ifdef DEBUG_IRQ
/* note: prints function name for you */
#define DPRINTK(fmt, args...) printk("%s: " fmt, __FUNCTION__ , ## args)
#else
#define DPRINTK(fmt, args...)
#endif

#ifdef CONFIG_REMOTE_DEBUG
extern void breakpoint(void);
#endif

/* revisit */
#define EXT_IRQ0_TO_IP 2 /* IP 2 */
#define EXT_IRQ5_TO_IP 7 /* IP 7 */

#define ALLINTS_NOTIMER (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4)

void disable_sb2f_board_irq(unsigned int irq_nr);
void enable_sb2f_board_irq(unsigned int irq_nr);

extern void set_debug_traps(void);
// extern void mips_timer_interrupt(int irq, struct pt_regs *regs);
extern void mips_timer_interrupt(int irq);
extern asmlinkage void sb2f_board_IRQ(void);

struct sb2f_board_intc_regs volatile *sb2f_board_hw0_icregs
	= (struct sb2f_board_intc_regs volatile *)(KSEG1ADDR(SB2F_BOARD_INTREG_BASE));


void ack_sb2f_board_irq(unsigned int irq_nr)
{
	disable_sb2f_board_irq(irq_nr);
	DPRINTK("ack_sb2f_board_irq %d\n", irq_nr);
    	(sb2f_board_hw0_icregs+(irq_nr>>5))->int_clr |= (1 << (irq_nr&0x1f));
}

void disable_sb2f_board_irq(unsigned int irq_nr)
{
	DPRINTK("disable_sb2f_board_irq %d\n", irq_nr);
    	(sb2f_board_hw0_icregs+(irq_nr>>5))->int_en &= ~(1 << (irq_nr&0x1f));
}

void enable_sb2f_board_irq(unsigned int irq_nr)
{

	DPRINTK("enable_sb2f_board_irq %d\n", irq_nr);
    	(sb2f_board_hw0_icregs+(irq_nr>>5))->int_en |= (1 << (irq_nr&0x1f));
}

static unsigned int startup_sb2f_board_irq(unsigned int irq)
{
	enable_sb2f_board_irq(irq);
	return 0; 
}

#define shutdown_sb2f_board_irq	disable_sb2f_board_irq
#define mask_and_ack_sb2f_board_irq    disable_sb2f_board_irq

static void end_sb2f_board_irq(unsigned int irq)
{
	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS))){
		(sb2f_board_hw0_icregs+(irq>>5))->int_clr |= 1 << (irq&0x1f); 
		//if(irq<SB2F_BOARD_GPIO_FIRST_IRQ) 
		enable_sb2f_board_irq(irq);
	}
}

hw_irq_controller sb2f_board_irq_controller = {
	.typename = "SB2F BOARD",
	.ack = ack_sb2f_board_irq,
	.startup = startup_sb2f_board_irq,
	.shutdown = disable_sb2f_board_irq,
	.enable = enable_sb2f_board_irq,
	.disable = disable_sb2f_board_irq,
	.end = end_sb2f_board_irq,
};

// void sb2f_board_hw0_irqdispatch(struct pt_regs *regs)
void sb2f_board_hw_irqdispatch(int n, struct pt_regs *regs)
{
	int irq;
	int intstatus = 0;
   	int status;

	/* Receive interrupt signal, compute the irq */
	intstatus = (sb2f_board_hw0_icregs+n)->int_isr;
	irq=ffs(intstatus);
//        printk(KERN_ERR "irq==--%d\n\n",irq);
	if(!irq){
		return; 
	}
	else do_IRQ(n*32+irq-1, regs);
}

void sb2f_board_irq_init(u32 irq_base)
{
	extern irq_desc_t irq_desc[];
	u32 i;
	for (i= 0; i<= SB2F_BOARD_LAST_IRQ; i++) {
		irq_desc[i].status = IRQ_DISABLED;
		irq_desc[i].action = NULL;
		irq_desc[i].depth = 1;
		irq_desc[i].handler = &sb2f_board_irq_controller;
	}

#if 1
        for(i=0;i<5;i++)
        {
            /* active level setting */
            /* uart, keyboard, and mouse are active high */
            if(i==1)
                (sb2f_board_hw0_icregs+1)->int_pol = ~( (INT_PCI_INTA)|(INT_PCI_INTB)|(INT_PCI_INTC)|(INT_PCI_INTD));//pci active low
            else
                (sb2f_board_hw0_icregs+i)->int_pol = -1;//pci active low

            /* make all interrupts level triggered */
            if(i ==  0){
                (sb2f_board_hw0_icregs+i)->int_edge = 0x0000e000;
            }
            else
                (sb2f_board_hw0_icregs+i)->int_edge = 0x00000000;

            /* mask all interrupts */
            (sb2f_board_hw0_icregs+i)->int_clr = 0xffffffff;

        }
#endif
}
