#ifdef DEBUG26_RAMDISK_MYUNZIP
/*
 * gzip declarations
 */
#define OF(args)  args

#ifndef memzero
#define memzero(s, n)     memset ((s), 0, (n))
#endif

typedef unsigned char  uch;
typedef unsigned short ush;
typedef unsigned long  ulg;

#define INBUFSIZ 4096
#define WSIZE 0x10000    /* window size--must be a power of two, and */
			/*  at least 32K for zip's deflate method */

static uch *inbuf;
static uch *window;

static unsigned insize;  /* valid bytes in inbuf */
static unsigned inptr;   /* index of next byte to be processed in inbuf */
static unsigned outcnt;  /* bytes in output buffer */
static int exit_code;
static long bytes_out;
static int crd_outfd;

#define get_byte()  (inbuf[inptr++])
		
/* Diagnostic functions (stubbed out) */
#define Assert(cond,msg)
#define Trace(x)
#define Tracev(x)
#define Tracevv(x)
#define Tracec(c,x)
#define Tracecv(c,x)

#define STATIC static

static void flush_window(void);
static void *malloc(int size);
static void free(void *where);
static void error(char *m);
static void gzip_mark(void **);
static void gzip_release(void **);

#include "inflate.c"

static void __init *malloc(int size)
{
	return kmalloc(size, GFP_KERNEL);
}

static void __init free(void *where)
{
	kfree(where);
}

static void __init gzip_mark(void **ptr)
{
}

static void __init gzip_release(void **ptr)
{
}


/* ===========================================================================
 * Write the output window window[0..outcnt-1] and update crc and bytes_out.
 * (Used for the decompressed data only.)
 */
static void __init flush_window(void)
{
    ulg c = crc;         /* temporary variable */
    unsigned n;
    uch *in, ch;
	static int old=0,new=0;
	new=(int)(inptr*100/insize);
    if(new!=old){
		printk("\b\b\b%02d%%",new);
		old=new;
	}
    write(crd_outfd, window, outcnt);
    in = window;
    for (n = 0; n < outcnt; n++) {
	    ch = *in++;
	    c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
    }
    crc = c;
    bytes_out += (ulg)outcnt;
    outcnt = 0;
}

static void __init error(char *x)
{
	printk(KERN_ERR "%s", x);
	exit_code = 1;
}

//#include "../arch/ramdisk.c"
#define MAJOR_NR 1 //RAMDISK_MAJOR// 1
//extern kdev_t ROOT_DEV;

extern void * __rd_start, * __rd_end;

static int __init setup_ramdisk()
{
	int result;
	unsigned long initrd_start;
	unsigned long initrd_end;
	mm_segment_t    oldfs;


	oldfs=get_fs();
	set_fs(KERNEL_DS);
	initrd_start = (unsigned long)&__rd_start;
    initrd_end = (unsigned long)&__rd_end;
		
	
	insize = initrd_end-initrd_start;		/* valid bytes in inbuf */
	inptr = 0;		/* index of next byte to be processed in inbuf */
	outcnt = 0;		/* bytes in output buffer */
	exit_code = 0;
	bytes_out = 0;
	crc = (ulg)0xffffffffL; /* shift register contents */
	
	mknod("/ram1", S_IFBLK|0700, MKDEV(MAJOR_NR, 1));
	result=crd_outfd=open("/ram1",O_RDWR,0);
	if(crd_outfd<0){printk("<1>open /ram0 error\n");goto error;}
	
	if(ROOT_DEV!=MKDEV(MAJOR_NR,1)){
	write(crd_outfd,initrd_start ,(initrd_end-initrd_start));
	result=-1;goto error0;
	}

	printk("<0>unpack ramdisk now...00%%",initrd_start,initrd_end);
	inbuf = (void *)initrd_start;

	window = kmalloc(WSIZE, GFP_KERNEL);
	if (window == 0) {
		printk(KERN_ERR "RAMDISK: Couldn't allocate gzip window\n");
		kfree(inbuf);
		result=-1;
		goto error0;
	}
	makecrc();
	result = gunzip();
	printk(",done,return %d\n",result);
#if 1
	if(result<0)
	{
	printk("<0>not a zip image,use it as root ramdisk directly\n");
	write(crd_outfd,initrd_start ,(initrd_end-initrd_start));
	}
#endif	
	kfree(window);
error0:
	close(crd_outfd);
//	ROOT_DEV=MKDEV(MAJOR_NR,1);
error:
	set_fs(oldfs);
	return result;
}
myinit_begin(setup_ramdisk);
#endif
