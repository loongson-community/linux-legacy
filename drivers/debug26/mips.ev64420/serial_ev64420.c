/*
 * mcfserial.c -- serial driver for ColdFire internal UARTS.
 *
 * Copyright (C) 1999-2003 Greg Ungerer <gerg@snapgear.com>
 * Copyright (c) 2000-2001 Lineo, Inc. <www.lineo.com> 
 * Copyright (C) 2001-2002 SnapGear Inc. <www.snapgear.com> 
 *
 * Based on code from 68332serial.c which was:
 *
 * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
 * Copyright (C) 1998 TSHG
 * Copyright (c) 1999 Rt-Control Inc. <jeff@uclinux.org>
 *
 * Changes:
 * 08/07/2003    Daniele Bellucci <bellucda@tiscali.it>
 *               some cleanups in ev64420_write.
 *
 */
 
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/timer.h>
#include <linux/wait.h>
#include <linux/interrupt.h>
#include <linux/tty.h>
#include <linux/tty_flip.h>
#include <linux/string.h>
#include <linux/fcntl.h>
#include <linux/mm.h>
#include <linux/kernel.h>
#include <linux/serial.h>
#include <linux/serialP.h>
#include <linux/console.h>
#include <linux/init.h>
#include <linux/bitops.h>
#include <linux/delay.h>

#include <asm/io.h>
#include <asm/irq.h>
#include <asm/system.h>
#include <asm/semaphore.h>
#include <asm/delay.h>
#include <asm/uaccess.h>

struct timer_list ev64420_timer_struct;

struct ev64420_serial {
	int			magic;
	int			irq;
	int			line;
	int			count;
	int			flags; 		/* defined in tty.h */
	struct tty_struct 	*tty;
};

int ev64420_console_inited = 0;
int ev64420_console_port = -1;
int ev64420_console_cbaud = 9600;

/*
 *	Driver data structures.
 */
static struct tty_driver *ev64420_serial_driver;

/*
 *	Configuration table, UARTs to look for at startup.
 */
static struct ev64420_serial ev64420_table = {
		.magic = 0,
		.flags = ASYNC_BOOT_AUTOCONF,
};


#define	NR_PORTS	1 



static inline void receive_chars(struct ev64420_serial *info)
{
	struct tty_struct	*tty = info->tty;
	unsigned char		ch;

	if (!tty)
		return;


	while (mpsc_test_char_debug()) {

		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
			break;

		ch = mpsc_getchar_debug();


		tty->flip.count++;
		*tty->flip.flag_buf_ptr++ = 0;
		*tty->flip.char_buf_ptr++ = ch;
	}

	schedule_work(&tty->flip.work);
	return;
}

/*
 * This is the serial driver's generic interrupt routine
 */
irqreturn_t ev64420_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	struct ev64420_serial	*info;

	info = &ev64420_table;
		if(mpsc_test_char_debug())
		receive_chars(info);

	return IRQ_HANDLED;
}



static int ev64420_write(struct tty_struct * tty,
		    const unsigned char *buf, int count)
{
	int			i;
	if (!tty ) return 0;
	   for(i=0;i<count;i++)
		prom_putchar(buf[i]);
	return count;
}

static int ev64420_write_room(struct tty_struct *tty)
{
	return 1024;
}


/*
 * ------------------------------------------------------------
 * ev64420_close()
 * 
 * This routine is called when the serial port gets closed.  First, we
 * wait for the last remaining data to be sent.  Then, we unlink its
 * S structure from the interrupt chain if necessary, and we free
 * that IRQ if nothing is left in the chain.
 * ------------------------------------------------------------
 */
static void ev64420_close(struct tty_struct *tty, struct file * filp)
{
	struct ev64420_serial	*info = (struct ev64420_serial *)tty->driver_data;
	unsigned long		flags;

	if (!info )
		return;
	
	local_irq_save(flags);
	
	if (tty_hung_up_p(filp)) {
		local_irq_restore(flags);
		return;
	}
	
	if ((tty->count == 1) && (info->count != 1)) {
		/*
		 * Uh, oh.  tty->count is 1, which means that the tty
		 * structure will be freed.  Info->count should always
		 * be one in these conditions.  If it's greater than
		 * one, we've got real problems, since it means the
		 * serial port won't be shutdown.
		 */
		printk("MCFRS: bad serial port count; tty->count is 1, "
		       "info->count is %d\n", info->count);
		info->count = 1;
	}
	if (--info->count < 0) {
		printk("MCFRS: bad serial port count for ttyS%d: %d\n",
		       info->line, info->count);
		info->count = 0;
	}
	if (info->count) {
		local_irq_restore(flags);
		return;
	}
	info->flags |= ASYNC_CLOSING;

	/*
	 * Now we wait for the transmit buffer to clear; and we notify 
	 * the line discipline to only process XON/XOFF characters.
	 */
	tty->closing = 1;

	if (tty->driver->flush_buffer)
		tty->driver->flush_buffer(tty);
	tty_ldisc_flush(tty);
	tty->closing = 0;
	info->tty = 0;
	local_irq_restore(flags);
}



/*
 * This routine is called whenever a serial port is opened. It
 * enables interrupts for a serial port, linking in its structure into
 * the IRQ chain.   It also performs the serial-specific
 * initialization for the tty structure.
 */
int ev64420_open(struct tty_struct *tty, struct file * filp)
{
	struct ev64420_serial	*info;
	int 			line;

	line = tty->index;
	if ((line < 0) || (line >= NR_PORTS))
		return -ENODEV;
	info = &ev64420_table;
	info->count++;
	tty->driver_data = info;
	info->tty = tty;

	return 0;
}


static void int_timer_do (unsigned long irq)
{
	ev64420_interrupt(irq,0,0);
    init_int_timer (irq);
}

static struct timer_list int_timer;
static void init_int_timer(int irq)
{
    init_timer (&int_timer);
    int_timer.function = (void *)int_timer_do;
    int_timer.data = irq;
    mod_timer(&int_timer,jiffies + 1);
}

/*
 *	Based on the line number set up the internal interrupt stuff.
 */
static void ev64420_irqinit(struct ev64420_serial *info)
{
init_int_timer(info->irq);
	return;
}


char *ev64420_drivername = "ColdFire internal UART serial driver version 1.00\n";




/* Finally, routines used to initialize the serial driver. */

static void show_serial_version(void)
{
	printk(ev64420_drivername);
}

static struct tty_operations ev64420_ops = {
	.open = ev64420_open,
	.close = ev64420_close,
	.write = ev64420_write,
	.write_room = ev64420_write_room,
};

/* ev64420_init inits the driver */
static int __init
ev64420_init(void)
{
	struct ev64420_serial	*info;
	unsigned long		flags;

	/* Setup base handler, and timer table. */
	ev64420_serial_driver = alloc_tty_driver(NR_PORTS);
	if (!ev64420_serial_driver)
		return -ENOMEM;

	show_serial_version();

	/* Initialize the tty_driver structure */
	ev64420_serial_driver->owner = THIS_MODULE;
	ev64420_serial_driver->name = "ttyS";
	ev64420_serial_driver->devfs_name = "ttys/";
	ev64420_serial_driver->driver_name = "serial";
	ev64420_serial_driver->major = TTY_MAJOR;
	ev64420_serial_driver->minor_start = 64;
	ev64420_serial_driver->type = TTY_DRIVER_TYPE_SERIAL;
	ev64420_serial_driver->subtype = SERIAL_TYPE_NORMAL;
	ev64420_serial_driver->init_termios = tty_std_termios;

	ev64420_serial_driver->init_termios.c_cflag =
		ev64420_console_cbaud | CS8 | CREAD | HUPCL | CLOCAL;
	ev64420_serial_driver->flags = TTY_DRIVER_REAL_RAW;

	tty_set_operations(ev64420_serial_driver, &ev64420_ops);

	if (tty_register_driver(ev64420_serial_driver)) {
		printk("MCFRS: Couldn't register serial driver\n");
		put_tty_driver(ev64420_serial_driver);
		return(-EBUSY);
	}

	local_irq_save(flags);

	/*
	 *	Configure all the attached serial ports.
	 */
		info = &ev64420_table;
		info->magic = SERIAL_MAGIC;
		info->line = 0;
		info->tty = 0;

		ev64420_irqinit(info);

		local_irq_restore(flags);
	return 0;
}

module_init(ev64420_init);

/****************************************************************************/
/*                          Serial Console                                  */
/****************************************************************************/

/*
 *	Quick and dirty UART initialization, for console output.
 */

void ev64420_init_console(void)
{

	return;
}


/*
 *	Setup for console. Argument comes from the boot command line.
 */

int ev64420_console_setup(struct console *cp, char *arg)
{

	if (!cp)
		return(-1);

	if (!strncmp(cp->name, "ttyS", 4))
		ev64420_console_port = cp->index;
	else if (!strncmp(cp->name, "cua", 3))
		ev64420_console_port = cp->index;
	else
		return(-1);

	ev64420_init_console(); /* make sure baud rate changes */
	return(0);
}


static struct tty_driver *ev64420_console_device(struct console *c, int *index)
{
	*index = c->index;
	return ev64420_serial_driver;
}



/*
 * rs_console_write is registered for printk output.
 */

void ev64420_console_write(struct console *cp, const char *p, unsigned len)
{
	if (!ev64420_console_inited)
		ev64420_init_console();
	while (len-- > 0) {
		if (*p == '\n')
			prom_putchar('\r');
		  prom_putchar(*p++);
	}
}

/*
 * declare our consoles
 */

struct console ev64420_console = {
	.name		= "ttyS",
	.write		= ev64420_console_write,
	.device		= ev64420_console_device,
	.setup		= ev64420_console_setup,
	.flags		= CON_PRINTBUFFER,
	.index		= -1,
};

static int __init ev64420_console_init(void)
{
	register_console(&ev64420_console);
	return 0;
}

console_initcall(ev64420_console_init);

/****************************************************************************/
