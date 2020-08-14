#ifndef __IRQREGS__H__
#define __IRQREGS__H__

#include <asm/mach-loongson/boot_param.h>

#define LOONGSON_INT_BIT_INT0			(1 << 11)
#define LOONGSON_INT_BIT_INT1			(1 << 12)

#define LOONGSON3_INT_BIT_HT_INT0		loongson_int_bit_ht_int0
#define IO_base_regs_addr			io_base_regs_addr

#define	smp_core_group0_base			smp_group0
#define	smp_core_group1_base			smp_group1
#define	smp_core_group2_base			smp_group2
#define	smp_core_group3_base			smp_group3

#if 0
#define IO_control_regs_Intisr			*(volatile unsigned int *)(IO_base_regs_addr + 0x1420)
#define IO_control_regs_Inten			*(volatile unsigned int *)(IO_base_regs_addr + 0x1424)
#define IO_control_regs_Intenset		*(volatile unsigned int *)(IO_base_regs_addr + 0x1428)
#define IO_control_regs_Intenclr		*(volatile unsigned int *)(IO_base_regs_addr + 0x142c)
#define IO_control_regs_Intedge			*(volatile unsigned int *)(IO_base_regs_addr + 0x1438)
#define IO_control_regs_CORE0_INTISR	*(volatile unsigned int *)(IO_base_regs_addr + 0x1440)
#define IO_control_regs_CORE1_INTISR	*(volatile unsigned int *)(IO_base_regs_addr + 0x1448)
#define IO_control_regs_CORE2_INTISR	*(volatile unsigned int *)(IO_base_regs_addr + 0x1450)
#define IO_control_regs_CORE3_INTISR	*(volatile unsigned int *)(IO_base_regs_addr + 0x1458)

#define INT_router_regs_sys_int0		*(volatile unsigned char *)(IO_base_regs_addr + 0x1400)
#define INT_router_regs_sys_int1		*(volatile unsigned char *)(IO_base_regs_addr + 0x1401)
#define INT_router_regs_sys_int2		*(volatile unsigned char *)(IO_base_regs_addr + 0x1402)
#define INT_router_regs_sys_int3		*(volatile unsigned char *)(IO_base_regs_addr + 0x1403)
#define INT_router_regs_pci_int0		*(volatile unsigned char *)(IO_base_regs_addr + 0x1404)
#define INT_router_regs_pci_int1		*(volatile unsigned char *)(IO_base_regs_addr + 0x1405)
#define INT_router_regs_pci_int2		*(volatile unsigned char *)(IO_base_regs_addr + 0x1406)
#define INT_router_regs_pci_int3		*(volatile unsigned char *)(IO_base_regs_addr + 0x1407)
#define INT_router_regs_matrix_int0		*(volatile unsigned char *)(IO_base_regs_addr + 0x1408)
#define INT_router_regs_matrix_int1		*(volatile unsigned char *)(IO_base_regs_addr + 0x1409)
#define INT_router_regs_lpc_int			*(volatile unsigned char *)(IO_base_regs_addr + 0x140a)
#define INT_router_regs_mc0				*(volatile unsigned char *)(IO_base_regs_addr + 0x140b)
#define INT_router_regs_mc1				*(volatile unsigned char *)(IO_base_regs_addr + 0x140c)
#define INT_router_regs_barrier			*(volatile unsigned char *)(IO_base_regs_addr + 0x140d)
#define INT_router_regs_reserve			*(volatile unsigned char *)(IO_base_regs_addr + 0x140e)
#define INT_router_regs_pci_perr		*(volatile unsigned char *)(IO_base_regs_addr + 0x140f)

#define INT_router_regs_HT0_int0		*(volatile unsigned char *)(IO_base_regs_addr + 0x1410)
#define INT_router_regs_HT0_int1		*(volatile unsigned char *)(IO_base_regs_addr + 0x1411)
#define INT_router_regs_HT0_int2		*(volatile unsigned char *)(IO_base_regs_addr + 0x1412)
#define INT_router_regs_HT0_int3		*(volatile unsigned char *)(IO_base_regs_addr + 0x1413)
#define INT_router_regs_HT0_int4		*(volatile unsigned char *)(IO_base_regs_addr + 0x1414)
#define INT_router_regs_HT0_int5		*(volatile unsigned char *)(IO_base_regs_addr + 0x1415)
#define INT_router_regs_HT0_int6		*(volatile unsigned char *)(IO_base_regs_addr + 0x1416)
#define INT_router_regs_HT0_int7		*(volatile unsigned char *)(IO_base_regs_addr + 0x1417)
#define INT_router_regs_HT1_int0		*(volatile unsigned char *)(IO_base_regs_addr + 0x1418)
#define INT_router_regs_HT1_int1		*(volatile unsigned char *)(IO_base_regs_addr + 0x1419)
#define INT_router_regs_HT1_int2		*(volatile unsigned char *)(IO_base_regs_addr + 0x141a)
#define INT_router_regs_HT1_int3		*(volatile unsigned char *)(IO_base_regs_addr + 0x141b)
#define INT_router_regs_HT1_int4		*(volatile unsigned char *)(IO_base_regs_addr + 0x141c)
#define INT_router_regs_HT1_int5		*(volatile unsigned char *)(IO_base_regs_addr + 0x141d)
#define INT_router_regs_HT1_int6		*(volatile unsigned char *)(IO_base_regs_addr + 0x141e)
#define INT_router_regs_HT1_int7		*(volatile unsigned char *)(IO_base_regs_addr + 0x141f)
#endif

#define _IO_control_regs_Intisr			(IO_base_regs_addr + 0x1420)
#define _IO_control_regs_Inten			(IO_base_regs_addr + 0x1424)
#define _IO_control_regs_Intenset		(IO_base_regs_addr + 0x1428)
#define _IO_control_regs_Intenclr		(IO_base_regs_addr + 0x142c)
#define _IO_control_regs_Intedge		(IO_base_regs_addr + 0x1438)
#define _IO_control_regs_CORE0_INTISR	(IO_base_regs_addr + 0x1440)
#define _IO_control_regs_CORE1_INTISR	(IO_base_regs_addr + 0x1448)
#define _IO_control_regs_CORE2_INTISR	(IO_base_regs_addr + 0x1450)
#define _IO_control_regs_CORE3_INTISR	(IO_base_regs_addr + 0x1458)

#define _INT_router_regs_sys_int0		(IO_base_regs_addr + 0x1400)
#define _INT_router_regs_sys_int1		(IO_base_regs_addr + 0x1401)
#define _INT_router_regs_sys_int2		(IO_base_regs_addr + 0x1402)
#define _INT_router_regs_sys_int3		(IO_base_regs_addr + 0x1403)
#define _INT_router_regs_pci_int0		(IO_base_regs_addr + 0x1404)
#define _INT_router_regs_pci_int1		(IO_base_regs_addr + 0x1405)
#define _INT_router_regs_pci_int2		(IO_base_regs_addr + 0x1406)
#define _INT_router_regs_pci_int3		(IO_base_regs_addr + 0x1407)
#define _INT_router_regs_matrix_int0		(IO_base_regs_addr + 0x1408)
#define _INT_router_regs_matrix_int1		(IO_base_regs_addr + 0x1409)
#define _INT_router_regs_lpc_int			(IO_base_regs_addr + 0x140a)
#define _INT_router_regs_mc0				(IO_base_regs_addr + 0x140b)
#define _INT_router_regs_mc1				(IO_base_regs_addr + 0x140c)
#define _INT_router_regs_barrier			(IO_base_regs_addr + 0x140d)
#define _INT_router_regs_reserve			(IO_base_regs_addr + 0x140e)
#define _INT_router_regs_pci_perr		(IO_base_regs_addr + 0x140f)

#define _INT_router_regs_HT0_int0		(IO_base_regs_addr + 0x1410)
#define _INT_router_regs_HT0_int1		(IO_base_regs_addr + 0x1411)
#define _INT_router_regs_HT0_int2		(IO_base_regs_addr + 0x1412)
#define _INT_router_regs_HT0_int3		(IO_base_regs_addr + 0x1413)
#define _INT_router_regs_HT0_int4		(IO_base_regs_addr + 0x1414)
#define _INT_router_regs_HT0_int5		(IO_base_regs_addr + 0x1415)
#define _INT_router_regs_HT0_int6		(IO_base_regs_addr + 0x1416)
#define _INT_router_regs_HT0_int7		(IO_base_regs_addr + 0x1417)
#define _INT_router_regs_HT1_int0		(IO_base_regs_addr + 0x1418)
#define _INT_router_regs_HT1_int1		(IO_base_regs_addr + 0x1419)
#define _INT_router_regs_HT1_int2		(IO_base_regs_addr + 0x141a)
#define _INT_router_regs_HT1_int3		(IO_base_regs_addr + 0x141b)
#define _INT_router_regs_HT1_int4		(IO_base_regs_addr + 0x141c)
#define _INT_router_regs_HT1_int5		(IO_base_regs_addr + 0x141d)
#define _INT_router_regs_HT1_int6		(IO_base_regs_addr + 0x141e)
#define _INT_router_regs_HT1_int7		(IO_base_regs_addr + 0x141f)

/* LS3 LPC regs */
#define Local_IO_regs_Base			0xffffffffbfe00000
#define LS3_LPC_INT_regs_ctrl			(Local_IO_regs_Base + 0x0200)
#define LS3_LPC_INT_regs_enable			(Local_IO_regs_Base + 0x0204)
#define LS3_LPC_INT_regs_status			(Local_IO_regs_Base + 0x0208)
#define LS3_LPC_INT_regs_clear			(Local_IO_regs_Base + 0x020c)

/* 2H LPC regs */
#define LS2H_LPC_REG_BASE0			0xffffffffbbf10000
#define LS2H_LPC_INT_regs_ctrl			(LS2H_LPC_REG_BASE0 + 0x0)
#define LS2H_LPC_INT_regs_enable		(LS2H_LPC_REG_BASE0 + 0x4)
#define LS2H_LPC_INT_regs_status		(LS2H_LPC_REG_BASE0 + 0x8)
#define LS2H_LPC_INT_regs_clear			(LS2H_LPC_REG_BASE0 + 0xc)

#define LPC_INT_regs_ctrl			*lpc_int_regs_ctrl
#define LPC_INT_regs_enable			*lpc_int_regs_enable
#define LPC_INT_regs_status			*lpc_int_regs_status
#define LPC_INT_regs_clear			*lpc_int_regs_clear


static inline int readl_addr64(unsigned long long addr)
{
unsigned long long a = addr;
int ret;
asm volatile( ".set mips64;ld $2,%1;lw %0,($2);.set mips0;\n":"=r"(ret):"m"(a):"$2")
;
return ret;
}

static inline void writel_addr64(unsigned long long addr, int v)
{
unsigned long long a = addr;
asm volatile( ".set mips64;ld $2,%1;sw %0,($2);.set mips0;\n"::"r"(v),"m"(a):"$2")
;
}


static inline int readb_addr64(unsigned long long addr)
{
unsigned long long a = addr;
int ret;
asm volatile( ".set mips64;ld $2,%1;lb %0,($2);.set mips0;\n":"=r"(ret):"m"(a):"$2")
;
return ret;
}

static inline void writeb_addr64(unsigned long long addr, int v)
{
unsigned long long a = addr;
asm volatile( ".set mips64;ld $2,%1;sb %0,($2);.set mips0;\n"::"r"(v),"m"(a):"$2")
;
}


#endif
