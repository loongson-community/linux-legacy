/*
 * pci_machdep_cs5536.c  
 * 	the Virtual Support Module(VSM) for virtulize the PCI configure  
 * 	space. so user can access the PCI configure space directly as
 *	a normal multi-function PCI device which following the PCI-2.2 spec.
 *
 * Author : jlliu <liujl@lemote.com>
 * Date : 07-07-05
 *
 */
#include <linux/types.h>

#include "cs5536.h"
#include "cs5536_pci.h"
#include "pcireg.h"

extern void _wrmsr(u32 reg, u32 hi, u32 lo);
extern void _rdmsr(u32 reg, u32 *hi, u32 *lo);

/******************************INTERNAL USED FUNCTIONS***********************************/

/*
 * divil_lbar_enable_disable : enable/disable the divil module bar space.
 * For all the DIVIL module LBAR, you should control the DIVIL LBAR reg
 * and the RCONFx(0~5) reg to use the modules.
 */
static void divil_lbar_enable_disable(int enable)
{
	u32 hi, lo;
	
	/* 
	 * The DIVIL IRQ is not used yet. and make the RCONF0 reserved.
	 */
	
	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &lo);
	if(enable)
		hi |= 0x01;
	else
		hi &= ~0x01;
	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), hi, lo);

	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
	if(enable)
		hi |= 0x01;
	else
		hi &= ~0x01;
	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), hi, lo);

	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &hi, &lo);
	if(enable)
		hi |= 0x01;
	else
		hi &= ~0x01;
	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), hi, lo);

	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), &hi, &lo);
	if(enable)
		hi |= 0x01;
	else
		hi &= ~0x01;
	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), hi, lo);

	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), &hi, &lo);
	if(enable)
		hi |= 0x01;
	else
		hi &= ~0x01;
	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), hi, lo);
	
	/*
	 * RCONF0 is reserved to the DIVIL IRQ mdoule
	 */
#if	0	
	_rdmsr(SB_MSR_REG(SB_R1), &hi, &lo);
	if(enable)
		lo |= 0x01;
	else
		lo &= ~0x01;
	_wrmsr(SB_MSR_REG(SB_R1), hi, lo);
	
	_rdmsr(SB_MSR_REG(SB_R2), &hi, &lo);
	if(enable)
		lo |= 0x01;
	else
		lo &= ~0x01;
	_wrmsr(SB_MSR_REG(SB_R2), hi, lo);

	_rdmsr(SB_MSR_REG(SB_R3), &hi, &lo);
	if(enable)
		lo |= 0x01;
	else
		lo &= ~0x01;
	_wrmsr(SB_MSR_REG(SB_R3), hi, lo);
	
	_rdmsr(SB_MSR_REG(SB_R4), &hi, &lo);
	if(enable)
		lo |= 0x01;
	else
		lo &= ~0x01;
	_wrmsr(SB_MSR_REG(SB_R4), hi, lo);

	_rdmsr(SB_MSR_REG(SB_R5), &hi, &lo);
	if(enable)
		lo |= 0x01;
	else
		lo &= ~0x01;
	_wrmsr(SB_MSR_REG(SB_R5), hi, lo);
#endif	
	return;
}

#ifdef	TEST_CS5536_USE_FLASH
/*
 * flash_lbar_enable_disable : enable or disable the region of flashs(NOR or NAND)
 * the same as the DIVIL other modules above, two groups of regs should be modified
 * here to control the region. DIVIL flash LBAR and the RCONFx(6~9 reserved).
 */
static void flash_lbar_enable_disable(int enable)
{
	u32 hi, lo;
	
	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
	if(enable)
		hi |= 0x01;
	else
		hi &= ~0x01;
	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), hi, lo);

	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), &hi, &lo);
	if(enable)
		hi |= 0x01;
	else
		hi &= ~0x01;
	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), hi, lo);

	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), &hi, &lo);
	if(enable)
		hi |= 0x01;
	else
		hi &= ~0x01;
	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), hi, lo);

	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), &hi, &lo);
	if(enable)
		hi |= 0x01;
	else
		hi &= ~0x01;
	_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), hi, lo);

	_rdmsr(SB_MSR_REG(SB_R6), &hi, &lo);
	if(enable)
		lo |= 0x01;
	else
		lo &= ~0x01;
	_wrmsr(SB_MSR_REG(SB_R6), hi, lo);
	
	_rdmsr(SB_MSR_REG(SB_R7), &hi, &lo);
	if(enable)
		lo |= 0x01;
	else
		lo &= ~0x01;
	_wrmsr(SB_MSR_REG(SB_R7), hi, lo);
	
	_rdmsr(SB_MSR_REG(SB_R8), &hi, &lo);
	if(enable)
		lo |= 0x01;
	else
		lo &= ~0x01;
	_wrmsr(SB_MSR_REG(SB_R8), hi, lo);

	_rdmsr(SB_MSR_REG(SB_R9), &hi, &lo);
	if(enable)
		lo |= 0x01;
	else
		lo &= ~0x01;
	_wrmsr(SB_MSR_REG(SB_R9), hi, lo);
	
	return;
}
#endif


/**********************************MODULES*********************************************/

/*
 * isa_write : isa write transfering.
 * WE assume that the ISA is not the BUS MASTER.!!!
 */
/* FAST BACK TO BACK '1' for BUS MASTER '0' for BUS SALVE */
/* COMMAND :
 * 	bit0 : IO SPACE ENABLE
 *	bit1 : MEMORY SPACE ENABLE(ignore)
 *	bit2 : BUS MASTER ENABLE(ignore)
 *	bit3 : SPECIAL CYCLE(ignore)? default is ignored.
 *	bit4 : MEMORY WRITE and INVALIDATE(ignore)
 *	bit5 : VGA PALETTE(ignore)
 *	bit6 : PARITY ERROR(ignore)? : default is ignored.
 *	bit7 : WAIT CYCLE CONTROL(ignore)
 *	bit8 : SYSTEM ERROR(ignore)
 *	bit9 : FAST BACK TO BACK(ignore)
 *	bit10-bit15 : RESERVED
 * STATUS :
 *	bit0-bit3 : RESERVED
 *	bit4 : CAPABILITY LIST(ignore)
 *	bit5 : 66MHZ CAPABLE
 *	bit6 : RESERVED
 *	bit7 : FAST BACK TO BACK(ignore)
 *	bit8 : DATA PARITY ERROR DETECED(ignore)
 *	bit9-bit10 : DEVSEL TIMING(ALL MEDIUM)
 *	bit11: SIGNALED TARGET ABORT
 *	bit12: RECEIVED TARGET ABORT
 *	bit13: RECEIVED MASTER ABORT
 *	bit14: SIGNALED SYSTEM ERROR
 *	bit15: DETECTED PARITY ERROR
 */
static void pci_isa_write_reg(int reg, u32 value)
{
	u32 hi, lo;
	u32 temp;

	switch(reg){
		case PCI_COMMAND_STATUS_REG :
			// command
			if( value & PCI_COMMAND_IO_ENABLE ){
				divil_lbar_enable_disable(1);
			}else{
				divil_lbar_enable_disable(0);
			}
#if	0
			/* PER response enable or disable. */
			if( value & PCI_COMMAND_PARITY_ENABLE ){
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				lo |= SB_PARE_ERR_EN;
				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);			
			}else{
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				lo &= ~SB_PARE_ERR_EN;
				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);			
			}
#endif
			// status
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			temp = lo & 0x0000ffff;
			if( (value & PCI_STATUS_TARGET_TARGET_ABORT) && 
				(lo & SB_TAS_ERR_EN) ){
				temp |= SB_TAS_ERR_FLAG;
			}
			if( (value & PCI_STATUS_MASTER_TARGET_ABORT) &&
				(lo & SB_TAR_ERR_EN) ){
				temp |= SB_TAR_ERR_FLAG;
			}
			if( (value & PCI_STATUS_MASTER_ABORT) &&
				(lo & SB_MAR_ERR_EN) ){
				temp |= SB_MAR_ERR_FLAG;
			}
			if( (value & PCI_STATUS_PARITY_DETECT) &&
				(lo & SB_PARE_ERR_EN) ){
				temp |= SB_PARE_ERR_FLAG; 
			}
			lo = temp;
			_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
			break;
		case PCI_BHLC_REG :
			value &= 0x0000ff00;
			_rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
			hi &= 0xffffff00;
			hi |= (value >> 8);
			_wrmsr(SB_MSR_REG(SB_CTRL), hi, lo);
			break;
		case PCI_BAR0_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_SMB_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				// SMB NATIVE IO space has 8bytes
				hi = 0x0000f001;
				lo = value & 0x0000fff8;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), hi, lo);
				
				// RCONFx is 4bytes in units for IO space.
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_SMB_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R0), hi, lo);
			}
			break;
		case PCI_BAR1_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_GPIO_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				// GPIO NATIVE reg is 256bytes
				hi = 0x0000f001;
				lo = value & 0x0000ff00;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), hi, lo);

				// RCONFx is 4bytes in units for IO space
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_GPIO_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R1), hi, lo);
			}
			break;
		case PCI_BAR2_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_MFGPT_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				// MFGPT NATIVE reg is 64bytes
				hi = 0x0000f001;
				lo = value & 0x0000ffc0;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), hi, lo);

				// RCONFx is 4bytes in units for IO space
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_MFGPT_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R2), hi, lo);
			}
			break;
		case PCI_BAR3_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_IRQ_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				// IRQ NATIVE reg is 32bytes
				hi = 0x0000f001;
				lo = value & 0x0000ffc0;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_IRQ), hi, lo);

				// RCONFx is 4bytes in units for IO space
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_IRQ_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R3), hi, lo);
			}
			break;
		case PCI_BAR4_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_PMS_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				// PMS NATIVE reg is 128bytes
				hi = 0x0000f001;
				lo = value & 0x0000ff80;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), hi, lo);

				// RCONFx is 4bytes in units for IO space.
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_PMS_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R4), hi, lo);
			}
			break;
		case PCI_BAR5_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_ACPI_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				// ACPI NATIVE reg is 32bytes
				hi = 0x0000f001;
				lo = value & 0x0000ffe0;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), hi, lo);
				
				// RCONFx is 4bytes in units for IO space.
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_ACPI_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R5), hi, lo);
			}
			break;
		case PCI_UART1_INT_REG :
			if(value){
			/* enable uart1 interrupt in PIC */	
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
				lo &= ~(0xf << 24);
				lo |= (CS5536_UART1_INTR << 24);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
			}else{
			/* disable uart1 interrupt in PIC */
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
				lo &= ~(0xf << 24);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
			}
			break;
		case PCI_UART2_INT_REG :
			if(value){
			/* enable uart2 interrupt in PIC */	
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
				lo &= ~(0xf << 28);
				lo |= (CS5536_UART2_INTR << 28);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
			}else{
			/* disable uart2 interrupt in PIC */
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), &hi, &lo);
				lo &= ~(0xf << 28);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_HIGH), hi, lo);
			}
			break;
		case PCI_ISA_FIXUP_REG :
			if(value){
				/* enable the TARGET ABORT/MASTER ABORT etc. */
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				lo |= 0x00000063;
				_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
			}

		default :
			/* ALL OTHER PCI CONFIG SPACE HEADER IS NOT IMPLEMENTED. */
			break;			
	}
	
	return;
}

/*
 * isa_read : isa read transfering.
 * we assume that the ISA is not the BUS MASTER. 
 */
 
 /* COMMAND :
 * 	bit0 : IO SPACE ENABLE
 *	bit1 : MEMORY SPACE ENABLE(ignore)
 *	bit2 : BUS MASTER ENABLE(ignore)
 *	bit3 : SPECIAL CYCLE(ignore)? default is ignored.
 *	bit4 : MEMORY WRITE and INVALIDATE(ignore)
 *	bit5 : VGA PALETTE(ignore)
 *	bit6 : PARITY ERROR(ignore)? : default is ignored.
 *	bit7 : WAIT CYCLE CONTROL(ignore)
 *	bit8 : SYSTEM ERROR(ignore)
 *	bit9 : FAST BACK TO BACK(ignore)
 *	bit10-bit15 : RESERVED
 * STATUS :
 *	bit0-bit3 : RESERVED
 *	bit4 : CAPABILITY LIST(ignore)
 *	bit5 : 66MHZ CAPABLE
 *	bit6 : RESERVED
 *	bit7 : FAST BACK TO BACK(ignore)
 *	bit8 : DATA PARITY ERROR DETECED(ignore)?
 *	bit9-bit10 : DEVSEL TIMING(ALL MEDIUM)
 *	bit11: SIGNALED TARGET ABORT
 *	bit12: RECEIVED TARGET ABORT
 *	bit13: RECEIVED MASTER ABORT
 *	bit14: SIGNALED SYSTEM ERROR
 *	bit15: DETECTED PARITY ERROR(?)
 */

static u32 pci_isa_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (CS5536_ISA_DEVICE_ID << 16 | CS5536_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
			// COMMAND
			// we just check the first LBAR for the IO enable bit,
			// maybe we should changed later.
			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &lo);
			if(hi & 0x01){
				conf_data |= PCI_COMMAND_IO_ENABLE;
			}
			//conf_data |= PCI_COMMAND_IO_ENABLE | PCI_COMMAND_MEM_ENABLE | PCI_COMMAND_MASTER_ENABLE;
#if	0
			conf_data |= PCI_COMMAND_SPECIAL_ENABLE;
#endif
#if	0
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_PARE_ERR_EN){
				conf_data |= PCI_COMMAND_PARITY_ENABLE;
			}else{
				conf_data &= ~PCI_COMMAND_PARITY_ENABLE;
			}
#endif
			// STATUS	
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
#if	1
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
#endif
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_TAS_ERR_FLAG)
				conf_data |= PCI_STATUS_TARGET_TARGET_ABORT;
			if(lo & SB_TAR_ERR_FLAG)
				conf_data |= PCI_STATUS_MASTER_TARGET_ABORT;
			if(lo & SB_MAR_ERR_FLAG)
				conf_data |= PCI_STATUS_MASTER_ABORT;
			if(lo & SB_PARE_ERR_FLAG)
				conf_data |= PCI_STATUS_PARITY_DETECT;
			break;
		case PCI_CLASS_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_CHIP_REV_ID), &hi, &lo);
			conf_data = lo & 0x000000ff;
			conf_data |= (CS5536_ISA_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			_rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
			hi &= 0x000000f8;
			conf_data = (PCI_NONE_BIST << 24) | (PCI_BRIDGE_HEADER_TYPE << 16) |
				(hi << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		/*
		 * we only use the LBAR of DIVIL, no RCONF used. 
		 * all of them are IO space.
		 */
		case PCI_BAR0_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_SMB_FLAG){
				conf_data = CS5536_SMB_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_SMB_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &lo);
				conf_data = lo & 0x0000fff8;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
		case PCI_BAR1_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_GPIO_FLAG){
				conf_data = CS5536_GPIO_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_GPIO_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
				conf_data = lo & 0x0000ff00;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
		case PCI_BAR2_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_MFGPT_FLAG){
				conf_data = CS5536_MFGPT_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_MFGPT_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &hi, &lo);
				conf_data = lo & 0x0000ffc0;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
#if	1
		case PCI_BAR3_REG :
			conf_data = 0;
			break;
#else
		case PCI_BAR3_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_IRQ_FLAG){
				conf_data = CS5536_IRQ_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_IRQ_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_IRQ), &hi, &lo);
				conf_data = lo & 0x0000ffc0;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
#endif
		case PCI_BAR4_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_PMS_FLAG){
				conf_data = CS5536_PMS_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_PMS_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_PMS), &hi, &lo);
				conf_data = lo & 0x0000ff80;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
		case PCI_BAR5_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_ACPI_FLAG){
				conf_data = CS5536_ACPI_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_ACPI_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_ACPI), &hi, &lo);
				conf_data = lo & 0x0000ffe0;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (CS5536_ISA_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(0x00 << 8) | 0x00;
			break;
		default :
			conf_data = 0;
			break;
	}
	
	return conf_data;
}

#ifdef	TEST_CS5536_USE_FLASH

#ifndef	TEST_CS5536_USE_NOR_FLASH	/* for nand flash */
static void pci_flash_write_reg(int reg, u32 value)
{
	u32 hi, lo;

	switch(reg){
		case PCI_COMMAND_STATUS_REG :
			// command
			if( value & PCI_COMMAND_MEM_ENABLE ){
				flash_lbar_enable_disable(1);
			}else{
				flash_lbar_enable_disable(0);
			}
			// STATUS
			if(value & PCI_STATUS_PARITY_ERROR){
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				if(lo & SB_PARE_ERR_FLAG){
					lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
					_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
				}				
			}
			break;
		case PCI_BAR0_REG :
			if(value == PCI_BAR_RANGE_MASK){
				// make the flag for reading the bar length.
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_FLSH0_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if( (value & 0x01) == 0x00 ){
				// mem space nand flash native reg base addr
				hi = 0xfffff007;
				lo = value & 0xfffff000;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), hi, lo);
	
				// RCONFx is 4KB in units for mem space.
				hi = ((value & 0xfffff000) << 12) | ( (CS5536_FLSH0_LENGTH & 0xfffff000) - (1 << 12) ) | 0x00;
				lo = ((value & 0xfffff000) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R6), hi, lo);			
			}
			break;
		case PCI_BAR1_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_FLSH1_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if( (value & 0x01) == 0x00 ){
				// mem space nand flash native reg base addr
				hi = 0xfffff007;
				lo = value & 0xfffff000;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), hi, lo);
	
				// RCONFx is 4KB in units for mem space.
				hi = ((value & 0xfffff000) << 12) | ( (CS5536_FLSH1_LENGTH & 0xfffff000) - (1 << 12) ) | 0x00;
				lo = ((value & 0xfffff000) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R7), hi, lo);
			}
			break;
		case PCI_BAR2_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_FLSH2_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if( (value & 0x01) == 0x00 ){
				// mem space nand flash native reg base addr
				hi = 0xfffff007;
				lo = value & 0xfffff000;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), hi, lo);
	
				// RCONFx is 4KB in units for mem space.
				hi = ((value & 0xfffff000) << 12) | ( (CS5536_FLSH2_LENGTH & 0xfffff000) - (1 << 12) ) | 0x00;
				lo = ((value & 0xfffff000) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R8), hi, lo);
			}
			break;		
		case PCI_BAR3_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_FLSH3_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if( (value & 0x01) == 0x00 ){
				// mem space nand flash native reg base addr
				hi = 0xfffff007;
				lo = value & 0xfffff000;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), hi, lo);
	
				// RCONFx is 4KB in units for mem space.
				hi = ((value & 0xfffff000) << 12) | ( (CS5536_FLSH3_LENGTH & 0xfffff000)- (1 << 12) ) | 0x00;
				lo = ((value & 0xfffff000) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R9), hi, lo);
			}
			break;
		case PCI_FLASH_INT_REG :
			if(value){
			/* enable all the flash interrupt in PIC */	
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
				lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
				lo |= (CS5536_FLASH_INTR << PIC_YSEL_LOW_FLASH_SHIFT);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
			}else{
			/* disable all the flash interrupt in PIC */
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
				lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
			}
			break;
		case PCI_NAND_FLASH_TDATA_REG :
			hi = 0;
			lo = value;
			_wrmsr(DIVIL_MSR_REG(NANDF_DATA), hi, lo);
			break;
		case PCI_NAND_FLASH_TCTRL_REG :
			hi = 0;
			lo = value & 0x00000fff;
			_wrmsr(DIVIL_MSR_REG(NANDF_CTRL), hi, lo);
			break;
		case PCI_NAND_FLASH_RSVD_REG :
			hi = 0;
			lo = value;
			_wrmsr(DIVIL_MSR_REG(NANDF_RSVD), hi, lo);
			break;
		case PCI_FLASH_SELECT_REG :
			if(value == CS5536_IDE_FLASH_SIGNATURE){
				_rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
				lo &= ~0x01;
				_wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
			}
			break;
		default :
			break;
	}
	
	return;
}

static u32 pci_flash_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (CS5536_FLASH_DEVICE_ID << 16 | CS5536_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
			// COMMAND
			// we just read one lbar for returning.
			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
			if(hi & 0x01)
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			//STATUS
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_PARE_ERR_FLAG)
				conf_data |= PCI_STATUS_PARITY_ERROR;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			_rdmsr(DIVIL_MSR_REG(DIVIL_CAP), &hi, &lo);
			conf_data = lo & 0x000000ff;
			conf_data |= (CS5536_FLASH_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(PCI_NORMAL_LATENCY_TIMER << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_FLSH0_FLAG){
				conf_data = CS5536_FLSH0_RANGE | PCI_MAPREG_TYPE_MEM;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_FLSH0_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
				conf_data = lo;
				conf_data &= ~0x0f;
			}
			break;
		case PCI_BAR1_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_FLSH1_FLAG){
				conf_data = CS5536_FLSH1_RANGE | PCI_MAPREG_TYPE_MEM;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_FLSH1_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), &hi, &lo);
				conf_data = lo;
				conf_data &= ~0x0f;
			}
			break;
		case PCI_BAR2_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_FLSH2_FLAG){
				conf_data = CS5536_FLSH2_RANGE | PCI_MAPREG_TYPE_MEM;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_FLSH2_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), &hi, &lo);
				conf_data = lo;
				conf_data &= ~0x0f;
			}
			break;
		case PCI_BAR3_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_FLSH3_FLAG){
				conf_data = CS5536_FLSH3_RANGE | PCI_MAPREG_TYPE_MEM;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_FLSH3_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), &hi, &lo);
				conf_data = lo;
				conf_data &= ~0x0f;
			}
			break;	
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (CS5536_FLASH_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (CS5536_FLASH_INTR);
			break;
		case PCI_NAND_FLASH_TDATA_REG :
			_rdmsr(DIVIL_MSR_REG(NANDF_DATA), &hi, &lo);
			conf_data = lo;
			break;
		case PCI_NAND_FLASH_TCTRL_REG :
			_rdmsr(DIVIL_MSR_REG(NANDF_CTRL), &hi, &lo);
			conf_data = lo & 0x00000fff;
			break;
		case PCI_NAND_FLASH_RSVD_REG :
			_rdmsr(DIVIL_MSR_REG(NANDF_RSVD), &hi, &lo);
			conf_data = lo;
			break;
		case PCI_FLASH_SELECT_REG :
			_rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
			conf_data = lo & 0x01;
			break;

		}
	return 0;
}

#else /* nor flash */

static void pci_flash_write_reg(int reg, u32 value)
{
	u32 hi, lo;

	switch(reg){
		case PCI_COMMAND_STATUS_REG :
			// command
			if( value & PCI_COMMAND_IO_ENABLE ){
				flash_lbar_enable_disable(1);
			}else{
				flash_lbar_enable_disable(0);
			}
			// STATUS
			if(value & PCI_STATUS_PARITY_ERROR){
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				if(lo & SB_PARE_ERR_FLAG){
					lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
					_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
				}				
			}
			break;
		case PCI_BAR0_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_FLSH0_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				// IO space of 16bytes nor flash
				hi = 0x0000fff1;
				lo = value & 0x0000fff0;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), hi, lo);
	
				// RCONFx used for 16bytes reserved.
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_FLSH0_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R6), hi, lo);
			}
			break;
		case PCI_BAR1_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_FLSH1_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				// IO space of 16bytes nor flash
				hi = 0x0000fff1;
				lo = value & 0x0000fff0;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), hi, lo);
	
				// RCONFx used for 16bytes reserved.
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_FLSH1_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R7), hi, lo);			
			}
			break;
		case PCI_BAR2_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_FLSH2_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				hi = 0x0000fff1;
				lo = value & 0x0000fff0;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), hi, lo);
	
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_FLSH2_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R8), hi, lo);				
			}
			break;		
		case PCI_BAR3_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_FLSH3_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				// 16bytes for nor flash
				hi = 0x0000fff1;
				lo = value & 0x0000fff0;
				_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), hi, lo);
	
				// 16bytes of IO space of RCONFx region.
				hi = ((value & 0x000ffffc) << 12) | ((CS5536_FLSH3_LENGTH - 4) << 12) | 0x01;
				lo = ((value & 0x000ffffc) << 12) | 0x01;
				_wrmsr(SB_MSR_REG(SB_R9), hi, lo);	
			}
			break;
			
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (CS5536_FLASH_INTR);
			break;
		case PCI_FLASH_INT_REG :
			if(value){
			/* enable all the flash interrupt in PIC */	
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
				lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
				lo |= (CS5536_FLASH_INTR << PIC_YSEL_LOW_FLASH_SHIFT);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
			}else{
			/* disable all the flash interrupt in PIC */
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
				lo &= ~(0xf << PIC_YSEL_LOW_FLASH_SHIFT);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
			}
			break;
		case PCI_NOR_FLASH_CTRL_REG :
			hi = 0;
			lo = value & 0x000000ff;
			_wrmsr(DIVIL_MSR_REG(NORF_CTRL), hi, lo);
			break;
		case PCI_NOR_FLASH_T01_REG :
			hi = 0;
			lo = value;
			_wrmsr(DIVIL_MSR_REG(NORF_T01), hi, lo);
			break;
		case PCI_NOR_FLASH_T23_REG :
			hi = 0;
			lo = value;
			_wrmsr(DIVIL_MSR_REG(NORF_T23), hi, lo);
			break;
		case PCI_FLASH_SELECT_REG :
			if(value == CS5536_IDE_FLASH_SIGNATURE){
				_rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
				lo &= ~0x01;
				_wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
			}
			break;

		default :
			break;			
	}
	
	return;
}

static u32 pci_flash_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (CS5536_FLASH_DEVICE_ID << 16 | CS5536_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
			// COMMAND
			// we just check one flash bar for returning.
			_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
			if(hi & 0x01)
				conf_data |= PCI_COMMAND_IO_ENABLE;
			//STATUS
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_PARE_ERR_FLAG)
				conf_data |= PCI_STATUS_PARITY_ERROR;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			_rdmsr(DIVIL_MSR_REG(DIVIL_CAP), &hi, &lo);
			conf_data = lo & 0x000000ff;
			conf_data |= (CS5536_FLASH_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(PCI_NORMAL_LATENCY_TIMER << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_FLSH0_FLAG){
				conf_data = CS5536_FLSH0_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_FLSH0_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH0), &hi, &lo);
				conf_data = lo & 0x0000ffff;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
		case PCI_BAR1_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_FLSH1_FLAG){
				conf_data = CS5536_FLSH1_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_FLSH1_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH1), &hi, &lo);
				conf_data = lo & 0x0000ffff;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
		case PCI_BAR2_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_FLSH2_FLAG){
				conf_data = CS5536_FLSH2_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_FLSH2_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH2), &hi, &lo);
				conf_data = lo & 0x0000ffff;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
		case PCI_BAR3_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_FLSH3_FLAG){
				conf_data = CS5536_FLSH3_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_FLSH3_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_FLSH3), &hi, &lo);
				conf_data = lo & 0x0000ffff;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;	
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (CS5536_FLASH_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (CS5536_FLASH_INTR);
			break;
		case PCI_NOR_FLASH_CTRL_REG :
			_rdmsr(DIVIL_MSR_REG(NORF_CTRL), &hi, &lo);
			conf_data = lo & 0x000000ff;
			break;
		case PCI_NOR_FLASH_T01_REG :
			_rdmsr(DIVIL_MSR_REG(NORF_T01), &hi, &lo);
			conf_data = lo;
			break;
		case PCI_NOR_FLASH_T23_REG :
			_rdmsr(DIVIL_MSR_REG(NORF_T23), &hi, &lo);
			conf_data = lo;
			break;
		default :
			conf_data = 0;
			break;
	}
	return conf_data;
}
#endif  /* TEST_CS5536_USE_NOR_FLASH */

#else	/* TEST_CS5536_USE_FLASH */

static void pci_flash_write_reg(int reg, u32 value)
{
	return;
}

static u32 pci_flash_read_reg(int reg)
{
	return 0xffffffff;
}

#endif	/* TEST_CS5536_USE_FLASH */

/*
 * ide_write : ide write transfering
 */
static void pci_ide_write_reg(int reg, u32 value)
{
	u32 hi, lo;
	
	switch(reg){
		case PCI_COMMAND_STATUS_REG :
			// COMMAND
			if(value & PCI_COMMAND_MASTER_ENABLE){
				_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
				lo |= (0x03 << 4);
				_wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);			
			}else{
				_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
				lo &= ~(0x03 << 4);
				_wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);	
			}
			// STATUS
			if(value & PCI_STATUS_PARITY_ERROR){
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				if(lo & SB_PARE_ERR_FLAG){
					lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
					_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
				}				
			}
			break;
		case PCI_BHLC_REG :
			value &= 0x0000ff00;
			_rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
			hi &= 0xffffff00;
			hi |= (value >> 8);
			_wrmsr(SB_MSR_REG(SB_CTRL), hi, lo);
			break;
		case PCI_BAR4_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_IDE_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if(value & 0x01){
				hi = 0x00000000;
				//lo = ((value & 0x0fffffff) << 4) | 0x001;
				lo = (value & 0xfffffff0) | 0x1;
				_wrmsr(IDE_MSR_REG(IDE_IO_BAR), hi, lo);

				value &= 0xfffffffc;
				hi = 0x60000000 | ((value & 0x000ff000) >> 12);
				lo = 0x000ffff0 | ((value & 0x00000fff) << 20);
				_wrmsr(GLIU_MSR_REG(GLIU_IOD_BM2), hi, lo);
	   		}
			break;
		case PCI_IDE_CFG_REG :
			if(value == CS5536_IDE_FLASH_SIGNATURE){
				_rdmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), &hi, &lo);
				lo |= 0x01;
				_wrmsr(DIVIL_MSR_REG(DIVIL_BALL_OPTS), hi, lo);
			}else{
				hi = 0;
				lo = value;
				_wrmsr(IDE_MSR_REG(IDE_CFG), hi, lo);			
			}
			break;
		case PCI_IDE_DTC_REG :
			hi = 0;
			lo = value;
			_wrmsr(IDE_MSR_REG(IDE_DTC), hi, lo);
			break;
		case PCI_IDE_CAST_REG :
			hi = 0;
			lo = value;
			_wrmsr(IDE_MSR_REG(IDE_CAST), hi, lo);
			break;
		case PCI_IDE_ETC_REG :
			hi = 0;
			lo = value;
			_wrmsr(IDE_MSR_REG(IDE_ETC), hi, lo);
			break;
		case PCI_IDE_PM_REG :
			hi = 0;
			lo = value;
			_wrmsr(IDE_MSR_REG(IDE_INTERNAL_PM), hi, lo);
			break;
		default :
			break;			
	}
	
	return;
}

/*
 * ide_read : ide read tranfering.
 */
static u32 pci_ide_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (CS5536_IDE_DEVICE_ID << 16 | CS5536_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
			// COMMAND
			_rdmsr(IDE_MSR_REG(IDE_IO_BAR), &hi, &lo);
			if(lo & 0xfffffff0)
				conf_data |= PCI_COMMAND_IO_ENABLE;
			_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
			if( (lo & 0x30) == 0x30 )
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
			/* conf_data |= PCI_COMMAND_BACKTOBACK_ENABLE??? HOW TO GET..*/
			//STATUS
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_PARE_ERR_FLAG)
				conf_data |= PCI_STATUS_PARITY_ERROR;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			_rdmsr(IDE_MSR_REG(IDE_CAP), &hi, &lo);
			conf_data = lo & 0x000000ff;
			conf_data |= (CS5536_IDE_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			_rdmsr(SB_MSR_REG(SB_CTRL), &hi, &lo);
			hi &= 0x000000f8;
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(hi << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			conf_data = 0x00000000;
			break;
		case PCI_BAR1_REG :
			conf_data = 0x00000000;
			break;
		case PCI_BAR2_REG :
			conf_data = 0x00000000;
			break;
		case PCI_BAR3_REG :
			conf_data = 0x00000000;
			break;
		case PCI_BAR4_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_IDE_FLAG){
				conf_data = CS5536_IDE_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_IDE_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(IDE_MSR_REG(IDE_IO_BAR), &hi, &lo);
				//conf_data = lo >> 4;
				conf_data = lo & 0xfffffff0;
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
		case PCI_BAR5_REG :
			conf_data = 0x00000000;
			break;
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (CS5536_IDE_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (CS5536_IDE_INTR);
			break;
		case PCI_IDE_CFG_REG :
			_rdmsr(IDE_MSR_REG(IDE_CFG), &hi, &lo);
			conf_data = lo;
			break;
		case PCI_IDE_DTC_REG :
			_rdmsr(IDE_MSR_REG(IDE_DTC), &hi, &lo);
			conf_data = lo;
			break;
		case PCI_IDE_CAST_REG :
			_rdmsr(IDE_MSR_REG(IDE_CAST), &hi, &lo);
			conf_data = lo;
			break;
		case PCI_IDE_ETC_REG :
			_rdmsr(IDE_MSR_REG(IDE_ETC), &hi, &lo);
			conf_data = lo;
		case PCI_IDE_PM_REG :
			_rdmsr(IDE_MSR_REG(IDE_INTERNAL_PM), &hi, &lo);
			conf_data = lo;
			break;
			
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}

static void pci_acc_write_reg(int reg, u32 value)
{
	u32 hi, lo;

	switch(reg){
		case PCI_COMMAND_STATUS_REG :
			// COMMAND
			if(value & PCI_COMMAND_MASTER_ENABLE){
				_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
				lo |= (0x03 << 8);
				_wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);			
			}else{
				_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
				lo &= ~(0x03 << 8);
				_wrmsr(GLIU_MSR_REG(GLIU_PAE), hi, lo);	
			}
			// STATUS
			if(value & PCI_STATUS_PARITY_ERROR){
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				if(lo & SB_PARE_ERR_FLAG){
					lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
					_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
				}				
			}
			break;
		case PCI_BAR0_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_ACC_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if( value & 0x01 ){
				value &= 0xfffffffc;
				hi = 0xA0000000 | ((value & 0x000ff000) >> 12);
				lo = 0x000fff80 | ((value & 0x00000fff) << 20);
				_wrmsr(GLIU_MSR_REG(GLIU_IOD_BM1), hi, lo);
			}
			break;
		case PCI_ACC_INT_REG :
			if(value){
			/* enable all the acc interrupt in PIC */	
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
				lo &= ~(0xf << PIC_YSEL_LOW_ACC_SHIFT);
				lo |= (CS5536_ACC_INTR << PIC_YSEL_LOW_ACC_SHIFT);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
			}else{
			/* disable all the usb interrupt in PIC */
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
				lo &= ~(0xf << PIC_YSEL_LOW_ACC_SHIFT);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
			}
			break;
		default :
			break;			
	}

	return;
}

static u32 pci_acc_read_reg(int reg)
{
	u32 hi, lo;
	u32 conf_data;

	switch(reg){
		case PCI_ID_REG :
			conf_data = (CS5536_ACC_DEVICE_ID << 16 | CS5536_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			
			conf_data = 0;
			// COMMAND
			_rdmsr(GLIU_MSR_REG(GLIU_IOD_BM1), &hi, &lo);
			if( ( (lo & 0xfff00000) || (hi & 0x000000ff) ) 
					&& ((hi & 0xf0000000) == 0xa0000000) )
				conf_data |= PCI_COMMAND_IO_ENABLE;
			_rdmsr(GLIU_MSR_REG(GLIU_PAE), &hi, &lo);
			if( (lo & 0x300) == 0x300 )
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
			/* conf_data |= PCI_COMMAND_BACKTOBACK_ENABLE??? HOW TO GET..*/
			//STATUS
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_PARE_ERR_FLAG)
				conf_data |= PCI_STATUS_PARITY_ERROR;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			_rdmsr(ACC_MSR_REG(ACC_CAP), &hi, &lo);
			conf_data = lo & 0x000000ff;
			conf_data |= (CS5536_ACC_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(PCI_NORMAL_LATENCY_TIMER << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_ACC_FLAG){
				conf_data = CS5536_ACC_RANGE | PCI_MAPREG_TYPE_IO;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_ACC_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(GLIU_MSR_REG(GLIU_IOD_BM1), &hi, &lo);
				conf_data = (hi & 0x000000ff) << 12;
				conf_data |= (lo & 0xfff00000) >> 20; 
				conf_data |= 0x01;
				conf_data &= ~0x02;
			}
			break;
		case PCI_BAR1_REG :
			conf_data = 0x000000;
			break;		
		case PCI_BAR2_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR3_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR4_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR5_REG :
			conf_data = 0x000000;
			break;
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (CS5536_ACC_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_USB_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (CS5536_ACC_INTR);
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}


/*
 * ohci_write : ohci write tranfering.
 */
static void pci_ohci_write_reg(int reg, u32 value)
{
	u32 hi, lo;
	
	switch(reg){
		case PCI_COMMAND_STATUS_REG :
			// COMMAND
			if(value & PCI_COMMAND_MASTER_ENABLE){
				_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
				hi |= (1 << 2);
				_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
				hi &= ~(1 << 2);
				_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
			}
			if(value & PCI_COMMAND_MEM_ENABLE){
				_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
				hi |= (1 << 1);
				_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
				hi &= ~(1 << 1);
				_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);				
			}
			// STATUS
			if(value & PCI_STATUS_PARITY_ERROR){
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				if(lo & SB_PARE_ERR_FLAG){
					lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
					_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
				}				
			}
			break;
		case PCI_BAR0_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_OHCI_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if( (value & 0x01) == 0x00 ){
				_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
				//lo = (value & 0xffffff00) << 8;
				lo = value;
				_wrmsr(USB_MSR_REG(USB_OHCI), hi, lo);
				
				value &= 0xfffffff0;
				hi = 0x40000000 | ((value & 0xff000000) >> 24);
				lo = 0x000fffff | ((value & 0x00fff000) << 8);
				_wrmsr(GLIU_MSR_REG(GLIU_P2D_BM3), hi, lo);
			}
			break;
		case PCI_INTERRUPT_REG :
			value &= 0x000000ff;
			break;
		case PCI_OHCI_PM_REG :
			break;
		case PCI_OHCI_INT_REG :
			if(value){
			/* enable all the usb interrupt in PIC */	
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
				lo &= ~(0xf << 8);
				lo |= (CS5536_USB_INTR << 8);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
			}else{
			/* disable all the usb interrupt in PIC */
				_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
				lo &= ~(0xf << 8);
				_wrmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), hi, lo);
			}
			break;
		default :
			break;			
	}
	
	return;
}

/*
 * ohci_read : ohci read transfering.
 */
static u32 pci_ohci_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (CS5536_OHCI_DEVICE_ID << 16 | CS5536_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
			// COMMAND
			_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
			if(hi & 0x04)
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
			if(hi & 0x02)
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			// STATUS
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_PARE_ERR_FLAG)
				conf_data |= PCI_STATUS_PARITY_ERROR;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			_rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
			conf_data = lo & 0x000000ff;
			conf_data |= (CS5536_OHCI_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_OHCI_FLAG){
				conf_data = CS5536_OHCI_RANGE | PCI_MAPREG_TYPE_MEM;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_OHCI_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_OHCI), &hi, &lo);
				//conf_data = lo >> 8;
				conf_data = lo & 0xffffff00;
				conf_data &= ~0x0000000f; // 32bit mem
			}
			break;
		case PCI_BAR1_REG :
			conf_data = 0x000000;
			break;		
		case PCI_BAR2_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR3_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR4_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR5_REG :
			conf_data = 0x000000;
			break;
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (CS5536_OHCI_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_USB_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
			break;
		case PCI_OHCI_PM_REG :
			conf_data = 0;
			break;
		case PCI_OHCI_INT_REG :
			_rdmsr(DIVIL_MSR_REG(0x20), &hi, &lo);
			if((lo & 0x00000f00) == 11)
				conf_data = 1;
			else
				conf_data = 0;
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}

#ifdef	TEST_CS5536_USE_EHCI
static void pci_ehci_write_reg(int reg, u32 value)
{
	u32 hi, lo;
	
	switch(reg){
		case PCI_COMMAND_STATUS_REG :
			// COMMAND
			if(value & PCI_COMMAND_MASTER_ENABLE){
				_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
				hi |= (1 << 2);
				_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
				hi &= ~(1 << 2);
				_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
			}
			if(value & PCI_COMMAND_MEM_ENABLE){
				_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
				hi |= (1 << 1);
				_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
				hi &= ~(1 << 1);
				_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);				
			}
			// STATUS
			if(value & PCI_STATUS_PARITY_ERROR){
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				if(lo & SB_PARE_ERR_FLAG){
					lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
					_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
				}				
			}
			break;
		case PCI_BAR0_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_EHCI_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if( (value & 0x01) == 0x00 ){
				_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
				lo = value;
				_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
				
				value &= 0xfffffff0;
				hi = 0x40000000 | ((value & 0xff000000) >> 24);
				lo = 0x000fffff | ((value & 0x00fff000) << 8);
				_wrmsr(GLIU_MSR_REG(GLIU_P2D_BM4), hi, lo);
			}
			break;
		case PCI_EHCI_LEGSMIEN_REG :
			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
			hi &= 0x003f0000;
			hi |= (value & 0x3f) << 16;
			_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
			break;
		case PCI_EHCI_FLADJ_REG :
			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
			hi &= ~0x00003f00;
			hi |= value & 0x00003f00;
			_wrmsr(USB_MSR_REG(USB_EHCI), hi, lo);
			break;
		default :
			break;			
	}
	
	return;
}

static u32 pci_ehci_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (CS5536_EHCI_DEVICE_ID << 16 | CS5536_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
			// COMMAND
			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
			if(hi & 0x04)
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
			if(hi & 0x02)
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			// STATUS
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_PARE_ERR_FLAG)
				conf_data |= PCI_STATUS_PARITY_ERROR;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			_rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
			conf_data = lo & 0x000000ff;
			conf_data |= (CS5536_EHCI_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(PCI_NORMAL_LATENCY_TIMER << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_EHCI_FLAG){
				conf_data = CS5536_EHCI_RANGE | PCI_MAPREG_TYPE_MEM;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_EHCI_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
				conf_data = lo & 0xfffff000;
			}
			break;
		case PCI_BAR1_REG :
			conf_data = 0x000000;
			break;		
		case PCI_BAR2_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR3_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR4_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR5_REG :
			conf_data = 0x000000;
			break;
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (CS5536_EHCI_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_USB_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
			break;
		case PCI_EHCI_LEGSMIEN_REG :
			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
			conf_data = (hi & 0x003f0000) >> 16;
			break;
		case PCI_EHCI_LEGSMISTS_REG :
			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
			conf_data = (hi & 0x3f000000) >> 24;
			break;
		case PCI_EHCI_FLADJ_REG :
			_rdmsr(USB_MSR_REG(USB_EHCI), &hi, &lo);
			conf_data = hi & 0x00003f00;
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}
#else
static void pci_ehci_write_reg(int reg, u32 value)
{
	return;
}

static u32 pci_ehci_read_reg(int reg)
{
	return  0xffffffff;
}


#endif

#ifdef	TEST_CS5536_USE_UDC
static void pci_udc_write_reg(int reg, u32 value)
{
	u32 hi, lo;
	
	switch(reg){
		case PCI_COMMAND_STATUS_REG :
			// COMMAND
			if(value & PCI_COMMAND_MASTER_ENABLE){
				_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
				hi |= (1 << 2);
				_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
				hi &= ~(1 << 2);
				_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
			}
			if(value & PCI_COMMAND_MEM_ENABLE){
				_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
				hi |= (1 << 1);
				_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
				hi &= ~(1 << 1);
				_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);				
			}
			// STATUS
			if(value & PCI_STATUS_PARITY_ERROR){
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				if(lo & SB_PARE_ERR_FLAG){
					lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
					_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
				}				
			}
			break;
		case PCI_BAR0_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_UDC_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if( (value & 0x01) == 0x00 ){
				_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
				lo = value;
				_wrmsr(USB_MSR_REG(USB_UDC), hi, lo);
				
				value &= 0xfffffff0;
				hi = 0x40000000 | ((value & 0xff000000) >> 24);
				lo = 0x000fffff | ((value & 0x00fff000) << 8);
				_wrmsr(GLIU_MSR_REG(GLIU_P2D_BM0), hi, lo);
			}
			break;
		default :
			break;			
	}
	
	return;
}

static u32 pci_udc_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (CS5536_UDC_DEVICE_ID << 16 | CS5536_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
			// COMMAND
			_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
			if(hi & 0x04)
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
			if(hi & 0x02)
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			// STATUS
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_PARE_ERR_FLAG)
				conf_data |= PCI_STATUS_PARITY_ERROR;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			_rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
			conf_data = lo & 0x000000ff;
			conf_data |= (CS5536_UDC_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_UDC_FLAG){
				conf_data = CS5536_UDC_RANGE | PCI_MAPREG_TYPE_MEM;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_UDC_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_UDC), &hi, &lo);
				conf_data = lo & 0xfffff000;
				conf_data &= ~0x0000000f; // 32bit mem
			}
			break;
		case PCI_BAR1_REG :
			conf_data = 0x000000;
			break;		
		case PCI_BAR2_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR3_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR4_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR5_REG :
			conf_data = 0x000000;
			break;
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (CS5536_UDC_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_USB_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}

#else	/* TEST_CS5536_USE_UDC */

static void pci_udc_write_reg(int reg, u32 value)
{
	return;
}

static u32 pci_udc_read_reg(int reg)
{
	return  0xffffffff;
}

#endif	/* TEST_CS5536_USE_UDC */


#ifdef	TEST_CS5536_USE_OTG
static void pci_otg_write_reg(int reg, u32 value)
{
	u32 hi, lo;
	
	switch(reg){
		case PCI_COMMAND_STATUS_REG :
			// COMMAND
			if(value & PCI_COMMAND_MEM_ENABLE){
				_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
				hi |= (1 << 1);
				_wrmsr(USB_MSR_REG(USB_OTG), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
				hi &= ~(1 << 1);
				_wrmsr(USB_MSR_REG(USB_OTG), hi, lo);				
			}
			// STATUS
			if(value & PCI_STATUS_PARITY_ERROR){
				_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
				if(lo & SB_PARE_ERR_FLAG){
					lo = (lo & 0x0000ffff) | SB_PARE_ERR_FLAG;
					_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
				}				
			}
			break;
		case PCI_BAR0_REG :
			if(value == PCI_BAR_RANGE_MASK){
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo |= SOFT_BAR_OTG_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else if( (value & 0x01) == 0x00 ){
				_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
				lo = value & 0xffffff00;
				_wrmsr(USB_MSR_REG(USB_OTG), hi, lo);
				
				value &= 0xfffffff0;
				hi = 0x40000000 | ((value & 0xff000000) >> 24);
				lo = 0x000fffff | ((value & 0x00fff000) << 8);
				_wrmsr(GLIU_MSR_REG(GLIU_P2D_BM1), hi, lo);
			}
			break;
		default :
			break;			
	}
	
	return;
}

static u32 pci_otg_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (CS5536_OTG_DEVICE_ID << 16 | CS5536_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
			// COMMAND
			_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
			if(hi & 0x02)
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			// STATUS
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			_rdmsr(SB_MSR_REG(SB_ERROR), &hi, &lo);
			if(lo & SB_PARE_ERR_FLAG)
				conf_data |= PCI_STATUS_PARITY_ERROR;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			_rdmsr(USB_MSR_REG(USB_CAP), &hi, &lo);
			conf_data = lo & 0x000000ff;
			conf_data |= (CS5536_OTG_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
			if(lo & SOFT_BAR_OTG_FLAG){
				conf_data = CS5536_OTG_RANGE | PCI_MAPREG_TYPE_MEM;
				_rdmsr(GLCP_MSR_REG(GLCP_SOFT_COM), &hi, &lo);
				lo &= ~SOFT_BAR_OTG_FLAG;
				_wrmsr(GLCP_MSR_REG(GLCP_SOFT_COM), hi, lo);
			}else{
				_rdmsr(USB_MSR_REG(USB_OTG), &hi, &lo);
				conf_data = lo & 0xffffff00;
				conf_data &= ~0x0000000f;
			}
			break;
		case PCI_BAR1_REG :
			conf_data = 0x000000;
			break;		
		case PCI_BAR2_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR3_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR4_REG :
			conf_data = 0x000000;
			break;
		case PCI_BAR5_REG :
			conf_data = 0x000000;
			break;
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (CS5536_OTG_SUB_ID << 16) | CS5536_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_USB_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (CS5536_USB_INTR);
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}

#else	/* TEST_CS5536_USE_OTG */

static void pci_otg_write_reg(int reg, u32 value)
{
	return;
}

static u32 pci_otg_read_reg(int reg)
{
	return 0xffffffff;
}

#endif	/* TEST_CS5536_USE_OTG */

/*******************************************************************************/

/*
 * writen : write to PCI config space and transfer it to MSR write.
 */
void cs5536_pci_conf_write4(int function, int reg, u32 value)
{
	/* some basic checking. */
	if( (function < CS5536_FUNC_START) || (function > CS5536_FUNC_END) ){
		return;
	}
	if( (reg < 0) || (reg > 0x100) || ((reg & 0x03) != 0) ){
		return;
	}
	
	switch(function){
		case CS5536_ISA_FUNC :
			pci_isa_write_reg(reg, value);		
			break;

		case CS5536_FLASH_FUNC :
			pci_flash_write_reg(reg, value);
			break;
		
		case CS5536_IDE_FUNC :
			pci_ide_write_reg(reg, value);
			break;

		case CS5536_ACC_FUNC :
			pci_acc_write_reg(reg, value);
			break;

		case CS5536_OHCI_FUNC :
			pci_ohci_write_reg(reg, value);
			break;

		case CS5536_EHCI_FUNC :
			pci_ehci_write_reg(reg, value);
			break;

		case CS5536_UDC_FUNC :
			pci_udc_write_reg(reg, value);
			break;

		case CS5536_OTG_FUNC :
			pci_otg_write_reg(reg, value);
			break;
		
		default :
			break;
	}
	
	return;
}

/*
 * readn : read PCI config space and transfer it to MSR access.
 */
u32 cs5536_pci_conf_read4(int function, int reg)
{
	u32 data = 0;

	/* some basic checking. */
	if( (function < CS5536_FUNC_START) || (function > CS5536_FUNC_END) ){
		return 0;
	}
	if( (reg < 0) || ((reg & 0x03) != 0) ){
		return 0;
	}
	if( reg > 0x100 )
		return 0xffffffff;
	
	switch(function){
		case CS5536_ISA_FUNC :
			data = pci_isa_read_reg(reg);
			break;

		case CS5536_FLASH_FUNC :
			data = pci_flash_read_reg(reg);
			break;
		
		case CS5536_IDE_FUNC :
			data = pci_ide_read_reg(reg);
			break;

		case CS5536_ACC_FUNC :
			data = pci_acc_read_reg(reg);
			break;

		case CS5536_OHCI_FUNC :
			data = pci_ohci_read_reg(reg);
			break;

		case CS5536_EHCI_FUNC :
			data = pci_ehci_read_reg(reg);
			break;

		case CS5536_UDC_FUNC :
			data = pci_udc_read_reg(reg);
			break;

		case CS5536_OTG_FUNC :
			data = pci_otg_read_reg(reg);
			break;
		
		default :
			break;
	
	}
	
	return data;
}

/**************************************************************************/

