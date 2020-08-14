/*
 *  Driver for YeeLoong laptop extras
 *
 *  Copyright (C) 2009 Lemote Inc.
 *  Author: Wu Zhangjin <wuzj@lemote.com>
 *   
 *  Hongbing Hu <huhb@lemote.com>  Add the battery driver
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License version 2 as
 *  published by the Free Software Foundation.
 */

#include <linux/module.h>
#include <linux/backlight.h>
#include <linux/err.h>
#include <linux/fb.h>
#include <linux/interrupt.h>
#include <linux/jiffies.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/slab.h>
#include <linux/spinlock.h>
#include <linux/pm.h>
#include <linux/platform_device.h>
#include <linux/power_supply.h>
#include <linux/thermal.h>
#include <linux/workqueue.h>
#include <linux/video_output.h>

#include "ec.h"

/*
 * Battery driver
 */
 
#define BIT_BAT_POWER_ACIN       (1 << 0)        // adapter is inserted

#define APM_AC_OFFLINE          0
#define APM_AC_ONLINE           1
#define APM_AC_BACKUP           2
#define APM_AC_UNKNOWN          0xff

#define APM_BATTERY_STATUS_HIGH     0
#define APM_BATTERY_STATUS_LOW      1
#define APM_BATTERY_STATUS_CRITICAL 2
#define APM_BATTERY_STATUS_CHARGING 3
#define APM_BATTERY_STATUS_NOT_PRESENT  4
#define APM_BATTERY_STATUS_UNKNOWN  0xff

struct yeeloong_power_info {
	unsigned int ac_in;	/* AC insert or no */
	unsigned int bat_in;	/* Battery insert or no */

	/* we use capacity for caculating the life and time */
	unsigned int curr_cap;

	/* battery designed capacity */
	unsigned int design_cap;
	/* battery designed voltage */
	unsigned int design_vol;
	/* battery capacity after full charged */
	unsigned int full_charged_cap;
	/* battery vendor number */
	unsigned char vendor;
	/* battery cell count */
	unsigned char cell_count;

	/* battery dynamic charge/discharge voltage */
	unsigned int voltage_now;
	/* battery dynamic charge/discharge  current */
	int current_now;
	/* battery current temperature */
	unsigned int temperature;
	unsigned int remain_time;
	unsigned int health;
	unsigned int charge_status;
};

struct yeeloong_power_info *power_info;

static struct power_supply  yeeloong_ac, yeeloong_bat;

/**********************************************************
 *		Get power supply status 		  *	
 **********************************************************/
static void  yeeloong_read_bat_status(void)
{
    	unsigned int  charge, status, health, state;

	/* fixed value */
	power_info->design_cap =  (ec_read(REG_BAT_DESIGN_CAP_HIGH) << 8)
                | ec_read(REG_BAT_DESIGN_CAP_LOW);
	power_info->design_vol = (ec_read(REG_BAT_DESIGN_VOL_HIGH) << 8)
                | ec_read(REG_BAT_DESIGN_VOL_LOW); 
	power_info->full_charged_cap = (ec_read(REG_BAT_FULLCHG_CAP_HIGH) << 8)
                | ec_read(REG_BAT_FULLCHG_CAP_LOW);
        
	/* dynamic value */
	power_info->voltage_now = (ec_read(REG_BAT_VOLTAGE_HIGH) << 8) 
		| (ec_read(REG_BAT_VOLTAGE_LOW));
    	power_info->current_now = (ec_read(REG_BAT_CURRENT_HIGH) << 8) 
		| (ec_read(REG_BAT_CURRENT_LOW));
	if(power_info->current_now & 0x8000)
	    power_info->current_now = 0xffff - power_info->current_now;
    power_info->temperature = (ec_read(REG_BAT_TEMPERATURE_HIGH) << 8) 
		| (ec_read(REG_BAT_TEMPERATURE_LOW));
 	power_info->curr_cap = (ec_read(REG_BAT_RELATIVE_CAP_HIGH) << 8)
		| (ec_read(REG_BAT_RELATIVE_CAP_LOW));
    	power_info->ac_in = ((ec_read(REG_BAT_POWER)) & BIT_BAT_POWER_ACIN) 
		? APM_AC_ONLINE : APM_AC_OFFLINE;

	status = ec_read(REG_BAT_STATUS);
	charge = ec_read(REG_BAT_CHARGE);
	health = ec_read(REG_BAT_CHARGE_STATUS);
	state  = ec_read(REG_BAT_STATE); /* This register is no need ? */

	power_info->bat_in = status & BIT_BAT_STATUS_IN;
	if(power_info->bat_in) /* we assume that the health is good */
		power_info->health = POWER_SUPPLY_HEALTH_GOOD;
	else{	/* no battery present */
		power_info->health = POWER_SUPPLY_HEALTH_UNKNOWN;
		power_info->charge_status = POWER_SUPPLY_STATUS_UNKNOWN;
	}

	if(status & (BIT_BAT_STATUS_DESTROY | BIT_BAT_STATUS_LOW))
		power_info->health = POWER_SUPPLY_HEALTH_DEAD;
	if(status & BIT_BAT_STATUS_FULL ){
		power_info->charge_status = POWER_SUPPLY_STATUS_FULL;
		power_info->curr_cap = 100;
	}
	
	if(health & BIT_BAT_CHARGE_STATUS_OVERTEMP)
		power_info->health = POWER_SUPPLY_HEALTH_OVERHEAT;
	
	if(charge & FLAG_BAT_CHARGE_DISCHARGE)
		power_info->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
	else if (charge & FLAG_BAT_CHARGE_CHARGE)
		power_info->charge_status = POWER_SUPPLY_STATUS_CHARGING;
}

/*********************************************************************
 *		Power properties
 *********************************************************************/

static int yeeloong_get_ac_prop(struct power_supply *psy,
			   enum power_supply_property psp,
			   union power_supply_propval *val)
{
	switch (psp) {
	case POWER_SUPPLY_PROP_ONLINE:
		val->intval = power_info->ac_in;
		break;
	default:
		return -EINVAL;
	}

	return 0;
}

static enum power_supply_property yeeloong_ac_props[] = {
	POWER_SUPPLY_PROP_ONLINE,
};

static struct power_supply yeeloong_ac = {
	.name = "yeeloong-ac",
	.type = POWER_SUPPLY_TYPE_MAINS,
	.properties = yeeloong_ac_props,
	.num_properties = ARRAY_SIZE(yeeloong_ac_props),
	.get_property = yeeloong_get_ac_prop,
};

/*********************************************************************
 *		Battery properties
 *********************************************************************/

static int yeeloong_bat_get_property(struct power_supply *psy,
				enum power_supply_property psp,
				union power_supply_propval *val)
{
	
	unsigned int ac_in, bat_in;

	ac_in = power_info->ac_in;
	bat_in = power_info->bat_in;
	yeeloong_read_bat_status();
	if(ac_in != power_info->ac_in)
		power_supply_changed(&yeeloong_ac);
	if(bat_in != power_info->bat_in)
		power_supply_changed(&yeeloong_bat);
	
	switch (psp) {
	case POWER_SUPPLY_PROP_STATUS:
		val->intval = power_info->charge_status;
		break;
	case POWER_SUPPLY_PROP_PRESENT:
		val->intval = power_info->bat_in; 
		break;
	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
		val->intval = power_info->design_vol * 1000; /* mV -> µV */
		break;
	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
		val->intval = power_info->design_cap * 1000; /* mA -> µA */
		break;
	case POWER_SUPPLY_PROP_CHARGE_FULL:
		val->intval = power_info->full_charged_cap * 1000;/* µA */
		break;
	case POWER_SUPPLY_PROP_HEALTH:
		val->intval = power_info->health;
		break;
	case POWER_SUPPLY_PROP_CURRENT_NOW:
		val->intval = power_info->current_now * 1000; /* mA -> µA */
		break;
	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
		val->intval =  power_info->voltage_now * 1000; /* mV -> µV */
		break;
	case POWER_SUPPLY_PROP_CAPACITY:
		val->intval = power_info->curr_cap;	/* percentage */
		break;	
	case POWER_SUPPLY_PROP_TEMP:
		val->intval = power_info->temperature;	 /* Celcius */
		break;
	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW: 
	/* calculate the remain time, maybe it is wrong */
    		if(power_info->bat_in != APM_BATTERY_STATUS_NOT_PRESENT)
               		power_info->remain_time = ((power_info->curr_cap - 3) * 54 + 142) / 60;
        	else
                	power_info->remain_time = 0x00;
		val->intval = power_info->remain_time * 60;  /* units sec */
		break;
	default:
		return -EINVAL;
	}

	return 0;
}

static enum power_supply_property yeeloong_bat_props[] = {
	POWER_SUPPLY_PROP_STATUS,
	POWER_SUPPLY_PROP_PRESENT,
	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
	POWER_SUPPLY_PROP_CURRENT_NOW,
	POWER_SUPPLY_PROP_VOLTAGE_NOW,
	POWER_SUPPLY_PROP_HEALTH,
	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
	POWER_SUPPLY_PROP_CAPACITY,
	POWER_SUPPLY_PROP_TEMP,
};

static struct power_supply  yeeloong_bat = {	
	.name = "yeeloong-bat",
	.type = POWER_SUPPLY_TYPE_BATTERY,
	.properties = yeeloong_bat_props,
	.num_properties = ARRAY_SIZE(yeeloong_bat_props),
	.get_property = yeeloong_bat_get_property,
};

/*
 * End battery driver
 */

#define MAX_BRIGHTNESS 8
#define DEFAULT_BRIGHTNESS (MAX_BRIGHTNESS - 1)

static int yeeloong_set_brightness(struct backlight_device *bd)
{
	unsigned int level, current_level;
	static unsigned int old_level;

	level = (bd->props.fb_blank == FB_BLANK_UNBLANK &&
		 bd->props.power == FB_BLANK_UNBLANK) ?
				bd->props.brightness : 0;

	if (level > MAX_BRIGHTNESS)
		level = MAX_BRIGHTNESS;
	else if (level < 0)
		level = 0;

	/* avoid tune the brightness when the EC is tuning it */
	current_level = ec_read(REG_DISPLAY_BRIGHTNESS);
//	if ((old_level == current_level) && (old_level != level))
	if (old_level != level)
		ec_write(REG_DISPLAY_BRIGHTNESS, level);
	old_level = level;

	return 0;
}

static int yeeloong_get_brightness(struct backlight_device *bd)
{
	return (int)ec_read(REG_DISPLAY_BRIGHTNESS);
}

static struct backlight_ops yeeloong_ops = {
	.get_brightness = yeeloong_get_brightness,
	.update_status  = yeeloong_set_brightness,
};

static struct backlight_device *yeeloong_backlight_device;


/*
 * Hwmon
 */

/* fan speed divider */
#define	FAN_SPEED_DIVIDER		480000	/* (60*1000*1000/62.5/2)*/

/* pwm(auto/manual) enable or not */
static int yeeloong_get_fan_pwm_enable(void)
{
	int value = 0;

	/* This get the fan control method: auto or manual */
	value = ec_read(0xf459);

	return value;
}

static void yeeloong_set_fan_pwm_enable(int manual)
{
	if (manual)
		ec_write(0xf459, 1);
	else
		ec_write(0xf459, 0);
}

static int yeeloong_get_fan_pwm(void)
{
	/* fan speed level */
	return ec_read(0xf4cc);
}

static void yeeloong_set_fan_pwm(int value)
{
	int status;

	/* need to ensure the level?? */
	printk(KERN_INFO "fan pwm, value = %d\n", value);

	value = SENSORS_LIMIT(value, 0, 3);

	/* if value is not ZERO, we should ensure it is on */
	if (value != 0) {
		status = ec_read(0xf4da);
		if (status == 0)
			ec_write(0xf4d2, 1);
	}
	/* 0xf4cc is for writing */
	ec_write(0xf4cc, value);
}

static int yeeloong_get_fan_rpm(void)
{
	int value = 0;

	value = FAN_SPEED_DIVIDER /
		    (((ec_read(REG_FAN_SPEED_HIGH) & 0x0f) << 8) |
		     ec_read(REG_FAN_SPEED_LOW));

	return value;
}

/* Thermal subdriver
 */

static int yeeloong_get_cpu_temp(void)
{
	int value;

	value = ec_read(REG_TEMPERATURE_VALUE);

	if (value & (1 << 7))
		value = (value & 0x7f) - 128;
	else
		value = value & 0xff;

	return value * 1000;
}

static int parse_arg(const char *buf, unsigned long count, int *val)
{
	if (!count)
		return 0;
	if (sscanf(buf, "%i", val) != 1)
		return -EINVAL;
	return count;
}

static ssize_t store_sys_hwmon(void (*set)(int), const char *buf, size_t count)
{
	int rv, value;

	rv = parse_arg(buf, count, &value);
	if (rv > 0)
		set(value);
	return rv;
}

static ssize_t show_sys_hwmon(int (*get)(void), char *buf)
{
	return sprintf(buf, "%d\n", get());
}


#define CREATE_SENSOR_ATTR(_name, _mode, _set, _get)		\
	static ssize_t show_##_name(struct device *dev,			\
				    struct device_attribute *attr,	\
				    char *buf)				\
	{								\
		return show_sys_hwmon(_set, buf);			\
	}								\
	static ssize_t store_##_name(struct device *dev,		\
				     struct device_attribute *attr,	\
				     const char *buf, size_t count)	\
	{								\
		return store_sys_hwmon(_get, buf, count);		\
	}								\
	static SENSOR_DEVICE_ATTR(_name, _mode, show_##_name, store_##_name, 0);

CREATE_SENSOR_ATTR(fan1_input, S_IRUGO, yeeloong_get_fan_rpm, NULL);
CREATE_SENSOR_ATTR(pwm1, S_IRUGO | S_IWUSR,
			 yeeloong_get_fan_pwm, yeeloong_set_fan_pwm);
CREATE_SENSOR_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
			 yeeloong_get_fan_pwm_enable, yeeloong_set_fan_pwm_enable);
CREATE_SENSOR_ATTR(temp1_input, S_IRUGO,
			 yeeloong_get_cpu_temp, NULL);

static ssize_t
show_name(struct device *dev, struct device_attribute *attr, char *buf)
{
	return sprintf(buf, "yeeloong\n");
}
static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);

static struct attribute *hwmon_attributes[] = {
	&sensor_dev_attr_pwm1.dev_attr.attr,
	&sensor_dev_attr_fan1_input.dev_attr.attr,
	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
	&sensor_dev_attr_temp1_input.dev_attr.attr,
	&sensor_dev_attr_name.dev_attr.attr,
	NULL
};

static struct attribute_group hwmon_attribute_group = {
	.attrs = hwmon_attributes
};

struct device *yeeloong_sensors_device;

#ifdef CONFIG_SUSPEND
static int yeeloong_suspend(struct platform_device *pdev, pm_message_t state)
{
	printk(KERN_INFO "yeeloong specific suspend\n");

	/* minimize the speed of FAN */
	yeeloong_set_fan_pwm_enable(1);
	yeeloong_set_fan_pwm(1);

	return 0;
}

static int yeeloong_resume(struct platform_device *pdev)
{
	printk(KERN_INFO "yeeloong specific resume\n");

	/* resume fan to auto mode */
	yeeloong_set_fan_pwm_enable(0);

	return 0;
}
#else
static int yeeloong_suspend(struct platform_device *pdev, pm_message_t state)
{
	return 0;
}
static int yeeloong_resume(struct platform_device *pdev)
{
	return 0;	
}
#endif

static struct platform_driver platform_driver = {
	.driver = {
		.name = "yeeloong-laptop",
		.owner = THIS_MODULE,
	},
#ifdef CONFIG_PM
	.suspend = yeeloong_suspend,
	.resume = yeeloong_resume,
#endif
};

static struct platform_device *yeeloong_pdev;

static ssize_t yeeloong_pdev_name_show(struct device *dev,
			   struct device_attribute *attr,
			   char *buf)
{
	return sprintf(buf, "yeeloong laptop\n");
}

static struct device_attribute dev_attr_yeeloong_pdev_name =
	__ATTR(name, S_IRUGO, yeeloong_pdev_name_show, NULL);

/* report power state changes */
void yeeloong_power_change_trigger_event(void)
{
	unsigned int ac_in, bat_in;
	
	ac_in = power_info->ac_in;
	bat_in = power_info->bat_in;

	yeeloong_read_bat_status();

	if(ac_in != power_info->ac_in)
		power_supply_changed(&yeeloong_ac);
	if(bat_in != power_info->bat_in)
		power_supply_changed(&yeeloong_bat);
}

static int __init yeeloong_init(void)
{
	int ret;

	/* Register platform stuff */
	ret = platform_driver_register(&platform_driver);
	if (ret)
		return ret;
	yeeloong_pdev = platform_device_alloc("yeeloong-laptop", -1);
	if (!yeeloong_pdev) {
		ret = -ENOMEM;
		platform_driver_unregister(&platform_driver);
		return ret;
	}
	ret = platform_device_add(yeeloong_pdev);
	if (ret) {
		platform_device_put(yeeloong_pdev);
		return ret;
	}

	if (IS_ERR(yeeloong_pdev)) {
		ret = PTR_ERR(yeeloong_pdev);
		yeeloong_pdev = NULL;
		printk(KERN_INFO "unable to register hwmon platform device\n");
		return ret;
	}
	ret = device_create_file(&yeeloong_pdev->dev,
				 &dev_attr_yeeloong_pdev_name);
	if (ret) {
		printk(KERN_INFO "unable to create sysfs hwmon device attributes\n");
		return ret;
	}

	/* backlight */
	yeeloong_backlight_device = backlight_device_register(
		"backlight0",
		&yeeloong_pdev->dev, NULL,
		&yeeloong_ops);

	if (IS_ERR(yeeloong_backlight_device)) {
		ret = PTR_ERR(yeeloong_backlight_device);
		yeeloong_backlight_device = NULL;
		return ret;
	}

	yeeloong_backlight_device->props.max_brightness = MAX_BRIGHTNESS;
	yeeloong_backlight_device->props.brightness = DEFAULT_BRIGHTNESS;
	backlight_update_status(yeeloong_backlight_device);

	/* sensors */
	yeeloong_sensors_device = hwmon_device_register(&yeeloong_pdev->dev);
	if (IS_ERR(yeeloong_sensors_device)) {
		printk(KERN_INFO "Could not register yeeloong hwmon device\n");
		return PTR_ERR(yeeloong_sensors_device);
	}
	ret = sysfs_create_group(&yeeloong_sensors_device->kobj,
				    &hwmon_attribute_group);
	if (ret) {
		sysfs_remove_group(&yeeloong_sensors_device->kobj,
			   &hwmon_attribute_group);
		hwmon_device_unregister(yeeloong_sensors_device);
		yeeloong_sensors_device = NULL;
	}
	/* ensure fan is set to auto mode */
	yeeloong_set_fan_pwm_enable(0);

 	/* Register battery driver */
 	power_info = kzalloc(sizeof(struct yeeloong_power_info),GFP_KERNEL);
 	if(!power_info) {
 	   printk(KERN_ERR "Get memory failed.\n");
 	   return -ENOMEM;
 	}
 
 	/* Battery vendor and cell */
 	power_info->vendor = ec_read(REG_BAT_VENDOR);
 	power_info->cell_count = ec_read(REG_BAT_CELL_COUNT);
 	printk(KERN_INFO "Battery vendor: %s  cell: %d\n",
 	   (power_info->vendor == FLAG_BAT_VENDOR_SANYO)?"SANYO":"SIMPLO", power_info->cell_count);
	
 	ret = power_supply_register(&yeeloong_pdev->dev, &yeeloong_ac);
 	if (ret)
 		goto ac_register_failed;
 	ret = power_supply_register(&yeeloong_pdev->dev, &yeeloong_bat);
 	if (ret)
 		goto battery_register_failed;

	ec_handler_install(SCI_EVENT_NUM_AC_BAT, yeeloong_power_change_trigger_event);
 
 	goto success;
 
battery_register_failed:
 	power_supply_unregister(&yeeloong_bat);
ac_register_failed:
 	power_supply_unregister(&yeeloong_ac);
 	kfree(power_info);
success:
 	return ret;
}

static void __exit yeeloong_exit(void)
{
 	/* Unregister battery driver */
 	ec_handler_uninstall(SCI_EVENT_NUM_AC_BAT);
	power_supply_unregister(&yeeloong_bat);
 	power_supply_unregister(&yeeloong_ac);
 	kfree(power_info);

	if (yeeloong_backlight_device) {
		backlight_device_unregister(yeeloong_backlight_device);
		yeeloong_backlight_device = NULL;
	}

	if (yeeloong_sensors_device) {
		sysfs_remove_group(&yeeloong_sensors_device->kobj,
				&hwmon_attribute_group);
		hwmon_device_unregister(yeeloong_sensors_device);
	}

	if (yeeloong_pdev) {
		platform_device_unregister(yeeloong_pdev);
	}
	platform_driver_unregister(&platform_driver);
}

module_init(yeeloong_init);
module_exit(yeeloong_exit);

MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>");
MODULE_DESCRIPTION("YeeLoong laptop driver");
MODULE_LICENSE("GPL");
