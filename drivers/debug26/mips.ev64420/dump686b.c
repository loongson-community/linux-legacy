#ifdef DEBUG26_DUMP686B
char PNPGetConfig(char Index);
int dump686b(int argc,char **argv)
{
	unsigned int readdata;
	int func;
	for(func=0;func<8;func++)
	{
	pcidev=(void *)pci_find_slot(0,(10<<3)|func);
	if(pcidev)
	{unsigned int reg;
	for (reg=0;reg<256;reg+=4)
	{
	pci_read_config_dword(pcidev,reg,&readdata);
	nr_printf("%01x.%02x: %08x\n",func,reg,readdata);
	}
	}
	}
	printf("super io registers\n");
	{unsigned int i,data;
	for(i=0;i<256;i++)
	{
		printf("%x:%x\n",i,(unsigned char)PNPGetConfig(i));
	}
	}
	printf("io rgisters\n");
	{unsigned int i,data;
	for(i=0;i<0x400;i++)
	{
	printf("%02x: %02x\n",i,inb(i));
	}
	}
	
}

mycmd_init(dump686b,dump686b,"","dump686b");
#endif

