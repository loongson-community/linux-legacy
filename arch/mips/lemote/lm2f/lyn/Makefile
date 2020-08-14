#
# Makefile for Lemote Loongson-2F mini notebook
#

obj-y	+= setup.o prom.o reset.o irq.o bonito-irq.o dbg_io.o i2c.o
obj-$(CONFIG_SUSPEND) += lyn-pm.o

EXTRA_AFLAGS := $(CFLAGS)
