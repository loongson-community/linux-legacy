/*
 *	Based on the rtc-m41t80  driver
 *
 */

#include <linux/bcd.h>
#include <linux/i2c.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/rtc.h>
#include <linux/slab.h>
#include <linux/smp_lock.h>
#include <linux/string.h>
#include <linux/pci.h>
#include <linux/platform_device.h>

#include <i2c_oprate.h>	 

/* rtc time regs */
#define REG_SEC		2
#define REG_MIN 	3
#define REG_HOUR 	4
#define REG_WDAY	6
#define REG_DAY 	5
#define REG_MON		7
#define	REG_YEAR	8

/* alarm time regs */

/* control regs */
#define REG_CRT1	0xf
#define REG_CRT2	0x10	
#define REG_CRT3	0x11
#define REG_Time_Adjust	0x12
#define REG_TIMER	0x13

#define	WRTC1_BIT	7	/* belongs to REG_CRT2 */
#define WRTC2_BIT   2   /* belongs to REG_CRT1 */
#define WRTC3_BIT	7   /* belongs to REG_CRT1 */

/* general ram */
/*	0x14-0x1F 12bytes*/

#define REG_MAX		0x10

#define SM_VENDOR	0x126f
#define	SM_DEVICE	0x0501

#define SLAVE_ADDR	0xa2 /* i2c slave device addr */
#define	DRV_VERSION "0.01"


volatile char *mmio;
struct rtc_device *rtc = NULL;
static struct platform_device *rtc_test;

extern int i2c_write(u8 slave_addr, u8 index_addr, u8 value);
extern u8 i2c_read(u8 slave_addr, u8 index_addr);

static int pcf8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
{
	u8 buf[REG_MAX];
	int loop; 
#if 1	
	// buf[0..6]
	for(loop = REG_SEC; loop <= REG_SEC + 6; loop++)
		buf[loop] = i2c_read(SLAVE_ADDR, loop);

	tm->tm_sec = bcd2bin(buf[REG_SEC] & 0x7f);
	tm->tm_min = bcd2bin(buf[REG_MIN] & 0x7f);
	tm->tm_hour = bcd2bin(buf[REG_HOUR] & 0x3f);
	tm->tm_mday = bcd2bin(buf[REG_DAY] & 0x3f);
	tm->tm_wday = buf[REG_WDAY] & 0x07;
	tm->tm_mon = bcd2bin(buf[REG_MON] & 0x1f) - 1;

	/* assume 20YY not 19YY */
	tm->tm_year = bcd2bin(buf[REG_YEAR]) + 100;
#endif
#if 0	
	/* workaroud rtc problem */
	tm->tm_sec = 20;
	tm->tm_min = 45;
	tm->tm_hour = 22;
	tm->tm_mday = 12;
	tm->tm_wday = 6;
	tm->tm_mon	=	10;
	tm->tm_year = 190;
#endif
//	printk("tm_sec: %d, tm_min: %d, tm_hour %d, tm_mday %d, tm_wday %d, tm_mon: %d, tm_year: %d\n"
//		,tm->tm_sec,tm->tm_min, tm->tm_hour, tm->tm_mday, tm->tm_wday, tm->tm_mon, tm->tm_year);

	return 0;
}

/* Sets the given date and time to the real time clock. */
static int pcf8563_rtc_set_time(struct device *dev, struct rtc_time *tm)
{
	u8 buf[REG_MAX], tmp_reg = 0;
	int loop;

	for(loop = REG_SEC; loop <= REG_SEC + 6; loop++)
		buf[loop] = i2c_read(SLAVE_ADDR, loop);	
		
	buf[REG_SEC] =
		bin2bcd(tm->tm_sec) | (buf[REG_SEC] & ~0x7f);
	buf[REG_MIN] =
		bin2bcd(tm->tm_min) | (buf[REG_MIN] & ~0x7f);
	buf[REG_HOUR] =
		bin2bcd(tm->tm_hour) | (buf[REG_HOUR] & ~0x3f);
	buf[REG_WDAY] =
		(tm->tm_wday & 0x07) | (buf[REG_WDAY] & ~0x07);
	buf[REG_DAY] =
		bin2bcd(tm->tm_mday) | (buf[REG_DAY] & ~0x3f);
	buf[REG_MON] =
		bin2bcd(tm->tm_mon + 1) | (buf[REG_MON] & ~0x1f);
	/* assume 20YY not 19YY */
	buf[REG_YEAR] = bin2bcd(tm->tm_year % 100);

	for(loop = REG_SEC; loop <= REG_SEC + 6; loop++)
		i2c_write(SLAVE_ADDR, loop, buf[loop]);//buf[0..7]

	return 0;
}

static struct rtc_class_ops pcf8563_rtc_ops = {
	.read_time = pcf8563_rtc_read_time,
	.set_time = pcf8563_rtc_set_time,
//	.read_alarm = NULL,
//	.set_alarm = pcf8563_rtc_set_alarm,
//	.proc = pcf8563_rtc_proc,
//	.ioctl = pcf8563_rtc_ioctl,
};


/*
 *****************************************************************************
 *
 *	Driver Interface
 *
 *****************************************************************************
 */

static int pcf8563_probe(void)
{
	int rc = 0;
	struct pci_dev *dev;

	//get mmio_base_addr used by i2c
	dev = pci_get_device(SM_VENDOR, SM_DEVICE, NULL);
	if(!dev){
		printk("Can't find sm502, error\n");
		return -ENODEV; 
	}
	mmio = ioremap(pci_resource_start(dev, 1), pci_resource_len(dev, 1));

	rc = i2c_read(SLAVE_ADDR, REG_DAY);
	if(rc <= 0){
		printk("no such device\n");
		goto exit;
	}	
			
	rtc = rtc_device_register("rtc-9003", &rtc_test->dev,
				  &pcf8563_rtc_ops, THIS_MODULE);
	if (IS_ERR(rtc)) {
		rc = PTR_ERR(rtc);
		rtc = NULL;
		goto exit;
	}

	return 0;
exit:
	if (rtc)
		rtc_device_unregister(rtc);
	return rc;
}

static int __init pcf8563_rtc_init(void)
{
	rtc_test = platform_device_register_simple("lyn-9003",0, NULL, 0);
	if (!rtc_test) {
		printk("can't register platform device\n");	
		return -ENOMEM;
	}	
	return	pcf8563_probe();
}

static void __exit pcf8563_rtc_exit(void)
{
	if(rtc)
		rtc_device_unregister(rtc);
}

MODULE_AUTHOR("huhb <huhb@lemote.com>");
MODULE_DESCRIPTION("pcfg8563 rtc driver");
MODULE_LICENSE("GPL");
MODULE_VERSION(DRV_VERSION);

module_init(pcf8563_rtc_init);
module_exit(pcf8563_rtc_exit);
