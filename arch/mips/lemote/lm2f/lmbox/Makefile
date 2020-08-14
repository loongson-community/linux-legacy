#
# Makefile for Lemote Loongson-2F based mini box.
#

obj-y	+= setup.o prom.o reset.o irq.o bonito-irq.o dbg_io.o 

obj-$(CONFIG_SUSPEND) += pm.o

EXTRA_AFLAGS := $(CFLAGS)
