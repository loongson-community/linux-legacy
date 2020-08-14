/*
 * pci_machdep_ls1a.c  
 * 	the Virtual Support Module(VSM) for virtulize the PCI configure  
 * 	space. so user can access the PCI configure space directly as
 *	a normal multi-function PCI device which following the PCI-2.2 spec.
 *
 * Author : jlliu <liujl@lemote.com>
 * Date : 07-07-05
 *
 */
#include <linux/types.h>

#include "pcireg.h"
#include "ls1a_pci.h"
#include <linux/pci_ids.h>
#define SYNOPGMAC_VENDOR_ID  0x0700
#define SYNOPGMAC_DEVICE_ID  0x1108

#define LS1A_AHCI_BASE 0x12e30000
#define LS1A_USB_OHCI_BASE 0x12e08000
#define LS1A_USB_EHCI_BASE 0x12e00000
#define LS1A_GMAC1_BASE	0x12e10000
#define LS1A_GMAC2_BASE	0x12e20000
#define LS1A_NAND_BASE	0x12e78000
#define LS1A_AUDIO_BASE	0x12e74000

static int pci_conf_write_val;

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
static void pci_ahci_write_reg(int reg, u32 value)
{
	switch(reg){
		case PCI_BAR5_REG :
			pci_conf_write_val = value;
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

static u32 pci_ahci_read_reg(int reg)
{
	u32 conf_data;
	u32 hi = 0, lo = 0;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (0x2652 << 16 | 0x8086);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 7;
			break;
		case PCI_CLASS_REG :
			conf_data = (LS1A_AHCI_CLASS_CODE << 8);
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_BRIDGE_HEADER_TYPE << 16) |
				(hi << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		/*
		 * we only use the LBAR of DIVIL, no RCONF used. 
		 * all of them are IO space.
		 */
		case PCI_BAR5_REG :
			if (pci_conf_write_val == PCI_BAR_RANGE_MASK){
			conf_data = 0xfffffff0;
			}
			else
			conf_data = LS1A_AHCI_BASE | PCI_MAPREG_TYPE_MEM;
			break;
		case PCI_CARDBUS_CIS_REG :
			conf_data = PCI_CARDBUS_CIS_POINTER;
			break;
		case PCI_SUBSYS_ID_REG :
			conf_data = (LS1A_AHCI_SUB_ID << 16) | LS1A_SUB_VENDOR_ID;
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




/*
 * ohci_write : ohci write tranfering.
 */
static void pci_ohci_write_reg(int reg, u32 value)
{
	switch(reg){
		case PCI_BAR0_REG :
			pci_conf_write_val = value;
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
			conf_data = (LS1A_OHCI_DEVICE_ID << 16 | LS1A_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			conf_data = ((PCI_CLASS_SERIAL_USB << 8) | 0x10)<<8;
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			if (pci_conf_write_val == PCI_BAR_RANGE_MASK){
			conf_data = 0xfffffff0;
			}
			else
				conf_data = LS1A_USB_OHCI_BASE | PCI_MAPREG_TYPE_MEM;
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
			conf_data = (LS1A_OHCI_SUB_ID << 16) | LS1A_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_USB_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (LS1A_USB_INTR);
			break;
		case PCI_OHCI_PM_REG :
			conf_data = 0;
			break;
		case PCI_OHCI_INT_REG :
			conf_data = 0;
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}

static void pci_ehci_write_reg(int reg, u32 value)
{
	switch(reg){
		case PCI_BAR0_REG :
			pci_conf_write_val = value;
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
			conf_data = (LS1A_EHCI_DEVICE_ID << 16 | LS1A_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			// STATUS
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			conf_data = ((PCI_CLASS_SERIAL_USB << 8) | 0x20)<<8;
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(PCI_NORMAL_LATENCY_TIMER << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			if (pci_conf_write_val == PCI_BAR_RANGE_MASK){
			conf_data = 0xfffffff0;
			}
			else
			conf_data = LS1A_USB_EHCI_BASE | PCI_MAPREG_TYPE_MEM;
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
			conf_data = (LS1A_EHCI_SUB_ID << 16) | LS1A_SUB_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_USB_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (LS1A_USB_INTR);
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}
//---------------------------

/*
 * ohci_write : ohci write tranfering.
 */
static void pci_gmac_write_reg(int reg, u32 value)
{
	switch(reg){
		case PCI_BAR0_REG :
			pci_conf_write_val = value;
			break;
	}
	return;
}

/*
 * ohci_read : ohci read transfering.
 */
static u32 pci_gmac_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (SYNOPGMAC_DEVICE_ID << 16 | SYNOPGMAC_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			conf_data = ((PCI_CLASS_NETWORK_ETHERNET << 8) | 0x10)<<8;
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			if (pci_conf_write_val == PCI_BAR_RANGE_MASK){
			conf_data = 0xfffffff0;
			}
			else
				conf_data = LS1A_GMAC1_BASE | PCI_MAPREG_TYPE_MEM;
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
			conf_data = (SYNOPGMAC_DEVICE_ID << 16) | SYNOPGMAC_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (LS1A_GMAC1_INTR);
			break;
		case PCI_OHCI_PM_REG :
			conf_data = 0;
			break;
		case PCI_OHCI_INT_REG :
			conf_data = 0;
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}

//---------------------------

/*
nand
 */
static void pci_nand_write_reg(int reg, u32 value)
{
	switch(reg){
		case PCI_BAR0_REG :
			pci_conf_write_val = value;
			break;
	}
	return;
}

/*
 * ohci_read : ohci read transfering.
 */
static u32 pci_nand_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (LS1A_FLASH_DEVICE_ID << 16 | LS1A_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			conf_data = ((PCI_CLASS_STORAGE_OTHER << 8) | 0x10)<<8;
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			if (pci_conf_write_val == PCI_BAR_RANGE_MASK){
			conf_data = 0xfffffff0;
			}
			else
				conf_data = LS1A_NAND_BASE | PCI_MAPREG_TYPE_MEM;
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
			conf_data = (LS1A_FLASH_DEVICE_ID << 16) | LS1A_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (LS1A_FLASH_INTR);
			break;
		case PCI_OHCI_PM_REG :
			conf_data = 0;
			break;
		case PCI_OHCI_INT_REG :
			conf_data = 0;
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}

//------------------------------------------------------------------------------
static void pci_audio_write_reg(int reg, u32 value)
{
	switch(reg){
		case PCI_BAR0_REG :
			pci_conf_write_val = value;
			break;
	}
	return;
}

static u32 pci_audio_read_reg(int reg)
{
	u32 conf_data;
	u32 hi, lo;
	
	switch(reg){
		case PCI_ID_REG :
			conf_data = (LS1A_AUDIO_DEVICE_ID << 16 | LS1A_VENDOR_ID);
			break;
		case PCI_COMMAND_STATUS_REG :
			conf_data = 0;
				conf_data |= PCI_COMMAND_MASTER_ENABLE;
				conf_data |= PCI_COMMAND_MEM_ENABLE;
			conf_data |= PCI_STATUS_66MHZ_SUPPORT;
			conf_data |= PCI_STATUS_BACKTOBACK_SUPPORT;
			conf_data |= PCI_STATUS_DEVSEL_MEDIUM;
			break;
		case PCI_CLASS_REG :
			conf_data = ((PCI_CLASS_NETWORK_ETHERNET << 8) | 0x10)<<8;
			break;
		case PCI_BHLC_REG :
			conf_data = (PCI_NONE_BIST << 24) | (PCI_NORMAL_HEADER_TYPE << 16) |
				(0x00 << 8) | PCI_NORMAL_CACHE_LINE_SIZE;
			break;
		case PCI_BAR0_REG :
			if (pci_conf_write_val == PCI_BAR_RANGE_MASK){
			conf_data = 0xfffffff0;
			}
			else
				conf_data = LS1A_AUDIO_BASE | PCI_MAPREG_TYPE_MEM;
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
			conf_data = (SYNOPGMAC_DEVICE_ID << 16) | SYNOPGMAC_VENDOR_ID;
			break;
		case PCI_MAPREG_ROM :
			conf_data = PCI_EXPANSION_ROM_BAR;
			break;
		case PCI_CAPLISTPTR_REG :
			conf_data = PCI_CAPLIST_POINTER;
			break;
		case PCI_INTERRUPT_REG :
			conf_data = (PCI_MAX_LATENCY << 24) | (PCI_MIN_GRANT << 16) | 
				(PCI_DEFAULT_PIN << 8) | (LS1A_AUDIO_IRQ);
			break;
		case PCI_OHCI_PM_REG :
			conf_data = 0;
			break;
		case PCI_OHCI_INT_REG :
			conf_data = 0;
			break;
		default :
			conf_data = 0;
			break;
	}

	return conf_data;
}

/*******************************************************************************/

/*
 * writen : write to PCI config space and transfer it to MSR write.
 */
void ls1a_pci_conf_write4(int function, int reg, u32 value)
{
	/* some basic checking. */
	if( (function < LS1A_FUNC_START) || (function > LS1A_FUNC_END) ){
		return;
	}
	if( (reg < 0) || (reg > 0x100) || ((reg & 0x03) != 0) ){
		return;
	}
	
	switch(function){
		case LS1A_AHCI_FUNC :
			pci_ahci_write_reg(reg, value);		
			break;

		case LS1A_FLASH_FUNC:
			pci_nand_write_reg(reg, value);		
			break;

		case LS1A_OHCI_FUNC :
			pci_ohci_write_reg(reg, value);
			break;

		case LS1A_EHCI_FUNC :
			pci_ehci_write_reg(reg, value);
			break;

		case LS1A_GMAC1_FUNC:
			pci_gmac_write_reg(reg, value);
			break;

		case LS1A_AUDIO_FUNC:
			pci_audio_write_reg(reg, value);
			break;

		default :
			break;
	}
	
	return;
}

/*
 * readn : read PCI config space and transfer it to MSR access.
 */
u32 ls1a_pci_conf_read4(int function, int reg)
{
	u32 data = -1;

	/* some basic checking. */
	if( (function < LS1A_FUNC_START) || (function > LS1A_FUNC_END) ){
		return -1;
	}
	if( (reg < 0) || ((reg & 0x03) != 0) ){
		return 0;
	}
	if( reg > 0x100 )
		return 0xffffffff;
	
	switch(function){
		case LS1A_AHCI_FUNC :
			data = pci_ahci_read_reg(reg);
			break;

		case LS1A_FLASH_FUNC:
			data = pci_nand_read_reg(reg);
			break;

		case LS1A_OHCI_FUNC :
			data = pci_ohci_read_reg(reg);
			break;

		case LS1A_EHCI_FUNC :
			data = pci_ehci_read_reg(reg);
			break;

		case LS1A_GMAC1_FUNC:
			data = pci_gmac_read_reg(reg);
			break;

		case LS1A_AUDIO_FUNC:
			data = pci_audio_read_reg(reg);
			break;
		
		default :
			break;
	
	}
	
	return data;
}

/**************************************************************************/

