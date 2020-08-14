O_TARGET := synopGMAC.o
#obj-$(CONFIG_SYNOPGMACHOST_PCI) += synop_GMAC_ether.o
obj-$(CONFIG_LS1X_GMAC) += synopGMAC_network_interface.o synopGMAC_Dev.o synopGMAC_plat.o # synopGMAC_platform_interface.o $(synop_GMAC_ether-objs-y)
ifdef CONFIG_PCI
obj-$(CONFIG_LS1X_GMAC) += synopGMAC_pci_bus_interface.o #synopGMAC_Host.o
endif
obj-m := $(O_TARGET)
####################################################
# Explanation for EXTRA_FLAGS
# -DDEBUG		     => Enable the debug trace for driver
# -DIPC_OFFLOAD		     => Enables the IP and TCP checksum offloading feature in HW (IPV4 only)
# -DENH_DESC		     => Enables Enhanced Descriptors 
# -DENH_DESC_8W              => Enable Enhanced Descriptors of 8words or else Descriptor will be of 4words.
####################################################


#with the below flags enables Debug messages

#EXTRA_CFLAGS += -DDEBUG 
#EXTRA_CFLAGS +=-DDEBUG -DIPC_OFFLOAD
#EXTRA_CFLAGS += -DDEBUG -DIPC_OFFLOAD 
#EXTRA_CFLAGS += -DIPC_OFFLOAD 


#Enhanced Descriptor
#EXTRA_CFLAGS += -DENH_DESC 
#EXTRA_CFLAGS += -DENH_DESC -DIPC_OFFLOAD 
#EXTRA_CFLAGS += -DENH_DESC -DENH_DESC_8W
#EXTRA_CFLAGS += -DDEBUG -DENH_DESC -DENH_DESC_8W
#EXTRA_CFLAGS += -DDEBUG -DENH_DESC -DENH_DESC_8W -DIPC_OFFLOAD
#EXTRA_CFLAGS += -DENH_DESC -DENH_DESC_8W -DIPC_OFFLOAD

#EXTRA_CFLAGS  += -DDEBUG

include $(TOPDIR)/Rules.make
