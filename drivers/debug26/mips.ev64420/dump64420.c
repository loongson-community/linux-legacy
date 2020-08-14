#include <asm/ict/gt64420.h>
#ifdef DEBUG26_DUMPMV
char PNPGetConfig(char Index);
int dumpmv(int argc,char **argv)
{
	unsigned int readdata;
	int func;
	unsigned int data;
	nr_printf("pci configure register\n");
	for(func=0;func<5;func++)
	{
	pcidev=(void *)pci_find_slot(0,(0<<3)|func);
	if(pcidev)
	{unsigned int reg;
	for (reg=0;reg<256;reg+=4)
	{
	pci_read_config_dword(pcidev,reg,&readdata);
	nr_printf("%01x.%02x: %08x\n",func,reg,readdata);
	}
	}
	}
	printf("io rgisters\n");
	{unsigned int i,data;
	for(i=0;i<0x10000;i=i+4)
	{
	GT_READ(i,&data);
	printf("%04x: %08x\n",i,data);
	}
	}
	
}

mycmd_init(dumpmv,dumpmv,"","dump ev64420");
#endif

