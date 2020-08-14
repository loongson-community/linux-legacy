/* $Id: x86_setup.c,v 1.1 2004/06/01 08:45:11 fxzhang Exp $
 * Performance-monitoring counters driver.
 * x86/x86_64-specific kernel-resident code.
 *
 * Copyright (C) 1999-2004  Mikael Pettersson
 */
#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/interrupt.h>
#include <asm/processor.h>
#include <asm/perfctr.h>
#include <asm/fixmap.h>
#include <asm/apic.h>
#include "x86_compat.h"
#include "compat.h"

/* XXX: belongs to a virtual_compat.c file */
#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED && defined(CONFIG_PERFCTR_VIRTUAL) && LINUX_VERSION_CODE < KERNEL_VERSION(2,4,21) && !defined(HAVE_SET_CPUS_ALLOWED)
/**
 * set_cpus_allowed() - change a given task's processor affinity
 * @p: task to bind
 * @new_mask: bitmask of allowed processors
 *
 * Upon return, the task is running on a legal processor.  Note the caller
 * must have a valid reference to the task: it must not exit() prematurely.
 * This call can sleep; do not hold locks on call.
 */
void set_cpus_allowed(struct task_struct *p, unsigned long new_mask)
{
	new_mask &= cpu_online_map;
	BUG_ON(!new_mask);

	/* This must be our own, safe, call from sys_vperfctr_control(). */

	p->cpus_allowed = new_mask;

	/*
	 * If the task is on a no-longer-allowed processor, we need to move
	 * it.  If the task is not current, then set need_resched and send
	 * its processor an IPI to reschedule.
	 */
	if (!(p->cpus_runnable & p->cpus_allowed)) {
		if (p != current) {
			p->need_resched = 1;
			smp_send_reschedule(p->processor);
		}
		/*
		 * Wait until we are on a legal processor.  If the task is
		 * current, then we should be on a legal processor the next
		 * time we reschedule.  Otherwise, we need to wait for the IPI.
		 */
		while (!(p->cpus_runnable & p->cpus_allowed))
			schedule();
	}
}
EXPORT_SYMBOL(set_cpus_allowed);
#endif

#if PERFCTR_INTERRUPT_SUPPORT
static void perfctr_default_ihandler(unsigned long pc)
{
}

static perfctr_ihandler_t perfctr_ihandler = perfctr_default_ihandler;

asmlinkage void smp_perfctr_interrupt(struct pt_regs *regs)
{
	/* PREEMPT note: invoked via an interrupt gate, which
	   masks interrupts. We're still on the originating CPU. */
	/* XXX: recursive interrupts? delay the ACK, mask LVTPC, or queue? */
	ack_APIC_irq();
	irq_enter();
	(*perfctr_ihandler)(instruction_pointer(regs));
	irq_exit();
}

void perfctr_cpu_set_ihandler(perfctr_ihandler_t ihandler)
{
	perfctr_ihandler = ihandler ? ihandler : perfctr_default_ihandler;
}
#endif

#ifdef __x86_64__
extern unsigned int cpu_khz;
#else
extern unsigned long cpu_khz;
#endif

/* Wrapper to avoid namespace clash in RedHat 8.0's 2.4.18-14 kernel. */
unsigned int perfctr_cpu_khz(void)
{
	return cpu_khz;
}

#ifdef CONFIG_PERFCTR_MODULE
EXPORT_SYMBOL_mmu_cr4_features;
EXPORT_SYMBOL(perfctr_cpu_khz);

#ifdef NMI_LOCAL_APIC
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6)
EXPORT_SYMBOL(nmi_perfctr_msr);
#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,67) && defined(CONFIG_PM)
EXPORT_SYMBOL(apic_pm_register);
EXPORT_SYMBOL(apic_pm_unregister);
EXPORT_SYMBOL(nmi_pmdev);
#endif

#endif /* NMI_LOCAL_APIC */

#if PERFCTR_INTERRUPT_SUPPORT
EXPORT_SYMBOL(perfctr_cpu_set_ihandler);
#endif /* PERFCTR_INTERRUPT_SUPPORT */

#endif /* MODULE */
