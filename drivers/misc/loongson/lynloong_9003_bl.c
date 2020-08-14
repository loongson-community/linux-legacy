/*
 *  LynLoong Backlight Driver
 */

#include <linux/init.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/backlight.h>
#include <linux/interrupt.h>
#include <linux/spinlock.h>
#include <linux/irq.h>
#include <linux/fb.h>
#include <linux/sm501.h>
#include <linux/sm501_regs.h>
#include <linux/pci.h>
#include <linux/delay.h>

#include <asm/io.h>

#define SM_VENDOR   0x126f
#define SM_DEVICE   0x0501

#define MAX_HZ       	96000000 /* 96MHz */
#define FREQ			(MAX_HZ/20000) /* 20k */

#define MAX_BRIGHTNESS 100
#define MIN_BRIGHTNESS 0

/*  accept input parameter,default 50 */
uint level = 50;
module_param(level, uint, S_IRUGO);

static volatile void *pwm_base = NULL;

u32 pwm_read32(u32 nOffset)
{
	return readl(pwm_base + nOffset);
}

void pwm_write32(u32 nOffset, u32 nData)
{
	writel(nData, pwm_base + nOffset);
}

static int pwm_config(u32 duty_cycle, u64 total_clock)
{
	unsigned int high, low, divider;
	int divider1, divider2;
	u32 reg;

	if (duty_cycle == 0 || duty_cycle == 100 || total_clock <=0 )
		return -EINVAL;

	/* Get the number of clock low and high */
	high =  total_clock * duty_cycle / 100;
	low = total_clock * (100 - duty_cycle) / 100;
		
	/* Get divider to make 'low' and 'high' fit into 12 bits */
	/* No need to say that the divider must be >= 0 */
	divider1 = fls(low)-12;
	divider2 = fls(high)-12;

	if (divider1 < 0)
		divider1 = 0;
	if (divider2 < 0)
		divider2 = 0;

	divider = max(divider1, divider2);

	low >>= divider;
	high >>= divider;

	reg = pwm_read32(PWM0);
	reg &= 0x5;
	pwm_write32(PWM0, (high<<20)|(low<<8)|(divider<<4)|reg);
	return 0;
}

void open_lcd(void)
{
	u32 reg;
	int count = 30;

	do{
		reg = pwm_read32(GPIO_DATA_HIGH);
		reg |= 0x3;
	    reg &= ~0x1;
		mdelay(1);
		pwm_write32(GPIO_DATA_HIGH, reg);
		reg = pwm_read32(GPIO_DATA_HIGH);
		if(!count--){
			printk(KERN_ERR"Error:Can not open backlight\n");
			break;
		}
	}while(!(reg & 0x2));
}
EXPORT_SYMBOL(open_lcd);

void close_lcd(void)
{
	u32 reg;

	reg = pwm_read32(GPIO_DATA_HIGH);
	reg |= 0x3;
    reg &= ~0x2;
	pwm_write32(GPIO_DATA_HIGH, reg);
}
EXPORT_SYMBOL(close_lcd);

static int lynloong_set_brightness(struct backlight_device *bd)
{
	uint level;

	/* brightnees level <-> duty cycle */
	/* 0 -> ? 1%
	 * 1 -> ? 1%
	 * 2 -> ? 2%
	 * 3 -> ? 
	 * 4 -> ?
	 * .........
	 * 100 -> 99%
	 */
	level = (bd->props.fb_blank == FB_BLANK_UNBLANK &&
		 bd->props.power == FB_BLANK_UNBLANK) ?
	    bd->props.brightness : 0;

	if (level >= MAX_BRIGHTNESS)
		level = MAX_BRIGHTNESS - 1;
	else if (level < MIN_BRIGHTNESS)
		level = MIN_BRIGHTNESS;

	if (level == 0)
		pwm_config(1, FREQ);
	else 
	    pwm_config(level, FREQ);

	return 0;
}

static int lynloong_get_brightness(struct backlight_device *bd)
{
	return level;
}

static struct backlight_ops lynloong_ops = {
	.get_brightness = lynloong_get_brightness,
	.update_status = lynloong_set_brightness,
};

static struct backlight_device *lynloong_backlight_device;

static void __exit lynloong_exit(void)
{
	u32 reg;

	if (lynloong_backlight_device)
		backlight_device_unregister(lynloong_backlight_device);

	/* Disable gpio29 to control brightness */
	reg = pwm_read32(GPIO_CONTROL_LOW);
	reg &= ~(1<<29);
	pwm_write32(GPIO_CONTROL_LOW, reg);
	/* Disalbe pwm0 */
    pwm_write32(PWM0, 0);
	printk(KERN_INFO "exit from LingLoong Backlight Driver\n");
}

static int __init lynloong_init(void)
{
	int ret;
	u32 reg;
	struct pci_dev *dev; 

    /* Get mmio_base_addr */
    dev = pci_get_device(SM_VENDOR, SM_DEVICE, NULL);
    if(!dev){
        printk("Can't find sm502, error\n");
        return -ENODEV;
    }
    pwm_base = ioremap(pci_resource_start(dev, 1), pci_resource_len(dev, 1));

	/* Enable pwm0 as gpio29 to control brightness */
	pwm_write32(PWM0, 0x1);
	reg = pwm_read32(GPIO_CONTROL_LOW);
	reg |= (1<<29);
	pwm_write32(GPIO_CONTROL_LOW, reg);

	lynloong_backlight_device =
	    backlight_device_register("lynloong_backlight", NULL, NULL,
				      &lynloong_ops);

	if (IS_ERR(lynloong_backlight_device)) {
		ret = PTR_ERR(lynloong_backlight_device);
		lynloong_backlight_device = NULL;
		lynloong_exit();
		return ret;
	}

	lynloong_backlight_device->props.max_brightness = MAX_BRIGHTNESS;
	lynloong_backlight_device->props.brightness =
	    lynloong_get_brightness(lynloong_backlight_device);
	backlight_update_status(lynloong_backlight_device);

	return 0;
}

module_init(lynloong_init);
module_exit(lynloong_exit);

MODULE_AUTHOR("huhb <huhb@lemote.com>");
MODULE_DESCRIPTION("LynLoong backlight driver");
MODULE_LICENSE("GPL");
