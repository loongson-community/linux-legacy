/*
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
 * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
 */
#include <linux/module.h>
#include <linux/init.h>
#include <linux/serial_8250.h>

#ifdef CONFIG_64BIT
#define	UART_BASE  (void*)0xffffffffbff003f8
#else
#define	UART_BASE  (void*)0xbff003f8
#endif	

#define PORT(base, int)							\
{									\
	.iobase		= base,						\
	.irq		= int,						\
	.uartclk	= 1843200,					\
	.iotype		= UPIO_PORT,					\
	.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,		\
	.regshift	= 0,						\
}

static struct plat_serial8250_port uart8250_data[] = {
#ifdef CONFIG_MACH_LM2F
#if defined(CONFIG_LEMOTE_NAS) || defined(CONFIG_LEMOTE_2FNOTEBOOK) || defined(CONFIG_LEMOTE_LYNLOONG_9003)
	{ .membase = UART_BASE,
	  .irq = MIPS_CPU_IRQ_BASE + 3,
	  .uartclk = 3686400,
	  .iotype = UPIO_MEM,
	  .flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
	  .regshift = 0,
	},
#else
	PORT(0x2F8, 3),
#endif
#else
	PORT(0x3F8, 4),
	PORT(0x2F8, 3),
	PORT(0x3E8, 4),
	PORT(0x2E8, 3),
#endif
	{ },
};

static struct platform_device uart8250_device = {
	.name			= "serial8250",
	.id			= PLAT8250_DEV_PLATFORM,
	.dev			= {
		.platform_data	= uart8250_data,
	},
};

static int __init uart8250_init(void)
{
	return platform_device_register(&uart8250_device);
}

module_init(uart8250_init);

MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Generic 8250 UART probe driver");
