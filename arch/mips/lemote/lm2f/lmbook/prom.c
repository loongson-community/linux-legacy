/*
 * Based on Ocelot Linux port, which is
 * Copyright 2001 MontaVista Software Inc.
 * Author: jsun@mvista.com or jsun@junsun.net
 *
 * Copyright 2003 ICT CAS
 * Author: Michael Guo <guoyi@ict.ac.cn>
 *
 * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
 * Author: Fuxin Zhang, zhangfx@lemote.com
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */
#include <linux/init.h>
#include <linux/mm.h>
#include <linux/sched.h>
#include <linux/bootmem.h>

#include <asm/addrspace.h>
#include <asm/bootinfo.h>

extern unsigned long bus_clock;
extern unsigned long cpu_clock_freq;
extern unsigned int memsize, highmemsize;
extern int putDebugChar(unsigned char byte);

static int argc;
/* pmon passes arguments in 32bit pointers */
static int *arg;
static int *env;

const char *get_system_type(void)
{
	return "lemote-yeeloong";
}

void __init prom_init_cmdline(void)
{
	int i;
	long l;

	/* arg[0] is "g", the rest is boot parameters */
	arcs_cmdline[0] = '\0';
	for (i = 1; i < argc; i++) {
		l = (long)arg[i];
		if (strlen(arcs_cmdline) + strlen(((char *)l) + 1)
		    >= sizeof(arcs_cmdline))
			break;
		strcat(arcs_cmdline, ((char *)l));
		strcat(arcs_cmdline, " ");
	}
}

extern void _wrmsr(u32 msr, u32 hi, u32 lo);

void __init prom_init(void)
{
	long l;
	unsigned char default_root[50] = "/dev/hda1";
	argc = fw_arg0;
	arg = (int *)fw_arg1;
	env = (int *)fw_arg2;

	 /* set lpc irq to quiet mode*/
	//_wrmsr(0x8000004e, 0, 0);
	//_wrmsr(0x8000004e, 0, 0xc0);
	_wrmsr(0x80000014, 0x00, 0x16000003);

	/*Emulate post for usb*/
	_wrmsr(0x40000001, 0x4, 0xBF000);

	prom_init_cmdline();

#if 1
	if (!strstr(arcs_cmdline, "no_auto_cmd")) {
		char *pmon_ver, *ec_ver, *p, version[60], ec_version[64];
		
		p = arcs_cmdline;

		pmon_ver = strstr(arcs_cmdline, "PMON_VER");
		if (pmon_ver) {
			if((p = strstr(pmon_ver, " ")))
				*p++ = '\0';
			strncpy(version, pmon_ver, 60);
		} else
			strncpy(version, "PMON_VER=Unknown", 60);

		ec_ver = strstr(p, "EC_VER");
		if (ec_ver) {
			if((p = strstr(ec_ver, " ")))
				*p = '\0';
			strncpy(ec_version, ec_ver, 64);
		} else
			strncpy(ec_version, "EC_VER=Unknown", 64);

		p = strstr(arcs_cmdline, "root=");
		if(p) {
			strncpy(default_root, p, sizeof(default_root));
			if(p=strstr(default_root, " "))
				*p = '\0';
		}

		memset(arcs_cmdline, 0, sizeof(arcs_cmdline));
		strcat(arcs_cmdline, version);
		strcat(arcs_cmdline, " ");
		strcat(arcs_cmdline, ec_version);
		strcat(arcs_cmdline, " ");
		strcat(arcs_cmdline, default_root);
		strcat(arcs_cmdline, " console=tty2");
		strcat(arcs_cmdline, " quiet");
	}
#endif
	if ((strstr(arcs_cmdline, "console=")) == NULL)
		strcat(arcs_cmdline, " console=ttyS0,115200");

	if ((strstr(arcs_cmdline, "root=")) == NULL)
		strcat(arcs_cmdline, " root=/dev/hda1");

	l = (long)*env;
	while (l != 0) {
		if (strncmp("busclock", (char *)l, strlen("busclock")) == 0) {
			bus_clock = simple_strtol((char *)l + strlen("busclock="),
					NULL, 10);
		}
		if (strncmp("cpuclock", (char *)l, strlen("cpuclock")) == 0) {
			cpu_clock_freq = simple_strtol((char *)l + strlen("cpuclock="),
					NULL, 10);
		}
		if (strncmp("memsize", (char *)l, strlen("memsize")) == 0) {
			memsize = simple_strtol((char *)l + strlen("memsize="),
						NULL, 10);
		}
		if (strncmp("highmemsize", (char *)l, strlen("highmemsize")) == 0) {
			highmemsize = simple_strtol((char *)l + strlen("highmemsize="),
					  NULL, 10);
		}
		env++;
		l = (long)*env;
	}
	if (memsize == 0)
		memsize = 256;

	printk("busclock=%ld, cpuclock=%ld,memsize=%d,highmemsize=%d\n",
	       bus_clock, cpu_clock_freq, memsize, highmemsize);
}

void __init prom_free_prom_memory(void)
{
}

void prom_putchar(char c)
{
	putDebugChar(c);
}
