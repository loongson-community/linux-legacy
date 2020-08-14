/*
 * Copyright 2002 Momentum Computer Inc.
 * Author: Matthew Dharm <mdharm@momenco.com>
 *
 * Based on Ocelot Linux port, which is
 * Copyright 2001 MontaVista Software Inc.
 * Author: jsun@mvista.com or jsun@junsun.net
 *
 * Copyright 2003 ICT CAS
 * Author: Michael Guo <guoyi@ict.ac.cn>
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */
#include <linux/config.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <linux/sched.h>
#include <linux/bootmem.h>

#include <asm/addrspace.h>
#include <asm/bootinfo.h>

//#include <asm/ev64240/gt64240.h>

char arcs_cmdline[CL_SIZE];

extern unsigned long bus_clock;
extern unsigned long cpu_clock;
extern unsigned int  memsize,highmemsize;

#ifdef CONFIG_GALILLEO_GT64240_ETH
extern unsigned char prom_mac_addr_base[6];
#endif

const char *get_system_type(void)
{
	return "ICT CAS NB2005";
}
extern int putDebugChar(unsigned char byte);
extern void prom_printf(char *fmt, ...);
/* [jsun@junsun.net] PMON passes arguments in C main() style */
void __init prom_init(int argc, int *arg, int* env, void *cv)
{
	int i;
     /* some 64bit toolchain can't convert int to a pointer correctly */
	long l;
	
	/* arg[0] is "g", the rest is boot parameters */
	arcs_cmdline[0] = '\0';
#if 1
	for (i = 1; i < argc; i++) {
		l = arg[i];
		if (strlen(arcs_cmdline) + strlen(((char*)l) + 1)
		    >= sizeof(arcs_cmdline))
			break;
		strcat(arcs_cmdline, ((char*)l));
		strcat(arcs_cmdline, " ");
	}
	if((strstr(arcs_cmdline, "console=")) == NULL)	
		strcat(arcs_cmdline, "console=ttyS0,115200 ");
		//strcat(arcs_cmdline, "root=/dev/hde1 console=ttyS0,115200");
	if((strstr(arcs_cmdline, "root=")) == NULL)	
		strcat(arcs_cmdline, "root=/dev/hda1 ");
	mips_machgroup = MACH_GROUP_ICT;
	mips_machtype = MACH_ICT_NB2005;

#ifdef CONFIG_GALILLEO_GT64240_ETH
	/* get the base MAC address for on-board ethernet ports */
	memcpy(prom_mac_addr_base, (void*)0xbc807cf2, 6);
#endif

	l = *env;
	while (l!=0) {
#if 0
		if (strncmp("gtbase", (char*)l, strlen("gtbase")) == 0) {
			gt64240_base = simple_strtol((char*)l + strlen("gtbase="),
							NULL, 16);
		}
#endif
		if (strncmp("busclock", (char*)l, strlen("busclock")) == 0) {
			bus_clock = simple_strtol((char*)l + strlen("busclock="),
							NULL, 10);
		}
		if (strncmp("cpuclock", (char*)l, strlen("cpuclock")) == 0) {
			cpu_clock = simple_strtol((char*)l + strlen("cpuclock="),
							NULL, 10);
		}
		if (strncmp("memsize", (char*)l, strlen("memsize")) == 0) {
			memsize = simple_strtol((char*)l + strlen("memsize="),
							NULL, 10);
		}
		if (strncmp("highmemsize", (char*)l, strlen("highmemsize")) == 0) {
			highmemsize = simple_strtol((char*)l + strlen("highmemsize="),
							NULL, 10);
		}
		env++;
		l=*env;
	}
#else
	strcpy(arcs_cmdline, "console=tty ");
	bus_clock = 100000000;
	cpu_clock = 600000000;
#endif

	prom_printf("Booting Linux kernel...\n");
	//prom_printf("gtbase=%x, busclock=%x, cpuclock=%x\n",gt64240_base, bus_clock, cpu_clock);
	prom_printf("busclock=%d, cpuclock=%d,memsize=%d\n", bus_clock, cpu_clock,memsize);
#ifdef	CONFIG_GODSON2_FPGA_FREQUENCY
	cpu_clock = CONFIG_GODSON2_FPGA_FREQUENCY_VALUE*1000000;
	prom_printf("Simulation cpuclock=%dMHz\n", cpu_clock/1000000);
#endif
}

void __init prom_free_prom_memory(void)
{
}

void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
{
}
