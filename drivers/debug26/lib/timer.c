#ifdef DEBUG26_TIMER
static struct timer_list int_timer;
static int running=0;
static int stop=0;

#define LENGTH 0x100
#define CFG 0x80
static struct addrstruc{
struct pci_dev *pcidev;
unsigned int addr;
char type;
};

static struct addrstruc addrs[LENGTH];

int addaddrs(int i,int bus,int dev,int func,int addr,int type)
{
struct pci_dev *pcidev;
if(type&CFG){
pcidev=pci_find_slot(bus,(dev<<3)|func);
if(!pcidev){nr_printf("can not find slot bus %d,dev %d,func %d\n",bus,dev,func);return -1;}
addrs[i].pcidev=pcidev;
}

addrs[i].addr=addr;
addrs[i].type=type;
return 0;
}

void printaddrs()
{
int i;
struct pci_dev *pcidev;
int data;
for(i=0;i<LENGTH;i++)
{
int bus,dev,func,addr,type;
addr=addrs[i].addr;
type=addrs[i].type;
if(!type)continue;
if(type&CFG){
	pcidev=addrs[i].pcidev;
	bus=pcidev->bus->number;
	dev=((pcidev->devfn)>>3);
	func=(pcidev->devfn)&7;
	data=0;
    switch(addrs[i].type&3)
	{
	case 1:pci_read_config_byte(pcidev,addr,&data);break;
	case 2:pci_read_config_word(pcidev,addr,&data);break;
	case 4:pci_read_config_dword(pcidev,addr,&data);break;
		}
	nr_fprintf(2,"bus %x,dev %x,func %x,reg %x = %x\n",bus,dev,func,addr,data);
}
else
{
	switch(type&3)
	{
	 case 1:data=*(volatile char *)addr;break;
	 case 2:data=*(volatile short *)addr;break;
	 case 4:data=*(volatile long *)addr;break;
	}
	nr_fprintf(2,"reg %x = %x\n",addr,data);
}

}

}

static void int_timer_do (unsigned long time)
{int i;
	printaddrs();
    init_int_timer (time);
}

static void init_int_timer(int time)
{
    init_timer (&int_timer);
    int_timer.function = (void *)int_timer_do;
    int_timer.data = time;
   if(!stop) {mod_timer(&int_timer,jiffies +time );}
   else {running=0;}
}


#define  harshel(x) ((x>>2)&0xff)
static int add(int argc,char **argv)
{
unsigned int i,addr,bus,dev,func;
char got;
int type=0;

if(argc==5){
type=CFG;
bus=nr_strtol(argv[1],0,0);
dev=nr_strtol(argv[2],0,0);
func=nr_strtol(argv[3],0,0);
addr=nr_strtol(argv[4],0,0);
}
else if(argc==2)
{
addr=nr_strtol(argv[1],0,0);
}
else return -1;
type=(argv[0][0]-'0')|type;


got=0;
for(i=harshel(addr);i<LENGTH;i++)
{
	if(!addrs[i].type){got=1;break;}
}

if(i==LENGTH)
{
	for(i=0;i<harshel(addr);i++)
	{
		    if(!addrs[i].type){got=1;break;}
	}
}
if(got)addaddrs(i,bus,dev,func,addr,type);
else printf("addrs table full\n");
return got?0:-1;
}

static int match(int i,int bus,int dev,int func,int addr,char type)
{
struct pci_dev *pcidev;
	if(type&CFG){
     pcidev=pci_find_slot(bus,(dev<<3)|func);
	 if(!pcidev)goto err;
	 if(pcidev!=addrs[i].pcidev)goto err;
	}
	 if(addr!=addrs[i].addr)goto err;
	 return 0;
err:
	 return -1;
}

static int del(int argc,char **argv)
{
unsigned int i,addr,bus,dev,func;
char got;
int type=0;

if(argc==5){
type=CFG;
bus=nr_strtol(argv[1],0,0);
dev=nr_strtol(argv[2],0,0);
func=nr_strtol(argv[3],0,0);
addr=nr_strtol(argv[4],0,0);
}
else if(argc==2)
{
addr=nr_strtol(argv[1],0,0);
}
else return -1;

got=0;
addr=nr_strtol(argv[1],0,0);
for(i=harshel(addr);i<LENGTH;i++)
{
	if(!match(i,bus,dev,func,addr,type)){got=1;break;}
}

if(i==LENGTH)
{
	for(i=0;i<harshel(addr);i++)
	{
	 if(!match(i,bus,dev,func,addr,type)){got=1;break;}
	}
}
if(got)addrs[i].type=0;
else printf("not find\n");
return got?0:-1;
}

static int listaddrs(int argc,char **argv)
{
int i;
char type;
struct pci_dev *pcidev;
int bus,dev,func;

    for(i=0;i<LENGTH;i++)
    {
		type=addrs[i].type;
        if(!type)continue;
		
		if(type&CFG){
		pcidev=addrs[i].pcidev;
		bus=pcidev->bus->number;
		dev=((pcidev->devfn)>>3);
		func=(pcidev->devfn)&7;
		pcidev=pci_find_slot(bus,(dev<<3)|func);
		nr_printf("bus %d,dev %d,func %d,reg %d\n",bus,dev,func,addrs[i].addr);
		}
		else nr_printf("addr %x\n",addrs[i].addr);
    }
}

static int trun(int argc,char **argv)
{
	int time1;
	if(argc!=2)return -1;
	time1=nr_strtol(argv[1],0,0);
	
    if(!time1){stop=1;}
	else {stop=0;
		if(!running)  
		{
			init_int_timer(time1);
		}
	}
	return 0;
}

static int mytimer_init()
{
memset(addrs,0,sizeof(addrs));
running=0;
stop=0;
return 0;
}

myinit_begin(mytimer_init);
mycmd_init(tadd1,add,"[bus dev func addr | addr]","add addr");
mycmd_init(tadd2,add,"[bus dev func addr | addr]","add addr");
mycmd_init(tadd4,add,"[bus dev func addr | addr]","add addr");
mycmd_init(tdel,del,"[bus dev func addr | addr]","del addr");
mycmd_init(trun,trun,"[0 | n10ms]","start/stop timer");
mycmd_init(tlist,listaddrs,"[0 | n10ms]","start/stop timer");
#endif

