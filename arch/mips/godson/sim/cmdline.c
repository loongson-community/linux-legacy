/* $Id: cmdline.c,v 1.4 2004/04/01 14:57:34 fxzhang Exp $
 * 
 * cmdline.c
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
 * Kernel command line creation using PMON argc/argv.
 *
 */
#include <linux/config.h>
#include <linux/init.h>
#include <linux/string.h>
#include <asm/bootinfo.h>
#include <asm/io.h>

extern int prom_argc;
extern char **prom_argv;

char arcs_cmdline[CL_SIZE];

char * __init prom_getcmdline(void)
{
	return &(arcs_cmdline[0]);
}


void __init prom_init_cmdline(void)
{
#ifndef CONFIG_GODSON_SIM
	char *cp;
	int actr;

	actr = 1; /* Always ignore argv[0] */

	cp = &(arcs_cmdline[0]);
	while(actr < prom_argc) {
	        strcpy(cp, prom_argv[actr]);
		cp += strlen(prom_argv[actr]);
		*cp++ = ' ';
		actr++;
	}
	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
		--cp;
	*cp = '\0';
#else
	/* temp hack to pass kernel command line options */
	strcpy(arcs_cmdline,(KSEG1 + 0x100));
        if((strstr(arcs_cmdline, "console=")) == NULL)
                strcat(arcs_cmdline, "console=ttyS0");
#endif
	prom_printf("prom_init_cmdline: %s$\n", &(arcs_cmdline[0]));
}
