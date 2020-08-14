/* dummy.c: a dummy net driver

	The purpose of this driver is to provide a device to point a
	route through, but not to actually transmit packets.

	Why?  If you have a machine whose only connection is an occasional
	PPP/SLIP/PLIP link, you can only connect to your own hostname
	when the link is up.  Otherwise you have to use localhost.
	This isn't very consistent.

	One solution is to set up a dummy link using PPP/SLIP/PLIP,
	but this seems (to me) too much overhead for too little gain.
	This driver provides a small alternative. Thus you can do
	
	[when not running slip]
		ifconfig dummy slip.addr.ess.here up
	[to go to slip]
		ifconfig dummy down
		dip whatever

	This was written by looking at Donald Becker's skeleton driver
	and the loopback driver.  I then threw away anything that didn't
	apply!	Thanks to Alan Cox for the key clue on what to do with
	misguided packets.

			Nick Holloway, 27th May 1994
	[I tweaked this explanation a little but that's all]
			Alan Cox, 30th May 1994
*/

/* To have statistics (just packets sent) define this */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/netdevice.h>
#include <linux/init.h>
#include <asm/uaccess.h>
#include <asm/ioctls.h>
int errno=0;
#define  __KERNEL_SYSCALLS__
#include <asm/unistd.h>

#define PCHAR(x) *(volatile unsigned char *)(x)
#define PSHORT(x) *(volatile unsigned short *)(x)
#define PLONG(x) *(volatile unsigned long *)(x)
static inline _syscall5(long,_newselect,int,n,fd_set *,inp,fd_set *,outp,fd_set *,exp,struct timeval *,tvp)
static inline _syscall1(long,sigpending,old_sigset_t *,set)
static inline _syscall3(long,ioctl,unsigned int,fd,unsigned int,cmd,unsigned long ,arg)


static int kbhit(void)
{
mm_segment_t old_fs;
int n;
old_fs=get_fs();
set_fs(KERNEL_DS);
	ioctl(0,FIONREAD,&n);
set_fs(old_fs);
return n;
}
