#include <linux/pci.h>
#ifndef pci_for_each_dev
#define pci_for_each_dev for_each_pci_dev
#endif
int pcibus(int argc,char **argv)
{
struct pci_bus *bus;
struct pci_dev *dev=0;
pci_for_each_dev(dev) {

	if((bus=dev->subordinate))
	{
		nr_printf("bus %d at bus %d  dev %d  func %d\n",bus->number,dev->bus->number,dev->devfn>>3,dev->devfn&7);
	}
                }
return 0;
}

static int pcisave(int argc,char **argv)
{
struct pci_dev *dev=0;
unsigned int data;
int i;
nr_printf(\
"static int pciload(struct pci_ops *ops){\n" \
"struct pci_bus bus;\n" \
"struct pci_dev dev;\n" \
"bus.ops=ops;\n" \
"dev.bus=&bus;\n" 
);

pci_for_each_dev(dev) {

nr_printf(\
"//bus=%d,device=%d,func=%d\n" \
"bus.number=0x%x;\n" \
"dev.devfn=0x%x;\n" ,dev->bus->number,PCI_SLOT(dev->devfn),PCI_FUNC(dev->devfn),dev->bus->number,dev->devfn);

nr_printf("//vendor=0x%04x,device=0x%04x,class=%06x(3 bytes: base,sub,prog-if)\n",dev->vendor,dev->device,dev->class);
for(i=0xc;i<0x28;i+=4)
{
pci_read_config_dword(dev,i,&data);
nr_printf(\
"pci_write_config_dword(&dev,0x%x,0x%x);\n",i,data);
}
i=0x30;
pci_read_config_dword(dev,i,&data);
nr_printf(\
"pci_write_config_dword(&dev,0x%x,0x%x);\n",i,data);
i=0x3c;
pci_read_config_dword(dev,i,&data);
nr_printf(\
"pci_write_config_dword(&dev,0x%x,0x%x);\n",i,data);
	
                }
nr_printf(\
"\n}\n");
return 0;
}
mycmd_init(pb,pcibus,"pb","pcibus");
mycmd_init(pcisave,pcisave,"pb","pcibus");
