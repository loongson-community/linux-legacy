
static union commondata{
		unsigned char data1;
		unsigned short data2;
		unsigned int data4;
		unsigned int data8[2];
		unsigned char c[8];
}mydata,*pmydata;

static int __syscall1(int type,unsigned long long addr,union commondata *mydata);
static int __syscall2(int type,unsigned long long addr,union commondata *mydata);
static int (*syscall1)(int type,unsigned long long addr,union commondata *mydata);
static int (*syscall2)(int type,unsigned long long addr,union commondata *mydata);
#ifdef CONFIG_MIPS64
#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long long)(p)))
#else
#define PTR_PAD(p) (p)
#endif

#define SEG0_BEGIN  PTR_PAD(0x80000000)
#define SEG1_END    PTR_PAD(0xc0000000)

#ifndef nr_munmap
static long myioremap(long long addr,int size)
{
long vaddr;
vaddr=ioremap(addr&PAGE_MASK,PAGE_SIZE);
if(vaddr)vaddr +=addr&(PAGE_SIZE - 1);
return vaddr;
}
static void mymunmap(long vaddr,int size)
{
iounmap(vaddr&PAGE_MASK);
}
#define nr_mmap myioremap
#define nr_munmap mymunmap
#endif

//static char *str2addmsg[]={"iomap address","64 bit cpu address","64 bit cached phyiscal address","64 bit uncached phyiscal address"};

#define syscall_addrwidth (1<<(syscall_addrtype<0?0:((syscall_addrtype>>4)&3)))
int nr_ioremap(unsigned long long phyaddr,unsigned int size,unsigned long long *vaddr)
{

if((syscall_addrtype&3)==1)
{ 
 *vaddr=(void *)nr_mmap(phyaddr,size);
 if(*vaddr!=-1)return 0;
 else return -1;
}
else if((syscall_addrtype&3)==3)*vaddr=phyaddr|0x9000000000000000ULL;
else if((syscall_addrtype&3)==2)*vaddr=phyaddr|0x9800000000000000ULL;
else *vaddr=phyaddr;

return 0;
}

int nr_iounremap(unsigned long long vaddr,unsigned int size)
{
if((syscall_addrtype&3)==1) { nr_munmap(vaddr,size);return 0;}
return 0;
}

#define MYMIPSASM asm
#define MYC(...)

static int __syscall1(int type,unsigned long long addr,union commondata *mydata)
{
union {
long long ll;
int l[2];
} a;

unsigned long long vaddr;
if(nr_ioremap(addr, type,&vaddr)<0)return -1;

a.ll=vaddr;

MYMIPSASM(".set mips3;");

switch(type)
{
case 1:
	  MYC(mydata->data1=*(volatile char *)vaddr;);
	  MYMIPSASM(".set mips3;dsll32 %2,%2,0;or %1,%2;lbu $2,(%1);" \
		  "sb $2,(%0);" \
		  ::"r"(&mydata->data1),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
case 2:
	  MYC(mydata->data2=*(volatile short *)vaddr;);
	  MYMIPSASM(".set mips3;dsll32 %2,%2,0;or %1,%2;lhu $2,(%1);" \
		  "sh $2,(%0);" \
		  ::"r"(&mydata->data2),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
case 4:
	  MYC(mydata->data4=*(volatile int *)vaddr;);
	  MYMIPSASM(".set mips3;dsll32 %2,%2,0;or %1,%2;lwu $2,(%1);" \
		   "sw $2,(%0);" \
		  ::"r"(&mydata->data4),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
case 8:
	  MYC( *(long long *)mydata->data8=*(volatile long long *)vaddr;);
	  MYMIPSASM(".set mips3;dsll32 %2,%2,0;or %1,%2;ld $2,(%1);" \
		  "sd $2,(%0);" \
		  ::"r"(mydata->data8),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
}
MYMIPSASM(".set mips0;");

nr_iounremap(vaddr,type);
return 0;
}

static int __syscall2(int type,unsigned long long addr,union commondata *mydata)
{
union {
long long ll;
int l[2];
} a;
unsigned long long vaddr;
if(nr_ioremap(addr, type,&vaddr)<0)return -1;

a.ll=vaddr;

MYMIPSASM(".set mips3;");
switch(type)
{
case 1:
	 MYC(*(volatile char *)vaddr=mydata->data1;);
	  MYMIPSASM(".set mips3;dsll32 %2,%2,0;or %1,%2;lbu $2,(%0);" \
		  "sb $2,(%1);" \
		  ::"r"(&mydata->data1),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   break;
case 2:
	  MYC(*(volatile short *)vaddr=mydata->data2;);
	  MYMIPSASM(".set mips3;dsll32 %2,%2,0;or %1,%2;lhu $2,(%0);" \
		   "sh $2,(%1);" \
		  ::"r"(&mydata->data2),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	  break;
case 4:
	  MYC(*(volatile int *)vaddr=mydata->data4;);
	  MYMIPSASM(".set mips3;dsll32 %2,%2,0;or %1,%2;lwu $2,(%0);" \
		  "sw $2,(%1);" \
		  ::"r"(&mydata->data4),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	    break;
case 8:
	  MYMIPSASM(".set mips3;dsll32 %2,%2,0;or %1,%2;ld $2,(%0);" \
		   "sd $2,(%1);" \
		  ::"r"(mydata->data8),"r"(a.l[0]),"r"(a.l[1])
		  :"$2"
		 );
	   MYC(*(volatile long long *)vaddr=*(volatile long long *)mydata->data8;);
	   break;
}
MYMIPSASM(".set mips0;");

nr_iounremap(vaddr,type);
return 0;
}



static int (*syscall1)(int type,unsigned long long addr,union commondata *mydata)=&__syscall1;
static int (*syscall2)(int type,unsigned long long addr,union commondata *mydata)=&__syscall2;

static unsigned long lastaddr=0;
static int dump(int argc,char **argv)
{
		char type=4;
static	unsigned long addr,count=1;
		int i,j,k;
		char memdata[16];
//		char opts[]="bhwd";
		if(argc>3){return -1;}

		switch(argv[0][1])
		{
				case '1':	type=1;break;
				case '2':	type=2;break;
				case '4':	type=4;break;
				case '8':	type=8;break;
		}

		if(argc>1)addr=nr_strtol(argv[1],0,0);
		else addr=lastaddr;
		if(argc>2)count=nr_strtol(argv[2],0,0);
		else if(count<=0||count>=1024) count=1;
		for(j=0;j<count;j=j+16/type,addr=addr+16/syscall_addrwidth)
		{
		nr_printf("%08lx: ",addr);

		pmydata=(void *)memdata;
		for(i=0;type*i<16;i++)
		{
		if(syscall1(type,addr+i*type/syscall_addrwidth,pmydata)<0){nr_printf("read address %p error\n",addr+i*type/syscall_addrwidth);return -1;}
		pmydata=(void *)((char *)pmydata+type);
		if(j+i+1>=count)break;
		}
		
		pmydata=(void *)memdata;
		for(i=0;type*i<16;i++)
		{
		switch(type)
		{
		case 1:	nr_printf("%02x ",pmydata->data1);break;
		case 2: nr_printf("%04x ",pmydata->data2);break;
		case 4: nr_printf("%08x ",pmydata->data4);break;
		case 8: nr_printf("%08x%08x ",pmydata->data8[1],pmydata->data8[0]);break;
		}
		if(j+i+1>=count){int k;for(i=i+1;type*i<16;i++){for(k=0;k<type;k++)nr_printf("  ");nr_printf(" ");}break;}
		pmydata=(void *)((char *)pmydata+type);
		}
		
		pmydata=(void *)memdata;
		#define CPMYDATA ((char *)pmydata)
		for(k=0;k<16;k++)
		{
		nr_printf("%c",(CPMYDATA[k]<0x20 || CPMYDATA[k]>0x7e)?'.':CPMYDATA[k]);
		if(j+(k+1)/type>=count)break;
		}
		nr_printf("\n");
		}
		lastaddr=addr+count*type;
		return 0;
}

static int getdata(char *str)
{
	static char buf[17];
	char *pstr;
	int sign=1;
	int radix=10;
	pstr=nr_strsep(&str," \t\x0a\x0d");

		if(pstr)
		{
		if(pstr[0]=='q')return -1;
		memset(buf,'0',16); buf[17]=0;
		if(pstr[0]=='-')
		{
		sign=-1;
		pstr++;
		}
		else if(pstr[0]=='+')
		{
			pstr++;
		}
		
		if(pstr[0]!='0'){radix=10;}
		else if(pstr[1]=='x'){radix=16;pstr=pstr+2;}

		memcpy(buf+16-strlen(pstr),pstr,strlen(pstr));
		pstr=buf;
		pstr[16]=pstr[8];pstr[8]=0;
		mydata.data8[1]=nr_strtol(pstr,0,radix);
		pstr[8]=pstr[16];pstr[16]=0;
		mydata.data8[0]=nr_strtol(&pstr[8],0,radix);
		if(sign==-1)
		{
		long x=mydata.data8[0];
			mydata.data8[0]=-mydata.data8[0];
			if(x<0)
			mydata.data8[1]=-mydata.data8[1];
			else mydata.data8[1]=~mydata.data8[1];
			
		}
		return 1;
		}
		return 0;

}

static int modify(int argc,char **argv)
{
		char type=4;
		unsigned long addr;
//		char opts[]="bhwd";
		char str[100];
		int i;

		if(argc<2){return -1;}

		switch(argv[0][1])
		{
				case '1':	type=1;break;
				case '2':	type=2;break;
				case '4':	type=4;break;
				case '8':	type=8;break;
		}
		addr=nr_strtol(argv[1],0,0);
		if(argc>2)
		{
		 i=2;
	          while(i<argc)
		 {
	       	   getdata(argv[i]);
		   if(syscall2(type,addr,&mydata)<0)
		   {nr_printf("write address %p error\n",addr);return -1;};
		   addr=addr+type/syscall_addrwidth;
		 i++;
		 }
		  return 0;
		}


		while(1)
		{
		if(syscall1(type,addr,&mydata)<0){nr_printf("read address %p error\n",addr);return -1;};
		nr_printf("%08lx:",addr);
		switch(type)
		{
		case 1:	nr_printf("%02x ",mydata.data1);break;
		case 2: nr_printf("%04x ",mydata.data2);break;
		case 4: nr_printf("%08x ",mydata.data4);break;
		case 8: nr_printf("%08x%08x ",mydata.data8[1],mydata.data8[0]);break;
		}
		memset(str,0,100);
		nr_gets(str,100);
	        i=getdata(str);
		if(i<0)break;	
		else if(i>0) 
		{
		if(syscall2(type,addr,&mydata)<0)
		{nr_printf("write address %p error\n",addr);return -1;};
		}
	addr=addr+type/syscall_addrwidth;
		}	
		lastaddr=addr;	
		return 0;
}
mycmd_init(d1,dump,"d1 [addr] [count]","dump memory (byte)");
mycmd_init(d2,dump,"d2 [addr] [count]","dump memory (half word)");
mycmd_init(d4,dump,"d4 [addr] [count]","dump memory (word)");
mycmd_init(d8,dump,"d8 [addr] [count]","modify memory (double word)");
mycmd_init(m1,modify,"m1 addr","modify memory (byte)");
mycmd_init(m2,modify,"m2 addr","modify memory (half word)");
mycmd_init(m4,modify,"m4 addr","modify memory (word)");
mycmd_init(m8,modify,"m8 addr","modify memory (double word)");
