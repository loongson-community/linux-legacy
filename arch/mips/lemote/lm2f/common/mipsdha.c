/*
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
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/mm.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <asm/uaccess.h>
#include <asm/io.h>

static ssize_t mipsdha_proc_read(struct file *file, char *buf, size_t len, loff_t *ppos);

static ssize_t mipsdha_proc_write(struct file *file, const char *buf, size_t len, loff_t *ppos);


static struct proc_dir_entry *mipsdha_proc_entry;

#define INFO_SIZE 4096
static char info_buf[INFO_SIZE];

static struct file_operations mipsdha_fops =
{
    owner:	THIS_MODULE,
    read:	mipsdha_proc_read,
    write:	mipsdha_proc_write,
};

static enum {CMD_ERR, CMD_GIB, CMD_GPI} cmd;

typedef struct pciinfo_s
{
  int		bus,card,func;
  unsigned short command;
  unsigned short vendor,device;
  unsigned	base0,base1,base2,baserom;
} pciinfo_t;


extern struct proc_dir_entry proc_root;

static int __init mipsdha_proc_init(void)
{
	mipsdha_proc_entry = create_proc_entry("mipsdha", S_IWUSR | S_IRUGO, &proc_root);
	if (mipsdha_proc_entry == NULL) {
		printk("MIPSDHA: register /proc/mipsdha failed!\n");
		return 0;
	}
	
	mipsdha_proc_entry->owner = THIS_MODULE;
	mipsdha_proc_entry->proc_fops = &mipsdha_fops;

	cmd=CMD_ERR;
	return 0;
}

static ssize_t mipsdha_proc_write (struct file *file, const char *buf, size_t len, loff_t *ppos)
{
	char cmd_gib[]="GET IO BASE";
	char cmd_gpi[]="GET PCI INFO";

	if (len >= INFO_SIZE) return -ENOMEM;

	if (copy_from_user(info_buf, buf, len)) return -EFAULT;
	info_buf[len] = '\0';

	if (strncmp(info_buf, cmd_gib, sizeof(cmd_gib)-1)==0) {
		cmd = CMD_GIB;
		return len;
	} else if (strncmp(info_buf, cmd_gpi, sizeof(cmd_gpi)-1)==0) {
		cmd = CMD_GPI;
		return len;
	} else {
		return -EINVAL;
	}
}

static ssize_t mipsdha_proc_read (struct file *file, char *buf, size_t len, loff_t *ppos)
{
	int info_cnt;
	pciinfo_t *pciinfo;
	struct pci_dev *dev = NULL;

	switch (cmd) {
		default:
			printk("MIPSDHA: BUG found in function %s!(cmd=%d)\n", 
					__FUNCTION__, cmd);
			return -EINVAL;


		case CMD_ERR:
			return -EINVAL;


		case CMD_GIB:
			*(unsigned long *)info_buf = 
				virt_to_phys((void *) mips_io_port_base);
			info_cnt=sizeof(unsigned long);
			break;


		case CMD_GPI:
			pciinfo = (pciinfo_t *) info_buf;
			info_cnt = 0;
			for_each_pci_dev(dev) {

				if (info_cnt+sizeof(pciinfo_t)>INFO_SIZE) return -ENOMEM;

				pciinfo->bus = dev->bus->number;
				pciinfo->card = PCI_SLOT(dev->devfn);
				pciinfo->func = PCI_FUNC(dev->devfn);

				if (pci_read_config_word(dev, PCI_COMMAND, &pciinfo->command)
						!= PCIBIOS_SUCCESSFUL) {
					printk("MIPSDHA: BUG found in function %s!\n", 
							__FUNCTION__);
					pciinfo->command=0;
				}

				pciinfo->vendor = dev->vendor;
				pciinfo->device = dev->device;

				pciinfo->base0 = (dev->resource[0]).start;
				pciinfo->base1 = (dev->resource[1]).start;
				pciinfo->base2 = (dev->resource[2]).start;
				pciinfo->baserom = (dev->resource[PCI_ROM_RESOURCE]).start;

				pciinfo++;
				info_cnt += sizeof(pciinfo_t);
			}
			break;
	}

	if (len < info_cnt) return -ENOMEM;
	if (copy_to_user(buf, info_buf, info_cnt)) return -EFAULT;

	return info_cnt;
}

__initcall(mipsdha_proc_init);
