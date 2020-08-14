#incldue <linux/linkage.h>
#include <asm/asm-offsets.h>
#include <asm/regdef.h>
#include <asm/asm.h>

.text 
LEAF(swsusp_arch_suspend)
	 PTR_LA t0, saved_ra
	 PTR_S ra, (t0)
	 PTR_LA t0, saved_sp
	 PTR_S sp, (t0)
	 PTR_LA t0, saved_fp
	 PTR_S fp, (t0)
	 PTR_LA t0, saved_gp
	 PTR_S gp, (t0)
	 PTR_LA t0, saved_s0
	 PTR_S s0, (t0) 
	 PTR_LA t0, saved_s1
	 PTR_S s1, (t0)
	 PTR_LA t0, saved_s2
	 PTR_S s2, (t0)
	 PTR_LA t0, saved_s3
	 PTR_S s3, (t0)
	 PTR_LA t0, saved_s4
	 PTR_S s4, (t0)
	 PTR_LA t0, saved_s5
	 PTR_S s5, (t0)
	 PTR_LA t0, saved_s6
	 PTR_S s6, (t0)
	 PTR_LA t0, saved_s7
	 PTR_S s7, (t0)
	 PTR_LA t0, saved_a0
	 PTR_S a0, (t0)
	 PTR_LA t0, saved_a1
	 PTR_S a1, (t0)
	 PTR_LA t0, saved_a2
	 PTR_S a2, (t0)
	 PTR_LA t0, saved_v1
	 PTR_S v1, (t0)
	 j swsusp_save
	 nop
END(swsusp_arch_suspend)

LEAF(swsusp_arch_resume)
	PTR_L t0, restore_pblist
0: 
	PTR_L t1, PBE_ADDRESS(t0)   /* source */
 	PTR_L t2, PBE_ORIG_ADDRESS(t0) /* destination */
 	PTR_ADDIU t3, t1, _PAGE_SIZE
1: 
	REG_L t8, (t1)
 	REG_S t8, (t2)
 	PTR_ADDIU t1, t1, SZREG
 	PTR_ADDIU t2, t2, SZREG
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
	//flush cache and tlb. no need?I am not sure.
	PTR_L ra, saved_ra
	PTR_L sp, saved_sp
	PTR_L fp, saved_fp
	PTR_L s0, saved_s0
	PTR_L s1, saved_s1
	PTR_L s2, saved_s2
	PTR_L s3, saved_s3
	PTR_L s4, saved_s4
	PTR_L s5, saved_s5
	PTR_L s6, saved_s6
	PTR_L s7, saved_s7
	PTR_L a0, saved_a0
	PTR_L a1, saved_a1
	PTR_L a2, saved_a2
	PTR_L a3, saved_a3
	PTR_LI v0, 0x0 
	PTR_L v1, saved_v1
	jr ra
	nop
END(swsusp_arch_resume)
