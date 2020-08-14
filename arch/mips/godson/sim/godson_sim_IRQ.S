/* $Id: godson_sim_IRQ.S,v 1.1.2.1 2004/06/01 08:45:11 fxzhang Exp $
 *
 * p6032IRQ.S
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
 * Interrupt exception dispatch code.
 *
 */

#include <asm/asm.h>
#include <asm/mipsregs.h>
#include <asm/regdef.h>
#include <asm/stackframe.h>
#include <asm/godson/godson_sim_int.h>

	/* A lot of complication here is taken away because:
	 *
	 * 1) We handle one interrupt and return, sitting in a loop
	 *    and moving across all the pending IRQ bits in the cause
	 *    register is _NOT_ the answer, the common case is one
	 *    pending IRQ so optimize in that direction.
	 *
	 * 2) We need not check against bits in the status register
	 *    IRQ mask, that would make this routine slow as hell.
	 *
	 * 3) Linux only thinks in terms of all IRQs on or all IRQs
	 *    off, nothing in between like BSD spl() brain-damage.
	 *
	 * Furthermore, the IRQs on the Algorithmics P6032  board look 
	 * basically (barring software IRQs which we don't use at all and 
	 * all external interrupt sources are combined together on hardware 
	 * interrupt 0 (MIPS IRQ 2)) like:
	 *
	 *	MIPS IRQ	Source
	 *      --------        ------
	 *             0	Software (ignored)
	 *             1        Software (ignored)
	 *             2        Hardware (ignored)
	 *             3        Serial port 1 (what we use)
	 *             4        Hardware (ignored)
	 *             5        Hardware (ignored)
	 *             6        perfctr interrupt
	 *             7        R4k timer (what we use)
	 *
	 * We handle the IRQ according to _our_ priority which is:
	 *
	 * Highest ----     R4k Timer
	 * Secondly----     Serial port 1 
	 * Lowest  ----     none
	 *
	 * then we just return, if multiple IRQs are pending then
	 * we will just take another exception, big deal.
	 */

	.text
	.set	noreorder
	.set	noat
	.align	5
	NESTED(godson_sim_IRQ, PT_SIZE, sp)
	SAVE_ALL
	CLI
	.set	at

	mfc0	s0, CP0_CAUSE		# get irq mask

	/* First we check for r4k counter/timer IRQ. */
	andi	a0, s0, CAUSEF_IP7
	beq	a0, zero, 1f
	 andi	a0, s0, CAUSEF_IP6	# delay slot, check perfctr interrupt
	

	/* Wheee, a timer interrupt. */
	 li      a0, 63 
	 jal     do_IRQ
	 move    a1, sp  
	 j       ret_from_irq
	 nop				# delay slot

1:	beqz	a0,1f
	andi	a0, s0, CAUSEF_IP3
	
	li	a0, 26
	jal	do_IRQ
	move	a1, sp			# delay slot
	
	j	ret_from_irq
	 nop				# delay slot

1:	beqz	a0,1f
	nop
	
	/* Wheee, serial port 1 interrupt. */
	li	a0, GODSON_SIM_INT_ISACOM1
	jal	do_IRQ
	move	a1, sp			# delay slot
	
	j	ret_from_irq
	 nop				# delay slot



1:
	/* Here by mistake?  This is possible, what can happen
	 * is that by the time we take the exception the IRQ
	 * pin goes low, so just leave if this is the case.
	 */
	j	ret_from_irq
	 nop
	END(godson_sim_IRQ)
