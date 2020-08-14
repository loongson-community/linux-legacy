/*
 *
 * BRIEF MODULE DESCRIPTION
 *	LS232 EVA BOARD Interrupt Numbering
 *
 * Copyright 2000 MontaVista Software Inc.
 * Author: MontaVista Software, Inc.
 *         	ppopov@mvista.com or source@mvista.com
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
 */

#ifndef _MIPS_SB2F_BOARD_INT_H
#define _MIPS_SB2F_BOARD_INT_H

#define SB2F_BOARD_ACPI_IRQ		0
#define SB2F_BOARD_HPET_IRQ		1
#define SB2F_BOARD_UART0_IRQ	2
#define SB2F_BOARD_UART1_IRQ	3
#define SB2F_BOARD_UART2_IRQ	4
#define SB2F_BOARD_UART3_IRQ	5
#define SB2F_BOARD_CAN0_IRQ	6
#define SB2F_BOARD_CAN1_IRQ	7
#define SB2F_BOARD_SPI0_IRQ	8
#define SB2F_BOARD_SPI1_IRQ	9
#define SB2F_BOARD_AC97_IRQ	10
#define SB2F_BOARD_MS_IRQ	11
#define SB2F_BOARD_KB_IRQ	12
#define SB2F_BOARD_DMA0_IRQ	13
#define SB2F_BOARD_DMA1_IRQ	14
#define SB2F_BOARD_NAND_IRQ	15
#define SB2F_BOARD_I2C0_IRQ	17
#define SB2F_BOARD_I2C1_IRQ	18
//#define SB2F_BOARD_PWM0_IRQ	18
#define SB2F_BOARD_PWM1_IRQ	19
#define SB2F_BOARD_PWM2_IRQ	20
#define SB2F_BOARD_PWM3_IRQ	21
#define SB2F_BOARD_LPC_IRQ	22
#define SB2F_BOARD_TOY0_IRQ 26
#define SB2F_BOARD_EHCI_IRQ	32
#define SB2F_BOARD_OHCI_IRQ	33
#define SB2F_BOARD_GMAC1_IRQ	34
#define SB2F_BOARD_GMAC2_IRQ	35
#define SB2F_BOARD_SATA_IRQ	36
#define SB2F_BOARD_GPU_IRQ	37
#define SB2F_BOARD_PCI_INTA_IRQ 38
#define SB2F_BOARD_PCI_INTB_IRQ 39
#define SB2F_BOARD_PCI_INTC_IRQ 40
#define SB2F_BOARD_PCI_INTD_IRQ 41

#define SB2F_BOARD_GPIO_IRQ 64
#define SB2F_BOARD_GPIO_FIRST_IRQ 64
#define SB2F_BOARD_GPIO_IRQ_COUNT 96
#define SB2F_BOARD_GPIO_LAST_IRQ  (SB2F_BOARD_GPIO_FIRST_IRQ + SB2F_BOARD_GPIO_IRQ_COUNT-1)

#define INT_PCI_INTA	(1<<6)
#define INT_PCI_INTB	(1<<7)
#define INT_PCI_INTC	(1<<8)
#define INT_PCI_INTD	(1<<9)

#define SB2F_BOARD_LAST_IRQ 159
#define MIPS_CPU_TIMER_IRQ	167
#define SB2F_BOARD_INTREG_BASE 0x12d01040

struct sb2f_board_intc_regs
{
	volatile unsigned int int_isr;
	volatile unsigned int int_en;
	volatile unsigned int int_set;
	volatile unsigned int int_clr;		/* offset 0x10*/
	volatile unsigned int int_pol;
   	volatile unsigned int int_edge;		/* offset 0 */
}; 

#endif
