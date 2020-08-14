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

#include <asm/nb2005/p6032.h>
#include <asm/nb2005/p6032int.h>
#include <asm/nb2005/bonito.h>
#include <asm/nb2005/prom.h>
#include <asm-mips/mach-ls2f1a/irq.h>
#include <asm/delay.h>

extern asmlinkage void nb2005_handle_int(void);
#define Bonito static char * const _bonito = (char * const )KSEG1ADDR(BONITO_BASE)

#define NB2005_HOTPLUG_PIN 28
#define	bonito_irq_shutdown	bonito_irq_disable

//#define Bonito static char * const _bonito = (char * const )CKSEG1ADDR(BONITO_BASE)

#define MIPS_ASSERT(x)  if (!(x)) { panic("MIPS_ASSERT failed at %s:%d\n", __FILE__, __LINE__); }

static int bonito_irq_base=-1;

static inline void ll_bonito_irq_enable(int irq)
{
	Bonito;
#ifdef CONFIG_NB_ICT_CPCI
if(irq==NB2005_HOTPLUG_PIN)return;
#endif
	BONITO_INTENSET = (1 << irq);
	BONITO_INTENSET;
}

static inline void ll_bonito_irq_disable(int irq)
{
	Bonito;
#ifdef CONFIG_NB_ICT_CPCI
if(irq==NB2005_HOTPLUG_PIN)return;
#endif
	BONITO_INTENCLR = (1 << irq);
	BONITO_INTENCLR;
}

static void bonito_irq_enable(unsigned int irq)
{
	MIPS_ASSERT(bonito_irq_base != -1 && irq >= bonito_irq_base);
	ll_bonito_irq_enable(irq - bonito_irq_base);
}

static void bonito_irq_disable(unsigned int irq)
{
	MIPS_ASSERT(bonito_irq_base != -1 && irq >= bonito_irq_base);
	ll_bonito_irq_disable(irq - bonito_irq_base);
}

static unsigned int bonito_irq_startup(unsigned int irq)
{
	//Bonito;
	bonito_irq_enable(irq);
	//printk("INTEN=%x,INTSET=%x,INTCLR=%x,INTISR=%x\n",BONITO_INTEN,BONITO_INTENSET,BONITO_INTENCLR,BONITO_INTISR);
	printk("bonito irq startup %d\n", irq);
	return 0;
}


static void bonito_irq_ack(unsigned int irq)
{
	Bonito;

	MIPS_ASSERT(bonito_irq_base != -1 && irq >= bonito_irq_base);

	/* clear the interrupt bit */
	/* some irqs require the driver to clear the sources */
	BONITO_INTENCLR = (1 << (irq - bonito_irq_base));
	//reread it to make write to chip
	BONITO_INTENCLR;
}

static void bonito_irq_end(unsigned int irq)
{
	MIPS_ASSERT(bonito_irq_base != -1 && irq >= bonito_irq_base);
	ll_bonito_irq_enable( irq - bonito_irq_base);
}

hw_irq_controller bonito_irq_controller = {
	"bonito_irq",
	bonito_irq_startup,
	bonito_irq_shutdown,
	bonito_irq_enable,
	bonito_irq_disable,
	bonito_irq_ack,
	bonito_irq_end,
	NULL			/* no affinity stuff for UP */
};

void bonito_irq_init(u32 irq_base)
{
	extern irq_desc_t irq_desc[];
	u32 i;

	for (i= irq_base; i< irq_base+32; i++) {
		irq_desc[i].status = IRQ_DISABLED;
		irq_desc[i].action = NULL;
		irq_desc[i].depth = 1;
		irq_desc[i].handler = &bonito_irq_controller;
	}

	bonito_irq_base = irq_base;

#if 1 /* gx 060306 */
	//ll_bonito_irq_enable(10);
#endif
	
}
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

void __init init_IRQ(void)
{
	Bonito;
	extern void bonito_irq_init(u32 irq_base);

	/*
	 * Clear all of the interrupts while we change the able around a bit.
	 * int-handler is not on bootstrap
	 */
#ifdef CONFIG_DEBUG_BEV
	clear_c0_status(ST0_IM| 0x1f);
#else
	clear_c0_status(ST0_IM | ST0_BEV| 0x1f);
#endif
	local_irq_disable();
	set_except_vector(0, nb2005_handle_int);

	/* most bonito irq should be level triggered */
	/* 
	 * Mask out all interrupt by writing "1" to all bit position in 
	 * the interrupt reset reg. 
	 */
	BONITO_INTENCLR = ~0;

	BONITO_INTPOL= -1; 
	BONITO_INTSTEER = 0;
	/* init all controller
	 *   0-15         ------> i8259 interrupt
	 *   16-47        ------> bonito interrupt
	 *   NR_IRQS - 1  ------> r4k timer interrupt
	 */

	/* Sets the first-level interrupt dispatcher. */

	sb2f_board_irq_init(0);
	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);	
	bonito_irq_init(BONITO_IRQ);


	/* bonito irq at IP6 */
	setup_irq(MIPS_CPU_IRQ_BASE + 6, &cascade_irqaction);
#if !(defined(CONFIG_GODSON2F_SM502_GOLDING)  || defined(CONFIG_GODSON2F_LS1A_GOLDING))
	/* 8259 irq at IP2 */
	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cascade_irqaction);
#endif

	setup_irq(BONITO_IRQ+7, &cascade_irqaction);	//pci_intD
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

	*(volatile int *)(int)0xb2f10204 = 0;
	*(volatile int *)(int)0xb2f10204;
	udelay(1000);
	/*ls1f usb reset stop*/
	*(volatile int *)(int)0xb2f10204 = 0x40000000;
	*(volatile int *)(int)0xb2f10204;

//	*(volatile int *)(int)0xb2d01114 = 0x238a0;
	/*ls1a adjust sata phy clock added by menghaibo*/
	*(volatile int *)(int)0xb2d00424 |= 0x80000000;
	*(volatile int *)(int)0xb2d00418  = 0x38682650;
	*(volatile int *)(int)0xb2e30000 &= 0x0;

	{
		void swiotlb_init (void);
		//swiotlb_init();
	}
}



static void godson2f_irqdispatch(struct pt_regs *regs)
{
	Bonito;

	int irq;
	unsigned long int_status;
	int i;          

	/* Get pending sources, masked by current enables */
	int_status = BONITO_INTISR & BONITO_INTEN;

	/* Scan all pending interrupt bits and execute appropriate actions */
	for (i=7; i>3 && int_status; i--) {
		if (int_status & 1<<i) {
		  if(i==10) prom_printf("ddr int!!!\n");
			irq = i + BONITO_IRQ;
			/* Clear bit to optimise loop exit */

		  if(i==7 ){
			int n;
			int_status &= ~(1<<i);
			for(n=0; n<5; n++){
				sb2f_board_hw_irqdispatch(n, regs);
			}   	
			}
		  else
			do_IRQ(irq,regs);
			break;
	int_status = BONITO_INTISR & BONITO_INTEN;
		}
	}

	return;
}

int putDebugChar(char byte);
char getDebugChar(void);

#define read_c0_epc()		__read_32bit_c0_register($14, 0)
unsigned long myepc;
asmlinkage int plat_irq_dispatch(struct pt_regs *regs)
{
	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
	//prom_printf("pending=%x\n",pending);
#ifdef CONFIG_KGDB
	if (remote_debug) {
		unsigned int volatile *p = 0xffffffffb2e40000ULL;
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

	if (pending & CAUSEF_IP7) {
		do_IRQ(MIPS_CPU_IRQ_BASE+7, regs);
	} else if (pending & CAUSEF_IP2) {
		do_IRQ(MIPS_CPU_IRQ_BASE+2, regs);
	} else if (pending & CAUSEF_IP3) {
		do_IRQ(MIPS_CPU_IRQ_BASE+3, regs);
	} else if (pending & CAUSEF_IP4) {
		do_IRQ(MIPS_CPU_IRQ_BASE+4, regs);
	} else if (pending & CAUSEF_IP5) {
		do_IRQ(MIPS_CPU_IRQ_BASE+5, regs);
	} else if (pending & CAUSEF_IP6) {
		godson2f_irqdispatch(regs);
	} else
	return -1; //will call spurious_interrup

	return 0;
}

void godsonev2a_timer_setup(struct irqaction *irq)
{
	prom_printf("godsonev2a_timer_setup,irq=63\n");
	setup_irq(MIPS_CPU_IRQ_BASE+7, irq);
}
