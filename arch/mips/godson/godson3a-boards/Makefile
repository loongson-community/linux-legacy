#
# Makefile for ICT CAS GodsonEV2a board.
#
# Note! Dependencies are done automagically by 'make dep', which also
# removes any old dependencies. DON'T put your own dependencies here
# unless it's something special (ie not a .c file).
#

USE_STANDARD_AS_RULE := true

O_TARGET:= nb2005.o
export-objs += printf.o setup.o env.o

obj-y	 += int-handler.o  prom.o setup.o  printf.o 
ifdef CONFIG_GODSON3A_780E
obj-y	 += irq.o rtc.o dbg_io.o fixup-irq.o rs780e-irq.o  pci.o boardinfo.o reset.o mem.o
#obj-y	 += irq.o rtc.o dbg_io.o  cs5536/pci.o cs5536/fixup-cs5536-dev.o cs5536/cs5536_vsm.o cs5536/reset.o
endif


ifdef CONFIG_GODSON2F_LS1A_GOLDING
obj-y	 += ls1a/irq.o ls1a/ls1a_irq.o ls1a/rtc.o ls1a/dbg_io.o ls1a/pci.o  ls1a/ls1a_vsm.o reset.o ls1a/fixup-ls1a.o ls1a/kbd-ls1a.o ls1a/i2c.o
endif

ifeq (,$(findstring dbg_io.o,$(obj-y)))
obj-y	 += irq.o  rtc.o dbg_io.o  pci.o fixup-via.o reset.o
endif

obj-y	+= mipsdha.o

include $(TOPDIR)/Rules.make
