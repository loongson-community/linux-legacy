/*
 * cs5536_vsm.h
 * the definition file of cs5536 Virtual Support Module(VSM).
 * pci configuration space can be accessed through the VSM, so
 * there is no need the MSR read/write now, except the spec. MSR
 * registers which are not implemented yet.
 *
 * Author : jlliu <liujl@lemote.com>
 * Date : 07-07-04
 *
 */

#ifndef	_LS1A_PCI_H
#define	_LS1A_PCI_H

/**********************************************************************/

//#define	TEST_LS1A_USE_FLASH
//#ifdef	TEST_LS1A_USE_FLASH
//#define	TEST_LS1A_USE_NOR_FLASH
//#endif
#define	TEST_LS1A_USE_EHCI
#define	TEST_LS1A_USE_UDC
#define	TEST_LS1A_USE_OTG

/**********************************************************************/

#define	PCI_SPECIAL_SHUTDOWN	1
#define	LS1A_FLASH_INTR	13
#define	LS1A_ACC_INTR		9
#define	LS1A_IDE_INTR		14
#define	LS1A_USB_INTR		11
#define	LS1A_GMAC1_INTR		34
#define	LS1A_GMAC2_INTR		35
#define LS1A_AUDIO_IRQ		14
#define	LS1A_UART1_INTR	6
#define	LS1A_UART2_INTR	5

/************************* PCI BUS DEVICE FUNCTION ********************/

/*
 * PCI bus device function
 */
#define	PCI_BUS_LS1A		0
#define	PCI_IDSEL_LS1A	14
#define	PCI_CFG_BASE		0x02000000

#define	LS1A_AHCI_FUNC		0
#define	LS1A_FLASH_FUNC	1
#define	LS1A_GMAC1_FUNC		2
#define	LS1A_GMAC2_FUNC		3
#define	LS1A_OHCI_FUNC	4
#define	LS1A_EHCI_FUNC	5
#define	LS1A_AUDIO_FUNC		6
#define	LS1A_OTG_FUNC		7
#define	LS1A_FUNC_START	0
#define	LS1A_FUNC_END		7
#define	LS1A_FUNC_COUNT	(LS1A_FUNC_END - LS1A_FUNC_START + 1)

/***************************** STANDARD PCI-2.2 EXPANSION ***********************/

/*
 * PCI configuration space
 * we have to virtualize the PCI configure space head, so we should
 * define the necessary IDs and some others.
 */
/* VENDOR ID */ 
#define	LS1A_VENDOR_ID	0x104a

/* DEVICE ID */
#define	LS1A_AHCI_DEVICE_ID		0x2090
#define	LS1A_FLASH_DEVICE_ID		0x2091
#define	LS1A_IDE_DEVICE_ID		0x209a
#define	LS1A_ACC_DEVICE_ID		0x2093
#define	LS1A_OHCI_DEVICE_ID		0x2094
#define	LS1A_EHCI_DEVICE_ID		0x2095
#define	LS1A_AUDIO_DEVICE_ID		0x2096
#define	LS1A_OTG_DEVICE_ID		0x2097

/* CLASS CODE : CLASS SUB-CLASS INTERFACE */
#define	LS1A_AHCI_CLASS_CODE		0x060100
#define	LS1A_FLASH_CLASS_CODE		0x050100
#define LS1A_IDE_CLASS_CODE		0x010180
#define	LS1A_ACC_CLASS_CODE		0x040100
#define	LS1A_OHCI_CLASS_CODE		0x0C0310
#define	LS1A_EHCI_CLASS_CODE		0x0C0320
#define	LS1A_AUDIO_CLASS_CODE		0x0401FE
#define	LS1A_OTG_CLASS_CODE		0x0C0380

/* BHLC : BIST HEADER-TYPE LATENCY-TIMER CACHE-LINE-SIZE */
#define	PCI_NONE_BIST			0x00	//RO not implemented yet.
#define	PCI_BRIDGE_HEADER_TYPE		0x80	//RO
#define	PCI_NORMAL_HEADER_TYPE		0x00
#define	PCI_NORMAL_LATENCY_TIMER	0x00
#define	PCI_NORMAL_CACHE_LINE_SIZE	0x08	//RW

/* BAR */
#define	PCI_BAR0_REG			0x10
#define	PCI_BAR1_REG			0x14
#define	PCI_BAR2_REG			0x18
#define	PCI_BAR3_REG			0x1c
#define	PCI_BAR4_REG			0x20
#define	PCI_BAR5_REG			0x24
#define	PCI_BAR_COUNT			6
#define	PCI_BAR_RANGE_MASK		0xFFFFFFFF

/* CARDBUS CIS POINTER */
#define	PCI_CARDBUS_CIS_POINTER		0x00000000

/* SUBSYSTEM VENDOR ID  */
#define	LS1A_SUB_VENDOR_ID		LS1A_VENDOR_ID

/* SUBSYSTEM ID */
#define	LS1A_AHCI_SUB_ID		LS1A_AHCI_DEVICE_ID
#define	LS1A_FLASH_SUB_ID		LS1A_FLASH_DEVICE_ID
#define	LS1A_IDE_SUB_ID		LS1A_IDE_DEVICE_ID
#define	LS1A_ACC_SUB_ID		LS1A_ACC_DEVICE_ID
#define	LS1A_OHCI_SUB_ID		LS1A_OHCI_DEVICE_ID
#define	LS1A_EHCI_SUB_ID		LS1A_EHCI_DEVICE_ID
#define	LS1A_AUDIO_SUB_ID		LS1A_AUDIO_DEVICE_ID
#define	LS1A_OTG_SUB_ID		LS1A_OTG_DEVICE_ID

/* EXPANSION ROM BAR */
#define	PCI_EXPANSION_ROM_BAR		0x00000000

/* CAPABILITIES POINTER */
#define	PCI_CAPLIST_POINTER		0x00000000
#define PCI_CAPLIST_USB_POINTER		0x40
/* INTERRUPT */
#define	PCI_MAX_LATENCY			0x40
#define	PCI_MIN_GRANT			0x00
#define	PCI_DEFAULT_PIN			0x01

/**************************** EXPANSION PCI REG **************************************/

/*
 * ISA EXPANSION
 */
#define	PCI_UART1_INT_REG 	0x50
#define PCI_UART2_INT_REG	0x54
#define	PCI_ISA_FIXUP_REG	0x58

/*
 * FLASH EXPANSION
 */
#define	PCI_FLASH_INT_REG		0x50
#define	PCI_NOR_FLASH_CTRL_REG		0x40
#define	PCI_NOR_FLASH_T01_REG		0x44
#define	PCI_NOR_FLASH_T23_REG		0x48
#define	PCI_NAND_FLASH_TDATA_REG	0x60
#define	PCI_NAND_FLASH_TCTRL_REG	0x64
#define	PCI_NAND_FLASH_RSVD_REG		0x68
#define	PCI_FLASH_SELECT_REG		0x70

/*
 * IDE EXPANSION
 */ 
#define	PCI_IDE_CFG_REG		0x40
#define	LS1A_IDE_FLASH_SIGNATURE	0xDEADBEEF
#define	PCI_IDE_DTC_REG		0x48
#define	PCI_IDE_CAST_REG	0x4C
#define	PCI_IDE_ETC_REG		0x50
#define	PCI_IDE_PM_REG		0x54
#define	PCI_IDE_INT_REG		0x60

/*
 * ACC EXPANSION
 */
#define	PCI_ACC_INT_REG		0x50

/*
 * OHCI EXPANSION : INTTERUPT IS IMPLEMENTED BY THE OHCI
 */
#define	PCI_OHCI_PM_REG		0x40
#define	PCI_OHCI_INT_REG	0x50

/*
 * EHCI EXPANSION
 */
#define	PCI_EHCI_LEGSMIEN_REG	0x50
#define	PCI_EHCI_LEGSMISTS_REG	0x54
#define	PCI_EHCI_FLADJ_REG	0x60

#endif /* _LS1A_PCI_H_ */
