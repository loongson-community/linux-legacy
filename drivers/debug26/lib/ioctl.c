static int read(void *src,void *dst,type)

#define CFG 0x80
#define WRITEOP 0x40
static struct addrstruc{
unsigned int addr;
void *buf;
int count;
char type;
};

int accessmem(struct addrstruc addrs *addrs,char *page)
{
int bus,devfn,reg;
struct pci_dev *pcidev;
addr=addrs.addr;
type=addrs.type;

if(type&CFG){
		bus=addr>>16;
		devfn=(addr>>8)&0xff;
		reg=addr&0xff;
		pcidev=pci_find_slot(bus,devfn);
		if(!pcidev)return -1;

    switch(addrs.type&3)
    {
    case 1:
			for(i=0;i<count;i++)
			pci_read_config_byte(pcidev,addr,((char *)page)+i);
			break;
    case 2:
			for(i=0;i<count;i++)
			pci_read_config_word(pcidev,addr,((short *)page)+i);
			break;
    case 4:
			for(i=0;i<count;i++)
			pci_read_config_dword(pcidev,addr,((long *)page)+i);
			break;
        }
}
else
{
    switch(type&3)
    {
     case 1: for(i=0;i<count;i++)((char *)page)[i]=((volatile char *)addr)[i];break;
     case 2: for(i=0;i<count;i++)((char *)page)[i]=((volatile short *)addr)[i];break;
     case 4: for(i=0;i<count;i++)((char *)page)[i]=((volatile long *)addr)[i];break;
    }

}
return 0;
}

int proc_ioctl_debug26(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
{
char *page=__get_free_page(GFP_KERNEL);
	switch(cmd&0xff)
	{

	}
if(page)free_page(page);
}

