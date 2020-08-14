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
	return "lemote-fuloong";
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

void __init prom_init(void)
{
	long l;
	argc = fw_arg0;
	arg = (int *)fw_arg1;
	env = (int *)fw_arg2;

	prom_init_cmdline();

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
