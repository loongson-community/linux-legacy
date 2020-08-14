
# Makefile for yeeloong laptop
obj- = yeeloong.o  #built-in.o

obj-$(CONFIG_EC_SCI_DRIVER) += ec_scid.o
ec_scid-objs := ec_sci.o
obj-$(CONFIG_EC_COMMON_OPERATION) += ec_core.o
obj-$(CONFIG_EC_ROM_UPDATE_DRIVER) += ec_rom.o
obj-$(CONFIG_LAPTOP_YEELOONG)	+= yeeloong_laptop.o
obj-$(CONFIG_BIOS_DRIVER)  += pmon_flash.o
obj-$(CONFIG_IO_MSR_DEBUG_DRIVER) += io_msr_debug.o
obj-$(CONFIG_LYNLOONG_9003_BACKLIGHT) += lynloong_9003_bl.o
