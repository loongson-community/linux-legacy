/*
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
 * Chris Dearman, chris@algor.co.uk
 * Copyright (C) 2001 Algorithmics Ltd.  All rights reserved.
 *
 *  This program is free software; you can distribute it and/or modify it
 *  under the terms of the GNU General Public License (Version 2) as
 *  published by the Free Software Foundation.
 *
 *  This program is distributed in the hope it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 *  for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * Algorithmics P6032 specific PCI support.
 *
 */

#include <linux/config.h>

#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/init.h>

#include <asm/pci_channel.h>

#include <asm/nb2005/p6032.h>
#include <asm/nb2005/p6032int.h>
#include <asm/nb2005/bonito.h>
#include <asm/nb2005/i82371eb.h>

#define PCI_ACCESS_READ  0
#define PCI_ACCESS_WRITE 1

#define Bonito static char * const _bonito = (char * const )KSEG1ADDR(BONITO_BASE)

static inline void
bflush (void)
{
        Bonito;
	/* flush Bonito register writes */
	(void) BONITO_PCICMD;
}

static int
p6032_pcibios_config_access(unsigned char access_type, struct pci_dev *dev,
			    unsigned char where, u32 *data)
{
        Bonito;
	unsigned char bus = dev->bus->number;
	unsigned char dev_fn = dev->devfn;

	u_int32_t addr, type;
	void *addrp;
	int device = dev_fn >> 3;
	int function = dev_fn & 0x7;
	int reg = where & ~3;

	if (bus == 0) 
	{
	        /* Type 0 configuration on onboard PCI bus */
		if (device > 20 || function > 7) {
			*data = -1;	/* device out of range */
			return PCIBIOS_DEVICE_NOT_FOUND;
		}
		addr = (1 << (device+11)) | (function << 8) | reg;
		type = 0;
	} else {
	        /* Type 1 configuration on offboard PCI bus */
	        if (bus > 255 || device > 31 || function > 7) {
			*data = -1;	/* device out of range */
		        return PCIBIOS_DEVICE_NOT_FOUND;
		}
		addr = (bus << 16) | (device << 11) | (function << 8) | reg;
		type = 0x10000;
	}

	/* clear aborts */
	BONITO_PCICMD |= BONITO_PCICMD_MABORT | BONITO_PCICMD_MTABORT;

	BONITO_PCIMAP_CFG = (addr >> 16) | type;
	bflush ();

	addrp = (void *)KSEG1ADDR(BONITO_PCICFG_BASE | (addr & 0xffff));
	if (access_type == PCI_ACCESS_WRITE)
		*(volatile unsigned int *)addrp = cpu_to_le32(*data);
	else
		*data = le32_to_cpu(*(volatile unsigned int *)addrp);

#if 0
prom_printf ("pci_config: (%d,%d,%d)/%x 0x%02x %s 0x%x\n", bus, device, function, addr,
	     reg,
	     access_type == PCI_ACCESS_WRITE ? "<-" : "->",
	     *data);
#endif

	if (BONITO_PCICMD & (BONITO_PCICMD_MABORT | BONITO_PCICMD_MTABORT)) {
	    BONITO_PCICMD |= BONITO_PCICMD_MABORT | BONITO_PCICMD_MTABORT;
	    *data = -1;
	    return PCIBIOS_DEVICE_NOT_FOUND;
	}

	return PCIBIOS_SUCCESSFUL;
}


static int
p6032_pcibios_read_config_byte(struct pci_dev *dev, int where, u8 *val)
{
        u32 data;
	int status;
	status = p6032_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);
	*val = (data >> ((where & 3) << 3)) & 0xff;

	return status;
}


static int
p6032_pcibios_read_config_word (struct pci_dev *dev, int where, u16 *val)
{
        u32 data;
	int status;

	if (where & 1)
		return PCIBIOS_BAD_REGISTER_NUMBER;

	status = p6032_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);
	*val = (data >> ((where & 3) << 3)) & 0xffff;

	return status;
}

static int
p6032_pcibios_read_config_dword (struct pci_dev *dev, int where, u32 *val)
{
	u32 data;
	int status;

	if (where & 3)
		return PCIBIOS_BAD_REGISTER_NUMBER;
	
	status = p6032_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);
	*val = data;

	return status;
}


static int
p6032_pcibios_write_config_byte (struct pci_dev *dev, int where, u8 val)
{
	u32 data;
	int status;
	status = p6032_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);

	if (status != PCIBIOS_SUCCESSFUL)
		return status;

	data = (data & ~(0xff << ((where & 3) << 3))) |
	       (val << ((where & 3) << 3));

	status = p6032_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &data);
	return status;
}

static int
p6032_pcibios_write_config_word (struct pci_dev *dev, int where, u16 val)
{
        u32 data;
	int status;

	if (where & 1)
		return PCIBIOS_BAD_REGISTER_NUMBER;
       
        status = p6032_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);

	if (status != PCIBIOS_SUCCESSFUL)
		return status;

	data = (data & ~(0xffff << ((where & 3) << 3))) | 
	       (val << ((where & 3) << 3));

	status = p6032_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &data);
	return status;
}

static int
p6032_pcibios_write_config_dword(struct pci_dev *dev, int where, u32 val)
{
	if (where & 3)
		return PCIBIOS_BAD_REGISTER_NUMBER;

	return p6032_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &val);
}

struct pci_ops p6032_pci_ops = {
	p6032_pcibios_read_config_byte,
	p6032_pcibios_read_config_word,
	p6032_pcibios_read_config_dword,
	p6032_pcibios_write_config_byte,
	p6032_pcibios_write_config_word,
	p6032_pcibios_write_config_dword
};


#ifndef pcibios_assign_all_busses
unsigned __init int pcibios_assign_all_busses(void)
{
	return 1;
}
#endif


static struct resource pci_io_resource = {
	"pci IO space",
	0x4000,
	0x20000000,
	IORESOURCE_IO
};

static struct resource pci_mem_resource = {
	"pci memory space",
	0x14000000, /* 0x10000000 does not work*/
	0x20000000,
	IORESOURCE_MEM
};

struct pci_channel mips_pci_channels[] = {
	{&p6032_pci_ops, &pci_io_resource, &pci_mem_resource, 0, 0},
	{(struct pci_ops *) NULL, (struct resource *) NULL,
		(struct resource *) NULL, (int) NULL, (int) NULL}
};

//--------------------------------------------------------
//
#undef P6032_PCIDEV_SLOT1
#undef P6032_PCIDEV_SLOT2
#undef P6032_PCIDEV_SLOT3
#undef P6032_PCIDEV_SLOT4
#undef P6032_PCIDEV_ETH
#undef P6032_PCIDEV_I82371
#undef P6032_PCIDEV_BONITO
#undef P6032INT_IRQA
#undef P6032INT_IRQB
#undef P6032INT_IRQC
#undef P6032INT_IRQD

#define P6032_PCIDEV_SLOT1 13
#define P6032_PCIDEV_SLOT2 14
#define P6032_PCIDEV_SLOT3 15
#define P6032_PCIDEV_SLOT4 18
#define P6032_PCIDEV_ETH 16
#define P6032_PCIDEV_I82371 17
#define P6032_PCIDEV_BONITO 19


#define P6032INT_IRQA 20
#define P6032INT_IRQB 21
#define P6032INT_IRQC 22
#define P6032INT_IRQD 23

int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
{
  if(dev->devfn == (17<<3 | 2)){
#define USB1_IRQ 11
			pci_write_config_byte(dev, PCI_COMMAND, PCI_COMMAND_IO|PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER);
			pci_write_config_byte(dev, 0x3c, USB1_IRQ);
			dev->irq=USB1_IRQ;
		return dev->irq;
  }
  else if(dev->devfn == (17<<3 | 3)){
#define USB2_IRQ 10
			pci_write_config_byte(dev, PCI_COMMAND, PCI_COMMAND_IO|PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER);
			pci_write_config_byte(dev, 0x3c, USB2_IRQ);
			dev->irq = USB2_IRQ;
			return dev->irq;
  }
  else if(dev->devfn == (17<<3 | 5)){

			/* route ac97 IRQ */
			pci_write_config_byte(dev, 0x3c, 9);
			dev->irq = 9;
		return dev->irq;
  }
 else if (slot == 16) { /* 8139 */ 
			dev->irq = P6032INT_IRQA;
			(void) pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
			return dev->irq;
 }else if (slot >=12 && slot <=15) { /* usb */
			dev->irq = P6032INT_IRQA +(((slot-12)+ (pin-1))&3);
			(void) pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
			return dev->irq;
}
  else return 0;
}

void __init pcibios_fixup_irqs(void)
{
	struct pci_dev *pdev;
	char pin;

	pci_for_each_dev(pdev) {
	pci_read_config_byte(pdev,PCI_INTERRUPT_PIN,&pin);
	pcibios_map_irq(pdev,PCI_SLOT(pdev->devfn),pin);
	}
}



//#define Bonito static char * const _bonito = (char * const )KSEG1ADDR(BONITO_BASE)
static void __init godson2e_686b_func0_fixup(struct pci_dev *pdev)
{
	unsigned char c;

	printk("via686b fix: ISA bridge\n");

	/*  Enable I/O Recovery time */
	pci_write_config_byte(pdev, 0x40, 0x08);

	/*  Enable ISA refresh */
	pci_write_config_byte(pdev, 0x41, 0x01);

	/*  disable ISA line buffer */
	pci_write_config_byte(pdev, 0x45, 0x00);

	/*  Gate INTR, and flush line buffer */
	pci_write_config_byte(pdev, 0x46, 0xe0);

	/*  Disable PCI Delay Transaction, Enable EISA ports 4D0/4D1. */
	//pci_write_config_byte(pdev, 0x47, 0x20); 
	/*  enable PCI Delay Transaction, Enable EISA ports 4D0/4D1. 
	 *  enable time-out timer 
	 */
	pci_write_config_byte(pdev, 0x47, 0xe6); 

	/* enable level trigger on pci irqs: 9,10,11,13 */
	/* important! without this PCI interrupts won't work */
	outb(0x2e,0x4d1);

	/*  512 K PCI Decode */
	pci_write_config_byte(pdev, 0x48, 0x01);

	/*  Wait for PGNT before grant to ISA Master/DMA */
	pci_write_config_byte(pdev, 0x4a, 0x84);

	/*  Plug'n'Play */
	/*  Parallel DRQ 3, Floppy DRQ 2 (default) */
	pci_write_config_byte(pdev, 0x50, 0x0e);

	/*  IRQ Routing for Floppy and Parallel port */
	/*  IRQ 6 for floppy, IRQ 7 for parallel port */
	pci_write_config_byte(pdev, 0x51, 0x76);

	/*  IRQ Routing for serial ports (take IRQ 3 and 4) */
	pci_write_config_byte(pdev, 0x52, 0x34);

	/*  All IRQ's level triggered. */
	pci_write_config_byte(pdev, 0x54, 0x00);


	/* route PIRQA-D irq */
	pci_write_config_byte(pdev,0x55, 0x90); /* bit 7-4, PIRQA */
	pci_write_config_byte(pdev,0x56, 0xba); /* bit 7-4, PIRQC; 3-0, PIRQB */
	pci_write_config_byte(pdev,0x57, 0xd0); /* bit 7-4, PIRQD */

	/* enable function 5/6, audio/modem */
	pci_read_config_byte(pdev,0x85, &c); 
	c &= ~(0x3<<2);
	pci_write_config_byte(pdev,0x85,c);

	printk("via686b fix: ISA bridge done\n");
}


static void __init godson2e_686b_func1_fixup(struct pci_dev *pdev)
{
	printk("via686b fix: IDE\n");

	/* Modify IDE controller setup */
	pci_write_config_byte(pdev,PCI_LATENCY_TIMER, 48); //0xd0
	pci_write_config_byte(pdev, PCI_COMMAND, PCI_COMMAND_IO|PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER);
	pci_write_config_byte(pdev, 0x40, 0x0b); 
	/* legacy mode */
	pci_write_config_byte(pdev, 0x42, 0x09);   
#if 0
	/* disable read prefetch/write post buffers */
	pci_write_config_byte(pdev, 0x41, 0x02); //0xf2);  

	/* use 3/4 as fifo thresh hold  */
	pci_write_config_byte(pdev, 0x43, 0x0a);//qqqw

	pci_write_config_byte(pdev, 0x44, 0x00);

	pci_write_config_byte(pdev, 0x45, 0x00);
#else
	pci_write_config_byte(pdev, 0x41, 0xc2); 
	pci_write_config_byte(pdev, 0x43, 0x35);
	pci_write_config_byte(pdev, 0x44, 0x9c);

	pci_write_config_byte(pdev, 0x45, 0x10);
#endif

	printk("via686b fix: IDE done\n");
}

static void __init godson2e_686b_func5_fixup(struct pci_dev *pdev)
{
	unsigned int val;
	unsigned char c;

	/* enable IO */
	pci_write_config_byte(pdev, PCI_COMMAND, PCI_COMMAND_IO|PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER);
	pci_read_config_dword(pdev, 0x4, &val);
	pci_write_config_dword(pdev, 0x4, val | 1);

	/* route ac97 IRQ */
	pci_write_config_byte(pdev, 0x3c, 9);
	pdev->irq = 9;
	printk("ac97 interrupt = 9\n");

	pci_read_config_byte(pdev, 0x8, &c);
	printk("ac97 rev=%d\n",c);

	/* link control: enable link & SGD PCM output */
	pci_write_config_byte(pdev, 0x41, 0xcc);

	/* disable game port, FM, midi, sb, enable write to reg2c-2f */
	pci_write_config_byte(pdev, 0x42, 0x20);

	printk("Setting sub-vendor ID & device ID\n");

	/* we are using Avance logic codec */
	pci_write_config_word(pdev, 0x2c, 0x1005);
	pci_write_config_word(pdev, 0x2e, 0x4710);
	pci_read_config_dword(pdev, 0x2c, &val);
	printk("sub vendor-device id=%x\n",val);

	pci_write_config_byte(pdev, 0x42, 0x0);
}

#ifndef CONFIG_LOONGSON_BIGPCI
static int bigpci=0;
#else
static int bigpci=1;
#endif

//#define Bonito static char * const _bonito = (char * const )CKSEG1ADDR(BONITO_BASE)
void __init pcibios_fixup(void) 
{
	Bonito;
	static int first = 1;
	return;

	if (first) first = 0; else return;
			
	/* 
	 * 	 Make pci address mapping coincident with cpu address mapping
	 * 	  1. use (both cpu&pci) space [256M,448M] for pci dev mem
	 * 	  2. allocate pci io address from 0x10000,pci iomem from 0x10000000
	 * 	  3. use pci_auto to allocate pci resource to pci devices
	 * 	 The only benefit of doing so is to avoid broken of some drivers
	 * 	 really ugly and dangerous:(
	 */
	/* local to PCI mapping: [256M,512M] -> [256M,512M] */
	/* 
	 * 	 cpu address space [256M,448M] is window for accessing pci space
	 * 	 we set pcimap_lo[0,1,2] to map it to pci space [256M,448M]
	 * 	  pcimap: bit18,pcimap_2; bit[17-12],lo2;bit[11-6],lo1;bit[5-0],lo0
	 */
	/* 1,00 0110 ,0001 01,00 0000 */
	BONITO_PCIMAP = 0x46140;
	//1, 00 0010, 0000,01, 00 0000
	//BONITO_PCIMAP = 0x42040;

	/* 
	 * PCI to local mapping: [2G,2G+256M] -> [0,256M]
	 */
	BONITO_PCIBASE0 = 0x80000000; 
	BONITO_PCIBASE1 = 0x0;
	BONITO(BONITO_REGBASE + 0x50) = 0x8000000c;
	BONITO(BONITO_REGBASE + 0x54) = 0xffffffff;

	/*set pci 2G -> DDR 0 ,window size 2G*/
	  asm(".set mips3;dli $2,0x900000003ff00000;dli $3,0x80000000;sd $3,0x60($2);sd $0,0xa0($2);dli $3,0xffffffff80000000;sd $3,0x80($2);.set mips0" :::"$2","$3");

	/* 
	 * PCI to local mapping: [8M,16M] -> [8M,16M]
	 */
	BONITO_PCI_REG(0x18) = 0x00800000; 
	BONITO_PCI_REG(0x1c) = 0x0;
	BONITO(BONITO_REGBASE + 0x58) = 0xff80000c;
	BONITO(BONITO_REGBASE + 0x5c) = 0xffffffff;

	/*set pci 8-16M -> DDR 8-16M ,window size 8M*/
	  asm(".set mips3;dli $2,0x900000003ff00000;li $3,0x800000;sd $3,0x68($2);sd $3,0xa8($2);dli $3,0xffffffffff800000;sd $3,0x88($2);.set mips0" :::"$2","$3");
								
	/* if needed then enable io cache for mem 0*/
	if (BONITO_PCIMEMBASECFG & BONITO_PCIMEMBASECFG_MEMBASE0_CACHED) 
	  		BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG_MEMBASE0_CACHED;
	else
	  		BONITO_PCIMEMBASECFG = 0x0;
	{
//can not change gnt to break pci transfer when device's gnt not deassert for some sb like 82371,via686b.
	volatile int *p=0xffffffffbfe00168;
	*p=0x00fe0105;
//make pci retry max 32.
    //p=0xffffffffbfe00058; *p=*p|0x2000;
	}
    if(bigpci) {
	/*set cpu window3 to map CPU 1G-> PCI 1G */	
	  asm(".set mips3;dli $2,0x900000003ff00000;li $3,0x40000000;sd $3,0x18($2);or $3,1;sd $3,0x58($2);dli $3,0xffffffffc0000000;sd $3,0x38($2);.set mips0" :::"$2","$3");
	}
}

#define DECLARE_PCI_FIXUP_HEADER(vendorid,deviceid,fixup_function) \
	if ((pdev->vendor == vendorid) && (pdev->device == deviceid)) fixup_function(pdev);

void __init pcibios_fixup_resources(struct pci_dev *pdev)
{
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,godson2e_686b_func0_fixup);
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,godson2e_686b_func1_fixup);
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,godson2e_686b_func5_fixup);
}

//------------------------------
int __init arch_pcibios_init(void)
{

    if(bigpci) {
#ifdef CONFIG_LOONGSON_FIX_RANDOM_INSTRUCTION_FETCH_SIDE_EFFECT_TO_DEVICE
		if(bigpci<2)bigpci=2;  //this fix method make random instruction side effection will not throw to low 256M region in every 1G.
#endif
		if(bigpci>4)bigpci=4;
		pci_mem_resource.start  = 0x10000000UL*(bigpci+3);
        pci_mem_resource.end    = 0x7fffffffUL;
	/*set cpu window3 to map CPU 1G-> PCI 1G */	
	  asm(".set mips3;dli $2,0x900000003ff00000;li $3,0x40000000;sd $3,0x18($2);or $3,1;sd $3,0x58($2);dli $3,0xffffffffc0000000;sd $3,0x38($2);.set mips0" :::"$2","$3");
	}
	return 0;
}


static int __init bigpci_setup(char *options)
{
    if (!options || !*options)
        return 0;
    if(options[0]=='0')bigpci=0;
    else bigpci=simple_strtoul(options,0,0);
		pci_mem_resource.start  = 0x10000000UL*(bigpci+3);
        pci_mem_resource.end    = 0x7fffffffUL;
    return 1;
}

__setup("bigpci=", bigpci_setup);
