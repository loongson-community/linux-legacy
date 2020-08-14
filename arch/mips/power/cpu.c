/*
 * Suspend support specific for mips.
 *
 */
#include <linux/mm.h>
#include <asm/mipsregs.h>
#include <asm/page.h>
#include <asm/suspend.h>

/* References to section boundaries */
extern const void __nosave_begin, __nosave_end;
static uint32_t saved_status;
unsigned long 
	 saved_ra,
	 saved_sp,
	 saved_fp,
	 saved_gp,
	 saved_s0,
	 saved_s1,
	 saved_s2,
	 saved_s3,
	 saved_s4,
	 saved_s5,
	 saved_s6,
	 saved_s7,
	 saved_a0,
	 saved_a1,
	 saved_a2,
	 saved_a3,
	 saved_v0,
	 saved_v1;

void save_processor_state(void)
{
	saved_status = read_c0_status();
}

void restore_processor_state(void)
{
	write_c0_status(saved_status);
}

int pfn_is_nosave(unsigned long pfn)
{
 	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
 	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
 	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
}
