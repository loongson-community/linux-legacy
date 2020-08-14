#include <linux/config.h>
#include <linux/init.h>
#include <linux/irq.h>
#include <linux/types.h>
#include <linux/ptrace.h>
#include <linux/interrupt.h>
#include <linux/kernel.h>

#include <asm/io.h>
#include <asm/system.h>
#include <asm/mipsregs.h>
#include <asm/godson/godson_sim.h>
#include <asm/godson/godson_sim_int.h>

static void godson_sim_irq_enable(unsigned int irq)
{
	unsigned int val;

	val = read_c0_status();
/* interrupts we have now: 
 *   irq=4, serial, on hw1
 *   irq=10, ethernet, on hw2
 *   irq=26, perfctr, on hw4
 *   irq=63, cpu timer, on hw5 
 */
	if (irq==4) {
	  val |= IE_IRQ1;
	}else if (irq==10) {
	  val |= IE_IRQ2;
	}else if (irq==26) {
	  val |= IE_IRQ4;
	}else{
	  val |= IE_IRQ5;
	}
	write_c0_status(val);
}


static void godson_sim_irq_disable(unsigned int irq)
{
	unsigned int val;

	val = read_c0_status();
	if (irq==4) {
	  val &= ~IE_IRQ1;
	}else if (irq==10) {
	  val &= ~IE_IRQ2;
	}else if (irq==26) {
	  val &= ~IE_IRQ4;
	}else{
	  val &= ~IE_IRQ5;
	}
	write_c0_status(val);
}

static unsigned int godson_sim_irq_startup(unsigned int irq)
{
	godson_sim_irq_enable(irq);
	return 0;
}


#define	godson_sim_irq_shutdown	godson_sim_irq_disable
#define	godson_sim_irq_ack	godson_sim_irq_disable
#define	godson_sim_irq_end	godson_sim_irq_enable

hw_irq_controller godson_sim_irq_controller = {
	"godson sim_irq",
	godson_sim_irq_startup,
	godson_sim_irq_shutdown,
	godson_sim_irq_enable,
	godson_sim_irq_disable,
	godson_sim_irq_ack,
	godson_sim_irq_end,
	NULL			/* no affinity stuff for UP */
};


void
godson_sim_irq_init(void)
{
	extern irq_desc_t irq_desc[];
	u32 i;

	for(i = 0; i<GODSON_SIM_INT_END; i++) {
		irq_desc[i].status = IRQ_DISABLED;
		irq_desc[i].action = NULL;
		irq_desc[i].depth = 1;
		irq_desc[i].handler = &godson_sim_irq_controller;
	}
}

extern asmlinkage void godson_sim_IRQ(void);
void __init init_IRQ(void)
{

	prom_printf("init_IRQ invoked.\n");

	clear_c0_status(ST0_IM | ST0_BEV);
	__cli();

	/* init all controllers */
	init_generic_irq();
	godson_sim_irq_init();

	/* hook up the first-level interrupt handler */
	set_except_vector(0, godson_sim_IRQ);

	prom_printf("init_IRQ done.\n");
}


