#include "pci.c"
#include "lpc.c"

static int __syscall1(int type,unsigned addr,union commondata *mydata);
static int __syscall2(int type,unsigned addr,union commondata *mydata);
extern int (*syscall1)(int type,unsigned addr,union commondata *mydata);
extern int (*syscall2)(int type,unsigned addr,union commondata *mydata);

static char * nr_gets(char *s);
static int nr_printf(char *fmt,...);

static struct _mypciinfo{
	int bus;
	int device;
	int function;
} mpi;

static int __pcisyscall1(int type,unsigned addr,union commondata *mydata)
{
int readdata;
switch(type)
{
case 1:sysPciCfgRead(mpi.bus,mpi.device,mpi.function,addr,type*8,&readdata);mydata->data1=readdata;break;
case 2:sysPciCfgRead(mpi.bus,mpi.device,mpi.function,addr,type*8,&readdata);mydata->data2=readdata;break;
case 4:sysPciCfgRead(mpi.bus,mpi.device,mpi.function,addr,type*8,&readdata);mydata->data4=readdata;break;
case 8:sysPciCfgRead(mpi.bus,mpi.device,mpi.function,addr,type*8,&readdata);mydata->data8[0]=readdata;
	sysPciCfgRead(mpi.bus,mpi.device,mpi.function,addr+4,type*8,&readdata);mydata->data8[1]=readdata;break;
}
return 0;
}

static int __pcisyscall2(int type,unsigned addr,union commondata *mydata)
{
switch(type)
{
case 1:break;
case 2:break;
case 4:sysPciCfgWrite (mpi.bus,mpi.device,mpi.function,addr,mydata->data4);return 0;
case 8:break;
}
return -1;
}

static int PciConfSel(int argc,char **argv)
{

		if(argc<2||argc>4){nr_printf("pcs bus [dev] [func]\n");return -1;}
		if(argc>=2)sscanf(argv[1],"%d",&mpi.bus);
		if(argc>=3)sscanf(argv[2],"%d",&mpi.device);
		if(argc>=4)sscanf(argv[3],"%d",&mpi.function);
    if(mpi.bus<0){
    	syscall1=__syscall1;
    	syscall2=__syscall2;
    	nr_printf("select normal memory space\n");
    	}
    else
    {
    	syscall1=__pcisyscall1;
    	syscall2=__pcisyscall2;
    	nr_printf("select pci configure space bus:%d dev:%d func:%d\n",mpi.bus,mpi.device,mpi.function);
    }
		return 0;
}

static int LpcRead(int argc,char **argv)
{
	unsigned char LdnNumber,Index,data;
		if(argc!=3){nr_printf("lpcr LdnNumber Index\n");return -1;}
		sscanf(argv[1],"%x",&LdnNumber);
		sscanf(argv[2],"%x",&Index);
	
data=LPCGetConfig(LdnNumber,Index);
nr_printf("%02x\n",data);
return 0;
}

static int LpcWrite(int argc,char **argv)
{
        unsigned char LdnNumber,Index,data;
                if(argc!=4){nr_printf("lpcw LdnNumber Index data\n");return -1;}
                sscanf(argv[1],"%x",&LdnNumber);
                sscanf(argv[2],"%x",&Index);
                sscanf(argv[3],"%x",&data);

LPCSetConfig(LdnNumber,Index,data);
data=LPCGetConfig(LdnNumber,Index);
nr_printf("%02x\n",data);
return 0;
}



#define USERCMDS \
{"pcs",PciConfSel,"pcs bus [dev] [func]","Pci Configure sel,bus==-1 for normal memory access"},\
{"lpcr",LpcRead,"lpcr LDN index","LPC Get Config"},\
{"lpcw",LpcWrite,"lpcw LDN index value","LPC Set Config"}, 


