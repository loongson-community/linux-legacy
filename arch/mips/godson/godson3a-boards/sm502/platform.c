#include <linux/device.h>
#include <linux/platform_device.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/resource.h>
#include <linux/serial_8250.h>
#include <asm/irq.h>


static struct plat_serial8250_port uart8250_data[] = {
{.uartclk = 3686400,  .mapbase=0x1ff003f8,.membase=(void *)0xffffffffbff003f8,.irq=MIPS_CPU_IRQ_BASE + 2,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
{}
};

static struct platform_device uart8250_device = {
	.name = "serial8250",
	.id = PLAT8250_DEV_PLATFORM,
 .dev = {
   .platform_data = uart8250_data,
	}
};


static struct platform_device *ls2f_sm502_platform_devices[] __initdata = {
	&uart8250_device,
};


int ls2f_sm502_platform_init(void)
{
	return platform_add_devices(ls2f_sm502_platform_devices, ARRAY_SIZE(ls2f_sm502_platform_devices));
}

arch_initcall(ls2f_sm502_platform_init);
