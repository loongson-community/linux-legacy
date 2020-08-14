/*
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
 *
 * ########################################################################
 *
 *  This program is free software; you can distribute it and/or modify it
 *  under the terms of the GNU General Public License (Version 2) as
 *  published by the Free Software Foundation.
 *
 *  This program is distributed in the hope it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 *  for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * ########################################################################
 *
 * RTC routines for Malta style attached PIIX4 device, which contains a
 * Motorola MC146818A-compatible Real Time Clock.
 *
 */
#include <linux/mc146818rtc.h>
#include <linux/time.h>

static unsigned char godsonev2a_rtc_read_data(unsigned long addr)
{
	outb(addr, 0x70);
	return inb(0x71);
}

static void godsonev2a_rtc_write_data(unsigned char data, unsigned long addr)
{
	outb(addr, 0x70);
	outb(data, 0x71);
}

static int godsonev2a_rtc_bcd_mode(void)
{
	return 0;
}

struct rtc_ops godsonev2a_rtc_ops = {
	&godsonev2a_rtc_read_data,
	&godsonev2a_rtc_write_data,
	&godsonev2a_rtc_bcd_mode
};

unsigned long mips_rtc_get_time(void)
{
	unsigned int year, mon, day, hour, min, sec;
	unsigned char save_control;

	save_control = CMOS_READ(RTC_CONTROL);

	/* Freeze it. */
	CMOS_WRITE(save_control | RTC_SET, RTC_CONTROL);

	/* Read regs. */
	sec = CMOS_READ(RTC_SECONDS);
	min = CMOS_READ(RTC_MINUTES);
	hour = CMOS_READ(RTC_HOURS);

	if (!(save_control & RTC_24H))
	{
		if ((hour & 0xf) == 0xc)
		        hour &= 0x80;
	        if (hour & 0x80)
		        hour = (hour & 0xf) + 12;
	}
	day = CMOS_READ(RTC_DAY_OF_MONTH);
	mon = CMOS_READ(RTC_MONTH);
	year = CMOS_READ(RTC_YEAR);

	/* Unfreeze clock. */
	CMOS_WRITE(save_control, RTC_CONTROL);

	if ((year += 1900) < 1970)
	        year += 100;

	return mktime(year, mon, day, hour, min, sec);
}

