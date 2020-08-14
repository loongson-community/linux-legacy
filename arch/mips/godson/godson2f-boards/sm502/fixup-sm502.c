#include <linux/config.h>

#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/init.h>
#define P6032INT_IRQA 20
#define P6032INT_IRQB 21
#define P6032INT_IRQC 22
#define P6032INT_IRQD 23

int __init
pcibios_map_irq (const struct pci_dev *dev, u8 slot, u8 pin)
{
  int irq;
  switch (slot)
    {
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
