#ifdef DEBUG26_TEST_PMON
static int pmon1(int argc,char **argv);
static char *sp;
static unsigned int status;
/*
in linux
cat /proc/debug
pmon
to pmon.
in pmon
g -e 0x???????? //exit address to linux
*/
static int pmon(int argc,char **argv)
{
if(argc!=2)return -1;
nr_printf("exit=%x\n",pmon1);
sp=&argc;
asm("mfc0 %0,$12":"=r"(status));

asm(\
".set noreorder;" \
"mfc0 $2,$12;or $2,1;xor $2,1;mtc0 $2,$12;" \
"li $31,%0;" \
"jr	$31;" \
"li $2,1 ;" ::"X"(strtoul(argv[1],0,0))); //call pmon _exit(ra register displaye on pmon),pmon _exit will call pmon longjmp
return 0;	
}

static int pmon1(int argc,char **argv)
{
asm("move $29,%0;mtc0 %1,$12;"::"r"(sp),"r"(status):"$2");
exit(0);
return 0;	
}

mycmd_init(pmon,pmon,"cmds","pmon");
mycmd_init(pmon1,pmon1,"cmds","pmon");
#endif

