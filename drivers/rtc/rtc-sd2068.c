/*
 *	Based on the rtc-m41t80 driver
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
#include <linux/delay.h>

#define REG_MAX		0x10

#define SM_VENDOR	0x126f
#define	SM_DEVICE	0x0501

#define	DRV_VERSION "0.01"
#define RTC_NAME	"rtc-sd2068"

volatile char *mmio;
struct rtc_device *rtc = NULL;
static struct platform_device *rtc_test;

static void  sd2068_read_time(struct rtc_time *tm)
{
	u8 buf[REG_MAX];
	int tm_hour;

	i2c_rtc_read(&buf[0]);

	if(buf[REG_HOUR] >> 7){ /* 24-hour */
	//	printk(KERN_DEBUG"RTC use 24-hours\n");
		tm_hour = bcd2bin(buf[REG_HOUR] & 0x3f);
	}else{ 		/* 12-hour */
		printk(KERN_DEBUG"RTC use 12-hours,maybe time is wrong\n");
		if(buf[REG_HOUR] >> 6)	/* PM */
			if(bcd2bin(buf[REG_HOUR] & 0x1f) == 12) /* 12:00:00 no need to +12 */
				tm_hour = bcd2bin(buf[REG_HOUR] & 0x1f);
			else
				tm_hour = bcd2bin(buf[REG_HOUR] & 0x1f) + 12;
		else	/* AM */
	    	tm_hour = bcd2bin(buf[REG_HOUR] & 0x1f);
	}

	tm->tm_sec = bcd2bin(buf[REG_SEC] & 0x7f);
	tm->tm_min = bcd2bin(buf[REG_MIN] & 0x7f);
	tm->tm_hour = tm_hour;
	tm->tm_mday = bcd2bin(buf[REG_DAY] & 0x3f);
	tm->tm_wday = buf[REG_WDAY] & 0x07;
	tm->tm_mon = bcd2bin(buf[REG_MON] & 0x1f) - 1;
	/* assume 1950 - 2049 */
	tm->tm_year = bcd2bin(buf[REG_YEAR]);
	if(tm->tm_year < 50)
		tm->tm_year += 100;
}

unsigned long sd2068_get_time(void)
{
	struct rtc_time tm;

	sd2068_read_time(&tm);
	if(rtc_valid_tm(&tm)){
        printk(KERN_ERR"get time is not valid\n");
        return 0;
    }
	tm.tm_year = ((tm.tm_year) < 70 ? (tm.tm_year) + 2000 : (tm.tm_year) + 1900);

	return mktime(tm.tm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
}
EXPORT_SYMBOL(sd2068_get_time);

static int sd2068_rtc_read_time(struct device *dev, struct rtc_time *tm)
{
	sd2068_read_time(tm);

	return 0;
}

/* Sets the given date and time to the real time clock. */
static int sd2068_rtc_set_time(struct device *dev, struct rtc_time *tm)
{
	u8 buf[REG_MAX];

	if((tm->tm_sec >= 59) && (tm->tm_min >= 59)){ /* overflow 60 sec */
		tm->tm_sec = 59;
		tm->tm_min = 59;
		goto no_fix_time;
	}else if(tm->tm_sec >= 59){ /* overflow 60 sec */
		msleep(490);
		tm->tm_sec = 0;
		tm->tm_min += 1;
		goto no_fix_time;
	}
	msleep(490);
	tm->tm_sec += 1;

no_fix_time:
	buf[REG_SEC] = bin2bcd(tm->tm_sec);
	buf[REG_MIN] = bin2bcd(tm->tm_min);
	buf[REG_HOUR] =	bin2bcd(tm->tm_hour) | 0x80; /* use 24-hours */
	buf[REG_WDAY] =	tm->tm_wday;
	buf[REG_DAY] = bin2bcd(tm->tm_mday);
	buf[REG_MON] = bin2bcd(tm->tm_mon + 1);
	buf[REG_YEAR] = bin2bcd(tm->tm_year % 100);

	if(rtc_valid_tm(tm)){
		printk(KERN_ERR"Set time is not valid \n");
		return -EINVAL;
	}
	
	i2c_rtc_write(&buf[0]);

	return 0;
}

static struct rtc_class_ops sd2068_rtc_ops = {
	.read_time = sd2068_rtc_read_time,
	.set_time = sd2068_rtc_set_time,
};


/*
 *****************************************************************************
 *
 *	Driver Interface
 *
 *****************************************************************************
 */

static int sd2068_probe(void)
{
	int rc = 0;
	struct pci_dev *dev;

	/* Get mmio_base_addr used by i2c */
	dev = pci_get_device(SM_VENDOR, SM_DEVICE, NULL);
	if(!dev){
		printk("Can't find sm502, error\n");
		return -ENODEV; 
	}
	mmio = ioremap(pci_resource_start(dev, 1), pci_resource_len(dev, 1));

	rtc = rtc_device_register(RTC_NAME, &rtc_test->dev,
				  &sd2068_rtc_ops, THIS_MODULE);
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

static int __init sd2068_rtc_init(void)
{
	rtc_test = platform_device_register_simple("lyn-9003",0, NULL, 0);
	if (!rtc_test) {
		printk("can't register platform device\n");	
		return -ENOMEM;
	}	
	return	sd2068_probe();
}

static void __exit sd2068_rtc_exit(void)
{
	if(rtc)
		rtc_device_unregister(rtc);
}

module_init(sd2068_rtc_init);
module_exit(sd2068_rtc_exit);

MODULE_AUTHOR("huhb <huhb@lemote.com>");
MODULE_DESCRIPTION("SD2068 rtc driver");
MODULE_LICENSE("GPL");
MODULE_VERSION(DRV_VERSION);
