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
 * PROM library functions for acquiring/using memory descriptors given to 
 * us from the YAMON.
 * 
 */
#include <linux/config.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <linux/bootmem.h>

#include <asm/bootinfo.h>
#include <asm/page.h>

#include <asm/mips-boards/prom.h>
#include <asm/godson/machine_params.h>

#define DEBUG

enum yamon_memtypes {
	yamon_dontuse,
	yamon_prom,
	yamon_free,
};
struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];

#ifdef DEBUG
static char *mtypes[3] = {
	"Dont use memory",
	"YAMON PROM memory",
	"Free memory",
};
#endif


struct prom_pmemblock * __init prom_getmdesc(void)
{
	char *memsize_str;
	unsigned int memsize;

	int i;

#ifdef CONFIG_GODSON_SIMOS
	memsize = machines->machine[0].MemSize;
#else
	memsize = 0x02000000;
#endif
	prom_printf("prom_memsize = %dM\n", memsize/(1<<20));

	memset(mdesc, 0, sizeof(mdesc));

       /* first 16k reserved for simulator,note that 
	* it should be a multiple of PAGE_SIZE */
	mdesc[0].type = yamon_dontuse;
	mdesc[0].base = 0x00000000;
	mdesc[0].size = 0x00004000;

	mdesc[1].type = yamon_prom;
	mdesc[1].base = 0x00004000;
	mdesc[1].size = 0x000fc000;

#ifdef CONFIG_BLK_DEV_INITRD
	mdesc[2].type = yamon_free;
	mdesc[2].base = 0x00100000;
	mdesc[2].size = 0x00200000;
	
	mdesc[3].type = yamon_dontuse;
	mdesc[3].base = 0x00300000;
	mdesc[3].size = *((unsigned long*)(KSEG0 + 0x2ffffc));

	mdesc[4].type = yamon_free;
	mdesc[4].base = mdesc[3].base + mdesc[3].size;
	mdesc[4].size = memsize - mdesc[4].base;
#else
	mdesc[2].type = yamon_free;
	mdesc[2].base = mdesc[1].base + mdesc[1].size;
	mdesc[2].size = memsize - mdesc[2].base;
#endif

	return &mdesc[0];
}

static int __init prom_memtype_classify (unsigned int type)
{
	switch (type) {
	case yamon_free:
		return BOOT_MEM_RAM;
	case yamon_prom:
		return BOOT_MEM_ROM_DATA;
	default:
		return BOOT_MEM_RESERVED;
	}
}

void __init prom_meminit(void)
{
	struct prom_pmemblock *p;

#ifdef DEBUG
	int i = 0;

	prom_printf("YAMON MEMORY DESCRIPTOR dump:\n");
	p = prom_getmdesc();
	while (p->size) {
		prom_printf("[%d,%p]: base<%08lx> size<%08lx> type<%s>\n",
			    i, p, p->base, p->size, mtypes[p->type]);
		p++;
		i++;
	}
#endif
	p = prom_getmdesc();
	while (p->size) {
		unsigned long base, size;
		long type;

		type = prom_memtype_classify (p->type);
		base = p->base;
		size = p->size;

		add_memory_region(base, size, type);

		p++;
	}
}

void prom_free_prom_memory (void)
{
#if 1
	int i;
	struct prom_pmemblock *p;
	unsigned long freed = 0;
	unsigned long addr;

	for (i = 0; i < boot_mem_map.nr_map; i++) {
		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
			continue;

		addr = boot_mem_map.map[i].addr;
		while (addr < boot_mem_map.map[i].addr
			      + boot_mem_map.map[i].size) {
		        ClearPageReserved(virt_to_page(phys_to_virt(addr)));
			set_page_count(virt_to_page(phys_to_virt(addr)), 1);
			free_page(phys_to_virt(addr));
			addr += PAGE_SIZE;
			freed += PAGE_SIZE;
		}
	}
	printk("Freeing prom memory: %ldkb freed\n", freed >> 10);
#endif
}
