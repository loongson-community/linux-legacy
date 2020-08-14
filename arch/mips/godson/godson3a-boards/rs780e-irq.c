/*
 * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
 * Author: Fuxin Zhang, zhangfx@lemote.com
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
#include <linux/bitops.h>

#include <asm/mach-loongson/loongson.h>
#include <asm/mach-loongson/boot_param.h>
#include <asm/mach-loongson/htregs.h>

#include "irqregs.h"
#ifdef CONFIG_I8259
#include <asm/i8259.h>
#endif

extern void prom_printf(char *fmt, ...);
extern void loongson3_ipi_interrupt(struct pt_regs *regs);
extern int loongson3_send_irq_by_ipi(int cpu,int irqs);
extern unsigned long ht_enable;
extern unsigned long long causef_ip;
unsigned long phy_core_id[4];
extern unsigned int nr_cpu_loongson;
extern int ls3a_ht_int_cpumask[NR_CPUS];
extern void (*mach_ip3) (void);
extern void (*do_sb_bal_irq) (unsigned int irqs);
extern unsigned int nr_cpu_handle_int;
int ls3a_ht_stripe4 = 0;
//core_param(stripe4, ls3a_ht_stripe4, bool, 0444);

int ht_irq_mask[8];

static void do_780e_bal_irq(unsigned int irqs, struct pt_regs *regs)
{
	int irq;
	while ((irq = ffs(irqs))) {
		do_IRQ(irq - 1, regs);
		irqs &= ~(1<<(irq - 1));
	}
}

void dispatch_ht_irq(struct pt_regs *regs)
{
	int i;
	int irq,irqs;
	int cpu = smp_processor_id();
	int mask;

	if(ls3a_ht_stripe4)
	{
		mask = 0x11111111<<cpu;
	}
	else
	{
		mask = 0xffffffff;
	}
	
	irqs = 0;
	irqs |= HT_irq_vector_reg0 & mask;
	irqs |= HT_irq_vector_reg0 & mask;
	irqs |= HT_irq_vector_reg0 & mask;

	if(irqs)
	{

		HT_irq_vector_reg0 = irqs;
		HT_irq_vector_reg0 = irqs;
		HT_irq_vector_reg0 = irqs;
		irqs &= ht_irq_mask[0];

		while((irq = ffs(irqs)) != 0){
			/*maybe reenter*/
			if(irq){
				do_IRQ(irq-1, regs);
				irqs &= ~(1<<(irq-1));
			}else
				spurious_interrupt();
		}
	}


#ifdef HT_SOUTH_BRIDGE_I8259
	irq = mach_i8259_irq();
	if (irq >= 0)
        {
		do_IRQ(irq, regs);
	}
	else
		spurious_interrupt();
#endif
}


void dispatch_msi_irq(struct pt_regs *regs)
{
	int cpu = smp_processor_id();
	/*dispatch ht irqs for smi*/
#define HT_irq_vector_regs(n)	*(volatile unsigned int *)(HT_control_regs_base + 0x80 +(n)*4)
	int i, irqs, irq, hts;
	int mask, start, end;

	if(ls3a_ht_stripe4)
	{
		start = 1;
		end = 7;
		mask = 0x11111111<<cpu;
	}
	else
	{
		start = cpu? cpu*2:1;
		end = cpu*2+1;
		mask = 0xffffffff;
	}


	for(i=start;i<=end;i++)
	{
		int irqmask;
		int irqs0;
		int irqs1;
		irqs = 0;
		irqs |= HT_irq_vector_regs(i) & mask;
		irqs |= HT_irq_vector_regs(i) & mask;
		irqs |= HT_irq_vector_regs(i) & mask;
		if(!irqs) continue;
		HT_irq_vector_regs(i) = irqs;
		HT_irq_vector_regs(i) = irqs;
		HT_irq_vector_regs(i) = irqs;
//		irqs &= *(volatile unsigned int *)(HT_control_regs_base + 0xA0 + i*4);
		irqs &= ht_irq_mask[i];
		while((irq = ffs(irqs)) != 0){
			/*maybe reenter*/
			do_IRQ(64+i*32+irq-1, regs);
			irqs &= ~(1<<(irq-1));
		}
	}
}
 
void (*do_sb_bal_irq) (unsigned int irqs);

void rs780e_init_irq(void)
{
#define b(cpu) ((nr_cpu_ids>cpu)?(1<<cpu):1)
	//io_base_regs_addr = ioremap(io_base_regs_addr,0x1000);
/*ht it stripe 1*/
	if(ls3a_ht_stripe4)
		*(volatile int *)(HT_control_regs_base+0x58) = 0x200;
	else
		*(volatile int *)(HT_control_regs_base+0x58) = 0;

	/* Route the HT interrupt to Core0 INT1 */
	writeb_addr64(_INT_router_regs_HT1_int0,0x21);
	writeb_addr64(_INT_router_regs_HT1_int1,0x22);
	writeb_addr64(_INT_router_regs_HT1_int2,0x24);
	writeb_addr64(_INT_router_regs_HT1_int3,0x28);
	writeb_addr64(_INT_router_regs_HT1_int4,0x21);
	writeb_addr64(_INT_router_regs_HT1_int5,0x21);
	writeb_addr64(_INT_router_regs_HT1_int6,0x21);
	writeb_addr64(_INT_router_regs_HT1_int7,0x21);
	/* Enable the all HT interrupt */
	HT_irq_enable_reg0 = 0x0000ffff;
	HT_irq_enable_reg1 = 0x00000000;
	HT_irq_enable_reg2 = 0x00000000;
	HT_irq_enable_reg3 = 0x00000000;
	HT_irq_enable_reg4 = 0x00000000;
	HT_irq_enable_reg5 = 0x00000000;
	HT_irq_enable_reg6 = 0x00000000;
	HT_irq_enable_reg7 = 0x00000000;

	/* Enable the IO interrupt controller */ 
	writel_addr64(_IO_control_regs_Intenset, readl_addr64(_IO_control_regs_Inten) | (0xffff << 16));
	prom_printf("the new IO inten is %x\n", readl_addr64(_IO_control_regs_Inten));

	/* Sets the first-level interrupt dispatcher. */
	mips_cpu_irq_init(56);	

#ifdef CONFIG_I8259
	init_i8259_irqs();
#endif
	set_c0_status(STATUSF_IP6);
	do_sb_bal_irq = do_780e_bal_irq;
}
