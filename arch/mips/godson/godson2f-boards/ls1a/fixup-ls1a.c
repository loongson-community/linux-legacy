#include <linux/config.h>

#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <asm/mach-ls2f1a/irq.h>
#include "ls1a_pci.h"
#define P6032INT_IRQA (BONITO_IRQ+4)
#define P6032INT_IRQB (P6032INT_IRQA+1)
#define P6032INT_IRQC (P6032INT_IRQA+2)
#define P6032INT_IRQD (P6032INT_IRQA+3)


#define LS1X_BOARD_EHCI_IRQ	32
#define LS1X_BOARD_OHCI_IRQ	33
#define LS1X_BOARD_GMAC1_IRQ	34
#define LS1X_BOARD_GMAC2_IRQ	35
#define LS1X_BOARD_SATA_IRQ	36

int __init
pcibios_map_irq (struct pci_dev *dev, u8 slot, u8 pin)
{
	int irq;
	switch (slot)
	{
		case  9:
			switch(PCI_FUNC(dev->devfn))
			{
				case LS1A_OHCI_FUNC:
					irq = LS1X_BOARD_OHCI_IRQ;
					break;
				case LS1A_EHCI_FUNC:
					irq = LS1X_BOARD_EHCI_IRQ;
					break;
				case LS1A_AHCI_FUNC:
					irq = LS1X_BOARD_SATA_IRQ;
					break;
				default:
					irq = dev->irq;
					break;
			}
			break;
		case 11:
			irq = P6032INT_IRQA + ( (pin - 1) & 3);
			break;

		case 13:
			irq = P6032INT_IRQA +  1; 
			break;
		case 17:
			irq = P6032INT_IRQA +  3; 
			break;

		default:
			if (slot >= 14 && slot <= 16)
				irq = P6032INT_IRQA + (((slot - 14) + (pin - 1)) & 3);
			else
				irq = 0;
			break;
	}

	(void) pci_write_config_byte (dev, PCI_INTERRUPT_LINE, irq);
	dev->irq = irq;
	return irq;
}
