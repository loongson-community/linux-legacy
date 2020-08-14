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

#ifndef	_CS5536_PCI_H
#define	_CS5536_PCI_H

/**********************************************************************/

//#define	TEST_CS5536_USE_FLASH
//#ifdef	TEST_CS5536_USE_FLASH
//#define	TEST_CS5536_USE_NOR_FLASH
//#endif
#define		TEST_CS5536_USE_EHCI
#define	TEST_CS5536_USE_UDC
#define	TEST_CS5536_USE_OTG

/**********************************************************************/

#define	PCI_SPECIAL_SHUTDOWN	1
#define	CS5536_FLASH_INTR	6
#define	CS5536_ACC_INTR		9
#define	CS5536_IDE_INTR		14
#define	CS5536_USB_INTR		11
#define	CS5536_UART1_INTR	4
#define	CS5536_UART2_INTR	3

/************************* PCI BUS DEVICE FUNCTION ********************/

/*
 * PCI bus device function
 */
#define	PCI_BUS_CS5536		0
#define	PCI_IDSEL_CS5536	14
#define	PCI_CFG_BASE		0x02000000

#define	CS5536_ISA_FUNC		0
#define	CS5536_FLASH_FUNC	1
#define	CS5536_IDE_FUNC		2
#define	CS5536_ACC_FUNC		3
#define	CS5536_OHCI_FUNC	4
#define	CS5536_EHCI_FUNC	5
#define	CS5536_UDC_FUNC		6
#define	CS5536_OTG_FUNC		7
#define	CS5536_FUNC_START	0
#define	CS5536_FUNC_END		7
#define	CS5536_FUNC_COUNT	(CS5536_FUNC_END - CS5536_FUNC_START + 1)

/***************************** STANDARD PCI-2.2 EXPANSION ***********************/

/*
 * PCI configuration space
 * we have to virtualize the PCI configure space head, so we should
 * define the necessary IDs and some others.
 */
/* VENDOR ID */ 
#define	CS5536_VENDOR_ID	0x1022

/* DEVICE ID */
#define	CS5536_ISA_DEVICE_ID		0x2090
#define	CS5536_FLASH_DEVICE_ID		0x2091
#define	CS5536_IDE_DEVICE_ID		0x209a
#define	CS5536_ACC_DEVICE_ID		0x2093
#define	CS5536_OHCI_DEVICE_ID		0x2094
#define	CS5536_EHCI_DEVICE_ID		0x2095
#define	CS5536_UDC_DEVICE_ID		0x2096
#define	CS5536_OTG_DEVICE_ID		0x2097

/* CLASS CODE : CLASS SUB-CLASS INTERFACE */
#define	CS5536_ISA_CLASS_CODE		0x060100
#define	CS5536_FLASH_CLASS_CODE		0x050100
#define CS5536_IDE_CLASS_CODE		0x010180
#define	CS5536_ACC_CLASS_CODE		0x040100
#define	CS5536_OHCI_CLASS_CODE		0x0C0310
#define	CS5536_EHCI_CLASS_CODE		0x0C0320
#define	CS5536_UDC_CLASS_CODE		0x0C03FE
#define	CS5536_OTG_CLASS_CODE		0x0C0380

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
#define	CS5536_SUB_VENDOR_ID		CS5536_VENDOR_ID

/* SUBSYSTEM ID */
#define	CS5536_ISA_SUB_ID		CS5536_ISA_DEVICE_ID
#define	CS5536_FLASH_SUB_ID		CS5536_FLASH_DEVICE_ID
#define	CS5536_IDE_SUB_ID		CS5536_IDE_DEVICE_ID
#define	CS5536_ACC_SUB_ID		CS5536_ACC_DEVICE_ID
#define	CS5536_OHCI_SUB_ID		CS5536_OHCI_DEVICE_ID
#define	CS5536_EHCI_SUB_ID		CS5536_EHCI_DEVICE_ID
#define	CS5536_UDC_SUB_ID		CS5536_UDC_DEVICE_ID
#define	CS5536_OTG_SUB_ID		CS5536_OTG_DEVICE_ID

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
#define	CS5536_IDE_FLASH_SIGNATURE	0xDEADBEEF
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

#endif /* _CS5536_PCI_H_ */
