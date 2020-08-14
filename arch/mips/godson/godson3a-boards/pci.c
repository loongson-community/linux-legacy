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


#define PCI_ACCESS_READ  0
#define PCI_ACCESS_WRITE 1

#define HT1LO_PCICFG_BASE      0x1a000000
#define HT1LO_PCICFG_BASE_TP1  0x1b000000

extern int pcidev_max_func_num;

static int
ls3a_pcibios_config_access(unsigned char access_type, struct pci_dev *dev,
			    unsigned char where, u32 *data)
{
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
		if (device > 31 || function > pcidev_max_func_num) {
			*data = -1;	/* device out of range */
			return PCIBIOS_DEVICE_NOT_FOUND;
		}
		addr = (device << 11) | (function << 8) | reg;
		type = 0;
		addrp = (void *)(UNCAC_BASE|(HT1LO_PCICFG_BASE | (addr & 0xffff)));
	} else {
	        /* Type 1 configuration on offboard PCI bus */
	        if (bus > 255 || device > 31 || function > pcidev_max_func_num) {
			*data = -1;	/* device out of range */
		        return PCIBIOS_DEVICE_NOT_FOUND;
		}
		addr = (bus << 16) | (device << 11) | (function << 8) | reg;
		type = 0x10000;
		addrp = (void *)(UNCAC_BASE | (HT1LO_PCICFG_BASE_TP1 | (addr)));
	}


	if (access_type == PCI_ACCESS_WRITE)
		*(volatile unsigned int *)addrp = cpu_to_le32(*data);
	else {
		*data = le32_to_cpu(*(volatile unsigned int *)addrp);
		if (*data == 0xffffffff){
			*data = -1;
			return PCIBIOS_DEVICE_NOT_FOUND;
		}
	}


	return PCIBIOS_SUCCESSFUL;
}


static int
ls3a_pcibios_read_config_byte(struct pci_dev *dev, int where, u8 *val)
{
        u32 data;
	int status;
	status = ls3a_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);
	*val = (data >> ((where & 3) << 3)) & 0xff;

	return status;
}


static int
ls3a_pcibios_read_config_word (struct pci_dev *dev, int where, u16 *val)
{
        u32 data;
	int status;

	if (where & 1)
		return PCIBIOS_BAD_REGISTER_NUMBER;

	status = ls3a_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);
	*val = (data >> ((where & 3) << 3)) & 0xffff;

	return status;
}

static int
ls3a_pcibios_read_config_dword (struct pci_dev *dev, int where, u32 *val)
{
	u32 data;
	int status;

	if (where & 3)
		return PCIBIOS_BAD_REGISTER_NUMBER;
	
	status = ls3a_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);
	*val = data;

	return status;
}


static int
ls3a_pcibios_write_config_byte (struct pci_dev *dev, int where, u8 val)
{
	u32 data;
	int status;
	status = ls3a_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);

	if (status != PCIBIOS_SUCCESSFUL)
		return status;

	data = (data & ~(0xff << ((where & 3) << 3))) |
	       (val << ((where & 3) << 3));

	status = ls3a_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &data);
	return status;
}

static int
ls3a_pcibios_write_config_word (struct pci_dev *dev, int where, u16 val)
{
        u32 data;
	int status;

	if (where & 1)
		return PCIBIOS_BAD_REGISTER_NUMBER;
       
        status = ls3a_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data);

	if (status != PCIBIOS_SUCCESSFUL)
		return status;

	data = (data & ~(0xffff << ((where & 3) << 3))) | 
	       (val << ((where & 3) << 3));

	status = ls3a_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &data);
	return status;
}

static int
ls3a_pcibios_write_config_dword(struct pci_dev *dev, int where, u32 val)
{
	if (where & 3)
		return PCIBIOS_BAD_REGISTER_NUMBER;

	return ls3a_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &val);
}

struct pci_ops ls3a_pci_ops = {
	ls3a_pcibios_read_config_byte,
	ls3a_pcibios_read_config_word,
	ls3a_pcibios_read_config_dword,
	ls3a_pcibios_write_config_byte,
	ls3a_pcibios_write_config_word,
	ls3a_pcibios_write_config_dword
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
	{&ls3a_pci_ops, &pci_io_resource, &pci_mem_resource, 0, 0},
	{(struct pci_ops *) NULL, (struct resource *) NULL,
		(struct resource *) NULL, (int) NULL, (int) NULL}
};

//--------------------------------------------------------
//

int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin);


void __init pcibios_fixup_irqs(void)
{
	struct pci_dev *pdev;
	char pin;

	pci_for_each_dev(pdev) {
	pci_read_config_byte(pdev,PCI_INTERRUPT_PIN,&pin);
	pcibios_map_irq(pdev,PCI_SLOT(pdev->devfn),pin);
	}
}



int godson_pci_resource_assigned;

//#define Bonito static char * const _bonito = (char * const )CKSEG1ADDR(BONITO_BASE)
void __init pcibios_fixup(void) 
{
	godson_pci_resource_assigned = 1;
}

#define DECLARE_PCI_FIXUP_HEADER(vendorid,deviceid,fixup_function) \
	if ((pdev->vendor == vendorid) && (pdev->device == deviceid)) fixup_function(pdev);

void __init pcibios_fixup_resources(struct pci_dev *pdev)
{
}

//------------------------------
int __init arch_pcibios_init(void)
{
extern  unsigned long pci_mem_start_addr, pci_mem_end_addr;

	pci_mem_resource.start  = pci_mem_start_addr;
        pci_mem_resource.end    = pci_mem_end_addr;
	return 0;
}

