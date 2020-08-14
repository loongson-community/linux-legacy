/*
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
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
 * Putting things on the screen/serial line using YAMONs facilities.
 *
 */
#include <linux/config.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/serialP.h>
#include <linux/serial_reg.h>
#include <asm/system.h>
#include <asm/io.h>
#include <asm/serial.h>
#include <linux/module.h>

static char buf[1024];

void prom_printf(char *fmt, ...)
{
	va_list args;
	int l;
	char *p, *buf_end;
	long flags;

	int putDebugChar(unsigned char);

	/* Low level, brute force, not SMP safe... */
	save_and_cli(flags);
	va_start(args, fmt);
	l = vsprintf(buf, fmt, args); /* hopefully i < sizeof(buf) */
	va_end(args);

	buf_end = buf + l;

	for (p = buf; p < buf_end; p++) {
		/* Crude cr/nl handling is better than none */
		if(*p == '\n')putDebugChar('\r');
		putDebugChar(*p);
	}
	restore_flags(flags);
}

static int Prom_debug=0;
void Prom_printf(char *fmt, ...)
{
	va_list args;
	int l;
	char *p, *buf_end;
	long flags;

	int putDebugChar(unsigned char);
if(!Prom_debug)return;

	/* Low level, brute force, not SMP safe... */
	save_and_cli(flags);
	va_start(args, fmt);
	l = vsprintf(buf, fmt, args); /* hopefully i < sizeof(buf) */
	va_end(args);

	buf_end = buf + l;

	for (p = buf; p < buf_end; p++) {
		/* Crude cr/nl handling is better than none */
		if(*p == '\n')putDebugChar('\r');
		putDebugChar(*p);
	}
	restore_flags(flags);
}

static int __init Prom_setup(char *options)
{
    char           *this_opt;

    if (!options || !*options)
        return 0;
	Prom_debug=simple_strtoul(options,0,0);
    return 1;
}

__setup("debug=", Prom_setup);
EXPORT_SYMBOL(prom_printf);

