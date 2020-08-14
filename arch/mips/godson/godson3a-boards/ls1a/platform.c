/*
 * Platform device support for GS232 SoCs.
 *
 * Copyright 2009, Su Wen <suwen@ict.ac.cn>
 *	
 * base on Au1xxx Socs drivers by Matt Porter <mporter@kernel.crashing.org>
 *
 * This file is licensed under the terms of the GNU General Public
 * License version 2.  This program is licensed "as is" without any
 * warranty of any kind, whether express or implied.
 */
#include <linux/device.h>
#include <linux/platform_device.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/resource.h>
#include <ls2f1a.h>
#include <ls2f1a_int.h>
#include <linux/serial_8250.h>
#include <linux/mtd/mtd.h>
#include <linux/mtd/partitions.h>
#include <linux/delay.h>
#include <linux/stmmac.h>
#include <linux/phy.h>

struct ls1g_nand_platform_data{
    int enable_arbiter;
    struct mtd_partition *parts;
    unsigned int nr_parts;
};

static struct mtd_partition ls1g_nand_partitions[]={
    [0] = {
        .name   ="kernel",
        .offset =0,
        .size   =0x600000,
//        .mask_flags =   MTD_WRITEABLE,
    },
    [1] = {
        .name   ="os",
        .offset = 0x600000,
        .size   = 0x000000,
    
    },
};

static struct ls1g_nand_platform_data ls1g_nand_parts = {
        .enable_arbiter =   1,
        .parts          =   ls1g_nand_partitions,
        .nr_parts       =   ARRAY_SIZE(ls1g_nand_partitions),
    
};

static struct plat_serial8250_port uart8250_data[12] = {
{ .mapbase=0xb2e40000,.membase=(void *)0xb2e40000,.irq=2,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 2,},
//{ .mapbase=0xb2e40000,.membase=(void *)0xb2e40000,.irq=0,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,}, //yang23
#if 0
{ .mapbase=0xb2e44000,.membase=(void *)0xb2e44000,.irq=3,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
{ .mapbase=0xb2e48000,.membase=(void *)0xb2e48000,.irq=4,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
{ .mapbase=0xb2e4c000,.membase=(void *)0xb2e4c000,.irq=5,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
{ .mapbase=0xb2e6c000,.membase=(void *)0xb2e6c000,.irq=29,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
{ .mapbase=0xb2e7c000,.membase=(void *)0xb2e7c000,.irq=30,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
#ifdef CONFIG_MULTIFUNC_CONFIG_SERAIL0
{ .mapbase=0xb2e41000,.membase=(void *)0xb2e41000,.irq=SB2F_BOARD_UART0_IRQ,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
{ .mapbase=0xb2e42000,.membase=(void *)0xb2e42000,.irq=SB2F_BOARD_UART0_IRQ,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
{ .mapbase=0xb2e43000,.membase=(void *)0xb2e43000,.irq=SB2F_BOARD_UART0_IRQ,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
#endif
#ifdef CONFIG_MULTIFUNC_CONFIG_SERAIL1
{ .mapbase=0xb2e45000,.membase=(void *)0xb2e45000,.irq=SB2F_BOARD_UART0_IRQ,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
{ .mapbase=0xb2e46000,.membase=(void *)0xb2e46000,.irq=SB2F_BOARD_UART0_IRQ,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
{ .mapbase=0xb2e47000,.membase=(void *)0xb2e47000,.irq=SB2F_BOARD_UART0_IRQ,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,},
#endif
#endif
//{ .uartclk = 1843200, .mapbase=0xbff003f8,.membase=(void *)0xbff003f8,.irq=0,.flags=UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,.iotype=UPIO_MEM,.regshift   = 0,}, 
{}
};

static struct platform_device uart8250_device = {
	.name = "serial8250",
	.id = PLAT8250_DEV_PLATFORM,
 .dev = {
   .platform_data = uart8250_data,
	}
};

static struct resource sb2f_ahci_resources[] = { 
 [0] = {
   .start          = 0x12e30000,
   .end            = 0x12e30000+0x1ff,
   .flags          = IORESOURCE_MEM,
 },
 [1] = {
   .start          = 36,
   .end            = 36,
   .flags          = IORESOURCE_IRQ,
 },
};

static void __iomem *sb2f_ahci_map_table[6];

static struct platform_device sb2f_ahci_device = {
 .name           = "sb2f-ahci",
 .id             = -1,
 .dev = {
   .platform_data = sb2f_ahci_map_table,
 },
 .num_resources  = ARRAY_SIZE(sb2f_ahci_resources),
 .resource       = sb2f_ahci_resources,
};

/*
 * ohci
 */
static int dma_mask=-1;

static struct resource sb2f_ohci_resources[] = { 
 [0] = {
   .start          = SB2F_USB_OHCI_BASE,
   .end            = (SB2F_USB_OHCI_BASE + 0x1000 - 1),
   .flags          = IORESOURCE_MEM,
 },
 [1] = {
   .start          = SB2F_BOARD_OHCI_IRQ,
   .end            = SB2F_BOARD_OHCI_IRQ,
   .flags          = IORESOURCE_IRQ,
 },
};

static struct sb2f_usbh_data  sb2f_ohci_platform_data={
	.ports=4,
};

static struct platform_device sb2f_ohci_device = {
 .name           = "sb2f-ohci",
 .id             = -1,
 .dev = {
   .platform_data = &sb2f_ohci_platform_data,
   .dma_mask=&dma_mask,
   .coherent_dma_mask=-1,
 },
 .num_resources  = ARRAY_SIZE(sb2f_ohci_resources),
 .resource       = sb2f_ohci_resources,
};

/*
 * ehci
 */

static struct resource sb2f_ehci_resources[] = { 
 [0] = {
   .start          = SB2F_USB_EHCI_BASE,
   .end            = (SB2F_USB_EHCI_BASE + 0x6b),
   .flags          = IORESOURCE_MEM,
 },
 [1] = {
   .start          = SB2F_BOARD_EHCI_IRQ,
   .end            = SB2F_BOARD_EHCI_IRQ,
   .flags          = IORESOURCE_IRQ,
 },
};

static struct sb2f_usbh_data  sb2f_ehci_platform_data={
	.ports=4,
};

static struct platform_device sb2f_ehci_device = {
 .name           = "sb2f-ehci",
 .id             = -1,
 .dev = {
   .platform_data = &sb2f_ehci_platform_data,
   .dma_mask=&dma_mask,
   .coherent_dma_mask=-1,
 },
 .num_resources  = ARRAY_SIZE(sb2f_ehci_resources),
 .resource       = sb2f_ehci_resources,
};

/*
* watchdog
*/

static struct resource sb2f_wat_resource[] = {
	[0]={
		.start      = SB2F_BOARD_WAT_BASE,
		.end        = (SB2F_BOARD_WAT_BASE + 0x8),
		.flags      = IORESOURCE_MEM,
	},
};

static struct platform_device sb2f_wat_device = {
	.name       = "gs2fsb_wdt",
	.id         = -1,
	.num_resources  = ARRAY_SIZE(sb2f_wat_resource),
	.resource   = sb2f_wat_resource,
};

/*
*RTC
*/

static struct resource sb2f_rtc_resource[] = {
	[0]={
		.start      = SB2F_BOARD_RTC_BASE,
		.end        = (SB2F_BOARD_RTC_BASE + 0x54),
		.flags      = IORESOURCE_MEM,
	},
	[1]={
		.start      = SB2F_BOARD_TOY0_IRQ,
		.end        = SB2F_BOARD_TOY0_IRQ,
		.flags      = IORESOURCE_IRQ,
	},
};

static struct platform_device sb2f_rtc_device = {
	.name       = "sb2f-rtc",
	.id         = -1,
	.num_resources  = ARRAY_SIZE(sb2f_rtc_resource),
	.resource   = sb2f_rtc_resource,
};

/*
*I2C
*/

static struct resource sb2f_i2c_resource[] = {
	[0]={
		.start	= SB2F_BOARD_I2C_BASE,
		.end	= (SB2F_BOARD_I2C_BASE + 0x4),
		.flags	= IORESOURCE_MEM,
	},
	[1]={
		.start	= SB2F_BOARD_I2C0_IRQ,
		.end	= SB2F_BOARD_I2C0_IRQ,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device sb2f_i2c_device = {
	.name		= "sb2f-i2c",
	.id			= -1,
	.num_resources	= ARRAY_SIZE(sb2f_i2c_resource),
	.resource	= sb2f_i2c_resource,

};

/*
 * dc
 */

static struct platform_device sb2f_dc_device = {
 .name           = "sb2f-fb",
 .id             = -1,
};

/*
 * gmac
 */

static struct resource sb2f_gmac1_resources[] = { 
 [0] = {
   .start          = SB2F_BOARD_GMAC1_BASE,
   .end            = (SB2F_BOARD_GMAC1_BASE + 0x6b),
   .flags          = IORESOURCE_MEM,
 },
 [1] = {
   .start          = SB2F_BOARD_GMAC1_IRQ,
   .end            = SB2F_BOARD_GMAC1_IRQ,
   .flags          = IORESOURCE_IRQ,
 },
};

static struct platform_device sb2f_gmac1_device = {
 .name           = "sb2f-gmac",
 .id             = 1,
 .dev = {
   .dma_mask=&dma_mask,
   .coherent_dma_mask=-1,
 },
 .num_resources  = ARRAY_SIZE(sb2f_gmac1_resources),
 .resource       = sb2f_gmac1_resources,
};


static struct resource sb2f_gmac2_resources[] = { 
 [0] = {
   .start          = SB2F_BOARD_GMAC2_BASE,
   .end            = (SB2F_BOARD_GMAC2_BASE + 0x6b),
   .flags          = IORESOURCE_MEM,
 },
 [1] = {
   .start          = SB2F_BOARD_GMAC2_IRQ,
   .end            = SB2F_BOARD_GMAC2_IRQ,
   .flags          = IORESOURCE_IRQ,
 },
};

static struct platform_device sb2f_gmac2_device = {
 .name           = "sb2f-gmac",
 .id             = 2,
 .dev = {
   .dma_mask=&dma_mask,
   .coherent_dma_mask=-1,
 },
 .num_resources  = ARRAY_SIZE(sb2f_gmac2_resources),
 .resource       = sb2f_gmac2_resources,
};
static struct resource ls1g_nand_resources[] = {
    [0] = {
        .start      =0,
        .end        =0,
        .flags      =IORESOURCE_DMA,    
    },
    [1] = {
        .start      =0x12e78000,
        .end        =0x12e78020,
        .flags      =IORESOURCE_MEM,
    },
    [2] = {
        .start      =0x12d01160,
        .end        =0x12d01160,
        .flags      =IORESOURCE_MEM,
    },
    [3] = {
        .start      =SB2F_BOARD_DMA0_IRQ,
        .end        =SB2F_BOARD_DMA0_IRQ,
        .flags      =IORESOURCE_IRQ,
    },
};

static struct platform_device ls1g_nand_device = {
    .name       ="ls1g-nand",
    .id         =-1,
    .dev        ={
        .platform_data = &ls1g_nand_parts,
   	.dma_mask=&dma_mask,
	.coherent_dma_mask=-1,
    },
    .num_resources  =ARRAY_SIZE(ls1g_nand_resources),
    .resource       =ls1g_nand_resources,
};

static struct platform_device sb2f_audio_device = {
 .name           = "sb2f-audio",
 .id             = -1,
};


/*
 * stmac
 */

static struct resource ls1b_eth0_stmac_resources[] = { 
 [0] = {
   .start          = SB2F_BOARD_GMAC1_BASE,
   .end            = (SB2F_BOARD_GMAC1_BASE + 0x6b),
   .flags          = IORESOURCE_MEM,
 },
 [1] = {
   .name	= "macirq",
   .start          = SB2F_BOARD_GMAC1_IRQ,
   .end            = SB2F_BOARD_GMAC1_IRQ,
   .flags          = IORESOURCE_IRQ,
 },
};


static struct stmmac_mdio_bus_data ls1b_eth0_mdio_bus_data = {
	.bus_id		= 0,
	.phy_mask	= 0,
};

static struct plat_stmmacenet_data ls1b_eth0_data = {
	.bus_id		= 0,
	.phy_addr	= -1,
	.mdio_bus_data	= &ls1b_eth0_mdio_bus_data,
	.pbl		= 32,
	.has_gmac	= 1,
	.tx_coe		= 1,
	.interface = PHY_INTERFACE_MODE_GMII,
};

static struct platform_device ls1b_eth0_device = {
	.name		= "stmmaceth",
	.id		= 0,
	.num_resources	= ARRAY_SIZE(ls1b_eth0_stmac_resources),
	.resource	= ls1b_eth0_stmac_resources,
	.dev		= {
		.platform_data = &ls1b_eth0_data,
	},
};

static struct resource ls1b_eth1_stmac_resources[] = { 
 [0] = {
   .start          = SB2F_BOARD_GMAC2_BASE,
   .end            = (SB2F_BOARD_GMAC2_BASE + 0x6b),
   .flags          = IORESOURCE_MEM,
 },
 [1] = {
   .name	= "macirq",
   .start          = SB2F_BOARD_GMAC2_IRQ,
   .end            = SB2F_BOARD_GMAC2_IRQ,
   .flags          = IORESOURCE_IRQ,
 },
};

static struct stmmac_mdio_bus_data ls1b_eth1_mdio_bus_data = {
	.bus_id		= 0,
	.phy_mask	= 0,
};

static struct plat_stmmacenet_data ls1b_eth1_data = {
	.bus_id		= 0,
	.phy_addr	= -1,
	.mdio_bus_data	= &ls1b_eth1_mdio_bus_data,
	.pbl		= 32,
	.has_gmac	= 1,
	.tx_coe		= 1,
	.interface = PHY_INTERFACE_MODE_GMII,
};

static struct platform_device ls1b_eth1_device = {
	.name		= "stmmaceth",
	.id		= 1,
	.num_resources	= ARRAY_SIZE(ls1b_eth1_stmac_resources),
	.resource	= ls1b_eth1_stmac_resources,
	.dev		= {
		.platform_data = &ls1b_eth1_data,
	},
};


static struct platform_device *sb2f_platform_devices[] __initdata = {
	&ls1g_nand_device,
	&uart8250_device,
	&sb2f_ahci_device,
	&sb2f_ohci_device,
	&sb2f_ehci_device,
//	&sb2f_dc_device,
	&sb2f_gmac1_device,
//	&ls1b_eth0_device,
//    &sb2f_gmac2_device,
//	&sb2f_wat_device,
//	&sb2f_rtc_device,
//	&sb2f_i2c_device,
	&sb2f_audio_device
};

#define AHCI_PCI_BAR  5

static int sb2f_platform_init(void)
{
	unsigned char data;
	int pll,ctrl,clk,i;
	unsigned int ddr_clk,uart_clk;

	sb2f_ahci_map_table[AHCI_PCI_BAR]=ioremap_nocache(sb2f_ahci_resources[0].start,0x200);

	*(volatile int *)0xb2f10204 = 0;
	*(volatile int *)0xb2f10204;
	mdelay(1);
	/*ls1f usb reset stop*/
	*(volatile int *)0xb2f10204 = 0x40000000;
	*(volatile int *)0xb2f10204;

//	*(volatile int *)0xb2d01114 = 0x238a0;
	/*ls1a adjust sata phy clock added by menghaibo*/
	*(volatile int *)0xb2d00424 |= 0x80000000;
	*(volatile int *)0xb2d00418  = 0x38682650;
	*(volatile int *)0xb2e30000 &= 0x0;

#ifdef CONFIG_MULTIFUNC_CONFIG_SERAIL0
	(*(volatile unsigned char *)(SB2F_UART_SPLIT)) = 0x1;
#endif
#ifdef CONFIG_MULTIFUNC_CONFIG_SERAIL1
	data = (*(volatile unsigned char *)(SB2F_UART_SPLIT));
	(*(volatile unsigned char *)(SB2F_UART_SPLIT)) = data | 0x2;

	data = (*(volatile unsigned int *)(SB2F_GPIO_MUX_CTRL1));
	(*(volatile unsigned int *)(SB2F_GPIO_MUX_CTRL1))= data | 0x30;
#endif

//	pll	= *(volatile unsigned int *)(0xb2e78030);
        //ddr_clk  =  (((pll>>8)&7)+3)*33333333;
        ddr_clk  =  5*25000000;
	for(i=0; i<12; i++)
		uart8250_data[i].uartclk = ddr_clk/2;
	return platform_add_devices(sb2f_platform_devices, ARRAY_SIZE(sb2f_platform_devices));
}

arch_initcall(sb2f_platform_init);
