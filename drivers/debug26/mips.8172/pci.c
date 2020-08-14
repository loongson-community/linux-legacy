#include "addrspace.h"
#include "ev8172.h"


#ifndef PCI_BYTE
#define PCI_BYTE	(8)
#endif

#ifndef PCI_WORD
#define PCI_WORD	(16)
#endif

#ifndef PCI_DWORD
#define PCI_DWORD	(32)
#endif

int
sysPciCfgRead (
	int bus,int device,int function, 
	int 		reg, 
	int 		width, 
	unsigned int 	*data)
{


    if (reg < 0 || reg >= 0x100) {
	return ~0;
    }


    if (bus == 0) {
	/* Type 0 configuration on onboard PCI bus */ 
	if (device > 20 || function > 7)
    	return ~0;		/* device out of range */
    } else {
	/* Type 1 configuration on offboard PCI bus */
	if (bus > 255 || device > 31 || function > 7)
    	return ~0;	/* device out of range */
    }

	IT_WRITE(IT_CONFADDR, 
		(bus << IT_BUSNUM_SHF) |
		(device << IT_DEVNUM_SHF) |
		(function << IT_FUNCNUM_SHF) | (reg & ~0x03));

	IT_READ(IT_CONFDATA, *data);
	
	switch (width) { 
			case PCI_BYTE:
			*data = ((*data) >> ((reg & 3) << 3)) & 0x0ff;
			break;

		case PCI_WORD:
			*data = ((*data) >> ((reg & 3) << 3)) & 0xffff;
			break;

		case PCI_DWORD:
			break;
			
		default:
			return ~0;
	}

    return 0;
}

//======================================
// sysPciCfgWrite
//
// IT8172G PCI Configuration write routine
//======================================
int
sysPciCfgWrite (
	int bus, int device, int function, 
	int 		reg, 
	int 		data)
{

    if ((reg & 3) || reg < 0 || reg >= 0x100) {
		return ~0;
    }


    if (bus == 0) {
		/* Type 0 configuration on onboard PCI bus */
		if (device > 20 || function > 7)
	    	return -1;		/* device out of range */
    } else {
		/* Type 1 configuration on offboard PCI bus */
		if (bus > 255 || device > 31 || function > 7)
	    	return -1;	/* device out of range */
    }

	IT_WRITE(IT_CONFADDR, 
		(bus << IT_BUSNUM_SHF) |
		(device << IT_DEVNUM_SHF) |
		(function << IT_FUNCNUM_SHF) | (reg & ~0x03));

	IT_WRITE(IT_CONFDATA, data);
	
	return 0;
}

