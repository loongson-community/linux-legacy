ifeq ($(PATCHLEVEL),)
-include .config
all: help clean kall

help:
	@echo *****************make menuconfig to change config*************

ifdef DEBUG26_LINUX26

KERNEL_PATH?=/usr/src/linux-2.6.12
kall:
	make -C  $(KERNEL_PATH) M=`pwd` modules V=1
	sync

else #DEBUG26_LINUX26

KERNEL_PATH?=/usr/src/716/linux-716
TOPDIR=$(KERNEL_PATH)

kall:
	make -C $(KERNEL_PATH) SUBDIRS=`pwd` modules __NR_signal==__NR_O32_signal 
	sync

endif #!DEBUG26_LINUX26

else #PATCHLEVEL

ifndef name
name=mydebug
endif


ifeq ($(PATCHLEVEL),6)
-include $(obj)/.config

obj-y := 
obj-m := 
obj-$(DEBUG26_DEBUG26):= ${name}.o  
$(name)-objs += begin.o debug.o end.o

##$(obj)/rootfs.o: $(obj)/disk.gz
## in 2.6's users rules, must add $(obj),because pwd in kernel's source root dir.
	
else 
-include .config
#ifdef DEBUG26_DEBUG26
O_TARGET    := mydebug.o
#endif
obj-y :=
obj-m :=
obj-$(DEBUG26_DEBUG26) += begin.o debug.o end.o
ifdef DEBUG26_RAMDISK
obj-$(DEBUG26_DEBUG26) +=rootfs.o
DEBUG26_RAMDISK_DIR := $(shell echo $(DEBUG26_RAMDISK_DIR))
endif


include $(TOPDIR)/Rules.make

rootfs.o:
	while :;do mountpoint -q ramdisk ||  break; sudo umount ramdisk;done 
	dd if=/dev/zero of=/tmp/disk bs=1K seek=$(DEBUG26_RAMDISK_SIZE) count=0
	echo y|mke2fs -q /tmp/disk 
	sudo mount /tmp/disk ramdisk -o loop
	sudo cp -a $(DEBUG26_RAMDISK_DIR)/* ramdisk
	sync
	sudo umount ramdisk
	gzip -9 /tmp/disk
	$(CROSS_COMPILE)gcc -c empty.S 
	$(CROSS_COMPILE)objcopy --add-section .initrd=/tmp/disk.gz \
	empty.o $@
	rm -f /tmp/disk.gz
	
		
endif 


endif #PATCHLEVEL
clean:
	rm -rf *.o *.ko *.mod.c  disk.gz usermmap
menuconfig: clean
	./mconf Config.in || { make config && ./mconf Config.in; }
usermmap:
	gcc -o usermmap usermmap.c
config:
	make -C scripts/config/ clean all
	gcc -o scripts/bb_mkdep scripts/bb_mkdep.c
	cp scripts/config/mconf .

