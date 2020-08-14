#ifdef DEBUG26_DM642
static struct dm642_struc
{
unsigned int base0;
unsigned int base1;
unsigned int base2;
int slot;
unsigned long pbase0;
unsigned long pbase1;
} dm642;

#define DM642_DSPP 8
#define DM642_DSPP_PAGE_SHIFT 22
static void myinit();
static int Dm642_Init()
{
struct pci_dev *dev=pci_find_device(0x104c,0x9065,0);
if(dev)
{
dm642.slot=PCI_SLOT(dev->devfn);
pci_read_config_dword(dev,0x10,&dm642.base0);
pci_read_config_dword(dev,0x14,&dm642.base1);
pci_read_config_dword(dev,0x18,&dm642.base2);
dm642.base0&=~0xf;
dm642.base1&=~0xf;
dm642.base2&=~0x3;
}
else dm642.slot=0;
printk("<0>dm642.slot=0x%x\ndm642.base0=0x%x,base2=0x5x\n",dm642.slot,dm642.base0,dm642.base2);
myinit();
return 0;
}

static int dm642_read(int type,unsigned long long addr,union commondata *mydata)
{
union {
long long ll;
int l[2];
} a;


*(volatile int *)(dm642.base2+DM642_DSPP+0xffffffffbfd00000ULL)=addr>>DM642_DSPP_PAGE_SHIFT;
a.ll=0x9000000000000000ULL+dm642.base0+(addr&((1<<DM642_DSPP_PAGE_SHIFT)-1));


asm(".set mips3;");

switch(type)
{
case 1:
	  //mydata->data1=*(volatile char *)addr;break;
	  asm("dsll32 %2,%2,0;or %1,%2;lbu $2,(%1);" \
		  "sb $2,(%0);" \
		  ::"r"(&mydata->data1),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
case 2:
	  //mydata->data2=*(volatile short *)addr;break;
	  asm("dsll32 %2,%2,0;or %1,%2;lhu $2,(%1);" \
		  "sh $2,(%0);" \
		  ::"r"(&mydata->data2),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
case 4:
	  //mydata->data4=*(volatile int *)addr;break;
	  asm("dsll32 %2,%2,0;or %1,%2;lwu $2,(%1);" \
		   "sw $2,(%0);" \
		  ::"r"(&mydata->data4),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
case 8:
	  // mydata->data8[0]=*(volatile int *)addr;mydata->data8[1]=*(volatile int *)(addr+4);
	  //*(long long *)mydata->data8=*(volatile long long *)addr;
	  asm("dsll32 %2,%2,0;or %1,%2;ld $2,(%1);" \
		  "sd $2,(%0);" \
		  ::"r"(mydata->data8),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
}
asm(".set mips0;");

return 0;
}

static int dm642_write(int type,unsigned long long addr,union commondata *mydata)
{
union {
long long ll;
int l[2];
} a;

*(volatile int *)(dm642.base2+DM642_DSPP+0xffffffffbfd00000ULL)=addr>>DM642_DSPP_PAGE_SHIFT;
a.ll=0x9000000000000000ULL+dm642.base0+(addr&((1<<DM642_DSPP_PAGE_SHIFT)-1));

asm(".set mips3;");
switch(type)
{
case 1:
	 //*(volatile char *)addr=mydata->data1;break;
	  asm("dsll32 %2,%2,0;or %1,%2;lbu $2,(%0);" \
		  "sb $2,(%1);" \
		  ::"r"(&mydata->data1),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
case 2:
	   //*(volatile short *)addr=mydata->data2;break;
	  asm("dsll32 %2,%2,0;or %1,%2;lhu $2,(%0);" \
		   "sh $2,(%1);" \
		  ::"r"(&mydata->data2),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	  break;
case 4:
	  //*(volatile int *)addr=mydata->data4;break;
	  asm("dsll32 %2,%2,0;or %1,%2;lwu $2,(%0);" \
		  "sw $2,(%1);" \
		  ::"r"(&mydata->data4),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	    break;
case 8:
	  asm("dsll32 %2,%2,0;or %1,%2;ld $2,(%0);" \
		   "sd $2,(%1);" \
		  ::"r"(mydata->data8),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   //*(volatile int *)addr=mydata->data8[0];*(volatile int *)(addr+4)=mydata->data8[1];
	   //*(volatile long long *)addr=*(volatile long long *)mydata->data8;
	   break;
}
asm(".set mips0;");

return 0;
}
static int dm642s(int argc,char **argv)
{
    	syscall1=dm642_read;
    	syscall2=dm642_write;
		return 0;
}

myinit_begin(Dm642_Init);
mycmd_init(dm642s,dm642s,"","select dm642 mod");

/*----------------------------------------------------------------------------*/

typedef unsigned char    Uint8;
typedef unsigned short   Uint16;
typedef unsigned int     Uint32;
typedef unsigned long    Uint40;
typedef char             Int8;
typedef short            Int16;
typedef int              Int32;
typedef long             Int40;

  typedef struct {
   Uint32 gpgc;
   Uint32 gpen;
   Uint32 gpdir;
   Uint32 gpval;
   Uint32 gphm;
   Uint32 gplm;   
   Uint32 gppol;
  } GPIO_Config;

/* device handle object */
typedef struct {
  Uint32 allocated;
  volatile Uint32 *baseAddr;
  Uint32 pinAllocMask;
} GPIO_Obj, *GPIO_Handle;

typedef struct {
  Uint32 allocated;
  Uint32 eventId;
  volatile Uint32 *baseAddr;
  Uint32 i2cdrrAddr;
  Uint32 i2cdxrAddr;
} I2C_Obj, *I2C_Handle;

/* device configuration structure */
typedef struct {
	Uint32 i2coar;
	Uint32 i2cimr;
	Uint32 i2cclkl;
	Uint32 i2cclkh;
	Uint32 i2ccnt;
	Uint32 i2csar;
	Uint32 i2cmdr;
	Uint32 i2cpsc;
} I2C_Config;

static unsigned long dspaddr(unsigned int addr)
{
if((addr>=0x01800000)&&(addr<0x02000000))
 return  dm642.pbase1+(addr-0x01800000);
else
{
*(volatile int *)(dm642.base2+DM642_DSPP+0xffffffffbfd00000ULL)=addr>>DM642_DSPP_PAGE_SHIFT;
return dm642.pbase0+(addr&((1<<DM642_DSPP_PAGE_SHIFT)-1));
}
}

/* Read an 8-bit value from a CPLD register */
static Uint8 EVMDM642_rget(Int16 regnum)
{
    Uint8 *pdata;
    
    /* Return lower 8 bits of register */
    pdata = (Uint8 *)dspaddr(0x90080000 + regnum);
    return (*pdata & 0xff);
}

static void EVMDM642_rset(Int16 regnum, Uint8 regval)
{
    Uint8 *pdata;
    
    /* Write lower 8 bits of register */
    pdata = (Uint8 *)dspaddr(0x90080000 + regnum);
    *pdata = (regval & 0xff);
}

static Uint32 GPIO_pinRead(GPIO_Handle hGpio,Uint32 pinId) {
volatile Uint32 x = 0xFFFFFFFF;

      if ( ((*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[2])))) & (pinId & hGpio->pinAllocMask))!= 0 ) { 
           x = 1;
      } else {
           x = 0;
        }
  
 return ( x );
}

static void GPIO_pinEnable(GPIO_Handle hGpio,Uint32 pinId) {
  volatile Uint32 gpen = (*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[0]))));
  gpen = gpen | (pinId & hGpio->pinAllocMask);
  (*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[0]))))=((Uint32)((Uint32)( (((Uint32)((*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[0])))))&~0x0000FFFFu)| (((Uint32)(gpen)<<0x00000000u) &0x0000FFFFu)) )));
}

static Uint32 GPIO_pinDirection(GPIO_Handle hGpio,Uint32 pinId, Uint32 direction) {
  volatile Uint32 gpdir = (*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[1]))));
  if ( direction == 0) {
       (*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[1]))))=((Uint32)((gpdir & (~pinId & hGpio->pinAllocMask))));
  } else {
       (*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[1]))))=((Uint32)((gpdir | (pinId & hGpio->pinAllocMask))));
    }
  return ( (*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[1])))));

}

static void GPIO_pinWrite(GPIO_Handle hGpio,Uint32 pinId, Uint32 val) {
   volatile Uint32 gpval = (*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[2]))));
 if ( val == 0) {
     (*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[2]))))=((Uint32)((gpval & (~pinId & hGpio->pinAllocMask))));
  } else {
     (*(volatile Uint32*)dspaddr((Uint32)(&((hGpio)->baseAddr[2]))))=((Uint32)((gpval | (pinId & hGpio->pinAllocMask))));
  }
}

/* Spin in a delay loop for delay iterations */
static void EVMDM642_wait(Uint32 delay)
{
    volatile Uint32 i, n;
    
    n = 0;
    for (i = 0; i < delay; i++)
    {
        n = n + 1;
    }
}

/* Spin in a delay loop for delay microseconds */
static void EVMDM642_waitusec(Uint32 delay)
{
    EVMDM642_wait(delay * 21);
}
static void fpgawrite(GPIO_Handle hGPIO, Uint16 data)
{
    Uint32 i;
    
    for (i = 0; i < 8; i++)
    {
        /* Clock low */
        GPIO_pinWrite(hGPIO, 0x00000002u, 0);
        
        /* Output data */
        GPIO_pinWrite(hGPIO, 0x00000004u, (data >> 7) & 1);
    //    asm(" nop 9");
        
        /* Clock high */
        GPIO_pinWrite(hGPIO, 0x00000002u, 1);
    //    asm(" nop 3");
        
        /* Set up for next bit */
        data = data << 1;
    }
}
 
/* I2C handle */
static I2C_Handle EVMDM642_I2C_hI2C;

/* GPIO handle */
static GPIO_Handle EVMDM642_GPIO_hGPIO;

static I2C_Obj i2c0;
static GPIO_Obj gpio0;


static void EVMDM642_fpgaLoad(Uint32 fpgaaddr)
{
    Uint8 *pdata;
    Uint32 i, j;
    
    /* Set internal pin mux to GPIOs */
    GPIO_pinEnable(EVMDM642_GPIO_hGPIO, 0x00000002u | 0x00000004u);
    
    /* Set direction - CCLK, PROG and DIN output, INIT input */
    GPIO_pinDirection(EVMDM642_GPIO_hGPIO, 0x00000002u | 0x00000001u | 0x00000004u, 1);
    GPIO_pinDirection(EVMDM642_GPIO_hGPIO, 0x00000040u, 0);
    
    /* Set PROG low, CCLK high */
    GPIO_pinWrite(EVMDM642_GPIO_hGPIO, 0x00000002u, 1);
    GPIO_pinWrite(EVMDM642_GPIO_hGPIO, 0x00000001u, 0);

    /* Wait for INIT to go low */
    while (GPIO_pinRead(EVMDM642_GPIO_hGPIO, 0x00000040u) == 1);

    /* Short delay then drive PROG high */
    for (i = 0; i < 1000; i++);
    GPIO_pinWrite(EVMDM642_GPIO_hGPIO, 0x00000001u, 1);
    
    /* Wait for INIT to go high */
    while (GPIO_pinRead(EVMDM642_GPIO_hGPIO, 0x00000040u) == 0);

    /* Write data */
    pdata = (Uint8 *)fpgaaddr;
    for (i = 0; i < 0x393d8; i++)
    {
        fpgawrite(EVMDM642_GPIO_hGPIO, *(Uint8 *)dspaddr(pdata));
		pdata++;
    }

    /* Clock the FPGA to finish the initialization */
    for (i = 0; i < 8; i++)
    {
        /* Clock low */
        GPIO_pinWrite(EVMDM642_GPIO_hGPIO, 0x00000002u, 0);
        for (j = 0; j < 100; j++);
        
        /* Clock high */
        GPIO_pinWrite(EVMDM642_GPIO_hGPIO, 0x00000002u, 1);
        for (j = 0; j < 100; j++);
    }
    
    /* Toggle FPGA soft reset */
    EVMDM642_rset(0x10, EVMDM642_rget(0x10) | 0x01);
    for (i = 0; i < 1000; i++);
    EVMDM642_rset(0x10, EVMDM642_rget(0x10) & ~0x01);
}



typedef struct {
  Uint32 gblctl;
  Uint32 cectl0;
  Uint32 cectl1;
  Uint32 cectl2;
  Uint32 cectl3;
  Uint32 sdctl;
  Uint32 sdtim;
  Uint32 sdext;
  Uint32 cesec0;
  Uint32 cesec1;
  Uint32 cesec2;
  Uint32 cesec3;
} EMIFA_Config;

static void EMIFA_config(EMIFA_Config *config) {

  Uint32 gie;
  volatile Uint32 *base = (volatile Uint32 *)dspaddr(0x01800000u);
  int x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11;


  /* the compiler generates more efficient code if the loads */
  /* and stores are grouped together raher than intermixed   */
  x0  = config->gblctl;
  x1  = config->cectl0;
  x2  = config->cectl1;
  x3  = config->cectl2;
  x4  = config->cectl3;
  x5  = config->sdctl;
  x6  = config->sdtim;
  x7  = config->sdext;
  x8  = config->cesec0;
  x9  = config->cesec1;
  x10 = config->cesec2;
  x11 = config->cesec3;

  base[0]  = x0;
  base[2]  = x1;
  base[1]  = x2;
  base[4]  = x3;
  base[5]  = x4;
  
  base[7]   = x6;
  base[8]   = x7;
  base[18]  = x8;
  base[17]  = x9;
  base[20]  = x10;
  base[21]  = x11;

  base[6]   = x5;

}


static void I2C_config(I2C_Handle hI2c, I2C_Config *config) {

  Uint32 gie;
  volatile Uint32 *base = (volatile Uint32 *)dspaddr(hI2c->baseAddr);
  register int x0,x1,x2,x3,x4,x5,x6,x7;

//  gie = IRQ_globalDisable();

  /* the compiler generates more efficient code if the loads */
  /* and stores are grouped together rather than intermixed  */
  x0 = config->i2coar;
  x1 = config->i2cimr;
  x2 = config->i2cclkl;
  x3 = config->i2cclkh;
  x4 = config->i2ccnt;
  x5 = config->i2csar;
  x6 = config->i2cpsc;
  x7 = config->i2cmdr;

  base[0]  = x0;
  base[1]  = x1;
  base[3] = x2;
  base[4] = x3;
  base[5]  = x4;
  base[7]  = x5;
  base[12]  = x6;
  base[9]  = x7;

//  IRQ_globalRestore(gie);
}

static void I2C_outOfReset(I2C_Handle hI2c){
	(*(volatile Uint32*)dspaddr((Uint32)(&((hI2c)->baseAddr[9]))))=((Uint32)((Uint32)( (((Uint32)((*(volatile Uint32*)dspaddr((Uint32)(&((hI2c)->baseAddr[9])))))&~0x00000020u)| (((Uint32)(0x00000001u)<<0x00000005u) &0x00000020u)) )));
}

void EVMDM642_APLL_rset(Uint16 data)
{
    /* Write data to the APLL */
    *((volatile Uint32 *)dspaddr(0xb0000000 + 4)) = data;

    /* Wait for transmission to complete */
    while ((EVMDM642_rget(0x13) & 0x20) == 0);
}

/* Initialize the board APIs */
static void EVMDM642_init()
{
    volatile Uint32 test;
    
    EMIFA_Config emifaCfg0 = {
        ( (0x00000001u<<0x00000012u) &0x000C0000u )    |
        ( (0x00000000u<<0x00000011u) &0x00020000u )          |
        ( (0x00000001u<<0x00000010u) &0x00010000u )       |
        ( (0x00000001u<<0x0000000Du) &0x00002000u )    |
        ( (0x00000000u<<0x00000007u) &0x00000080u )     |
        ( (0x00000001u<<0x00000006u) &0x00000040u )        |
        ( (0x00000001u<<0x00000005u) &0x00000020u )       |
        ( (0x00000001u<<0x00000004u) &0x00000010u )      |
        ( (0x00000001u<<0x00000003u) &0x00000008u ),
        ( (0x0000000Fu<<0x0000001Cu) &0xF0000000u )    |
        ( (0x0000003Fu<<0x00000016u) &0x0FC00000u )     |
        ( (0x00000003u<<0x00000014u) &0x00300000u )      |
        ( (0x0000000Fu<<0x00000010u) &0x000F0000u )    |
        ( (0x00000003u<<0x0000000Eu) &0x0000C000u )         |
        ( (0x0000003Fu<<0x00000008u) &0x00003F00u )     |
        ( (0x0000000Du<<0x00000004u) &0x000000F0u )      |
        ( (0x00000003u<<0x00000000u) &0x00000007u ),
        
        ( (((Uint32)(7))<<0x0000001Cu) &0xF0000000u )      |
        ( (((Uint32)(14))<<0x00000016u) &0x0FC00000u )      |
        ( (((Uint32)(2))<<0x00000014u) &0x00300000u )        |
        ( (((Uint32)(2))<<0x00000010u) &0x000F0000u )      |
        ( (((Uint32)(2))<<0x0000000Eu) &0x0000C000u )           |
        ( (((Uint32)(14))<<0x00000008u) &0x00003F00u )      |
        ( (0x00000000u<<0x00000004u) &0x000000F0u )       |
        ( (((Uint32)(1))<<0x00000000u) &0x00000007u ),
        
        ( (((Uint32)(2))<<0x0000001Cu) &0xF0000000u )      |
        ( (((Uint32)(10))<<0x00000016u) &0x0FC00000u )      |
        ( (((Uint32)(2))<<0x00000014u) &0x00300000u )        |
        ( (((Uint32)(2))<<0x00000010u) &0x000F0000u )      |
        ( (((Uint32)(2))<<0x0000000Eu) &0x0000C000u )           |
        ( (((Uint32)(10))<<0x00000008u) &0x00003F00u )      |
        ( (0x00000002u<<0x00000004u) &0x000000F0u )      |
        ( (((Uint32)(2))<<0x00000000u) &0x00000007u ),

        ( (((Uint32)(2))<<0x0000001Cu) &0xF0000000u )      |
        ( (((Uint32)(10))<<0x00000016u) &0x0FC00000u )      |
        ( (((Uint32)(2))<<0x00000014u) &0x00300000u )        |
        ( (((Uint32)(2))<<0x00000010u) &0x000F0000u )      |
        ( (((Uint32)(2))<<0x0000000Eu) &0x0000C000u )           |
        ( (((Uint32)(10))<<0x00000008u) &0x00003F00u )      |
        ( (0x00000004u<<0x00000004u) &0x000000F0u )       |
        ( (((Uint32)(2))<<0x00000000u) &0x00000007u ),
        
        ( (0x00000001u<<0x0000001Eu) &0x40000000u )       |
        ( (0x00000001u<<0x0000001Cu) &0x30000000u )        |
        ( (0x00000001u<<0x0000001Au) &0x0C000000u )         |
        ( (0x00000001u<<0x00000019u) &0x02000000u )        |
        ( (0x00000001u<<0x00000018u) &0x01000000u )           |
        ( (((Uint32)(1))<<0x00000014u) &0x00F00000u )         |
        ( (((Uint32)(1))<<0x00000010u) &0x000F0000u )          |
        ( (((Uint32)(5))<<0x0000000Cu) &0x0000F000u )          |
        ( (0x00000000u<<0x00000000u) &0x00000001u ),
        
        ( (((Uint32)(0))<<0x00000018u) &0x03000000u )         |
        ( (((Uint32)(2075))<<0x00000000u) &0x00000FFFu ),
        
        ( (((Uint32)(1))<<0x00000014u) &0x00100000u )        |
        ( (((Uint32)(3))<<0x00000012u) &0x000C0000u )      |
        ( (((Uint32)(1))<<0x00000011u) &0x00020000u )        |
        ( (((Uint32)(3))<<0x0000000Fu) &0x00018000u )       |
        ( (((Uint32)(2))<<0x0000000Cu) &0x00007000u )        |
        ( (((Uint32)(3))<<0x0000000Au) &0x00000C00u )      |
        ( (((Uint32)(1))<<0x00000009u) &0x00000200u )        |
        ( (((Uint32)(2))<<0x00000007u) &0x00000180u )         |
        ( (((Uint32)(2))<<0x00000005u) &0x00000060u )          |
        ( (((Uint32)(0))<<0x00000004u) &0x00000010u )         |
        ( (((Uint32)(6))<<0x00000001u) &0x0000000Eu )         |
        ( (((Uint32)(1))<<0x00000000u) &0x00000001u ),           
        
        (Uint32)( ((0x00000000u << 0x00000006u) & 0x00000040u) |((0x00000000u << 0x00000005u) & 0x00000020u) |((0x00000000u << 0x00000004u) & 0x00000010u) |((0x00000000u << 0x00000002u) & 0x0000000Cu) |((0x00000002u << 0x00000000u) & 0x00000003u) ),

        (Uint32)( ((0x00000000u << 0x00000006u) & 0x00000040u) |((0x00000000u << 0x00000005u) & 0x00000020u) |((0x00000000u << 0x00000004u) & 0x00000010u) |((0x00000000u << 0x00000002u) & 0x0000000Cu) |((0x00000002u << 0x00000000u) & 0x00000003u) ),

        (Uint32)( ((0x00000000u << 0x00000006u) & 0x00000040u) |((0x00000000u << 0x00000005u) & 0x00000020u) |((0x00000000u << 0x00000004u) & 0x00000010u) |((0x00000000u << 0x00000002u) & 0x0000000Cu) |((0x00000002u << 0x00000000u) & 0x00000003u) ),

        ( (0x00000001u<<0x00000006u) &0x00000040u )    |
        ( (0x00000001u<<0x00000005u) &0x00000020u )         |
        ( (0x00000001u<<0x00000004u) &0x00000010u )       |
        ( (0x00000000u<<0x00000002u) &0x0000000Cu )      |
        ( (0x00000003u<<0x00000000u) &0x00000003u )
    };

    I2C_Config i2cCfg = {
        0x0000007f, /* I2COAR -    Not used if master */
        0x00000000, /* I2CIER -    Disable interrupts, use polling */
        0x0000001b, /* I2CCLKL -   Low period for 100KHz operation */
        0x0000001b, /* I2CCLKH -   High period for 100KHz operation */
        0x00000002, /* I2CCNT -    Data words per transmission */
        0x0000001a, /* I2CSAR -    Slave address */
        0x00004680, /* I2CMDR -    Mode */
        0x00000019  /* I2CPSC -    Prescale 300MHz to 12MHz */
    };
        
    /* Initialize CSL */
//    CSL_init();
    
    /* Unlock PERCFG through PCFGLOCK */
    *((unsigned long *)dspaddr(0x1b3f018)) = 0x10c0010c;
    
    /* Enable VP0-VP2, I2C and McASP0 in PERCFG */
    *((unsigned long *)dspaddr(0x1b3f000)) = 0x79;
    
    /* Read back PERCFG */
    test = *((unsigned long *)dspaddr(0x1b3f000));
    
    /* Wait at least 128 CPU cycles */
    EVMDM642_wait(128);

    /* Initialize EMIFA */
    EMIFA_config(&emifaCfg0);

    /* Open I2C handle */
//    EVMDM642_I2C_hI2C = I2C_open((0), (0x00000001));

    /* Configure I2C controller */
    I2C_config(EVMDM642_I2C_hI2C, &i2cCfg);

    /* Take I2C out of reset */        
    I2C_outOfReset(EVMDM642_I2C_hI2C);
    
    /* Open the GPIO handle */
//    EVMDM642_GPIO_hGPIO = GPIO_open(0, 1);

    /* Enable caching of SDRAM */
//    CACHE_enableCaching(0x01848200u);
//    CACHE_enableCaching(0x01848204u);
    
    /* Load the FPGA from Flash */
    EVMDM642_fpgaLoad(0x90040000);

    /* Configure APLL in default state */
    EVMDM642_APLL_rset(0x73F0);
}

static void myinit()
{
dm642.pbase0=ioremap(dm642.base0,(1<<DM642_DSPP_PAGE_SHIFT));
dm642.pbase1=ioremap(dm642.base1,0x800000);
prom_printf("base0=%lx,pbase0=%lx\n",dm642.base0,dm642.pbase0);
memset(&i2c0,0,sizeof(i2c0));
memset(&gpio0,0,sizeof(gpio0));
i2c0.baseAddr=0x01b40000;
gpio0.baseAddr=0x01b00000;
gpio0.pinAllocMask=-1;

EVMDM642_I2C_hI2C=&i2c0;
EVMDM642_GPIO_hGPIO=&gpio0;
}

static void myuninit()
{
iounmap(dm642.pbase0);
iounmap(dm642.pbase1);
}

int dm642init()
{
//myinit();
EVMDM642_init();
//myuninit();
return 0;
}
mycmd_init(dm642init,dm642init,"","dm642 init");

EXPORT_SYMBOL(dm642init);

static Int16 ledstate;

void EVMDM642_LED_init()
{
    /* Turn all LEDs off */
    ledstate = 0xff;
    EVMDM642_rset(0x17, ledstate);
}

void EVMDM642_LED_off(Uint32 ledNum)
{
    /* Check bounds for ledNum */
    if (ledNum >= 8)
        return;
       
    /* Clear the LED bit */
    ledstate |= 1 << ledNum;
    EVMDM642_rset(0x17, ledstate);
}

void EVMDM642_LED_on(Uint32 ledNum)
{
    /* Check bounds for ledNum */
    if (ledNum >= 8)
        return;
        
    /* Set the LED bit */
    ledstate &= ~(1 << ledNum);
    EVMDM642_rset(0x17, ledstate);
}

void EVMDM642_LED_toggle(Uint32 ledNum)
{
    /* Check bounds for ledNum */
    if (ledNum >= 8)
        return;
        
    /* Toggle the LED bit */
    if ((EVMDM642_rget(0x17) & (1 << ledNum)) != 0)
        EVMDM642_LED_on(ledNum);
    else
        EVMDM642_LED_off(ledNum);
}

int dm642led(int argc,char **argv)
{
if(argc!=2)return -1;
EVMDM642_rset(0x17,nr_strtol(argv[1],0,0));
return 0;
}

mycmd_init(dm642led,dm642led,"","dm642 led");
#endif
