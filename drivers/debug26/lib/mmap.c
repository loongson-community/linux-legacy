/*  -*- C -*-
 * mmap.c -- memory mapping for the scullp char module
 *
 * Copyright (C) 2001 Alessandro Rubini and Jonathan Corbet
 * Copyright (C) 2001 O'Reilly & Associates
 *
 * The source code in this file can be freely used, adapted,
 * and redistributed in source or binary form, so long as an
 * acknowledgment appears in derived source files.  The citation
 * should list that the code comes from the book "Linux Device
 * Drivers" by Alessandro Rubini and Jonathan Corbet, published
 * by O'Reilly & Associates.   No warranty is attached;
 * we cannot take responsibility for errors or fitness for use.
 *
 * $Id: _mmap.c.in,v 1.21 2001/07/18 22:28:18 rubini Exp $
 */

#include <linux/autoconf.h>
#include <linux/module.h>

#include <linux/mm.h>     /* everything */
#include <linux/errno.h>  /* error codes */
#include <asm/pgtable.h>
#include <linux/version.h>


/*
 * open and close: just keep track of how many times the device is
 * mapped, to avoid releasing it.
 */
static int dev_vmas;
static struct semaphore dev_sem;

void debug_vma_open(struct vm_area_struct *vma)
{

    dev_vmas++;
}

void debug_vma_close(struct vm_area_struct *vma)
{

    dev_vmas--;
}

#define VMA_OFFSET(vma) (vma->vm_pgoff<<PAGE_SHIFT)

struct page *debug_vma_nopage(struct vm_area_struct *vma,
                                unsigned long address, int *type)
{
    unsigned long offset;
    struct page *page;

    down(&dev_sem);
    offset = (address - vma->vm_start) + VMA_OFFSET(vma);


    page = virt_to_page(__va(offset));

	get_page(page);
    
    up(&dev_sem);
    return page;
}




struct vm_operations_struct debug_vm_ops = {
    open:     debug_vma_open,
    close:  debug_vma_close,
    nopage:   debug_vma_nopage,
};

int debug_mmap(struct file *file, struct vm_area_struct *vma)
{
    vma->vm_ops = &debug_vm_ops;
    vma->vm_flags |= VM_RESERVED;
    debug_vma_open(vma);

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) 
    unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;


    /* Don't try to swap out physical pages.. */
    vma->vm_flags |= VM_RESERVED;

    /*
     * Don't dump addresses that are not real memory to a core file.
     */
    if (offset >= __pa(high_memory) || (file->f_flags & O_SYNC))
        vma->vm_flags |= VM_IO;

    if (remap_page_range(vma->vm_start, offset, vma->vm_end-vma->vm_start,
                 vma->vm_page_prot))
        return -EAGAIN;
    return 0;

#else
    /* Remap-pfn-range will mark the range VM_IO and VM_RESERVED */
    if (remap_pfn_range(vma,
                vma->vm_start,
                vma->vm_pgoff,
                vma->vm_end-vma->vm_start,
                vma->vm_page_prot))
        return -EAGAIN;
    return 0;
#endif
}

static void mmap_init(void)
{
dev_vmas=0;
sema_init(&dev_sem,1);
}
