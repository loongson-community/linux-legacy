#include "../arch/ramdisk.c"
#define MAJOR_NR 1 //RAMDISK_MAJOR// 1
extern kdev_t ROOT_DEV;
extern unsigned initrd_start,initrd_end;
static int __init setup_ramdisk()
{
initrd_start=&ramdisk;
initrd_end=&ramdisk[sizeof(ramdisk)];
#define AS_RAMDISK_NOT_AS_INITRD
#ifdef AS_RAMDISK_NOT_AS_INITRD
ROOT_DEV=MKDEV(RAMDISK_MAJOR,0);
#endif
}
