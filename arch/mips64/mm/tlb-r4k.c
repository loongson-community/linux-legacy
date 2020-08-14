/*
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
 *
 * This program is free software; you can distribute it and/or modify it
 * under the terms of the GNU General Public License (Version 2) as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * MIPS64 CPU variant specific MMU routines.
 * These routine are not optimized in any way, they are done in a generic way
 * so they can be used on all MIPS64 compliant CPUs, and also done in an
 * attempt not to break anything for the R4xx0 style CPUs.
 */
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/mm.h>

#include <asm/cpu.h>
#include <asm/bootinfo.h>
#include <asm/mmu_context.h>
#include <asm/pgtable.h>
#include <asm/system.h>

#undef DEBUG_TLB
#ifdef CONFIG_RTHAL
#if 1
/*
 * You may likely need this for your board...
 * Sucks that this eats away at some RTAI performance, too. :(
 * 
 * (then again, it beats crashing) -- don't forget include/asm/mmu_context.h
 */

#undef local_irq_save
#undef local_irq_restore
#define IRQ_SAFE_TLB
#define local_irq_save(x) hard_save_flags_and_cli(x)
#define local_irq_restore(x) hard_restore_flags(x)
#endif
#endif
#undef DEBUG_TLBUPDATE

extern void except_vec1_r4k(void);

/* CP0 hazard avoidance. */
#if defined(CONFIG_CPU_GODSON1) || defined(CONFIG_CPU_GODSON2) || defined(CONFIG_CPU_LOONGSON3)
#define BARRIER
#else
#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
				     "nop; nop; nop; nop; nop; nop;\n\t" \
				     ".set reorder\n\t")
#endif

void local_flush_tlb_all(void)
{
	unsigned long flags;
	unsigned long old_ctx;
	int entry;

#ifdef DEBUG_TLB
	printk("[tlball]");
#endif

	local_irq_save(flags);
	/* Save old context and create impossible VPN2 value */
	old_ctx = read_c0_entryhi();
	write_c0_entryhi(XKPHYS);
	write_c0_entrylo0(0);
	write_c0_entrylo1(0);
	BARRIER;

	entry = read_c0_wired();

	/* Blast 'em all away. */
	while(entry < current_cpu_data.tlbsize) {
	        /* Make sure all entries differ. */
	        write_c0_entryhi(XKPHYS+entry*2*PAGE_SIZE);
		write_c0_index(entry);
		BARRIER;
		tlb_write_indexed();
		BARRIER;
		entry++;
	}
	BARRIER;
	write_c0_entryhi(old_ctx);
#if defined(CONFIG_CPU_GODSON2) || defined(CONFIG_CPU_LOONGSON3)
        __asm__ __volatile__ ("mtc0 %0,$22;"::"r"(0x4));
#endif
	local_irq_restore(flags);
}

void local_flush_tlb_mm(struct mm_struct *mm)
{
	int cpu = smp_processor_id();

	if (cpu_context(cpu, mm) != 0) {
#ifdef DEBUG_TLB
		printk("[tlbmm<%d>]", mm->context);
#endif
		drop_mmu_context(mm,cpu);
	}
}

void local_flush_tlb_range(struct mm_struct *mm, unsigned long start,
				unsigned long end)
{
	int cpu = smp_processor_id();

	if (cpu_context(cpu, mm) != 0) {
		unsigned long flags;
		int size;

#ifdef DEBUG_TLB
		printk("[tlbrange<%02x,%08lx,%08lx>]", (mm->context & ASID_MASK),
		       start, end);
#endif
		local_irq_save(flags);
		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
		size = (size + 1) >> 1;
		if (size <= current_cpu_data.tlbsize/2) {
			int oldpid = read_c0_entryhi() & ASID_MASK;
			int newpid = cpu_asid(cpu, mm);

			start &= (PAGE_MASK << 1);
			end += ((PAGE_SIZE << 1) - 1);
			end &= (PAGE_MASK << 1);
			while(start < end) {
				int idx;

				write_c0_entryhi(start | newpid);
				start += (PAGE_SIZE << 1);
				BARRIER;
				tlb_probe();
				BARRIER;
				idx = read_c0_index();
				write_c0_entrylo0(0);
				write_c0_entrylo1(0);
				if(idx < 0)
					continue;
				/* Make sure all entries differ. */
				write_c0_entryhi(XKPHYS+idx*2*PAGE_SIZE);
				BARRIER;
				tlb_write_indexed();
				BARRIER;
			}
			write_c0_entryhi(oldpid);
		} else {
			drop_mmu_context(mm, cpu);
		}
#if defined(CONFIG_CPU_GODSON2) || defined(CONFIG_CPU_LOONGSON3)
                __asm__ __volatile__ ("mtc0 %0,$22;"::"r"(0x4));
#endif
		local_irq_restore(flags);
	}
}

void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
{
	int cpu = smp_processor_id();

	if (cpu_context(cpu, vma->vm_mm) != 0) {
		unsigned long flags;
		unsigned long oldpid, newpid, idx;

#ifdef DEBUG_TLB
		printk("[tlbpage<%d,%08lx>]", vma->vm_mm->context, page);
#endif
		newpid = cpu_asid(cpu, vma->vm_mm);
		page &= (PAGE_MASK << 1);
		local_irq_save(flags);
		oldpid = (read_c0_entryhi() & ASID_MASK);
		write_c0_entryhi(page | newpid);
		BARRIER;
		tlb_probe();
		BARRIER;
		idx = read_c0_index();
		write_c0_entrylo0(0);
		write_c0_entrylo1(0);
		if(idx < 0)
			goto finish;
		/* Make sure all entries differ. */
		write_c0_entryhi(XKPHYS+idx*2*PAGE_SIZE);
		BARRIER;
		tlb_write_indexed();
	finish:
		BARRIER;
		write_c0_entryhi(oldpid);
#if defined(CONFIG_CPU_GODSON2) || defined(CONFIG_CPU_LOONGSON3)
	        {
         		int exec = vma->vm_flags & VM_EXEC;
		        if (exec) {
        			__asm__ __volatile__ ("mtc0 %0,$22;"::"r"(0x4));
         	 	}
       		}
#endif
		local_irq_restore(flags);
	}
}

/*
 * Remove one kernel space TLB entry.  This entry is assumed to be marked
 * global so we don't do the ASID thing.
 */
void local_flush_tlb_one(unsigned long page)
{
	unsigned long flags;
	int oldpid, idx;

	page &= (PAGE_MASK << 1);
	oldpid = read_c0_entryhi();

	local_irq_save(flags);
	write_c0_entryhi(page);
	BARRIER;
	tlb_probe();
	BARRIER;
	idx = read_c0_index();
	write_c0_entrylo0(0);
	write_c0_entrylo1(0);
	if (idx >= 0) {
		/* Make sure all entries differ. */
		write_c0_entryhi(KSEG0+idx*0x2000);
		tlb_write_indexed();
	}
	BARRIER;
	write_c0_entryhi(oldpid);
	local_irq_restore(flags);
}

/*
 * Updates the TLB with the new pte(s).
 */
void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
{
	unsigned long flags;
	unsigned int asid;
	pgd_t *pgdp;
	pmd_t *pmdp;
	pte_t *ptep;
	int idx, pid;

	/*
	 * Handle debugger faulting in for debugee.
	 */
	if (current->active_mm != vma->vm_mm)
		return;

	pid = read_c0_entryhi() & ASID_MASK;

#ifdef DEBUG_TLB
	if ((pid != (cpu_asid(smp_processor_id(), vma->vm_mm))) ||
	   (cpu_context(smp_processor_id(), vma->vm_mm) == 0)) {
		printk("update_mmu_cache: Wheee, bogus tlbpid mmpid=%d"
		       "tlbpid=%d\n", (int) (cpu_context(smp_processor_id(),
		       vma->vm_mm) & ASID_MASK), pid);
	}
#endif

	local_irq_save(flags);
	address &= (PAGE_MASK << 1);
	write_c0_entryhi(address | (pid));
	pgdp = pgd_offset(vma->vm_mm, address);
	BARRIER;
	tlb_probe();
	BARRIER;
	pmdp = pmd_offset(pgdp, address);
	idx = read_c0_index();
	ptep = pte_offset(pmdp, address);
	BARRIER;
	write_c0_entrylo0(pte_val(*ptep++) >> 6);
	write_c0_entrylo1(pte_val(*ptep) >> 6);
	write_c0_entryhi(address | (pid));
	BARRIER;
	if(idx < 0) {
		tlb_write_random();
	} else {
		tlb_write_indexed();
	}
	BARRIER;
	write_c0_entryhi(pid);
	BARRIER;
#if defined(CONFIG_CPU_GODSON2) || defined(CONFIG_CPU_LOONGSON3)
        {
          int exec = vma->vm_flags & VM_EXEC;
          if (exec) {
        __asm__ __volatile__ ("mtc0 %0,$22;"::"r"(0x4));
          }
        }
#endif
	local_irq_restore(flags);
}

void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
				      unsigned long entryhi, unsigned long pagemask)
{
        unsigned long flags;
        unsigned long wired;
        unsigned long old_pagemask;
        unsigned long old_ctx;

        local_irq_save(flags);
        /* Save old context and create impossible VPN2 value */
        old_ctx = (read_c0_entryhi() & ASID_MASK);
        old_pagemask = read_c0_pagemask();
        wired = read_c0_wired();
        write_c0_wired(wired + 1);
        write_c0_index(wired);
        BARRIER;
        write_c0_pagemask(pagemask);
        write_c0_entryhi(entryhi);
        write_c0_entrylo0(entrylo0);
        write_c0_entrylo1(entrylo1);
        BARRIER;
        tlb_write_indexed();
        BARRIER;

        write_c0_entryhi(old_ctx);
        BARRIER;
        write_c0_pagemask(old_pagemask);
        local_flush_tlb_all();
        local_irq_restore(flags);
}

/*
 * Used for loading TLB entries before trap_init() has started, when we
 * don't actually want to add a wired entry which remains throughout the
 * lifetime of the system
 */

static int temp_tlb_entry __initdata;

__init int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
			       unsigned long entryhi, unsigned long pagemask)
{
	int ret = 0;
	unsigned long flags;
	unsigned long wired;
	unsigned long old_pagemask;
	unsigned long old_ctx;

	local_irq_save(flags);
	/* Save old context and create impossible VPN2 value */
	old_ctx = read_c0_entryhi() & ASID_MASK;
	old_pagemask = read_c0_pagemask();
	wired = read_c0_wired();
	if (--temp_tlb_entry < wired) {
		printk(KERN_WARNING "No TLB space left for add_temporary_entry\n");
		ret = -ENOSPC;
		goto out;
	}

	write_c0_index(temp_tlb_entry);
	BARRIER;
	write_c0_pagemask(pagemask);
	write_c0_entryhi(entryhi);
	write_c0_entrylo0(entrylo0);
	write_c0_entrylo1(entrylo1);
	BARRIER;
	tlb_write_indexed();
	BARRIER;

	write_c0_entryhi(old_ctx);
	BARRIER;
	write_c0_pagemask(old_pagemask);
out:
	local_irq_restore(flags);
	return ret;
}

static void __init probe_tlb(unsigned long config)
{
	struct cpuinfo_mips *c = &current_cpu_data;
	unsigned int config1;

	/*
	 * If this isn't a MIPS32 / MIPS64 compliant CPU.  Config 1 register
	 * is not supported, we assume R4k style.  Cpu probing already figured
	 * out the number of tlb entries.
	 */
	if ((c->processor_id  & 0xff0000) == PRID_COMP_LEGACY)
		return;

	config1 = read_c0_config1();
	if (!((config1 >> 7) & 3))
		panic("No MMU present");

	c->tlbsize = ((config1 >> 25) & 0x3f) + 1;
}

void __init r4k_tlb_init(void)
{
	unsigned long config = read_c0_config();
	probe_tlb(config);
	write_c0_pagemask(PM_DEFAULT_MASK);
	write_c0_wired(0);
	temp_tlb_entry = current_cpu_data.tlbsize - 1;
	local_flush_tlb_all();

	memcpy((void *)(KSEG0 + 0x80), except_vec1_r4k, 0x80);
#ifdef CONFIG_CPU_GODSON2
	memcpy((void *)(KSEG0), except_vec1_r4k, 0x80);
#endif
	flush_icache_range(KSEG0, KSEG0 + 0x100);
}
