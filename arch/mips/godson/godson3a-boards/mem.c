#include <linux/config.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <linux/sched.h>
#include <linux/bootmem.h>

#include <asm/addrspace.h>
#include <asm/bootinfo.h>

#include <asm/mach-loongson/loongson.h>
#include <asm/mach-loongson/boot_param.h>

extern unsigned long smbios_addr;

void __init prom_init_memory(void)
{
#ifndef CONFIG_UEFI_FIRMWARE_INTERFACE
	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);

	add_memory_region(memsize << 20, LOONGSON_PCI_MEM_START - (memsize <<
				20), BOOT_MEM_RESERVED);

#ifdef CONFIG_CPU_SUPPORTS_ADDRWINCFG
	{
		int bit;

		bit = fls(memsize + highmemsize);
		if (bit != ffs(memsize + highmemsize))
			bit += 20;
		else
			bit = bit + 20 - 1;

		/* set cpu window3 to map CPU to DDR: 2G -> 2G */
		LOONGSON_ADDRWIN_CPUTODDR(ADDRWIN_WIN3, 0x80000000ul,
					0x80000000ul, (1 << bit));
		mmiowb();
	}
#endif /* !CONFIG_CPU_SUPPORTS_ADDRWINCFG */

#ifdef CONFIG_64BIT
#ifdef CONFIG_CPU_LOONGSON2H
	add_memory_region(0x110000000, highmemsize << 20, BOOT_MEM_RAM);
#else
	if (highmemsize > 0)
		add_memory_region(LOONGSON_HIGHMEM_START,
				highmemsize << 20, BOOT_MEM_RAM);

	add_memory_region(LOONGSON_PCI_MEM_END + 1, LOONGSON_HIGHMEM_START -
			LOONGSON_PCI_MEM_END - 1, BOOT_MEM_RESERVED);
#endif /* CONFIG_CPU_LOONGSON2H */
#endif /* !CONFIG_64BIT */

#else	/* CONFIG_UEFI_FIRMWARE_INTERFACE */
	u64 node_id, mem_size, mem_start;
	u32 i, mem_type, total_memsize;
	total_memsize = 0;

	/* parse memory information */
	for (i = 0; i < emap->nr_map; i++){
		node_id = emap->map[i].node_id;
		mem_type = emap->map[i].mem_type;
		mem_size = emap->map[i].mem_size<<20;
		mem_start = emap->map[i].mem_start;
#ifndef CONFIG_MIPS64
	if(mem_start >= 0x100000000) continue;
#endif

		if (node_id == 0) {
			switch (mem_type) {
			case SYSTEM_RAM_LOW:
			case SYSTEM_RAM_HIGH:
				total_memsize += mem_size>>20;
				if(board_type == RS780E ) {
					if(mem_start<0x100000000 && mem_start + mem_size >= 0xfe000000) {
						if(mem_start<0xfe000000)
							add_memory_region(mem_start, 0xfe000000 - mem_start,
									BOOT_MEM_RAM);
#ifdef CONFIG_MIPS64
						if(mem_start + mem_size > 0x100000000)
							add_memory_region(0x100000000, mem_start + mem_size - 0x100000000,
									BOOT_MEM_RAM);
#endif
					} else 
						add_memory_region(mem_start, mem_size, BOOT_MEM_RAM);
				} else 
					add_memory_region(mem_start, mem_size, BOOT_MEM_RAM);
				break;
			case SMBIOS_TABLE:
				smbios_addr = emap->map[i].mem_start & 0x000000000fffffff;	
				printk("smbios_addr : 0x%lx\n", smbios_addr);
				break;
			case MEM_RESERVED:
				add_memory_region(emap->map[i].mem_start,
					mem_size, BOOT_MEM_RESERVED);
				break;
			}
		}
	}

	/*
	 * Just for compatibility previous loongson3A kernel.
	 * reserve the memory 0xff800000~0xffffffff for RS780E
	 * integrated GPU when system ram more than 2G.
	 */
	add_memory_region(0x0, 0x1000000, BOOT_MEM_RESERVED);
	if((board_type == RS780E) && (total_memsize >= 2032))
		add_memory_region(0xff800000, 0x800000, BOOT_MEM_RESERVED);
#endif
}

