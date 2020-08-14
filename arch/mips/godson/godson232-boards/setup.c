/*
 * setup.c
 *
 * BRIEF MODULE DESCRIPTION
 * GodsonEV2a - board dependent boot routines
 *
 * Copyright (C) 1996, 1997, 2001  Ralf Baechle
 * Copyright (C) 2000 RidgeRun, Inc.
 * Copyright (C) 2001 Red Hat, Inc.
 * Copyright (C) 2002 Momentum Computer
 * Copyright (C) 2003 ICT CAS
 * 
 * Author: Michae Guo, ICT CAS
 *   guoyi@ict.ac.cn
 * 
 * Author: Matthew Dharm, Momentum Computer
 *   mdharm@momenco.com
 *
 * Author: RidgeRun, Inc.
 *   glonnon@ridgerun.com, skranz@ridgerun.com, stevej@ridgerun.com
 *
 * Copyright 2001 MontaVista Software Inc.
 * Author: jsun@mvista.com or jsun@junsun.net
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
 *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
 *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
 *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  You should have received a copy of the  GNU General Public License along
 *  with this program; if not, write  to the Free Software Foundation, Inc.,
 *  675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */
#include <linux/config.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/mm.h>
#include <linux/swap.h>
#include <linux/ioport.h>
#include <linux/sched.h>
#include <linux/interrupt.h>
#include <linux/pci.h>
#include <linux/timex.h>
#include <linux/vmalloc.h>
#ifdef CONFIG_BLK_DEV_IDE
#include <linux/ide.h>
#endif
#include <asm/time.h>
#include <asm/bootinfo.h>
#include <asm/page.h>
#include <asm/bootinfo.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <asm/pci.h>
#include <asm/processor.h>
#include <asm/ptrace.h>
#include <asm/reboot.h>
#include <asm/mc146818rtc.h>
#include <asm/keyboard.h>
#include <linux/version.h>
#include <linux/bootmem.h>
#include <linux/blk.h>
#include <linux/mc146818rtc.h>
//#include <asm/ev64240/gt64240.h>

#ifdef CONFIG_BLK_DEV_FD
#include <asm/floppy.h>
#endif
#include <asm/dma.h>
#ifdef CONFIG_VT
#include <linux/console.h>
#endif
#ifdef CONFIG_PC_KEYB
#include <asm/keyboard.h>
#endif

extern struct ide_ops std_ide_ops;
extern struct kbd_ops std_kbd_ops;
extern struct rtc_ops godsonev2a_rtc_ops;
#ifdef CONFIG_BLK_DEV_FD
extern struct fd_ops std_fd_ops;
#endif

#ifdef CONFIG_BLK_DEV_INITRD
extern unsigned long initrd_start, initrd_end;
extern void * __rd_start, * __rd_end;
#endif

struct resource standard_io_resources[] = {
	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
};

#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))


extern void prom_printf(char *fmt, ...);

#ifdef CONFIG_MIPS64
#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long long)(p)))
#else
#define PTR_PAD(p) (p)
#endif
unsigned long gt64240_base;

unsigned long cpu_clock;
unsigned long bus_clock;
unsigned int  memsize;
unsigned int  highmemsize = 0;

/* These functions are used for rebooting or halting the machine*/
extern void godsonev2a_restart(char *command);
extern void godsonev2a_halt(void);
extern void godsonev2a_power_off(void);

extern void godsonev2a_irq_setup(void);

static void __init setup_l3cache(unsigned long size);
void godsonev2a_time_setup(void);
void godsonev2a_timer_setup(struct irqaction *irq)
{
	prom_printf("godsonev2a_timer_setup,irq=63\n");
	setup_irq(63, irq);
}

void godsonev2a_time_setup(void)
{
	prom_printf("godsonev2a_time_setup\n");
	/* setup mips r4k timer */
	mips_hpt_frequency = cpu_clock / 2;
	board_timer_setup = godsonev2a_timer_setup;
}

void (*__wbflush)(void);
static void wbflush_rm7k(void)
{
#if 1 
    *(volatile unsigned long *)KSEG1;
    asm(".set\tpush\n\t"
	".set\tnoreorder\n\t"
	".set mips3\n\t"
	"sync\n\t"
	"nop\n\t"
	".set\tpop\n\t"
	".set mips0\n\t");
#endif
}

extern char * __init prom_getcmdline(void);
extern unsigned long mips_rtc_get_time(void);

static inline int fls(int x)
{
	int r = 32;

	if (!x)
		return 0;
	if (!(x & 0xffff0000u)) {
		x <<= 16;
		r -= 16;
	}
	if (!(x & 0xff000000u)) {
		x <<= 8;
		r -= 8;
	}
	if (!(x & 0xf0000000u)) {
		x <<= 4;
		r -= 4;
	}
	if (!(x & 0xc0000000u)) {
		x <<= 2;
		r -= 2;
	}
	if (!(x & 0x80000000u)) {
		x <<= 1;
		r -= 1;
	}
	return r;
}

void __init nb2005_setup(void)
{
	unsigned int scs, baselo, basehi;

	int i;
	/* Reset PCI I/O and PCI MEM values */

        ioport_resource.start = 0;
        //ioport_resource.end = 0xfffff;
        ioport_resource.end = 0xffffff;
        iomem_resource.start = 0x10000000;
        iomem_resource.end = 0xffffffff;

	set_io_port_base(PTR_PAD(0xbfd00000));
	
	/* Request I/O space for devices used on the Malta board. */
	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
		request_resource(&ioport_resource, standard_io_resources+i);

	/*
	 * Enable DMA channel 4 (cascade channel) in the PIIX4 south bridge.
	 */
#ifdef CONFIG_ISA
	enable_dma(4);
#endif

	board_time_init = godsonev2a_time_setup;

	_machine_restart = godsonev2a_restart;
	_machine_halt = godsonev2a_halt;
	_machine_power_off = godsonev2a_power_off;
	rtc_get_time = mips_rtc_get_time;
	
#if 1
	__wbflush = wbflush_rm7k;
#endif
	
#ifdef CONFIG_BLK_DEV_INITRD
	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
	initrd_start = (unsigned long)&__rd_start;
	initrd_end = (unsigned long)&__rd_end;
#endif

#ifdef CONFIG_PC_KEYB
	kbd_ops = &std_kbd_ops;
#endif 

#ifdef CONFIG_RTC
	rtc_ops = &godsonev2a_rtc_ops;
#endif
#ifdef CONFIG_BLK_DEV_IDE
	ide_ops = &std_ide_ops;
#endif
#ifdef CONFIG_BLK_DEV_FD
	fd_ops = &std_fd_ops;
#endif

	prom_printf("GodsonEV2a\n");


    add_memory_region(0x100000,(memsize<<20) - 0x100000, BOOT_MEM_RAM);
#if defined(CONFIG_MIPS64)||defined(CONFIG_HIGHMEM)
{
int bit;
long mask;
bit=fls(memsize+highmemsize);
if(bit!=ffs(memsize+highmemsize)) bit=bit+20;
else bit=bit+20-1;
mask=~((1<<bit)-1);

#ifdef CONFIG_MIPS64
	*(unsigned volatile long long *) 0x900000003ff00010 = 0x0000000080000000; //base
	*(unsigned volatile long long *) 0x900000003ff00030 = 0xffffffff00000000|mask;//0xffffffff80000000; //mask
	*(unsigned volatile long long *) 0x900000003ff00050 = 0; //map
#else
	  asm(".set mips3;dli $2,0x900000003ff00000;dli $3,0x80000000;sd $3,0x10($2);dli $3,0xffffffff00000000;or $3,%0;sd $3,0x30($2);sd $0,0x50($2);.set mips0" ::"r"(mask):"$2","$3");

#endif
	if (highmemsize > 0) {
		add_memory_region(0x10000000, 0x10000000, BOOT_MEM_RESERVED);
		add_memory_region(0x90000000, highmemsize<<20, BOOT_MEM_RAM);
	}
}
#endif

#ifdef CONFIG_VT
#if defined(CONFIG_VGA_CONSOLE)
        conswitchp = &vga_con;

	screen_info = (struct screen_info) {
		0, 25,			/* orig-x, orig-y */
		0,			/* unused */
		0,			/* orig-video-page */
		0,			/* orig-video-mode */
		80,			/* orig-video-cols */
		0,0,0,			/* ega_ax, ega_bx, ega_cx */
		25,			/* orig-video-lines */
		1,			/* orig-video-isVGA */
		16			/* orig-video-points */
	};
#elif defined(CONFIG_DUMMY_CONSOLE)
	conswitchp = &dummy_con;
#endif
#endif

#ifdef CONFIG_BLK_DEV_INITRD
	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
	initrd_start = (unsigned long)&__rd_start;
	initrd_end = (unsigned long)&__rd_end;
#endif
//arch_pcibios_init();

}


