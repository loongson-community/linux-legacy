#ifdef DEBUG26_PNP_MV
// MB PnP configuration register
#include <asm/ict/ev64420.h>

#define PNP_KEY_ADDR (0x3f0)
#define PNP_DATA_ADDR (0x3f1)


void PNPSetConfig(char Index, char data);
char PNPGetConfig(char Index);

#define SUPERIO_CFG_REG 0x85

void EnterMBPnP(void)
{
	struct pci_dev *pcidev;
	char confval;
	pcidev=(void *)pci_find_slot(0,(10<<3)|0);
	pci_read_config_byte(pcidev,SUPERIO_CFG_REG,(void *)&confval);
	pci_write_config_byte(pcidev,SUPERIO_CFG_REG,confval|2);
}

void ExitMBPnP(void)
{
	struct pci_dev *pcidev;
	char confval;
	pcidev=(void *)pci_find_slot(0,(10<<3)|0);

	pci_read_config_byte(pcidev,SUPERIO_CFG_REG,(void *)&confval);
	pci_write_config_byte(pcidev,SUPERIO_CFG_REG,confval&~2);
}

void PNPSetConfig(char Index, char data)
{
        EnterMBPnP();                                // Enter IT8712 MB PnP mode
        outb(Index,PNP_KEY_ADDR);
        outb(data,PNP_DATA_ADDR);
        ExitMBPnP();
}

char PNPGetConfig(char Index)
{
        char rtn;

        EnterMBPnP();                                // Enter IT8712 MB PnP mode
        outb(Index,PNP_KEY_ADDR);
        rtn = inb(PNP_DATA_ADDR);
        ExitMBPnP();
        return rtn;
}


static int PnpRead(int argc,char **argv)
{
	unsigned char Index,data;
		if(argc!=2){return -1;}
		
		Index=nr_strtol(argv[1],0,0);
data=PNPGetConfig(Index);
nr_printf("pnpread index=0x%02x,value=0x%02x\n",Index,data);
return 0;
}

static int PnpWrite(int argc,char **argv)
{
        unsigned char Index,data;
        if(argc!=3){nr_printf("pnpw Index data\n");return -1;}
		Index=nr_strtol(argv[1],0,0);
		data=nr_strtol(argv[2],0,0);
PNPSetConfig(Index,data);
nr_printf("pnpwrite index=0x%02x,value=0x%02x,",Index,data);
data=PNPGetConfig(Index);
nr_printf("result=0x%02x\n",data);
return 0;
}




mycmd_init(pnpr,PnpRead,"LDN index","pnpr LDN(logic device NO) index");
mycmd_init(pnpw,PnpWrite,"LDN index value","pnpw LDN(logic device NO) index value");
#endif
