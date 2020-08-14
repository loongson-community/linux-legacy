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


ifeq ($(PATCHLEVEL),6)
include $(obj)/.config

obj-y := 
obj-m:= $(name).o
$(name)-objs:= debug.o
obj-$(DEBUG26_DEBUG26) += debug.o
obj-$(DEBUG26_RAMDISK) += null.o
#rootfs.o


$(obj)/null.o: $(obj)/disk.gz
	$(CROSS_COMPILE)gcc -c $(obj)/empty.S -o $(obj)/null.o 
	$(CROSS_COMPILE)objcopy --add-section .initrd=$(obj)/disk.gz \
	$(obj)/null.o $(obj)/rootfs.o
	
else 
include .config
#ifdef DEBUG26_DEBUG26
O_TARGET    := mydebug.o
#endif
obj-y :=
obj-m :=
obj-$(DEBUG26_DEBUG26) +=debug.o
obj-$(DEBUG26_RAMDISK) +=rootfs.o

#$(name)-objs:= debug.o  
#$(name).o: $(obj-y)
#	$(LD) -r -o $@ $(obj-y)

include $(TOPDIR)/Rules.make

rootfs.o: disk.gz
	$(CROSS_COMPILE)gcc -c empty.S 
	$(CROSS_COMPILE)objcopy --add-section .initrd=disk.gz \
	empty.o $@
		
endif 


endif #PATCHLEVEL
clean:
	rm -rf *.o *.ko *.mod.c  vmlinux26
menuconfig:
	rm -f *.o
	./mconf Config.in
vmlinux26: 
	make -C /usr/src/716/linux26-716 vmlinux
	make -C /usr/src/716/linux26-716 -f scripts/Makefile.build obj=`pwd`
	mipsel-linux-ld -T vmlinux.lds -o vmlinux26 /usr/src/716/linux26-716/vmlinux rootfs.o
