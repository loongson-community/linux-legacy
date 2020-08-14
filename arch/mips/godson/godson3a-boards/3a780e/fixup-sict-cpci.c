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
if(dev->bus->number==0)
{

	if(slot==8||slot==13)
	 return dev->irq=(pin-1)+P6032INT_IRQA;
    else if(slot==9||slot==11)
	 return dev->irq=((pin-1+2)&3)+P6032INT_IRQA;
    else if(slot==10||slot==12)
	 return dev->irq=((pin-1+3)&3)+P6032INT_IRQA;
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
	else{
		printk(" strange pci slot number.\n");
		return 0;
	}
}
else 
	{
	switch(slot)
	{
		case 15:
	 		return (dev->irq=((pin-1 + 3)&3)+P6032INT_IRQA);
		case 14:
	 		return (dev->irq=((pin-1 + 2)&3)+P6032INT_IRQA);
		case 13:
	 		return (dev->irq=((pin-1 + 1)&3)+P6032INT_IRQA);
		case 12:
			return (dev->irq=((pin-1 + 1)&3)+P6032INT_IRQA);
		default:
	 		return (dev->irq=((pin-1)&3)+P6032INT_IRQA);
	}
	}

}

