#include <linux/config.h>

#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/init.h>

#define P6032INT_IRQA 20
#define P6032INT_IRQB 21
#define P6032INT_IRQC 22
#define P6032INT_IRQD 23

int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
{
	if(slot>=11 && slot<=13)
	{
	 dev->irq=(pin-1)+P6032INT_IRQA+(slot-11);
	 return dev->irq;
	}
	else if( slot == 14){	// cs5536
		switch(PCI_FUNC(dev->devfn)){
			case 2 :
				dev->irq = 14;	// for IDE
				break;
			case 3 :
				dev->irq = 9;	// for AUDIO
				break;
			case 4 :		// for OHCI
			case 5 :		// for EHCI
			case 6 :		// for UDC
			case 7 :		// for OTG
				dev->irq = 11;	
				break;			
		}
		return dev->irq;
	}
	else if(slot == 15)
	{
	dev->irq=P6032INT_IRQD;
	return dev->irq;
	}
	
	else{
		printk(" strange pci slot number.\n");
		return 0;
	}

}

