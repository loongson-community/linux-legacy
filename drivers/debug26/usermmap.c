#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#define nr_gets(str,size)  read(0,str,size)
#define nr_printf printf
#define nr_strsep strsep
#define nr_strtol strtoul
#define nr_malloc malloc
#define nr_free free
int mem_fd;
#define PAGE_SIZE 0x1000
#define PAGE_MASK ~(PAGE_SIZE-1)
#define nr_mmap(physaddr,size)	((long)mmap(0,PAGE_SIZE,PROT_READ|PROT_WRITE,MAP_SHARED,mem_fd,physaddr&PAGE_MASK)+(physaddr&~PAGE_MASK))
#define nr_munmap(addr,size) munmap(addr&PAGE_MASK,PAGE_SIZE)

#include "begin.c"
#include "lib/cmdparser.c"
#include "lib/env.c"
#include "lib/mem.c"
static int quitnow;
static void debug(void)
{
static char str[1024];
int count;
quitnow=0;
do_initbegin_calls();
setbuf(stdout,0);
 while(!quitnow)
 {
    fprintf(stdout,"\n-");
    count=nr_gets(str,1024);
    if(count<=0)break;
    str[count-1]=0;
    do_cmd(str);
 }
}

int main(int argc,char **argv)
{
	int fd,i;
	char *devname="/dev/mem";
	if(argc==2)devname=argv[1];
	mem_fd=open(devname,O_RDWR|O_SYNC);
	debug();
	close(mem_fd);
	return 0;
}
#include "end.c"
