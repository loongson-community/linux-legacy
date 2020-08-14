
static int writefile(int argc,char **argv)
{
unsigned long addr,size,step;
char *pchar;
int fd;
mm_segment_t old_fs;
	if(argc!=5)
	{return -1;}
	addr=nr_strtol(argv[2],0,0);
	size=nr_strtol(argv[3],0,0);
	step=nr_strtol(argv[4],0,0);

pchar=(!strcmp(argv[0],"wf_ioremap"))?ioremap(addr,size):addr;
nr_printf("addr=%lx,pchar=%p,size=%lx\n",addr,pchar,size);
old_fs=get_fs();
set_fs(KERNEL_DS);
fd=open(argv[1],O_CREAT|O_WRONLY|O_TRUNC,0);
while(size)
{
nr_printf("addr=%lx\n",pchar);
write(fd,pchar,min(step,size));
pchar+=step;
size -=min(step,size);
}
close(fd);
set_fs(old_fs);
return 0;
}

static int mydumpaddr(int argc,char **argv)
{
unsigned long addr,size,step,count;
volatile int *pchar;
	if(argc!=4)
	{return -1;}
	addr=nr_strtol(argv[1],0,0);
	size=nr_strtol(argv[2],0,0);
	step=nr_strtol(argv[3],0,0);

pchar=addr;
nr_printf("addr=%lx,pchar=%p,size=%lx\n",addr,pchar,size);
count=0;
while(size>0)
{
if((count%step)==0)nr_printf("addr=%llx\n",pchar);
*pchar;
pchar++;
size=-4;
count+=4;
}
return 0;
}

mycmd_init(dumpaddr,mydumpaddr,"mydumpaddr addr size step","dump memory");
mycmd_init(wf,writefile,"wf filename addr size step","write memory into file");
mycmd_init(wf_ioremap,writefile,"wf_ioremap filename iomapaddr size","write memory into file");
