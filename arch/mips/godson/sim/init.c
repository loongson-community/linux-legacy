/* $Id: init.c,v 1.1.1.1 2006/01/05 06:08:34 root Exp $
 * 
 * init.c
 *
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 1999 MIPS Technologies, Inc.
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
 * Algorithmics PMON PROM library initialisation code.
 *
 */
#include <linux/config.h>
#include <linux/init.h>
#include <linux/string.h>
#include <asm/io.h>
#include <asm/bootinfo.h>


#include <asm/godson/prom.h>
#include <asm/godson/godson_sim.h>
#include <asm/godson/machine_params.h>

int prom_argc;
char **prom_argv, **prom_envp;

MachinesStruct *machines = NULL;

const char *get_system_type(void)
{
#ifdef CONFIG_GODSON_SIM
	return "Godson c simulator platform";
#elif CONFIG_GODSON_1
	return "Godson 1 evaluation board";
#elif CONFIG_GODSON_2
	return "Godson 2 evaluation board";
#elif CONFIG_GODSON_SIMOS
	return "Simos simulator platform";
#endif
}

char *prom_getenv(char *envname)
{
        /*
	 * Return a pointer to the given environment variable.
	 * Assumes PMON-style envoronment strings ("NAME=VALUE")
	 */

#if 0
	char **env = prom_envp;
	int i;
	i = strlen(envname);

	while(*env) {
		if(strnicmp(envname, *env, i) == 0) {
		    if( (*env)[i] == '=') {
			return(&(*env)[i+1]);
		    } 
		} 
		env++;
	}
#endif
	return(NULL);
}

 
unsigned long platform_io_mem_base = 0;
unsigned long platform_mem_iobus_base = 0;

int __init prom_init(int argc, char **argv, char **envp, int *prom_vec)
{
	(void)prom_vec;

	prom_argc = argc;
	prom_argv = argv;
	prom_envp = envp;

	mips_machgroup = MACH_GROUP_ICT;
#ifdef CONFIG_GODSON_SIM
	mips_machtype = MACH_GODSON_SIM;
#elif CONFIG_GODSON_SIMOS
	mips_machtype = MACH_GODSON_SIMOS;
#else
#error "No valid machtype selected!"
#endif

	platform_io_mem_base = GODSON_SIM_PCI_MEM_BASE;
	platform_mem_iobus_base = GODSON_SIM_MEM_IOBUS_BASE;
#ifndef CONFIG_GODSON_SIMOS
	set_io_port_base(GODSON_SIM_ISAPORT_ADDR(0));
#else
        set_io_port_base(KSEG1 + 0x1fe01000);
#endif

/*
 * Until a clean interface with the actual PMON hooks is
 * worked out, "prom_printf" will rely on a direct low
 * level access to the serial port driver.  
 */
	setup_prom_printf(0);

	prom_printf("\nLINUX starting...\n");

	prom_init_cmdline();
	
#ifdef CONFIG_GODSON_SIMOS
	/* machine params are stored at the start of memory */
	machines = (struct MachinesStruct *)KSEG1;
#endif

	prom_meminit();

	return 0;
}
