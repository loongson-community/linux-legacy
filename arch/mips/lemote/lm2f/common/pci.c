/*
 * pci.c
 *
 * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
 * Author: Fuxin Zhang, zhangfx@lemote.com
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
 *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
 *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
 *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  You should have received a copy of the  GNU General Public License along
 *  with this program; if not, write  to the Free Software Foundation, Inc.,
 *  675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */
#include <linux/types.h>
#include <linux/pci.h>
#include <linux/kernel.h>
#include <linux/init.h>

extern struct pci_ops loongson2f_pci_pci_ops;
/* if you want to expand the pci memory space, you should config 64bits kernel too. */

static struct resource loongson2f_pci_mem_resource = {
	.name   = "LOONGSON2F PCI MEM",
	.start  = 0x14000000UL,
	.end    = 0x1fffffffUL,
	.flags  = IORESOURCE_MEM,
};

static struct resource loongson2f_pci_io_resource = {
	.name   = "LOONGSON2F PCI IO MEM",
	.start  = 0x00004000UL,
	.end    = 0x0000ffffUL,
	.flags  = IORESOURCE_IO,
};


static struct pci_controller  loongson2f_pci_controller = {
	.pci_ops        = &loongson2f_pci_pci_ops,
	.io_resource    = &loongson2f_pci_io_resource,
	.mem_resource   = &loongson2f_pci_mem_resource,
	.mem_offset     = 0x00000000UL,
	.io_offset      = 0x00000000UL,
};

static int __init pcibios_init(void)
{
	extern int pci_probe_only;
	pci_probe_only = 0;

#ifdef CONFIG_TRACE_BOOT
	printk(KERN_INFO"arch_initcall:pcibios_init\n");
	printk(KERN_INFO"register_pci_controller : %x\n",&loongson2f_pci_controller);
#endif
	
#ifdef	CONFIG_64BIT
	loongson2f_pci_mem_resource.start	= 0x50000000UL; 
	loongson2f_pci_mem_resource.end		= 0x7fffffffUL;
	__asm__(".set mips3\n"
	         "dli $2,0x900000003ff00000\n"
		 "li $3,0x40000000\n"
		 "sd $3,0x18($2)\n"
		 "or $3,1\n"
		 "sd $3,0x58($2)\n"
		 "dli $3,0xffffffffc0000000\n"
		 "sd $3,0x38($2)\n"
		 ".set mips0\n"
		 :::"$2","$3","memory"
			   );
#endif
	loongson2f_pci_controller.io_map_base = mips_io_port_base;
	register_pci_controller(&loongson2f_pci_controller);
	return 0;
}

arch_initcall(pcibios_init);
