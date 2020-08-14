ifeq ($(PATCHLEVEL),)
ifndef linux
all:
	@echo make linux=2.6 [name=mydebug] to make modules for linux 2.6.x
	@echo make linux=2.4 [name=mydebug] to make modules for linux 2.4.x
else  #linux
all: clean debug
endif #!linux

ifeq ("$(linux)","2.6")

KERNEL_PATH?=/usr/src/linux-2.6.15 
debug:
	make -C  $(KERNEL_PATH) M=`pwd` modules V=1
	sync

else #linux2.6

KERNEL_PATH?=/usr/src/716/linux-716
TOPDIR=$(KERNEL_PATH)

debug:
	make -C $(KERNEL_PATH) SUBDIRS=`pwd` modules __NR_signal==__NR_O32_signal 
	sync

endif #!linux2.6

else #PATCHLEVEL

ifndef name
name=mydebug
endif

include .config

ifeq ($(PATCHLEVEL),6)
obj-$(CONFIG_DEBUG26):= $(name).o
obj-$(CONFIG_RAMDISK):=rootfs.o
$(name)-objs:= debug.o 

else 
#ifdef MYCONFIG_DEBUG26
O_TARGET    := mydebug.o
#endif

obj-y :=
obj-$(MYCONFIG_DEBUG26) += debug.o
obj-$(MYCONFIG_RAMDISK) +=rootfs.o

#$(name)-objs:= debug.o  
#$(name).o: $($(name)-objs)
#	$(LD) -r -o $@ $($(name)-objs)

		
include $(TOPDIR)/Rules.make
endif 

rootfs.o: disk.gz
	$(CROSS_COMPILE)gcc -c empty.S 
	$(CROSS_COMPILE)objcopy --add-section .initrd=disk.gz \
	empty.o $@

endif #PATCHLEVEL
clean:
	rm -rf *.o *.ko *.mod.c 
menuconfig:
	rm -f *.o
	./mconf Config.in
