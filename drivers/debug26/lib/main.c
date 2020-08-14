#include "../include/config.h"
#include <linux/autoconf.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/netdevice.h>
#include <linux/init.h>
//#include <linux/moduleparam.h>
#include <asm/uaccess.h>
#include <asm/ioctls.h>
#include <asm/io.h>
static int errno=0;
#include <asm/signal.h>
#include <linux/proc_fs.h>
#include <linux/file.h>
#include <asm-mips/mipsregs.h>

#define nr_strtol simple_strtol
#define nr_strsep strsep

//#define  __KERNEL_SYSCALLS__
#include <asm/unistd.h>
#define DEBUG_MAJOR 62
#ifndef __NR_signal
#define __NR_signal __NR_O32_signal
#define __NR_waitpid __NR_O32_waitpid 
#define __NR_time __NR_O32_time
#endif

#define _syscall0(type,name) \
type name(void) \
{ \
	register unsigned long __a3 asm("$7"); \
	unsigned long __v0; \
	\
	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"li\t$2, %2\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "=r" (__a3) \
	: "i" (__NR_##name) \
	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
	  "memory"); \
	\
	if (__a3 == 0) \
		return (type) __v0; \
	errno = __v0; \
	return (type) -1; \
}

/*
 * DANGER: This macro isn't usable for the pipe(2) call
 * which has a unusual return convention.
 */
#define _syscall1(type,name,atype,a) \
type name(atype a) \
{ \
	register unsigned long __a0 asm("$4") = (unsigned long) a; \
	register unsigned long __a3 asm("$7"); \
	unsigned long __v0; \
	\
	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"li\t$2, %3\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "=r" (__a3) \
	: "r" (__a0), "i" (__NR_##name) \
	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
	  "memory"); \
	\
	if (__a3 == 0) \
		return (type) __v0; \
	errno = __v0; \
	return (type) -1; \
}

#define _syscall2(type,name,atype,a,btype,b) \
type name(atype a, btype b) \
{ \
	register unsigned long __a0 asm("$4") = (unsigned long) a; \
	register unsigned long __a1 asm("$5") = (unsigned long) b; \
	register unsigned long __a3 asm("$7"); \
	unsigned long __v0; \
	\
	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"li\t$2, %4\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "=r" (__a3) \
	: "r" (__a0), "r" (__a1), "i" (__NR_##name) \
	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
	  "memory"); \
	\
	if (__a3 == 0) \
		return (type) __v0; \
	errno = __v0; \
	return (type) -1; \
}

#define _syscall3(type,name,atype,a,btype,b,ctype,c) \
type name(atype a, btype b, ctype c) \
{ \
	register unsigned long __a0 asm("$4") = (unsigned long) a; \
	register unsigned long __a1 asm("$5") = (unsigned long) b; \
	register unsigned long __a2 asm("$6") = (unsigned long) c; \
	register unsigned long __a3 asm("$7"); \
	unsigned long __v0; \
	\
	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"li\t$2, %5\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "=r" (__a3) \
	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
	  "memory"); \
	\
	if (__a3 == 0) \
		return (type) __v0; \
	errno = __v0; \
	return (type) -1; \
}

#define _syscall4(type,name,atype,a,btype,b,ctype,c,dtype,d) \
type name(atype a, btype b, ctype c, dtype d) \
{ \
	register unsigned long __a0 asm("$4") = (unsigned long) a; \
	register unsigned long __a1 asm("$5") = (unsigned long) b; \
	register unsigned long __a2 asm("$6") = (unsigned long) c; \
	register unsigned long __a3 asm("$7") = (unsigned long) d; \
	unsigned long __v0; \
	\
	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"li\t$2, %5\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "+r" (__a3) \
	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
	  "memory"); \
	\
	if (__a3 == 0) \
		return (type) __v0; \
	errno = __v0; \
	return (type) -1; \
}

#if (_MIPS_SIM == _MIPS_SIM_ABI32)

/*
 * Using those means your brain needs more than an oil change ;-)
 */

#define _syscall5(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e) \
type name(atype a, btype b, ctype c, dtype d, etype e) \
{ \
	register unsigned long __a0 asm("$4") = (unsigned long) a; \
	register unsigned long __a1 asm("$5") = (unsigned long) b; \
	register unsigned long __a2 asm("$6") = (unsigned long) c; \
	register unsigned long __a3 asm("$7") = (unsigned long) d; \
	unsigned long __v0; \
	\
	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"lw\t$2, %6\n\t" \
	"subu\t$29, 32\n\t" \
	"sw\t$2, 16($29)\n\t" \
	"li\t$2, %5\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	"addiu\t$29, 32\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "+r" (__a3) \
	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name), \
	  "m" ((unsigned long)e) \
	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
	  "memory"); \
	\
	if (__a3 == 0) \
		return (type) __v0; \
	errno = __v0; \
	return (type) -1; \
}

#define _syscall6(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e,ftype,f) \
type name(atype a, btype b, ctype c, dtype d, etype e, ftype f) \
{ \
	register unsigned long __a0 asm("$4") = (unsigned long) a; \
	register unsigned long __a1 asm("$5") = (unsigned long) b; \
	register unsigned long __a2 asm("$6") = (unsigned long) c; \
	register unsigned long __a3 asm("$7") = (unsigned long) d; \
	unsigned long __v0; \
	\
	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"lw\t$2, %6\n\t" \
	"lw\t$8, %7\n\t" \
	"subu\t$29, 32\n\t" \
	"sw\t$2, 16($29)\n\t" \
	"sw\t$8, 20($29)\n\t" \
	"li\t$2, %5\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	"addiu\t$29, 32\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "+r" (__a3) \
	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name), \
	  "m" ((unsigned long)e), "m" ((unsigned long)f) \
	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
	  "memory"); \
	\
	if (__a3 == 0) \
		return (type) __v0; \
	errno = __v0; \
	return (type) -1; \
}

#endif /* (_MIPS_SIM == _MIPS_SIM_ABI32) */

#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)

#define _syscall5(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e) \
type name (atype a,btype b,ctype c,dtype d,etype e) \
{ \
	register unsigned long __a0 asm("$4") = (unsigned long) a; \
	register unsigned long __a1 asm("$5") = (unsigned long) b; \
	register unsigned long __a2 asm("$6") = (unsigned long) c; \
	register unsigned long __a3 asm("$7") = (unsigned long) d; \
	register unsigned long __a4 asm("$8") = (unsigned long) e; \
	unsigned long __v0; \
	\
	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"li\t$2, %6\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "+r" (__a3) \
	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "i" (__NR_##name) \
	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
	  "memory"); \
	\
	if (__a3 == 0) \
		return (type) __v0; \
	errno = __v0; \
	return (type) -1; \
}

#define _syscall6(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e,ftype,f) \
type name (atype a,btype b,ctype c,dtype d,etype e,ftype f) \
{ \
	register unsigned long __a0 asm("$4") = (unsigned long) a; \
	register unsigned long __a1 asm("$5") = (unsigned long) b; \
	register unsigned long __a2 asm("$6") = (unsigned long) c; \
	register unsigned long __a3 asm("$7") = (unsigned long) d; \
	register unsigned long __a4 asm("$8") = (unsigned long) e; \
	register unsigned long __a5 asm("$9") = (unsigned long) f; \
	unsigned long __v0; \
	\
	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"li\t$2, %7\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "+r" (__a3) \
	: "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "r" (__a5), \
	  "i" (__NR_##name) \
	: "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", \
	  "memory"); \
	\
	if (__a3 == 0) \
		return (type) __v0; \
	errno = __v0; \
	return (type) -1; \
}
#endif

static inline _syscall0(int,pause)
static inline _syscall0(int,sync)
static inline _syscall0(pid_t,setsid)
static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
static inline _syscall1(int,dup,int,fd)
static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
static inline _syscall1(int,close,int,fd)
static inline _syscall1(void,exit,int,exitcode)
static inline _syscall1(int,delete_module,const char *,name)
static inline _syscall3(long,mknod,const char *, filename, int, mode, dev_t ,dev)
static inline _syscall5(long,mount,char * ,dev_name, char *, dir_name, char *, type,unsigned long, flags, void * ,data);
static inline _syscall3(long,ioctl,unsigned int, fd, unsigned int, cmd, unsigned long, arg);
static inline _syscall1(long,chroot,const char *, filename);
static inline _syscall2(long,mkdir,const char *, pathname, int, mode)
	
static int syscall_addrtype=0;

struct __myenv_s;
static char  *getenv(char *name);
static void do_cmd(char *p);

#include "malloc.c"
#include "ctype.h"
#include "ctype.c"
#if 1
static void sleep(unsigned howlong)
{
	current->state=TASK_INTERRUPTIBLE;
	schedule_timeout(howlong);
}
static int sleepcmd(int argc,char **argv)
{
	if(argc!=2)return -1;
	sleep(nr_strtol(argv[1],0,0));
	return 0;
}

static int busysleepcmd(int argc,char **argv)
{
	unsigned long cnt0,cnt,t;
	if(argc!=2)return -1;
	t = nr_strtol(argv[1],0,0);
	cnt0 = read_c0_count();
	while(1)
	{
	cnt = read_c0_count();
	if((cnt - cnt0) > t) break;
	}
	return 0;
}

#endif




//static inline _syscall2(unsigned long,signal,int ,sig,void *,handler)
	

static int nr_gets(char *s,int size);
#ifdef DEBUG26_FROM_SERIAL
#define nr_printf prom_printf
#define nr_gets   prom_gets
#endif

#ifndef nr_printf
static int nr_printf(char *fmt,...);
#endif

static void chfs(int save)
{
static mm_segment_t old_fs[10];
static int idx=0;
	if(save)
	{
	old_fs[idx++]=get_fs();
	set_fs(KERNEL_DS);
	}
	else set_fs(old_fs[--idx]);
}
#ifndef nr_gets
static int nr_gets(char *s,int size)
{
mm_segment_t old_fs;
int count;
old_fs=get_fs();
set_fs(KERNEL_DS);
count=read(0,s,size);
set_fs(old_fs);
if(count<=0)exit(0);
	return count;
}
#else
int getDebugChar();
static int prom_gets(char *s,int size)
{
int count=0;
while(count<size-1)
{
char c;
 c=getDebugChar();
 if(c=='\r')c='\n';
 s[count++]=c;
 if(c!='\n') putDebugChar(c);
 break;
}
s[count]=0;
	return count;
}

#endif
#ifndef nr_printf
static int nr_stdout=2; //must be 2,for write
static int nr_printf(char *fmt,...)
{
static char buf[0x200];
mm_segment_t old_fs;
  va_list ap;
  va_start(ap,fmt);
  vsprintf(buf,fmt,ap);
  va_end(ap);
old_fs=get_fs();
set_fs(KERNEL_DS);
write(nr_stdout,buf,strlen(buf));
set_fs(old_fs);
return 0;
}
#endif


static int nr_fprintf(int fd,char *fmt,...)
{
static char buf[0x200];
mm_segment_t old_fs;
  va_list ap;
  va_start(ap,fmt);
  vsprintf(buf,fmt,ap);
  va_end(ap);
old_fs=get_fs();
set_fs(KERNEL_DS);
write(fd,buf,strlen(buf));
set_fs(old_fs);
return 0;
}

#include "cmdparser.c"
static void debug(void)
{
static char str[1024];
int count;
quitnow=0;
 while(!quitnow)
 {
 char *pstart=str,*pend;
 int len=1023;
    nr_printf("\n-");	
    while(1)
    {
	count=nr_gets(pstart,len);
	if(count<=0)return;
	pstart[count]=0;
	pend=_do_cmd(str,1);
	if((pend-pstart)==count)break;
	strcpy(str,pend);
	pstart=str+strlen(str);
	len=1023-strlen(str);
    }
 }
}


static int debug_open(struct inode *inode, struct file *filp)
{
return 0;
}

int debug_release (struct inode *inode, struct file *filp)
{
		    return 0;
}

struct file_operations debug_fops = {
    open:       debug_open,
    release:    debug_release,
};

static int proc_read_debug(char *page, char **start,
			     off_t off, int count,
			     int *eof, void *data)
{
	debug();
	return 0;
}

	
static int proc_write_debug(struct file *file,
			     const char *buffer,
			     unsigned long count, 
			     void *data)
{
	int left,len;
	static char *pdata=0;
	char *pend;
	struct file *file2,*file0;

    fput(file2=fget(2));
    if(file==file2){
        fput(file0=fget(0));
     if(file0!=file)nr_fprintf(0,"debug26:wrong fd1==fd2,loop error\n");
     else printk("<0>debug26:wrong fd1==fd2,loop error\n");
        return -1;
    }

	if(!pdata)pdata=data;
	left=count;
	while(left)
	{
	len=(left > PAGE_SIZE-1-(pdata-(char *)data))?PAGE_SIZE-1-(pdata-(char *)data):left;

	if(copy_from_user(pdata, buffer+count-left, len)) {
		return -EFAULT;
	}

	pdata[len] = '\0';
	left-=len;
	pend=_do_cmd(data,1);
	strcpy(data,pend);
	pdata=data+strlen(data);
	}

	return count;
}

static struct proc_dir_entry *debug_proc_entry=0;
static int rcdevrv=0;

#ifdef DEBUG26_FROM_SERIAL
int debug26_runmydebug()
{
	do_initbegin_calls();
	debug();
	nr_printf("quit\n");
	return -1;
}
#endif

static int dummy_init_module(void)
{
#if defined(MODULE) && !defined(DEBUG26_MODULE_INSTALL) 
	do_initbegin_calls();
	debug();
	nr_printf("quit\n");
	return -1;
#else
	 do_initbegin_calls();
	 debug_proc_entry=create_proc_entry("debug",0444,0);
	if (debug_proc_entry) {
	debug_proc_entry->read_proc=proc_read_debug;
	debug_proc_entry->write_proc=proc_write_debug;
	debug_proc_entry->data=(void *)__get_free_page(GFP_KERNEL);
	printk("<0>create proc file debug succeed\n");
	}
	else printk("<0>create proc file debug fail\n");

rcdevrv=register_chrdev(DEBUG_MAJOR, "debug", &debug_fops);
if(rcdevrv<0)
	printk("<0>register_chrdev DEBUGMAJOR 62 fail\n");
else 
	printk("<0>register_chrdev DEBUGMAJOR 62 succeed\n");
return 0;
#endif
	
}
static void dummy_cleanup_module(void)
{
do_initend_calls();
if(debug_proc_entry)remove_proc_entry("debug",0);
if(rcdevrv>=0)unregister_chrdev(DEBUG_MAJOR, "debug");
if(debug_proc_entry->data)free_page((unsigned long)debug_proc_entry->data);
}
module_init(dummy_init_module);
module_exit(dummy_cleanup_module);
mycmd_init(sleep,sleepcmd,"njiffies","sleep a little time");
mycmd_init(busysleep,busysleepcmd,"ms","busysleep a little time");
