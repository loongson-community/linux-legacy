#include <linux/pci.h>
static int __syscall1(int type,unsigned long long addr,union commondata *mydata);
static int __syscall2(int type,unsigned long long addr,union commondata *mydata);
extern int (*syscall1)(int type,unsigned long long addr,union commondata *mydata);
extern int (*syscall2)(int type,unsigned long long addr,union commondata *mydata);

static struct _mypciinfo{
	int bus;
	int device;
	int function;
} mpi;


static struct pci_dev *pcidev;
static int __pcisyscall1(int type,unsigned long long addr,union commondata *mydata)
{
int readdata=0;
switch(type)
{
case 1:pci_read_config_byte(pcidev,addr,(void *)&readdata);mydata->data1=readdata;break;
case 2:pci_read_config_word(pcidev,addr,(void *)&readdata);mydata->data2=readdata;break;
case 4:pci_read_config_dword(pcidev,addr,&readdata);mydata->data4=readdata;break;
case 8:pci_read_config_dword(pcidev,addr,&readdata);mydata->data8[0]=readdata;
	pci_read_config_dword(pcidev,addr+4,&readdata);mydata->data8[1]=readdata;break;
}
return 0;
}

static int __pcisyscall2(int type,unsigned long long addr,union commondata *mydata)
{
switch(type)
{
case 1:return pci_write_config_byte(pcidev,addr,mydata->data1);
case 2:return pci_write_config_word(pcidev,addr,mydata->data2);
case 4:return pci_write_config_dword(pcidev,addr,mydata->data4);
case 8:break;
}
return -1;
}
static char *str2addmsg[]={"64 bit cpu address","iomap address","64 bit cached phyiscal address","64 bit uncached phyiscal address"};
struct pci_dev *
pci_find_slot(unsigned int bus, unsigned int devfn);

static struct pci_bus *pci_find_bus(int busno)
{
	struct pci_bus *b = NULL;
	pci_for_each_bus(b)
	if(b->number == busno)
	 return b;
	return NULL;
}
static int PciConfSel(int argc,char **argv)
{
		struct pci_bus *bus;

		if(argc<2||argc>4){return -1;}
		if(argc>=2)mpi.bus=nr_strtol(argv[1],0,0);
		if(argc>=3)mpi.device=nr_strtol(argv[2],0,0);
		if(argc>=4)mpi.function=nr_strtol(argv[3],0,0);
		pcidev=(void *)0;
		bus = pci_find_bus(mpi.bus);
		if(bus)
		{
			static struct pci_dev dev;
			pcidev=(void *)pci_find_slot(mpi.bus,(mpi.device<<3)|mpi.function);
			nr_printf("select pci configure space bus:%d dev:%d func:%d\n",mpi.bus,mpi.device,mpi.function);
			if(!pcidev)
			{
				dev.bus=bus;
				dev.devfn=(mpi.device<<3)| mpi.function;
				pcidev = &dev;
			}
			syscall1=__pcisyscall1;
			syscall2=__pcisyscall2;
		}
		else 
		{
		nr_printf("can not find the bus\n");
		if(argc==2){
		int type=nr_strtol(argv[1],0,10);
    	syscall1=__syscall1;
    	syscall2=__syscall2;
        setenv("iomap",argv[1],0);
    	nr_printf("select normal memory(%s)\n",str2addmsg[type&3]);
		}
		}
		return 0;
}


mycmd_init(pcs,PciConfSel,"pcs bus [dev] [func]","Pci Configure sel,bus==-1 for normal memory access");
