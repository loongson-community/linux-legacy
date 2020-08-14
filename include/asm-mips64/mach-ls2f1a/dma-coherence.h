/*
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
 * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
 *
 * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
 * Author: Fuxin Zhang, zhangfx@lemote.com
 *
 */
#ifndef __ASM_MACH_GENERIC_DMA_COHERENCE_H
#define __ASM_MACH_GENERIC_DMA_COHERENCE_H

struct device;


void prom_printf(char *fmt, ...);

static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
	size_t size)
{
	u32 phy_addr = (unsigned long)addr & (~((1 << 31) | (1<<30) | (1<<29))); 
#if 1
		if(phy_addr >=0x04000000 && phy_addr <=0x0fffffff){
			return phy_addr+0x0c000000; 
		}else{
			prom_printf("addr is out of range\n");
			printk("%s----the addr is out of range ",__FUNCTION__);
			printk("%s----the addr =0x%8x\n ",__FUNCTION__,(unsigned int)addr);
			while(1);
		}
#else
        if(phy_addr >=0x0 && phy_addr <=0x03ffffff){
		return phy_addr+0x10000000;
	}else{
		if(phy_addr >=0x08000000 && phy_addr <=0x0fffffff){
			return phy_addr+0x0c000000; 
		}else{
			printk("%s----the addr is out of range ",__FUNCTION__);
			printk("%s----the addr =0x%8x\n ",__FUNCTION__,(unsigned long)addr);
			while(1);
		}
	}
#endif
}

static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
	struct page *page)
{
printk("%s-------%d\n",__FUNCTION__,__LINE__);
#ifdef CONFIG_LOOKLIKE_PC
	return page_to_phys(page) ;
#else
	return page_to_phys(page) | 0x80000000;
#endif
}

static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
{
#if 1
    /*yang23*/
    if(dma_addr >= 0x10000000 && dma_addr <= 0x1bffffff)
        return (dma_addr-0x0c000000);
    else{
        printk("%s----the dma_addr is out of range ",__FUNCTION__);
        printk("%s----the dma_addr =0x%8x\n ",__FUNCTION__,dma_addr);
        while(1);
    }


#else    
    if(dma_addr >= 0x10000000 && dma_addr <= 0x13ffffff)
        return (dma_addr-0x10000000);
    else{
        if(dma_addr >= 0x14000000 && dma_addr <= 0x1bffffff)
            return (dma_addr-0x0c000000);
        else{
            printk("%s----the dma_addr is out of range ",__FUNCTION__);
            printk("%s----the dma_addr =0x%8x\n ",__FUNCTION__,dma_addr);
            while(1);
        }
    }
#endif        
}

static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
{
}

static inline int plat_device_is_coherent(struct device *dev)
{
	return 0;
}

#endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */


