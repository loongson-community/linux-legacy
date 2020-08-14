
extern void read_a_sector(int block,char *buf);
static char fdbuf[512];
static int readfd(char *argc,char **argv)
{
char str[32];
int block;
if(argc>1)block=nr_strtol(argv[1],0,0);
else block=0;
memset(fdbuf,0,512);
read_a_sector(block,fdbuf);
sprintf(str,"d1 0x%p 256",fdbuf);
do_cmd(str);
return 0;
}

static int writefd(char *argc,char **argv)
{
int block;
if(argc>1)block=nr_strtol(argv[1],0,0);
else block=0;
write_a_sector(block,fdbuf);
return 0;
}

void setup_fdvar()
{
char str[32];
do_cmd("set iomap 0");
sprintf(str,"0x%p",fdbuf);
setenv("faddr",str,0);
}

mycmd_init(readfd,readfd,"readfd sector","read a sector from floppy");
mycmd_init(writefd,writefd,"writefd sector","write a sector to floppy");
myinit_begin(setup_fdvar);
