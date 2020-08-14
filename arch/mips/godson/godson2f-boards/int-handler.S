/*
 * Copyright 2001 MontaVista Software Inc.
 * Copyright 2003 ICT CAS
 * Author: jsun@mvista.com or jsun@junsun.net
 *       : guoyi@ict.ac.cn
 *
 * First-level interrupt dispatcher for ocelot board.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */
#define __ASSEMBLY__
#include <linux/config.h>
#include <asm/asm.h>
#include <asm/mipsregs.h>
#include <asm/addrspace.h>
#include <asm/regdef.h>
#include <asm/stackframe.h>

/*
 * first level interrupt dispatcher for ev64240 board -
 * We check for the timer first, then check PCI ints A and D.
 * Then check for serial IRQ and fall through.
 */
		.align	5
		NESTED(nb2005_handle_int, PT_SIZE, sp)

		SAVE_ALL
		CLI
		PTR_LA	ra, ret_from_irq
		.set push
		.set noreorder
		jal plat_irq_dispatch
		move	a0, sp
		beqz v0,1f
		nop
		j spurious_interrupt
		nop
	1:
		j ret_from_irq
		nop
		.set pop

		END(nb2005_handle_int)


