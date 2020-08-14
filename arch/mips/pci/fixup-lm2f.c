/*
 * fixup-lm2f.c
 *
 * Copyright (C) 2004 ICT CAS
 * Author: Li xiaoyu, ICT CAS
 *   lixy@ict.ac.cn
 *
 * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
 * Author: Fuxin Zhang, zhangfx@lemote.com
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
 *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
 *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
 *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  You should have received a copy of the  GNU General Public License along
 *  with this program; if not, write  to the Free Software Foundation, Inc.,
 *  675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */
#include <linux/init.h>
#include <linux/pci.h>
#include <asm/mips-boards/bonito64.h>

/* PCI interrupt pins */
/* These should not be changed, or you should consider godson2f interrupt register and
 * your pci card dispatch
 */
#define PCIA		4
#define PCIB		5
#define PCIC		6
#define PCID		7

/* all the pci device has the PCIA pin, check the datasheet. */
static char irq_tab[][5] __initdata = {
	/*      INTA    INTB    INTC    INTD */
	{0,	0,	0,	0,	0 },	/*  11: Unused */
	{0,	0,	0,	0,	0 },	/*  12: Unused */
	{0,	0,	0,	0,	0 },	/*  13: Unused */
	{0,	0,	0,	0,	0 },	/*  14: Unused */
	{0,	0,	0,	0,	0 },	/*  15: Unused */
	{0,	0,	0,	0,	0 },	/*  16: Unused */
	{0,	PCIA,	0,	0,	0 },	/*  17: RTL8110-0 */
	{0,	PCIB,	0,	0,	0 },	/*  18: RTL8110-1 */
	{0,	PCIC,	0,	0,	0 },	/*  19: SiI3114 */
	{0,	0,	0,	0,	0 },	/*  20: Unused */
	{0,	PCIA,	PCIB,	PCIC,	PCID },	/*  21: PCI-SLOT */
	{0,	0,	0,	0,	0 },	/*  22: Unused */
	{0,	0,	0,	0,	0 },	/*  23: Unused */
	{0,	0,	0,	0,	0 },	/*  24: Unused */
	{0,	0,	0,	0,	0 },	/*  25: Unused */
	{0,	0,	0,	0,	0 },	/*  26: Unused */
	{0,	0,	0,	0,	0 },	/*  27: Unused */
};

int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
{
	int virq;
#if 0
	if(PCI_SLOT(dev->devfn) == (17 - 11) ){		/* RTL8110SC_0 */
		dev->irq = BONITO_IRQ_BASE + 25 + 1;
		(void) pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
		return dev->irq;
	}else if(PCI_SLOT(dev->devfn) == (18 - 11)){	/* RTL8110SC_1 */
		dev->irq = BONITO_IRQ_BASE + 25 + 2;
		(void) pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
		return dev->irq;
	}else if(PCI_SLOT(dev->devfn) == (19 - 11)){	/* SiI3114 */
		dev->irq = BONITO_IRQ_BASE + 25 + 3;
		(void) pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
		return dev->irq;
	//}
	//else if(PCI_SLOT(dev->devfn) == (21 - 11)){	/* PCI SLOT */
	//	dev->irq = BONITO_IRQ_BASE + 25 + 4;
	//	(void) pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
	//	return dev->irq;
	}else 
#endif

	if( (PCI_SLOT(dev->devfn) != (14)) && (PCI_SLOT(dev->devfn) < 32) ){
		virq = irq_tab[slot][pin];
		printk("slot: %d, pin: %d, irq: %d\n", slot, pin, virq+BONITO_IRQ_BASE);
		if(virq != 0)
			return (BONITO_IRQ_BASE + virq);
		else	
			return 0;
	}else if( PCI_SLOT(dev->devfn) == 14){	// cs5536
		switch(PCI_FUNC(dev->devfn)){
			case 2 :
				pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 14);
				return 14;	// for IDE
			case 3 :
				pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 9);
				return 9;	// for AUDIO
			case 4 :		// for OHCI
			case 5 :		// for EHCI
			case 6 :		// for UDC
			case 7 :		// for OTG
				pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
				return 11;	
		}
		return dev->irq;
	}else{
		printk(" strange pci slot number.\n");
		return 0;
	}
}

/* Do platform specific device initialization at pci_enable_device() time */
int pcibios_plat_dev_init(struct pci_dev *dev)
{
	return 0;
}

#ifndef	TEST_NO_CS5536
/* CS5536 SPEC. fixup */
static void __init loongson2e_cs5536_isa_fixup(struct pci_dev *pdev)
{
	/* the uart1 and uart2 interrupt in PIC is enabled as default */
	pci_write_config_dword(pdev, 0x50, 1);
	pci_write_config_dword(pdev, 0x54, 1);
	/* enable the pci MASTER ABORT/ TARGET ABORT etc. */
	pci_write_config_dword(pdev, 0x58, 1);
	return;
}


static void __init loongson2e_cs5536_ide_fixup(struct pci_dev *pdev)
{
	/* setting the mutex pin as IDE function */
	/* the IDE interrupt in PIC is enabled as default */
	pci_write_config_dword(pdev, 0x40, 0xDEADBEEF);
	return;
}

static void __init loongson2e_cs5536_acc_fixup(struct pci_dev *pdev)
{
	u8 val;

	/* enable the AUDIO interrupt in PIC  */
	pci_write_config_dword(pdev, 0x50, 1);

#if 1
	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
	printk("cs5536 acc latency %x\n", val);
	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
#endif
	return;
}

static void __init loongson2e_cs5536_ohci_fixup(struct pci_dev *pdev)
{
	/* enable the OHCI interrupt in PIC */
	/* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
	pci_write_config_dword(pdev, 0x50, 1);
	return;
}

static void __init loongson2e_cs5536_ehci_fixup(struct pci_dev *pdev)
{
	/* setting the USB2.0 micro frame length */
	pci_write_config_dword(pdev, 0x60, 0x2000);
	return;
}
#endif	/* TEST_NO_CS5536 */

static void __init loongson2e_fixup_pcimap(struct pci_dev *pdev)
{
	static int first = 1;
	u32 tmp;

	(void)pdev;
	if (first)
		first = 0;
	else
		return;

	/* local to PCI mapping: [256M,512M] -> [256M,512M]; differ from pmon */
	/*
	 *       cpu address space [256M,448M] is window for accessing pci space
	 *       we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
	 *        pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
	 */
	/* 1,00 0110 ,0001 01,00 0000 */
	BONITO_PCIMAP = 0x46140;
	//1, 00 0010, 0000,01, 00 0000
	//BONITO_PCIMAP = 0x42040;

	/*
	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
	 */
#if	1	// for GODSON2F
	BONITO_PCIBASE0 = 0x80000000;
	BONITO_PCIBASE1 = 0x00000000;
	BONITO(BONITO_REGBASE + 0x50) = 0x8000000c;
	BONITO(BONITO_REGBASE + 0x54) = 0xffffffff;
#else		// for GODSON2E
	BONITO_PCIBASE0 = 0x80000000;
	BONITO_PCIBASE1 = 0x00800000;
	BONITO_PCIBASE2 = 0x90000000;
#endif

#ifdef CONFIG_64BIT
	*(volatile u32*)0xffffffffbfe0004c = 0xd2000001;
/*
	tmp = *(volatile u32*)0xffffffffbfe00058ULL;
	tmp &= ~0x0000ff00;
	tmp |= 0x0000ff80;
	*(volatile u32*)0xffffffffbfe00058 = tmp;
*/
#else
	 *(volatile u32*)0xbfe0004c = 0xd2000001;
#endif
}

#ifndef	TEST_NO_CS5536
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, 
			 loongson2e_cs5536_isa_fixup);
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_OHC, 
			 loongson2e_cs5536_ohci_fixup);
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_EHC, 
			 loongson2e_cs5536_ehci_fixup);
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO, 
			 loongson2e_cs5536_acc_fixup);
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_IDE, 
			 loongson2e_cs5536_ide_fixup);
#endif	/* TEST_NO_CS5536 */
DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, loongson2e_fixup_pcimap);
