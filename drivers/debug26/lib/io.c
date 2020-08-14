
#include <linux/pci.h>
static int __syscall1(int type,unsigned long long addr,union commondata *mydata);
static int __syscall2(int type,unsigned long long addr,union commondata *mydata);
extern int (*syscall1)(int type,unsigned long long addr,union commondata *mydata);
extern int (*syscall2)(int type,unsigned long long addr,union commondata *mydata);


static int __iosyscall1(int type,unsigned long long addr,union commondata *mydata)
{
switch(type)
{
case 1:mydata->data1=inb(addr);break;
case 2:mydata->data2=inw(addr);break;
case 4:mydata->data4=inl(addr);break;
case 8:mydata->data8[0]=inl(addr);
	   mydata->data8[1]=inl(addr+4);break;
}
return 0;
}

static int __iosyscall2(int type,unsigned long long addr,union commondata *mydata)
{
switch(type)
{
case 1:outb(mydata->data1,addr);return 0;
case 2:outw(mydata->data2,addr);return 0;
case 4:outl(mydata->data4,addr);return 0;
case 8:break;
}
return -1;
}


static int IoS(int argc,char **argv)
{
int num=0;
		if(argc>2){nr_printf("ios [num]\n");return -1;}
		if(argc==2)num=nr_strtol(argv[1],0,0);
		if(num!=-1)
		{
    	nr_printf("select io space\n");
    	syscall1=__iosyscall1;
    	syscall2=__iosyscall2;
		}
		else {
    	syscall1=__syscall1;
    	syscall2=__syscall2;
    	nr_printf("select normal memory space\n");
		}
		return 0;
}
mycmd_init(ios,IoS,"ios [num]","io space select ,num==-1 for normal memory access");
