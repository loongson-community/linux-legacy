#ifdef __mips
#include <asm/cacheflush.h>
#include <asm/r4kcache.h>
#define MTC0(RT,RD,SEL) ((0x408<<20)|((RT)<<16)|((RD)<<11)|SEL)
#define MFC0(RT,RD,SEL) ((0x400<<20)|((RT)<<16)|((RD)<<11)|SEL)
#define DMTC0(RT,RD,SEL) ((0x40a<<20)|((RT)<<16)|((RD)<<11)|SEL)
#define DMFC0(RT,RD,SEL) ((0x402<<20)|((RT)<<16)|((RD)<<11)|SEL)
static int cp0s_sel=0;
static int __cp0syscall1(int type,unsigned long long addr,union commondata *mydata)
{
long data8;
extern int mycp0ins();
unsigned int *p=(void *)mycp0ins;
if(type!=8)return -1;
memset(mydata->data8,0,8);
addr=addr&0x1f;
#if __mips==3
*p=DMFC0(2,addr,cp0s_sel);
#else
*p=MFC0(2,addr,cp0s_sel);
#endif
flush_dcache_line(((unsigned long)p)&~31UL);
flush_icache_line(((unsigned long)p)&~31UL);

 asm(".global mycp0ins;mycp0ins:mfc0 $2,$0;move %0,$2" :"=r"(data8)::"$2");

 *(long *)mydata->data8=data8;

return 0;
}

static int __cp0syscall2(int type,unsigned long long addr,union commondata *mydata)
{
extern int mycp0ins1();
unsigned int *p=(void *)mycp0ins1;
if(type!=8)return -1;
addr=addr&0x1f;
#if __mips==3
*p=DMTC0(2,addr,cp0s_sel);
#else
*p=MTC0(2,addr,cp0s_sel);
#endif
flush_dcache_line(((unsigned long)p)&~31UL);
flush_icache_line(((unsigned long)p)&~31UL);

 asm(".global mycp0ins1;move $2,%0;mycp0ins1:mtc0 $2,$0;"::"r"(*(long *)mydata->data8):"$2");

return 0;
}

static int mycp0s(int argc,char **argv)
{
syscall1=__cp0syscall1;
syscall2=__cp0syscall2;
	syscall_addrtype=0x70;
if(argc>1)cp0s_sel=nr_strtol(argv[1],0,0);
else cp0s_sel=0;
return 0;	
}
mycmd_init(cp0s,mycp0s,"[0|-1]","set m4,d4 to access cp0 regs");
#endif
