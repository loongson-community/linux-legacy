#include <linux/config.h>

#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/init.h>


int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
{
	return 0;

}

