#include <linux/config.h>

#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/init.h>

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
