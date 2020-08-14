#
# Makefile for ICT CAS GodsonEV2a board.
#
# Note! Dependencies are done automagically by 'make dep', which also
# removes any old dependencies. DON'T put your own dependencies here
# unless it's something special (ie not a .c file).
#

USE_STANDARD_AS_RULE := true

O_TARGET:= nb2005.o
export-objs += printf.o

obj-y	 += int-handler.o irq.o prom.o reset.o setup.o rtc.o printf.o 

obj-y	+= pci.o

obj-y	+= dbg_io.o

obj-y	+= mipsdha.o

include $(TOPDIR)/Rules.make
