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
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/irq.h>

#include <asm/io.h>
#include <asm/irq.h>
#include <asm/irq_cpu.h>
#include <asm/i8259.h>
#include <asm/mipsregs.h>
#include <asm/delay.h>
#include <asm/mips-boards/bonito64.h>
#include <linux/kmod.h>

#define	BONITO_INT_BIT_GPIO0		(1 << 0)
#define	BONITO_INT_BIT_GPIO1		(1 << 1)
#define	BONITO_INT_BIT_GPIO2		(1 << 2)
#define	BONITO_INT_BIT_GPIO3		(1 << 3)
#define	BONITO_INT_BIT_PCI_INTA		(1 << 4)
#define	BONITO_INT_BIT_PCI_INTB		(1 << 5)
#define	BONITO_INT_BIT_PCI_INTC		(1 << 6)
#define	BONITO_INT_BIT_PCI_INTD		(1 << 7)
#define	BONITO_INT_BIT_PCI_PERR		(1 << 8)
#define	BONITO_INT_BIT_PCI_SERR		(1 << 9)
#define	BONITO_INT_BIT_DDR		(1 << 10)
#define	BONITO_INT_BIT_INT0		(1 << 11)
#define	BONITO_INT_BIT_INT1		(1 << 12)
#define	BONITO_INT_BIT_INT2		(1 << 13)
#define	BONITO_INT_BIT_INT3		(1 << 14)

#define	BONITO_INT_TIMER_OFF		7
#define	BONITO_INT_BONITO_OFF		6
#define	BONITO_INT_UART_OFF			3
#define	BONITO_INT_I8259_OFF		2

/****************************************************************/


static void loongson2f_bonito_dispatch(void)
{
	int int_status;
	int i = 0;

	/* place the other interrupt on bit6 for bonito, inclding PCI and so on */
	int_status = BONITO_INTISR & BONITO_INTEN;
	
	for(i = 0; (i < 10) && int_status; i++){
		if(int_status & (1 << i)){
			if(i == 10)
				printk("ddr int.\n");
			if(int_status & 0x000000f0)
				do_IRQ(BONITO_IRQ_BASE + i);
			int_status &= ~(1 << i);
		}
	}
	
	return;
}



static void power_handler();

asmlinkage void plat_irq_dispatch(void)
{
	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;

	if(pending & CAUSEF_IP7){
		do_IRQ(MIPS_CPU_IRQ_BASE + BONITO_INT_TIMER_OFF);
	}else if(pending & CAUSEF_IP6){ /*north bridge*/
#ifdef CONFIG_PROFILING
		do_IRQ(MIPS_CPU_IRQ_BASE + 6);
#endif
		loongson2f_bonito_dispatch();
	}else if(pending & CAUSEF_IP5){
		do_IRQ(MIPS_CPU_IRQ_BASE + 5);
	}else if(pending & CAUSEF_IP4){
		do_IRQ(MIPS_CPU_IRQ_BASE + 4);
	}else if(pending & CAUSEF_IP3){ /*cpu uart*/
		do_IRQ(MIPS_CPU_IRQ_BASE + 3);
	}else if(pending & CAUSEF_IP2){ /*south bridge*/
#ifdef CONFIG_LOONGSON2F_SM502_GOLDING
		do_IRQ(MIPS_CPU_IRQ_BASE + 2);
#else
		power_handler();
#endif
	}else{
		spurious_interrupt();
	}
	return;
}

irqreturn_t ip6_action(int cpl, void *dev_id, struct pt_regs *regs)
{
	return IRQ_HANDLED;
}

static struct irqaction ip6_irqaction = {
	.handler = ip6_action,
	.mask = CPU_MASK_NONE,
	.name = "cascade",
	.flags = IRQF_SHARED,
};

void __init arch_init_irq(void)
{
	extern void bonito_irq_init(void);

	/*
	 * Clear all of the interrupts while we change the able around a bit.
	 * int-handler is not on bootstrap
	 */
	clear_c0_status(ST0_IM | ST0_BEV);
	local_irq_disable();
	

	/* no steer */
	BONITO_INTSTEER = 0;

	/*
	 * Mask out all interrupt by writing "1" to all bit position in
	 * the interrupt reset reg.
	 */
	BONITO_INTENCLR = ~0;

	/* init all controller
	 *   0-15         ------> i8259 interrupt
	 *   16-23        ------> mips cpu interrupt
	 *   32-63        ------> bonito irq
	 */
	
	/* Sets the first-level interrupt dispatcher. */
	mips_cpu_irq_init();

	bonito_irq_init();
	
	/* setup bonito interrupt */
	setup_irq(MIPS_CPU_IRQ_BASE + BONITO_INT_BONITO_OFF, &ip6_irqaction);
#ifndef CONFIG_LOONGSON2F_SM502_GOLDING
	setup_irq(MIPS_CPU_IRQ_BASE + 2, &ip6_irqaction);
#endif
}

static DECLARE_WAIT_QUEUE_HEAD(powerd_wait);
static button_pressed=0;
static void power_handler()
{
	disable_irq(MIPS_CPU_IRQ_BASE + 2);
	button_pressed=1;
	wake_up(&powerd_wait);
}

static int powerthread(void *unused)
{
	int ret;
	char *argv[2] = { NULL, NULL };
	char *envp[3] = { NULL, NULL, NULL };


	/* minimal command environment */
	envp[0] = "HOME=/";
	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";

	daemonize("powerd");
	if(!button_pressed)sleep_on(&powerd_wait);

	while(1)
	{
	argv[0] = "/sbin/halt";
	ret=call_usermodehelper(argv[0], argv, envp, 1);
	argv[0]="/sbin/init";
	argv[1]="0";
	if(ret)ret=call_usermodehelper(argv[0], argv, envp, 1);
	argv[0]="/sbin/shutdown";
	argv[1]=0;
	if(ret)ret=call_usermodehelper(argv[0], argv, envp, 1);
	schedule();
	}
	return 0;
}

static int __init mypower_init(void)
{
	kernel_thread(powerthread,0,CLONE_FS | CLONE_FILES );
	return 0;
}

late_initcall(mypower_init);
