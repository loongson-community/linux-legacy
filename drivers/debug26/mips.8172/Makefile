all: debug
test:
	gcc -D__KERNEL__ -I/usr/src/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer -I /usr/src/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe  -mtune=r5000 -mips2 -Wa,--trap   -DMODULE -mlong-calls  -nostdinc -iwithprefix include -DKBUILD_BASENAME=myusb  -c -o test.o test.c
	sync
debug:
	gcc -I /usr/src/linux/include/ -D__KERNEL__  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer -I /usr/src/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe  -mtune=r5000 -mips2 -Wa,--trap   -DMODULE -mlong-calls  -nostdinc -iwithprefix include -DKBUILD_BASENAME=myusb  -c -o debug.o debug.c
	sync
cpp:
	gcc -D__KERNEL__ -I/usr/src/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer -I /usr/src/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe  -mtune=r5000 -mips2 -Wa,--trap   -DMODULE -mlong-calls  -nostdinc -iwithprefix include -DKBUILD_BASENAME=myusb  -E -C -g -g3 test.c
%.o:%.c
	gcc -D__KERNEL__ -I/usr/src/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer -I /usr/src/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe  -mtune=r5000 -mips2 -Wa,--trap   -DMODULE -mlong-calls  -nostdinc -iwithprefix include -DKBUILD_BASENAME=myusb  -c -o $*.o $*.c
	sync
	
clean:
	rm -f *.o
