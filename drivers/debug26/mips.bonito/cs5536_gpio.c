#ifdef DEBUG26_CS5536_GPIO
#include "cs5536.h"
static int cs5536_gpio(int argc,char **argv)
{
	unsigned long val;
	unsigned long tag;
	unsigned long base;
	unsigned long reg;
	struct pci_dev *pcidev;
	typedef struct gpio_struc {char *s;unsigned int a;} gpio_struc;
	
	int i,j;
	gpio_struc gpio_params[]={
	{"out_val",GPIOL_OUT_VAL},
	{"out",GPIOL_OUT_EN},
	{"out_inv",GPIOL_OUT_INVRT_EN},
	{"out_od",GPIOL_OUT_OD_EN},
	{"out_aux1",GPIOL_OUT_AUX1_SEL},
	{"out_aux2",GPIOL_OUT_AUX2_SEL},
	{"pu",GPIOL_PU_EN},
	{"pd",GPIOL_PD_EN},
	{"in",GPIOL_IN_EN},
	{"in_readback",GPIOL_IN_READBACK},
	{"in_inv",GPIOL_IN_INVRT_EN},
	{"in_aux1",GPIOL_IN_AUX1_SEL},
	};

	pcidev=(void *)pci_find_slot(0,(14<<3)|0);
	base=0;
	pci_read_config_dword(pcidev,0x14,(void *)&base);
	base &= ~3;


	reg=nr_strtol(argv[1],0,0);
	nr_printf("base=%x,reg=%x\n",base,reg);
	if(reg>15){reg -= 16;base += 0x80; }
	if(argc>2)
	for(i=2;i<argc;i++)
	{

	for(j=0;j<sizeof(gpio_params)/sizeof(gpio_params[0]);j++)
	 
	 if(!strncmp(argv[i],gpio_params[j].s,strlen(gpio_params[j].s)))
	 {
	  if(*(argv[i]+strlen(gpio_params[j].s))==':')
	  {
	  int val=(nr_strtol(argv[i]+strlen(gpio_params[j].s)+1,0,0)!=0);
	  //nr_printf("%s%d,%x\n",gpio_params[j].s,val,base+gpio_params[j].a);
		
	  if(val) outl(1<<reg,base+gpio_params[j].a);
	  else outl(1<<(16+reg),base+gpio_params[j].a);
	  break;
	  }
	  else if(*(argv[i]+strlen(gpio_params[j].s))=='?')
	  {
	   nr_printf("%s=%d\n",gpio_params[j].s,(inl(base+gpio_params[j].a)>>reg)&1);
	  break;
	  }

	 }
	}
	else
	{
	for(j=0;j<sizeof(gpio_params)/sizeof(gpio_params[0]);j++)
	   nr_printf("%s=%d\n",gpio_params[j].s,(inl(base+gpio_params[j].a)>>reg)&1);
	}

	return 0;
}

mycmd_init(cs5536_gpio,cs5536_gpio,"","cs5536_gpio");
#endif
