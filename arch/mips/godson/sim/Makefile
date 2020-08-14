# $Id: Makefile,v 1.1.1.1 2006/01/05 06:08:34 root Exp $
#
# Makefile
#
# Carsten Langgaard, carstenl@mips.com
# Copyright (C) 1999 MIPS Technologies, Inc.
#
# ########################################################################
#
# This program is free software; you can distribute it and/or modify it
# under the terms of the GNU General Public License (Version 2) as
# published by the Free Software Foundation.
# 
# This program is distributed in the hope it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
# 
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
#
# #######################################################################
#
USE_STANDARD_AS_RULE := true

all: godson_sim.o
O_TARGET := godson_sim.o

obj-y := \
	init.o \
	memory.o \
	printf.o \
	cmdline.o \
	godson_sim_IRQ.o \
	setup.o \
	irq.o 

include $(TOPDIR)/Rules.make
