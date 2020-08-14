/*
 * CS5536 General timer functions
 *
 */
#include <linux/clockchips.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/jiffies.h>
#include <linux/module.h>
#include <linux/spinlock.h>

#include <asm/delay.h>
#include <asm/io.h>
#include <asm/time.h>

DEFINE_SPINLOCK(mfgpt_lock);

#if 1
#define MFGFT_TICK_RATE 14318000
#else
#define MFGFT_TICK_RATE (14318180 / 8)
#endif
#define COMPARE  ((MFGFT_TICK_RATE + HZ/2) / HZ)

extern void _wrmsr(u32 reg, u32 hi, u32 lo);
extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);

static u32 base ;

/*
 * Initialize the MFGPT timer.
 *
 * This is also called after resume to bring the MFGPT into operation again.
 */
/* setup register bit fields:
   15: counter enable
   14: compare2 output status, write 1 to clear when in event mode
   13: compare1 output status
   12: setup(ro)
   11: stop enable, stop on sleep
   10: external enable
   9:8 compare2 mode; 00: disable, 01: compare on equal; 10: compare on GE, 11 event: GE + irq
   7:6 compare1 mode
   5:  reverse enable, bit reverse of the counter
   4:  clock select. 0: 32KHz, 1: 14.318MHz
   3:0 counter prescaler scale factor. select the input clock divide-by value. 2^n
   bit 11:0 is write once.
*/
   
 
static void init_mfgpt_timer(enum clock_event_mode mode,
			   struct clock_event_device *evt)
{
	spin_lock(&mfgpt_lock);

	switch(mode) {
	case CLOCK_EVT_MODE_PERIODIC:
		/* set comparator2 */
		outw(COMPARE, base + 2);
		/* set counter to 0 */
		outw(0, base + 4);
		/* setup; enable, comparator2 to event mode,14.318MHz clock */
		//outw(0xe313, base + 6);
		outw(0xe310, base + 6);
		break;

	case CLOCK_EVT_MODE_SHUTDOWN:
	case CLOCK_EVT_MODE_UNUSED:
		if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
		    evt->mode == CLOCK_EVT_MODE_ONESHOT) {
			/* disable counter */
			outw(inw(base+6) & 0x7fff, base + 6);
		}
		break;

	case CLOCK_EVT_MODE_ONESHOT:
		/* One shot setup */
		break;

	case CLOCK_EVT_MODE_RESUME:
		/* Nothing to do here */
		break;
	}
	spin_unlock(&mfgpt_lock);
}

/*
 * Program the next event in oneshot mode
 *
 * Delta is given in MFGPT ticks
 */
static int mfgpt_next_event(unsigned long delta, struct clock_event_device *evt)
{
	spin_lock(&mfgpt_lock);

	/* set comparator2 */
	outw(delta & 0xffff, base + 2);
	/* set counter to 0 */
	outw(0, base + 4);
	/* setup; enable, comparator2 */
	outw(0xe310, base + 6);

	spin_unlock(&mfgpt_lock);

	return 0;
}

static struct clock_event_device mfgpt_clockevent = {
	.name		= "mfgpt",
	.features	= CLOCK_EVT_FEAT_PERIODIC,
	.set_mode	= init_mfgpt_timer,
	.set_next_event = mfgpt_next_event,
	.rating         = 2000,
	.irq		= 5,
};

static irqreturn_t timer_interrupt(int irq, void *dev_id)
{
	u32 basehi,baselo;

	_rdmsr(0x8000000d,&basehi,&baselo);

	base = baselo;
	/* ack */
//	outw(0x0, baselo + 4);
	outw(0xc000, baselo + 6);

	mfgpt_clockevent.event_handler(&mfgpt_clockevent);

	return IRQ_HANDLED;
}

static struct irqaction irq5  = {
	.handler = timer_interrupt,
	.flags = IRQF_DISABLED | IRQF_NOBALANCING,
	.mask = CPU_MASK_NONE,
	.name = "timer"
};

/*
 * Initialize the conversion factor and the min/max deltas of the clock event
 * structure and register the clock event source with the framework.
 */
void __init setup_mfgpt_timer(void)
{
	u32 basehi;
	struct clock_event_device *cd = &mfgpt_clockevent;
	unsigned int cpu = smp_processor_id();

	cd->cpumask = cpumask_of_cpu(cpu);
	clockevent_set_clock(cd, MFGFT_TICK_RATE);
	cd->max_delta_ns = clockevent_delta2ns(0xFFFF, cd);
	cd->min_delta_ns = clockevent_delta2ns(0xF, cd);

	/* connect multifunction timer0 comparator 2 to irq mapper*/
	_wrmsr(0x80000028, 0, 0x100);

	/* map unrestricted interrupt source Z4 to IG5 */
	_wrmsr(0x80000022, 0, 0x50000);

	_rdmsr(0x8000000d, &basehi, &base);

	irq5.mask = cpumask_of_cpu(cpu);

	clockevents_register_device(cd);

	setup_irq(5, &irq5);

}

/*
 * Since the MFGPT overflows every tick, its not very useful
 * to just read by itself. So use jiffies to emulate a free
 * running counter:
 */
static cycle_t mfgpt_read(void)
{
	static cycle_t count, old_count;
	static unsigned long old_jifs;
	unsigned long jifs;
	unsigned long flags;

	spin_lock_irqsave(&mfgpt_lock, flags);

	jifs = jiffies;

	count =  inw(base + 4);

	/* overflow ?*/
	if (count < old_count && jifs == old_jifs) {
		count = old_count;
	}
	old_count = count;
	old_jifs = jifs;

	spin_unlock_irqrestore(&mfgpt_lock, flags);

	return (cycle_t)(jifs * COMPARE) + count;
}

static struct clocksource clocksource_mfgpt = {
	.name	= "mfgpt",
	.rating = 1200,
	.read	= mfgpt_read,
	.mask	= CLOCKSOURCE_MASK(32),
	.mult	= 0,
	.shift	= 22,
};

int __init init_mfgpt_clocksource(void)
{

	if (num_possible_cpus() > 1) /* MFGPT does not scale! */
		return 0;

	setup_mfgpt_timer();

	clocksource_mfgpt.mult = clocksource_hz2mult(MFGFT_TICK_RATE, 22);
	return clocksource_register(&clocksource_mfgpt);
}
/* Too late for kernel calc delay */
//arch_initcall(init_mfgpt_clocksource);
