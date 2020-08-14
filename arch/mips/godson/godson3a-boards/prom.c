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

#include <asm/mach-loongson/loongson.h>
#include <asm/mach-loongson/boot_param.h>

char arcs_cmdline[CL_SIZE];

extern unsigned long bus_clock;
extern unsigned long cpu_clock;
extern unsigned int  cpci_cpuid;

#ifdef CONFIG_KGDB
int remote_debug = 0;
#endif

extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;

struct boot_params *bp;
struct loongson_params *lp;
struct efi_memory_map_loongson *emap;
struct efi_cpuinfo_loongson *ecpu;
struct system_loongson *esys;
struct irq_source_routing_table *eirq_source;
struct interface_info *einter;
struct loongson_special_attribute *especial;
struct board_devices *eboard;

unsigned long pci_mem_start_addr, pci_mem_end_addr;
unsigned long long ht_control_base;
unsigned long long io_base_regs_addr;
unsigned long long smp_group0, smp_group1, smp_group2, smp_group3;
unsigned long long loongson_pciio_base;
unsigned long long loongson_htio_base;
unsigned long long rtc_always_bcd;
unsigned long ht_enable;
unsigned long ht_int_bit;
unsigned int sing_double;
unsigned int ccnuma;
unsigned int nr_cpu_loongson;
extern char *vendor;
extern char *release_date;
extern char *manufacturer;
extern char _bios_info[];
extern char _board_info[];
char *bios_info;
char *board_info;
uint32_t dma64_supported;
unsigned int Loongson3B05_uncache;


enum loongson_cpu_type cputype;
enum board_type board_type;

unsigned long sharevram, vramsize;
unsigned long cpu_clock_freq;
EXPORT_SYMBOL(cpu_clock_freq);
unsigned int nodes_loongson;
unsigned int CONFIG_NODES_SHIFT_LOONGSON;
unsigned long long poweroff_addr;
unsigned long long reboot_addr;
u64 vbios_addr;
#ifndef CONFIG_CPU_LOONGSON2H
extern unsigned long phy_core_id[];
#endif
unsigned int pmon_smbios = 0;
unsigned long smbios_addr;
int pcidev_max_func_num;


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
	char *p;
	
	fw_arg0 = argc;
	fw_arg1 = arg;
	fw_arg2 = env;
	fw_arg3 = cv;

	/* arg[0] is "g", the rest is boot parameters */
	arcs_cmdline[0] = '\0';

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
	if((p = strstr(arcs_cmdline, "kgdb")))
	{
		if(p[4] == '=')
			remote_debug = simple_strtol(p+5, 0, 0);
		else
			remote_debug = 1;
	}
	mips_machgroup = MACH_GROUP_ICT;
	mips_machtype = MACH_ICT_NB2005;

#ifndef CONFIG_UEFI_FIRMWARE_INTERFACE

	l = *env;
	while (l!=0) {
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
		if (strncmp("cpuid", (char*)l, strlen("cpuid")) == 0) {
			cpci_cpuid=simple_strtol((char*)l + strlen("cpuid="),
							NULL, 10);
		}
		if (strncmp("mtdparts", (char*)l, strlen("mtdparts")) == 0) {
		strcat(arcs_cmdline, ((char*)l));
		strcat(arcs_cmdline, " ");
		}
		env++;
		l=*env;
	}
#else
	/* pmon passes arguments in 32bit pointers */
	unsigned int available_core_mask;
#ifndef CONFIG_CPU_LOONGSON2H
	unsigned int idx;
	unsigned long core_offset;
#endif

	/* parse pmon argument */
	bp = (struct boot_params *)fw_arg2;
	lp = &(bp->efi.smbios.lp);

	emap = (struct efi_memory_map_loongson *) \
					((u64)lp+lp->memory_offset);
	ecpu = (struct efi_cpuinfo_loongson *) \
					((u64)lp + lp->cpu_offset);
	esys = (struct system_loongson *) \
					((u64)lp+lp->system_offset);
	eirq_source = (struct irq_source_routing_table *)
					((u64)lp+lp->irq_offset);
	einter = (struct interface_info *) \
					((u64)lp+lp->interface_offset);
	eboard = (struct board_devices *) \
					((u64)lp+lp->boarddev_table_offset);
	especial = (struct loongson_special_attribute *) \
					((u64)lp+lp->special_offset);

	poweroff_addr = bp->reset_system.Shutdown;
	reboot_addr = bp->reset_system.ResetWarm;
	printk("shutdown:0x%llx reset:0x%llx\n", poweroff_addr, reboot_addr);

	vbios_addr = bp->efi.smbios.vga_bios;
	printk("vbios locate in %llx\n", vbios_addr);

	cpu_clock = cpu_clock_freq = ecpu->cpu_clock_freq;
	cputype = ecpu->cputype;
	nr_cpu_loongson = ecpu->nr_cpus;
	available_core_mask = ecpu->cpu_startup_core_id;

	ccnuma = esys->ccnuma_smp;
	sing_double = esys->sing_double_channel;

	ht_int_bit = eirq_source->ht_int_bit;
	ht_enable = eirq_source->ht_enable;

	pci_mem_start_addr = eirq_source->pci_mem_start_addr;
	pci_mem_end_addr = eirq_source->pci_mem_end_addr;

	bios_info = _bios_info;
	board_info = _board_info;
	strcpy(bios_info, einter->description);
	if(strstr(bios_info, "PMON"))
		pmon_smbios = 1;
	strcpy(board_info, eboard->name);
	vendor = strsep(&bios_info, "-");
	strsep(&bios_info, "-");
	strsep(&bios_info, "-");
	release_date = strsep(&bios_info, "-");
	if (!release_date)
		release_date = especial->special_name;	
	manufacturer = strsep(&board_info, "-");

	if(strstr(eboard->name,"2H")){
		board_type = LS2H;
		pcidev_max_func_num = 1;
	}
	else{
		board_type = RS780E;
		pcidev_max_func_num = 7;
	}

	if(NR_CPUS < nr_cpu_loongson)
		nr_cpu_loongson = NR_CPUS;

	pr_info("Version:%d %s", einter->vers, einter->description);
	pr_info("Board name:%s %p %d", eboard->name, eboard->name,
						eboard->num_resources);
	pr_info("Board type:%d(%s)", board_type, board_type?"LS2H":"RS780E");
	pr_info("cpu_clock:%ld, cputye:%d, nr_cpus:%d, ccnuma_smp:%d,"	\
			"single_double_way:%d\n",cpu_clock_freq, cputype,\
					nr_cpu_loongson, ccnuma, sing_double);
	pr_info("lp:%p, irq_source:%p, offset:%lld, ht_int_bit:%lx," \
			"ht_enable:%lx\npci_mem_start:%lx, pci_mem_end:%lx\n",\
			lp, eirq_source, lp->irq_offset, ht_int_bit,	\
			ht_enable, pci_mem_start_addr,pci_mem_end_addr);

#undef CONFIG_NR_CPUS
#define CONFIG_NR_CPUS nr_cpu_loongson
	bus_clock = 33000000;
	ht_control_base = 0x90000EFDFB000000;
	loongson_pciio_base = 0xefdfc000000;	/* set default value for 3a780e */
	io_base_regs_addr = 0x900000003ff00000;
	if ((especial->resource[0].flags & DMA64_SUPPORTED) && (board_type == RS780E)) {
		if( 16 == nr_cpu_loongson){
			dma64_supported = 0;
		}
		else{
			dma64_supported = 1;
			pr_info("board enable 64bit dma configuration\n");
		}
	}
	if (especial->resource[0].end) {
		sharevram = especial->resource[0].flags;
		vramsize = especial->resource[0].end - especial->resource[0].start;
	} else {
		sharevram = 0;
		vramsize = 128;
	}
	rtc_always_bcd = 0;
	smp_group0 = 0x900000003ff01000;
	smp_group1 = 0x900010003ff01000;
	smp_group2 = 0x900020003ff01000;
	smp_group3 = 0x900030003ff01000;

	if(board_type == LS2H)
		loongson_pciio_base = 0x1ff00000;	/* for 3A2H,2GQ2H,3B2H,2H board */

	if(cputype == Loongson_3B) {
		ht_control_base = 0x90001EFDFB000000;

		if(board_type == LS2H)
			loongson_pciio_base = 0x1bf00000;	/* for 3B2H */
		else
			loongson_pciio_base = 0x1efdfc000000;	/* for 3B780e */

		smp_group0 = 0x900000003ff01000;
		smp_group1 = 0x900010003ff05000;
		smp_group2 = 0x900020003ff09000;
		smp_group3 = 0x900030003ff0d000;
		rtc_always_bcd = 1;
	if ((read_c0_prid() & 0xf) == (PRID_IMP_LOONGSON3B1500 & 0xf)) {
		Loongson3B05_uncache = 1;
	}
		else Loongson3B05_uncache = 0;
	}
#ifndef CONFIG_CPU_LOONGSON2H
	for(idx=0,core_offset=0; idx<4; core_offset++,available_core_mask >>=1) {
		while(available_core_mask & 0x1) {
			core_offset++;
			available_core_mask >>= 1;
		}
		phy_core_id[idx++] = core_offset;
	}
#endif
	nodes_loongson = nr_cpu_loongson / 4;
	if(nodes_loongson == 0)
		nodes_loongson = 1;
	CONFIG_NODES_SHIFT_LOONGSON = (nodes_loongson) >> 1;

#endif

	prom_printf("Booting Linux kernel...\n");
	//prom_printf("gtbase=%x, busclock=%x, cpuclock=%x\n",gt64240_base, bus_clock, cpu_clock);
	prom_printf("busclock=%d, cpuclock=%d\n", bus_clock, cpu_clock);
#ifdef	CONFIG_GODSON2_FPGA_FREQUENCY
	cpu_clock = CONFIG_GODSON2_FPGA_FREQUENCY_VALUE*1000000;
	prom_printf("Simulation cpuclock=%dMHz\n", cpu_clock/1000000);
#endif
	ht_control_base = (int)0xbe000000;

	asm volatile(\
			".set mips64;\n"
			"dli %0, 0x900000003ff02000;\n"
			"dli %1, 0x000000001e000000;\n"
			"sd  %1, 0x20(%0);\n"
			"dli %1, 0xffffffffff000000\n"
			"sd  %1, 0x60(%0)\n"
			"dli %1, 0x00000efdfb0000f7;\n"
			"sd  %1, 0xa0(%0);\n"
			".set mips0;\n"
			::"r"(0),"r"(0));
}

void __init prom_free_prom_memory(void)
{
}

void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
{
}
