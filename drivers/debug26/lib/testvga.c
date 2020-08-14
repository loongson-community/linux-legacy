#ifdef DEBUG26_TESTVGA
#include <asm/ict/gt64420.h>
#define VGA_BASE (PCI_MEM_SPACELOW_BASE+0xb8000)
int testvga(int argc,char **argv)
{
	volatile unsigned char *p;
	unsigned char data=0;
	int i;
	p=(char *)VGA_BASE;
while(1)
{
	memset((void *)VGA_BASE,data,80*25*2);
	for(i=0;i<80*25*2;i++)
	{
		if(p[i]!=data){prom_printf("%x != %x at %p\n",&p[i],data,p[i]);}
	}
	data=~*p;
}
return 0;
}

mycmd_init(testvga,testvga,"","test pci from vga");
#endif

