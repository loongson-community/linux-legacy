# 1 "drivers/debug26/debug.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "drivers/debug26/debug.c"
# 1 "drivers/debug26/include/config.h" 1
# 2 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/main.c" 1
# 1 "drivers/debug26/include/config.h" 1
# 2 "drivers/debug26/lib/main.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/autoconf.h" 1
# 3 "drivers/debug26/lib/main.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h" 1
# 10 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/config.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/autoconf.h" 1
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/config.h" 2
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/compiler.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/spinlock.h" 1





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sgidefs.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h" 1
# 10 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h"
# 1 "/mnt/opt/toolchain/lib/gcc-lib/mipsel-linux/3.2.3/include/stdarg.h" 1 3
# 43 "/mnt/opt/toolchain/lib/gcc-lib/mipsel-linux/3.2.3/include/stdarg.h" 3
typedef __builtin_va_list __gnuc_va_list;
# 110 "/mnt/opt/toolchain/lib/gcc-lib/mipsel-linux/3.2.3/include/stdarg.h" 3
typedef __gnuc_va_list va_list;
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/linkage.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/stddef.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/types.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/types.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/posix_types.h" 1
# 36 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/posix_types.h"
typedef struct {
        unsigned long fds_bits [(1024/(8 * sizeof(unsigned long)))];
} __kernel_fd_set;


typedef void (*__kernel_sighandler_t)(int);


typedef int __kernel_key_t;

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/posix_types.h" 1
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/posix_types.h"
typedef unsigned int __kernel_dev_t;
typedef unsigned long __kernel_ino_t;
typedef unsigned int __kernel_mode_t;
typedef unsigned int __kernel_nlink_t;
typedef long __kernel_off_t;
typedef int __kernel_pid_t;
typedef int __kernel_ipc_pid_t;
typedef int __kernel_uid_t;
typedef int __kernel_gid_t;
typedef unsigned long __kernel_size_t;
typedef long __kernel_ssize_t;
typedef long __kernel_ptrdiff_t;
typedef long __kernel_time_t;
typedef long __kernel_suseconds_t;
typedef long __kernel_clock_t;
typedef long __kernel_daddr_t;
typedef char * __kernel_caddr_t;

typedef unsigned short __kernel_uid16_t;
typedef unsigned short __kernel_gid16_t;
typedef int __kernel_uid32_t;
typedef int __kernel_gid32_t;
typedef __kernel_uid_t __kernel_old_uid_t;
typedef __kernel_gid_t __kernel_old_gid_t;


typedef long long __kernel_loff_t;


typedef struct {
        int val[2];
} __kernel_fsid_t;


typedef unsigned int __kernel_dev_t32;
typedef unsigned int __kernel_ino_t32;
typedef unsigned int __kernel_mode_t32;
typedef unsigned int __kernel_nlink_t32;
typedef int __kernel_off_t32;
typedef int __kernel_pid_t32;
typedef int __kernel_ipc_pid_t32;
typedef int __kernel_uid_t32;
typedef int __kernel_gid_t32;
typedef unsigned int __kernel_size_t32;
typedef int __kernel_ssize_t32;
typedef int __kernel_ptrdiff_t32;
typedef int __kernel_time_t32;
typedef int __kernel_suseconds_t32;
typedef int __kernel_clock_t32;
typedef int __kernel_daddr_t32;
typedef unsigned int __kernel_caddr_t32;
typedef __kernel_fsid_t __kernel_fsid_t32;




static __inline__ __attribute__((always_inline)) void __FD_SET(unsigned long __fd, __kernel_fd_set *__fdsetp)
{
        unsigned long __tmp = __fd / (8 * sizeof(unsigned long));
        unsigned long __rem = __fd % (8 * sizeof(unsigned long));
        __fdsetp->fds_bits[__tmp] |= (1UL<<__rem);
}


static __inline__ __attribute__((always_inline)) void __FD_CLR(unsigned long __fd, __kernel_fd_set *__fdsetp)
{
        unsigned long __tmp = __fd / (8 * sizeof(unsigned long));
        unsigned long __rem = __fd % (8 * sizeof(unsigned long));
        __fdsetp->fds_bits[__tmp] &= ~(1UL<<__rem);
}


static __inline__ __attribute__((always_inline)) int __FD_ISSET(unsigned long __fd, const __kernel_fd_set *__p)
{
        unsigned long __tmp = __fd / (8 * sizeof(unsigned long));
        unsigned long __rem = __fd % (8 * sizeof(unsigned long));
        return (__p->fds_bits[__tmp] & (1UL<<__rem)) != 0;
}






static __inline__ __attribute__((always_inline)) void __FD_ZERO(__kernel_fd_set *__p)
{
        unsigned long *__tmp = __p->fds_bits;
        int __i;

        if (__builtin_constant_p((1024/(8 * sizeof(unsigned long))))) {
                switch ((1024/(8 * sizeof(unsigned long)))) {
                case 16:
                        __tmp[ 0] = 0; __tmp[ 1] = 0;
                        __tmp[ 2] = 0; __tmp[ 3] = 0;
                        __tmp[ 4] = 0; __tmp[ 5] = 0;
                        __tmp[ 6] = 0; __tmp[ 7] = 0;
                        __tmp[ 8] = 0; __tmp[ 9] = 0;
                        __tmp[10] = 0; __tmp[11] = 0;
                        __tmp[12] = 0; __tmp[13] = 0;
                        __tmp[14] = 0; __tmp[15] = 0;
                        return;

                case 8:
                        __tmp[ 0] = 0; __tmp[ 1] = 0;
                        __tmp[ 2] = 0; __tmp[ 3] = 0;
                        __tmp[ 4] = 0; __tmp[ 5] = 0;
                        __tmp[ 6] = 0; __tmp[ 7] = 0;
                        return;

                case 4:
                        __tmp[ 0] = 0; __tmp[ 1] = 0;
                        __tmp[ 2] = 0; __tmp[ 3] = 0;
                        return;
                }
        }
        __i = (1024/(8 * sizeof(unsigned long)));
        while (__i) {
                __i--;
                *__tmp = 0;
                __tmp++;
        }
}
# 47 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/posix_types.h" 2
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/types.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/types.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/types.h"
typedef unsigned int umode_t;






typedef __signed__ char __s8;
typedef unsigned char __u8;

typedef __signed__ short __s16;
typedef unsigned short __u16;

typedef __signed__ int __s32;
typedef unsigned int __u32;



typedef __signed__ long __s64;
typedef unsigned long __u64;
# 47 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/types.h"
typedef __signed char s8;
typedef unsigned char u8;

typedef __signed short s16;
typedef unsigned short u16;

typedef __signed int s32;
typedef unsigned int u32;



typedef __signed__ long s64;
typedef unsigned long u64;
# 72 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/types.h"
typedef u64 dma_addr_t;
typedef u64 dma64_addr_t;

typedef unsigned long phys_t;
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/types.h" 2



typedef __kernel_fd_set fd_set;
typedef __kernel_dev_t dev_t;
typedef __kernel_ino_t ino_t;
typedef __kernel_mode_t mode_t;
typedef __kernel_nlink_t nlink_t;
typedef __kernel_off_t off_t;
typedef __kernel_pid_t pid_t;
typedef __kernel_daddr_t daddr_t;
typedef __kernel_key_t key_t;
typedef __kernel_suseconds_t suseconds_t;


typedef __kernel_uid32_t uid_t;
typedef __kernel_gid32_t gid_t;
typedef __kernel_uid16_t uid16_t;
typedef __kernel_gid16_t gid16_t;
# 52 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/types.h"
typedef __kernel_loff_t loff_t;
# 61 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/types.h"
typedef __kernel_size_t size_t;




typedef __kernel_ssize_t ssize_t;




typedef __kernel_ptrdiff_t ptrdiff_t;




typedef __kernel_time_t time_t;




typedef __kernel_clock_t clock_t;




typedef __kernel_caddr_t caddr_t;



typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned int u_int;
typedef unsigned long u_long;


typedef unsigned char unchar;
typedef unsigned short ushort;
typedef unsigned int uint;
typedef unsigned long ulong;




typedef __u8 u_int8_t;
typedef __s8 int8_t;
typedef __u16 u_int16_t;
typedef __s16 int16_t;
typedef __u32 u_int32_t;
typedef __s32 int32_t;



typedef __u8 uint8_t;
typedef __u16 uint16_t;
typedef __u32 uint32_t;


typedef __u64 uint64_t;
typedef __u64 u_int64_t;
typedef __s64 int64_t;
# 130 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/types.h"
struct ustat {
        __kernel_daddr_t f_tfree;
        __kernel_ino_t f_tinode;
        char f_fname[6];
        char f_fpack[6];
};
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/byteorder.h" 1
# 24 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/byteorder.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/byteorder/little_endian.h" 1
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/byteorder/little_endian.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/byteorder/swab.h" 1
# 161 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/byteorder/swab.h"
static __inline__ __attribute__((always_inline)) __attribute__((__const__)) __u16 __fswab16(__u16 x)
{
        return ({ __u16 __tmp = (x) ; ({ __u16 __x = (__tmp); ((__u16)( (((__u16)(__x) & (__u16)0x00ffU) << 8) | (((__u16)(__x) & (__u16)0xff00U) >> 8) )); }); });
}
static __inline__ __attribute__((always_inline)) __u16 __swab16p(__u16 *x)
{
        return ({ __u16 __tmp = (*(x)) ; ({ __u16 __x = (__tmp); ((__u16)( (((__u16)(__x) & (__u16)0x00ffU) << 8) | (((__u16)(__x) & (__u16)0xff00U) >> 8) )); }); });
}
static __inline__ __attribute__((always_inline)) void __swab16s(__u16 *addr)
{
        do { *(addr) = ({ __u16 __tmp = (*((addr))) ; ({ __u16 __x = (__tmp); ((__u16)( (((__u16)(__x) & (__u16)0x00ffU) << 8) | (((__u16)(__x) & (__u16)0xff00U) >> 8) )); }); }); } while (0);
}

static __inline__ __attribute__((always_inline)) __attribute__((__const__)) __u32 __fswab24(__u32 x)
{
        return ({ __u32 __tmp = (x) ; ({ __u32 __x = (__tmp); ((__u32)( ((__x & (__u32)0x000000ffUL) << 16) | (__x & (__u32)0x0000ff00UL) | ((__x & (__u32)0x00ff0000UL) >> 16) )); }); });
}
static __inline__ __attribute__((always_inline)) __u32 __swab24p(__u32 *x)
{
        return ({ __u32 __tmp = (*(x)) ; ({ __u32 __x = (__tmp); ((__u32)( ((__x & (__u32)0x000000ffUL) << 16) | (__x & (__u32)0x0000ff00UL) | ((__x & (__u32)0x00ff0000UL) >> 16) )); }); });
}
static __inline__ __attribute__((always_inline)) void __swab24s(__u32 *addr)
{
        do { *(addr) = ({ __u32 __tmp = (*((addr))) ; ({ __u32 __x = (__tmp); ((__u32)( ((__x & (__u32)0x000000ffUL) << 16) | (__x & (__u32)0x0000ff00UL) | ((__x & (__u32)0x00ff0000UL) >> 16) )); }); }); } while (0);
}

static __inline__ __attribute__((always_inline)) __attribute__((__const__)) __u32 __fswab32(__u32 x)
{
        return ({ __u32 __tmp = (x) ; ({ __u32 __x = (__tmp); ((__u32)( (((__u32)(__x) & (__u32)0x000000ffUL) << 24) | (((__u32)(__x) & (__u32)0x0000ff00UL) << 8) | (((__u32)(__x) & (__u32)0x00ff0000UL) >> 8) | (((__u32)(__x) & (__u32)0xff000000UL) >> 24) )); }); });
}
static __inline__ __attribute__((always_inline)) __u32 __swab32p(__u32 *x)
{
        return ({ __u32 __tmp = (*(x)) ; ({ __u32 __x = (__tmp); ((__u32)( (((__u32)(__x) & (__u32)0x000000ffUL) << 24) | (((__u32)(__x) & (__u32)0x0000ff00UL) << 8) | (((__u32)(__x) & (__u32)0x00ff0000UL) >> 8) | (((__u32)(__x) & (__u32)0xff000000UL) >> 24) )); }); });
}
static __inline__ __attribute__((always_inline)) void __swab32s(__u32 *addr)
{
        do { *(addr) = ({ __u32 __tmp = (*((addr))) ; ({ __u32 __x = (__tmp); ((__u32)( (((__u32)(__x) & (__u32)0x000000ffUL) << 24) | (((__u32)(__x) & (__u32)0x0000ff00UL) << 8) | (((__u32)(__x) & (__u32)0x00ff0000UL) >> 8) | (((__u32)(__x) & (__u32)0xff000000UL) >> 24) )); }); }); } while (0);
}


static __inline__ __attribute__((always_inline)) __attribute__((__const__)) __u64 __fswab64(__u64 x)
{





        return ({ __u64 __tmp = (x) ; ({ __u64 __x = (__tmp); ((__u64)( (__u64)(((__u64)(__x) & (__u64)0x00000000000000ffULL) << 56) | (__u64)(((__u64)(__x) & (__u64)0x000000000000ff00ULL) << 40) | (__u64)(((__u64)(__x) & (__u64)0x0000000000ff0000ULL) << 24) | (__u64)(((__u64)(__x) & (__u64)0x00000000ff000000ULL) << 8) | (__u64)(((__u64)(__x) & (__u64)0x000000ff00000000ULL) >> 8) | (__u64)(((__u64)(__x) & (__u64)0x0000ff0000000000ULL) >> 24) | (__u64)(((__u64)(__x) & (__u64)0x00ff000000000000ULL) >> 40) | (__u64)(((__u64)(__x) & (__u64)0xff00000000000000ULL) >> 56) )); }); });

}
static __inline__ __attribute__((always_inline)) __u64 __swab64p(__u64 *x)
{
        return ({ __u64 __tmp = (*(x)) ; ({ __u64 __x = (__tmp); ((__u64)( (__u64)(((__u64)(__x) & (__u64)0x00000000000000ffULL) << 56) | (__u64)(((__u64)(__x) & (__u64)0x000000000000ff00ULL) << 40) | (__u64)(((__u64)(__x) & (__u64)0x0000000000ff0000ULL) << 24) | (__u64)(((__u64)(__x) & (__u64)0x00000000ff000000ULL) << 8) | (__u64)(((__u64)(__x) & (__u64)0x000000ff00000000ULL) >> 8) | (__u64)(((__u64)(__x) & (__u64)0x0000ff0000000000ULL) >> 24) | (__u64)(((__u64)(__x) & (__u64)0x00ff000000000000ULL) >> 40) | (__u64)(((__u64)(__x) & (__u64)0xff00000000000000ULL) >> 56) )); }); });
}
static __inline__ __attribute__((always_inline)) void __swab64s(__u64 *addr)
{
        do { *(addr) = ({ __u64 __tmp = (*((addr))) ; ({ __u64 __x = (__tmp); ((__u64)( (__u64)(((__u64)(__x) & (__u64)0x00000000000000ffULL) << 56) | (__u64)(((__u64)(__x) & (__u64)0x000000000000ff00ULL) << 40) | (__u64)(((__u64)(__x) & (__u64)0x0000000000ff0000ULL) << 24) | (__u64)(((__u64)(__x) & (__u64)0x00000000ff000000ULL) << 8) | (__u64)(((__u64)(__x) & (__u64)0x000000ff00000000ULL) >> 8) | (__u64)(((__u64)(__x) & (__u64)0x0000ff0000000000ULL) >> 24) | (__u64)(((__u64)(__x) & (__u64)0x00ff000000000000ULL) >> 40) | (__u64)(((__u64)(__x) & (__u64)0xff00000000000000ULL) >> 56) )); }); }); } while (0);
}
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/byteorder/little_endian.h" 2
# 82 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/byteorder/little_endian.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/byteorder/generic.h" 1
# 149 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/byteorder/generic.h"
extern __u32 ntohl(__u32);
extern __u32 htonl(__u32);
extern unsigned short int ntohs(unsigned short int);
extern unsigned short int htons(unsigned short int);
# 83 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/byteorder/little_endian.h" 2
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/byteorder.h" 2
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h" 2
# 41 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h"
extern int console_printk[];
# 60 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h"
struct completion;

extern struct notifier_block *panic_notifier_list;
 void panic(const char * fmt, ...)
        __attribute__ ((noreturn, format (printf, 1, 2)));
 void do_exit(long error_code)
        __attribute__((noreturn));
 void complete_and_exit(struct completion *, long)
        __attribute__((noreturn));
extern int abs(int);
extern unsigned long simple_strtoul(const char *,char **,unsigned int);
extern long simple_strtol(const char *,char **,unsigned int);
extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
extern long long simple_strtoll(const char *,char **,unsigned int);
extern int sprintf(char * buf, const char * fmt, ...)
        __attribute__ ((format (printf, 2, 3)));
extern int vsprintf(char *buf, const char *, va_list)
        __attribute__ ((format (printf, 2, 0)));
extern int snprintf(char * buf, size_t size, const char * fmt, ...)
        __attribute__ ((format (printf, 3, 4)));
extern int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
        __attribute__ ((format (printf, 3, 0)));

extern int sscanf(const char *, const char *, ...)
        __attribute__ ((format (scanf, 2, 3)));
extern int vsscanf(const char *, const char *, va_list)
        __attribute__ ((format (scanf, 2, 0)));

extern int get_option(char **str, int *pint);
extern char *get_options(char *str, int nints, int *ints);
extern unsigned long long memparse(char *ptr, char **retptr);
extern void dev_probe_lock(void);
extern void dev_probe_unlock(void);

extern int session_of_pgrp(int pgrp);

 int printk(const char * fmt, ...)
        __attribute__ ((format (printf, 1, 2)));


extern int (*myrt_printk)(const char *fmt, ...);


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void console_silent(void)
{
        (console_printk[0]) = 0;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void console_verbose(void)
{
        if ((console_printk[0]))
                (console_printk[0]) = 15;
}

extern void bust_spinlocks(int yes);
extern int oops_in_progress;

extern int tainted;
extern const char *print_tainted(void);

extern void dump_stack(void);
# 183 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h"
extern void __out_of_line_bug(int line) __attribute__((noreturn));





struct sysinfo {
        long uptime;
        unsigned long loads[3];
        unsigned long totalram;
        unsigned long freeram;
        unsigned long sharedram;
        unsigned long bufferram;
        unsigned long totalswap;
        unsigned long freeswap;
        unsigned short procs;
        unsigned short pad;
        unsigned long totalhigh;
        unsigned long freehigh;
        unsigned int mem_unit;
        char _f[20-2*sizeof(long)-sizeof(int)];
};
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/addrspace.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ptrace.h" 1
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ptrace.h"
struct pt_regs {

        unsigned long pad0[6];


        unsigned long regs[32];


        unsigned long cp0_status;
        unsigned long lo;
        unsigned long hi;
        unsigned long cp0_badvaddr;
        unsigned long cp0_cause;
        unsigned long cp0_epc;
};
# 104 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ptrace.h"
extern void show_regs(struct pt_regs *);
# 20 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h" 2

__asm__ (

        ".macro\t__hard_sti\n\t"



        ".set\tpush\n\t"
        ".set\treorder\n\t"
        ".set\tnoat\n\t"
        "mfc0\t$1,$12\n\t"
        "ori\t$1,0x1f\n\t"
        "xori\t$1,0x1e\n\t"
        "mtc0\t$1,$12\n\t"
        ".set\tpop\n\t"
        ".endm");

extern __inline__ __attribute__((always_inline)) void

  hard_sti(void)



{
        __asm__ __volatile__(



                "__hard_sti"

                :
                :
                : "memory");
}
# 62 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
__asm__ (

        ".macro\t__hard_cli\n\t"



        ".set\tpush\n\t"
        ".set\treorder\n\t"
        ".set\tnoat\n\t"
        "mfc0\t$1,$12\n\t"
        "ori\t$1,1\n\t"
        "xori\t$1,1\n\t"
        ".set\tnoreorder\n\t"
        "mtc0\t$1,$12\n\t"
        "sll\t$0, $0, 1\t\t\t# nop\n\t"
        "sll\t$0, $0, 1\t\t\t# nop\n\t"
        "sll\t$0, $0, 1\t\t\t# nop\n\t"
        ".set\tpop\n\t"
        ".endm");

extern __inline__ __attribute__((always_inline)) void

  hard_cli(void)



{
        __asm__ __volatile__(



                "__hard_cli"

                :
                :
                : "memory");
}
# 156 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
extern __inline__ __attribute__((always_inline)) void __hard_save_flags(unsigned long *x)
{
   __asm__ __volatile__(
                        ".set\tpush\n\t"
                        ".set\treorder\n\t"
                        "mfc0\t%0,$12\n\t"
                        ".set\tpop\n\t"
                        : "=r" (*x));
}

extern __inline__ __attribute__((always_inline)) void __hard_save_flags_and_cli(unsigned long *x)
{
   __asm__ __volatile__(
                        ".set\tpush\n\t"
                        ".set\treorder\n\t"
                        ".set\tnoat\n\t"
                        "mfc0\t%0,$12\n\t"
                        "ori\t$1,%0,1\n\t"
                        "xori\t$1,1\n\t"
                        ".set\tnoreorder\n\t"
                        "mtc0\t$1,$12\n\t"
                        "nop\n\t"
                        "nop\n\t"
                        "nop\n\t"
                        ".set\tpop\n\t"
                        : "=r" (*x)
                        :
                        : "$1", "memory");
}

extern __inline__ __attribute__((always_inline)) void __hard_save_flags_and_sti(unsigned long *x)
{
   __asm__ __volatile__(
           ".set\tpush\n\t"
           ".set\treorder\n\t"
           ".set\tnoat\n\t"
           "mfc0\t%0,$12\n\t"
           "ori\t$1,%0,1\n\t"
           ".set\tnoreorder\n\t"
           "mtc0\t$1,$12\n\t"
           "nop\n\t"
           "nop\n\t"
           "nop\n\t"
           ".set\tpop\n\t"
           : "=r" (*x)
           :
           : "$1", "memory");
}
# 229 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
__asm__(".macro\t__hard_restore_flags flags\n\t"

        ".set\tnoreorder\n\t"
        ".set\tnoat\n\t"
        "mfc0\t$1, $12\n\t"
        "andi\t\\flags, 1\n\t"
        "ori\t$1, 1\n\t"
        "xori\t$1, 1\n\t"
        "or\t\\flags, $1\n\t"
        "mtc0\t\\flags, $12\n\t"
        "sll\t$0, $0, 1\t\t\t# nop\n\t"
        "sll\t$0, $0, 1\t\t\t# nop\n\t"
        "sll\t$0, $0, 1\t\t\t# nop\n\t"
        ".set\tat\n\t"
        ".set\treorder\n\t"
        ".endm");
# 296 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
struct rt_hal {
   void *ret_from_intr;
   unsigned int (*mips_timer_interrupt)(int irq, struct pt_regs *regs);
   unsigned int (*mips_interrupt)(int irq, struct pt_regs *regs);
   long long (*rtai_srq_interrupt)(unsigned int srq, unsigned int args);
   void (*disint)(void);
   void (*enint)(void);
   unsigned int rtai_active;
   unsigned long (*getflags)(void);
   void (*setflags)(unsigned long flags);
   unsigned long (*getflags_and_cli)(void);
   void *irq_desc;
   union { unsigned long tsc; unsigned int hltsc[2]; } tsc;
   void (*linux_mips_timer_intr)(int irq, void *dev_id, struct pt_regs *regs);
   void (*linux_soft_mips_timer_intr)(int irq, void *dev_id, struct pt_regs *regs);
   unsigned long (*getflags_and_sti)(void);
   void (*soft_enint)(void);
};

extern struct rt_hal rthal;
# 394 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
extern void *resume(void *last, void *next);



struct task_struct;






extern __inline__ __attribute__((always_inline)) unsigned long xchg_u32(volatile int * m, unsigned long val)
{
        unsigned long dummy;

        __asm__ __volatile__(
                ".set\tpush\t\t\t\t# xchg_u32\n\t"
                ".set\tnoreorder\n\t"
                ".set\tnomacro\n\t"
                "ll\t%0, %3\n"
                "1:\tmove\t%2, %z4\n\t"
                "sc\t%2, %1\n\t"
                "beqzl\t%2, 1b\n\t"
                " ll\t%0, %3\n\t"
                "sync\n\t"
                ".set\tpop"
                : "=&r" (val), "=m" (*m), "=&r" (dummy)
                : "R" (*m), "Jr" (val)
                : "memory");

        return val;
}

extern __inline__ __attribute__((always_inline)) unsigned long xchg_u64(volatile int * m, unsigned long val)
{
        unsigned long dummy;

        __asm__ __volatile__(
                ".set\tpush\t\t\t\t# xchg_u64\n\t"
                ".set\tnoreorder\n\t"
                ".set\tnomacro\n\t"
                "lld\t%0, %3\n"
                "1:\tmove\t%2, %z4\n\t"
                "scd\t%2, %1\n\t"
                "beqzl\t%2, 1b\n\t"
                " lld\t%0, %3\n\t"
                "sync\n\t"
                ".set\tpop"
                : "=&r" (val), "=m" (*m), "=&r" (dummy)
                : "R" (*m), "Jr" (val)
                : "memory");

        return val;
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long __xchg(unsigned long x, volatile void * ptr,
                                   int size)
{
        switch (size) {
                case 4:
                        return xchg_u32(ptr, x);
                case 8:
                        return xchg_u64(ptr, x);
        }
        return x;
}

extern void *set_except_vector(int n, void *addr);
extern void per_cpu_trap_init(void);

extern void __die(const char *, struct pt_regs *, const char *file,
        const char *func, unsigned long line) __attribute__((noreturn));
extern void __die_if_kernel(const char *, struct pt_regs *, const char *file,
        const char *func, unsigned long line);
# 7 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/spinlock.h" 2
# 42 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/spinlock.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/stringify.h" 1
# 43 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/spinlock.h" 2
# 77 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/spinlock.h"
  typedef struct { } spinlock_t;
# 141 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/spinlock.h"
  typedef struct { } rwlock_t;
# 172 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/spinlock.h"
typedef struct {
    spinlock_t lock;
} spinlock_cacheline_t;
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/list.h" 1





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/prefetch.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/prefetch.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/cache.h" 1




# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cache.h" 1
# 6 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/cache.h" 2
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 34 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smp.h" 1
# 35 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cachectl.h" 1
# 37 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cpu.h" 1
# 38 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h" 1
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/hazards.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h" 2
# 857 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tlb_probe(void)
{
        do { } while (0);
        __asm__ __volatile__(
                ".set noreorder\n\t"
                "tlbp\n\t"
                ".set reorder");
        do { } while (0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tlb_read(void)
{
        do { } while (0);
        __asm__ __volatile__(
                ".set noreorder\n\t"
                "tlbr\n\t"
                ".set reorder");
        do { } while (0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tlb_write_indexed(void)
{
        do { } while (0);
        __asm__ __volatile__(
                ".set noreorder\n\t"
                "tlbwi\n\t"
                ".set reorder");
        do { } while (0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tlb_write_random(void)
{
        do { } while (0);
        __asm__ __volatile__(
                ".set noreorder\n\t"
                "tlbwr\n\t"
                ".set reorder");
        do { } while (0);
}
# 938 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int set_c0_status(unsigned int set) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$12" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$12" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res |= set; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$12" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$12" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int clear_c0_status(unsigned int clear) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$12" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$12" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~clear; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$12" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$12" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int change_c0_status(unsigned int change, unsigned int new) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$12" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$12" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~change; res |= (new & change); do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$12" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$12" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int set_c0_cause(unsigned int set) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$13" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$13" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res |= set; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$13" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$13" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int clear_c0_cause(unsigned int clear) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$13" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$13" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~clear; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$13" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$13" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int change_c0_cause(unsigned int change, unsigned int new) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$13" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$13" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~change; res |= (new & change); do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$13" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$13" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int set_c0_config(unsigned int set) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$16" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$16" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res |= set; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$16" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$16" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int clear_c0_config(unsigned int clear) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$16" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$16" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~clear; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$16" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$16" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int change_c0_config(unsigned int change, unsigned int new) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$16" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$16" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~change; res |= (new & change); do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$16" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$16" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int set_c0_intcontrol(unsigned int set) { unsigned int res; res = ({ int __res; __asm__ __volatile__( "cfc0\t%0, " "$20" "\n\t" : "=r" (__res)); __res; }); res |= set; do { __asm__ __volatile__( "ctc0\t%z0, " "$20" "\n\t" : : "Jr" ((unsigned int)res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int clear_c0_intcontrol(unsigned int clear) { unsigned int res; res = ({ int __res; __asm__ __volatile__( "cfc0\t%0, " "$20" "\n\t" : "=r" (__res)); __res; }); res &= ~clear; do { __asm__ __volatile__( "ctc0\t%z0, " "$20" "\n\t" : : "Jr" ((unsigned int)res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int change_c0_intcontrol(unsigned int change, unsigned int new) { unsigned int res; res = ({ int __res; __asm__ __volatile__( "cfc0\t%0, " "$20" "\n\t" : "=r" (__res)); __res; }); res &= ~change; res |= (new & change); do { __asm__ __volatile__( "ctc0\t%z0, " "$20" "\n\t" : : "Jr" ((unsigned int)res)); } while (0); return res; }
# 39 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/reg.h" 1
# 40 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 50 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
struct cache_desc {
        unsigned short linesz;
        unsigned short ways;
        unsigned short sets;
        unsigned int waysize;
        unsigned int waybit;
        unsigned int flags;
};
# 67 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
struct cpuinfo_mips {
        unsigned long udelay_val;
        unsigned long *pgd_quick;
        unsigned long *pmd_quick;
        unsigned long *pte_quick;
        unsigned long pgtable_cache_sz;
        unsigned long asid_cache;
# 94 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
        unsigned long options;
        unsigned int processor_id;
        unsigned int fpu_id;
        unsigned int cputype;
        int isa_level;
        int tlbsize;
        struct cache_desc icache;
        struct cache_desc dcache;
        struct cache_desc scache;
        struct cache_desc tcache;
} __attribute__((aligned(32)));
# 140 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
extern struct cpuinfo_mips cpu_data[];


extern void cpu_probe(void);
extern void cpu_report(void);




extern void (*cpu_wait)(void);

extern unsigned int vced_count, vcei_count;
# 187 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
struct mips_fpu_hard_struct {
        unsigned long fp_regs[32];
        unsigned int control;
};







typedef u64 fpureg_t;
struct mips_fpu_soft_struct {
        fpureg_t regs[32];
        unsigned int sr;
};

union mips_fpu_union {
        struct mips_fpu_hard_struct hard;
        struct mips_fpu_soft_struct soft;
};





typedef struct {
        unsigned long seg;
} mm_segment_t;




struct thread_struct {

        unsigned long reg16;
        unsigned long reg17, reg18, reg19, reg20, reg21, reg22, reg23;
        unsigned long reg29, reg30, reg31;


        unsigned long cp0_status;


        union mips_fpu_union fpu;


        unsigned long cp0_badvaddr;
        unsigned long cp0_baduaddr;
        unsigned long error_code;
        unsigned long trap_no;




        unsigned long mflags;
        mm_segment_t current_ds;
        unsigned long irix_trampoline;
        unsigned long irix_oldctx;
};
# 287 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);





struct mips_frame_info {
        int frame_offset;
        int pc_offset;
};
extern struct mips_frame_info schedule_frame;



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long thread_saved_pc(struct thread_struct *t)
{
        extern void ret_from_sys_call(void);


        if (t->reg31 == (unsigned long) ret_from_sys_call)
                return t->reg31;

        if (schedule_frame.pc_offset < 0)
                return 0;
        return ((unsigned long *)t->reg29)[schedule_frame.pc_offset];
}






extern void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp);

struct task_struct;
unsigned long get_wchan(struct task_struct *p);
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/prefetch.h" 2
# 43 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/prefetch.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void prefetch(const void *x) {;}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void prefetchw(const void *x) {;}
# 7 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/list.h" 2
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/list.h"
struct list_head {
        struct list_head *next, *prev;
};
# 37 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/list.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __list_add(struct list_head *new,
                              struct list_head *prev,
                              struct list_head *next)
{
        next->prev = new;
        new->next = next;
        new->prev = prev;
        prev->next = new;
}
# 55 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/list.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void list_add(struct list_head *new, struct list_head *head)
{
        __list_add(new, head, head->next);
}
# 68 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/list.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void list_add_tail(struct list_head *new, struct list_head *head)
{
        __list_add(new, head->prev, head);
}
# 80 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/list.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __list_del(struct list_head *prev, struct list_head *next)
{
        next->prev = prev;
        prev->next = next;
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void list_del(struct list_head *entry)
{
        __list_del(entry->prev, entry->next);
        entry->next = (void *) 0;
        entry->prev = (void *) 0;
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void list_del_init(struct list_head *entry)
{
        __list_del(entry->prev, entry->next);
        do { (entry)->next = (entry); (entry)->prev = (entry); } while (0);
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void list_move(struct list_head *list, struct list_head *head)
{
        __list_del(list->prev, list->next);
        list_add(list, head);
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void list_move_tail(struct list_head *list,
                                  struct list_head *head)
{
        __list_del(list->prev, list->next);
        list_add_tail(list, head);
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int list_empty(struct list_head *head)
{
        return head->next == head;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __list_splice(struct list_head *list,
                                 struct list_head *head)
{
        struct list_head *first = list->next;
        struct list_head *last = list->prev;
        struct list_head *at = head->next;

        first->prev = head;
        head->next = first;

        last->next = at;
        at->prev = last;
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void list_splice(struct list_head *list, struct list_head *head)
{
        if (!list_empty(list))
                __list_splice(list, head);
}
# 172 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/list.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void list_splice_init(struct list_head *list,
                                    struct list_head *head)
{
        if (!list_empty(list)) {
                __list_splice(list, head);
                do { (list)->next = (list); (list)->prev = (list); } while (0);
        }
}
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h" 2
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/atomic.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/atomic.h"
typedef struct { volatile int counter; } atomic_t;
# 43 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/atomic.h"
static __inline__ __attribute__((always_inline)) void atomic_add(int i, volatile atomic_t * v)
{
        unsigned long temp;

        __asm__ __volatile__(
                "1:\tll\t%0,%1\t\t\t# atomic_add\n\t"
                "addu\t%0,%2\n\t"
                "sc\t%0,%1\n\t"
                "beqz\t%0,1b"
                : "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter));
}
# 64 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/atomic.h"
static __inline__ __attribute__((always_inline)) void atomic_sub(int i, volatile atomic_t * v)
{
        unsigned long temp;

        __asm__ __volatile__(
                "1:\tll\t%0,%1\t\t\t# atomic_sub\n\t"
                "subu\t%0,%2\n\t"
                "sc\t%0,%1\n\t"
                "beqz\t%0,1b"
                : "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter));
}




static __inline__ __attribute__((always_inline)) int atomic_add_return(int i, atomic_t * v)
{
        unsigned long temp, result;

        __asm__ __volatile__(
                ".set\tnoreorder\t\t\t# atomic_add_return\n"
                "1:\tll\t%1,%2\n\t"
                "addu\t%0,%1,%3\n\t"
                "sc\t%0,%2\n\t"
                "beqz\t%0,1b\n\t"
                "addu\t%0,%1,%3\n\t"
                "sync\n\t"
                ".set\treorder"
                : "=&r" (result), "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter)
                : "memory");

        return result;
}

static __inline__ __attribute__((always_inline)) int atomic_sub_return(int i, atomic_t * v)
{
        unsigned long temp, result;

        __asm__ __volatile__(
                ".set\tnoreorder\t\t\t# atomic_sub_return\n"
                "1:\tll\t%1,%2\n\t"
                "subu\t%0,%1,%3\n\t"
                "sc\t%0,%2\n\t"
                "beqz\t%0,1b\n\t"
                "subu\t%0,%1,%3\n\t"
                "sync\n\t"
                ".set\treorder"
                : "=&r" (result), "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter)
                : "memory");

        return result;
}
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h" 2


struct exception_table_entry;


struct kernel_sym
{
        unsigned long value;
        char name[60];
};

struct module_symbol
{
        unsigned long value;
        const char *name;
};

struct module_ref
{
        struct module *dep;
        struct module *ref;
        struct module_ref *next_ref;
};


struct module_persist;

struct module
{
        unsigned long size_of_struct;
        struct module *next;
        const char *name;
        unsigned long size;

        union
        {
                atomic_t usecount;
                long pad;
        } uc;

        unsigned long flags;

        unsigned nsyms;
        unsigned ndeps;

        struct module_symbol *syms;
        struct module_ref *deps;
        struct module_ref *refs;
        int (*init)(void);
        void (*cleanup)(void);
        const struct exception_table_entry *ex_table_start;
        const struct exception_table_entry *ex_table_end;






        const struct module_persist *persist_start;
        const struct module_persist *persist_end;
        int (*can_unload)(void);
        int runsize;
        const char *kallsyms_start;
        const char *kallsyms_end;
        const char *archdata_start;
        const char *archdata_end;
        const char *kernel_data;
};

struct module_info
{
        unsigned long addr;
        unsigned long size;
        unsigned long flags;
        long usecount;
};
# 184 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h"
extern void inter_module_register(const char *, struct module *, const void *);
extern void inter_module_unregister(const char *);
extern const void *inter_module_get(const char *);
extern const void *inter_module_get_request(const char *, const char *);
extern void inter_module_put(const char *);

struct inter_module_entry {
        struct list_head list;
        const char *im_name;
        struct module *owner;
        const void *userdata;
};

extern int try_inc_mod_count(struct module *mod);
# 332 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/module.h"
extern struct module *module_list;
# 4 "drivers/debug26/lib/main.c" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h" 1
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if.h" 1
# 23 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h" 1
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h"
struct __kernel_sockaddr_storage {
        unsigned short ss_family;

        char __data[128 - sizeof(unsigned short)];


} __attribute__ ((aligned((__alignof__ (struct sockaddr *)))));



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/socket.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/socket.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sockios.h" 1
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sockios.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ioctl.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sockios.h" 2
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/socket.h" 2
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sockios.h" 1
# 23 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/uio.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/uio.h"
struct iovec
{
        void *iov_base;
        __kernel_size_t iov_len;
};
# 24 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h" 2


typedef unsigned short sa_family_t;





struct sockaddr {
        sa_family_t sa_family;
        char sa_data[14];
};

struct linger {
        int l_onoff;
        int l_linger;
};
# 50 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h"
struct msghdr {
        void * msg_name;
        int msg_namelen;
        struct iovec * msg_iov;
        __kernel_size_t msg_iovlen;
        void * msg_control;
        __kernel_size_t msg_controllen;
        unsigned msg_flags;
};







struct cmsghdr {
        __kernel_size_t cmsg_len;
        int cmsg_level;
        int cmsg_type;
};
# 123 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct cmsghdr * __cmsg_nxthdr(void *__ctl, __kernel_size_t __size,
                                               struct cmsghdr *__cmsg)
{
        struct cmsghdr * __ptr;

        __ptr = (struct cmsghdr*)(((unsigned char *) __cmsg) + ( ((__cmsg->cmsg_len)+sizeof(long)-1) & ~(sizeof(long)-1) ));
        if ((unsigned long)((char*)(__ptr+1) - (char *) __ctl) > __size)
                return (struct cmsghdr *)0;

        return __ptr;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr *__cmsg)
{
        return __cmsg_nxthdr(__msg->msg_control, __msg->msg_controllen, __cmsg);
}






struct ucred {
        __u32 pid;
        __u32 uid;
        __u32 gid;
};
# 270 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h"
extern int memcpy_fromiovec(unsigned char *kdata, struct iovec *iov, int len);
extern int memcpy_fromiovecend(unsigned char *kdata, struct iovec *iov,
                                int offset, int len);
extern int csum_partial_copy_fromiovecend(unsigned char *kdata,
                                          struct iovec *iov,
                                          int offset,
                                          unsigned int len, int *csump);

extern int verify_iovec(struct msghdr *m, struct iovec *iov, char *address, int mode);
extern int memcpy_toiovec(struct iovec *v, unsigned char *kdata, int len);
extern void memcpy_tokerneliovec(struct iovec *iov, unsigned char *kdata, int len);
extern int move_addr_to_user(void *kaddr, int klen, void *uaddr, int *ulen);
extern int move_addr_to_kernel(void *uaddr, int ulen, void *kaddr);
extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
# 24 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if.h" 2


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/hdlc/ioctl.h" 1



typedef struct {
        unsigned int clock_rate;
        unsigned int clock_type;
        unsigned short loopback;
} sync_serial_settings;

typedef struct {
        unsigned int clock_rate;
        unsigned int clock_type;
        unsigned short loopback;
        unsigned int slot_map;
} te1_settings;

typedef struct {
        unsigned short encoding;
        unsigned short parity;
} raw_hdlc_proto;

typedef struct {
        unsigned int t391;
        unsigned int t392;
        unsigned int n391;
        unsigned int n392;
        unsigned int n393;
        unsigned short lmi;
        unsigned short dce;
} fr_proto;

typedef struct {
        unsigned int dlci;
} fr_proto_pvc;

typedef struct {
        unsigned int dlci;
        char master[16];
}fr_proto_pvc_info;

typedef struct {
    unsigned int interval;
    unsigned int timeout;
} cisco_proto;
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if.h" 2
# 93 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if.h"
struct ifmap
{
        unsigned long mem_start;
        unsigned long mem_end;
        unsigned short base_addr;
        unsigned char irq;
        unsigned char dma;
        unsigned char port;

};

struct if_settings
{
        unsigned int type;
        unsigned int size;
        union {

                raw_hdlc_proto *raw_hdlc;
                cisco_proto *cisco;
                fr_proto *fr;
                fr_proto_pvc *fr_pvc;
                fr_proto_pvc_info *fr_pvc_info;


                sync_serial_settings *sync;
                te1_settings *te1;
        } ifs_ifsu;
};
# 129 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if.h"
struct ifreq
{

        union
        {
                char ifrn_name[16];
        } ifr_ifrn;

        union {
                struct sockaddr ifru_addr;
                struct sockaddr ifru_dstaddr;
                struct sockaddr ifru_broadaddr;
                struct sockaddr ifru_netmask;
                struct sockaddr ifru_hwaddr;
                short ifru_flags;
                int ifru_ivalue;
                int ifru_mtu;
                struct ifmap ifru_map;
                char ifru_slave[16];
                char ifru_newname[16];
                char * ifru_data;
                struct if_settings ifru_settings;
        } ifr_ifru;
};
# 179 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if.h"
struct ifconf
{
        int ifc_len;
        union
        {
                char * ifcu_buf;
                struct ifreq *ifcu_req;
        } ifc_ifcu;
};
# 29 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if_ether.h" 1
# 97 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if_ether.h"
struct ethhdr
{
        unsigned char h_dest[6];
        unsigned char h_source[6];
        unsigned short h_proto;
} __attribute__((packed));
# 30 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if_packet.h" 1



struct sockaddr_pkt
{
        unsigned short spkt_family;
        unsigned char spkt_device[14];
        unsigned short spkt_protocol;
};

struct sockaddr_ll
{
        unsigned short sll_family;
        unsigned short sll_protocol;
        int sll_ifindex;
        unsigned short sll_hatype;
        unsigned char sll_pkttype;
        unsigned char sll_halen;
        unsigned char sll_addr[8];
};
# 43 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if_packet.h"
struct tpacket_stats
{
        unsigned int tp_packets;
        unsigned int tp_drops;
};

struct tpacket_hdr
{
        unsigned long tp_status;





        unsigned int tp_len;
        unsigned int tp_snaplen;
        unsigned short tp_mac;
        unsigned short tp_net;
        unsigned int tp_sec;
        unsigned int tp_usec;
};
# 82 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/if_packet.h"
struct tpacket_req
{
        unsigned int tp_block_size;
        unsigned int tp_block_nr;
        unsigned int tp_frame_size;
        unsigned int tp_frame_nr;
};

struct packet_mreq
{
        int mr_ifindex;
        unsigned short mr_type;
        unsigned short mr_alen;
        unsigned char mr_address[8];
};
# 31 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h" 2
# 42 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h"
struct divert_blk;
struct vlan_group;
struct ethtool_ops;
# 104 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h"
struct net_device_stats
{
        unsigned long rx_packets;
        unsigned long tx_packets;
        unsigned long rx_bytes;
        unsigned long tx_bytes;
        unsigned long rx_errors;
        unsigned long tx_errors;
        unsigned long rx_dropped;
        unsigned long tx_dropped;
        unsigned long multicast;
        unsigned long collisions;


        unsigned long rx_length_errors;
        unsigned long rx_over_errors;
        unsigned long rx_crc_errors;
        unsigned long rx_frame_errors;
        unsigned long rx_fifo_errors;
        unsigned long rx_missed_errors;


        unsigned long tx_aborted_errors;
        unsigned long tx_carrier_errors;
        unsigned long tx_fifo_errors;
        unsigned long tx_heartbeat_errors;
        unsigned long tx_window_errors;


        unsigned long rx_compressed;
        unsigned long tx_compressed;
};



enum {
        IF_PORT_UNKNOWN = 0,
        IF_PORT_10BASE2,
        IF_PORT_10BASET,
        IF_PORT_AUI,
        IF_PORT_100BASET,
        IF_PORT_100BASETX,
        IF_PORT_100BASEFX
};



extern const char *if_port_text[];


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/param.h" 1
# 23 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/param.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/compiler.h" 1
# 24 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/param.h" 2
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2

extern unsigned long event;


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/binfmts.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ptrace.h" 1
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/binfmts.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/capability.h" 1
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/capability.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 1
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/limits.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/break.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h" 2
# 34 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cacheflush.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cacheflush.h"
struct mm_struct;
struct vm_area_struct;
struct page;
# 33 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cacheflush.h"
extern void (*_flush_cache_all)(void);
extern void (*___flush_cache_all)(void);
extern void (*_flush_cache_mm)(struct mm_struct *mm);
extern void (*_flush_cache_range)(struct mm_struct *mm, unsigned long start,
        unsigned long end);
extern void (*_flush_cache_page)(struct vm_area_struct *vma,
        unsigned long page);
extern void flush_dcache_page(struct page * page);
extern void (*_flush_icache_range)(unsigned long start, unsigned long end);
extern void (*_flush_icache_page)(struct vm_area_struct *vma,
        struct page *page);

extern void (*_flush_cache_sigtramp)(unsigned long addr);
extern void (*_flush_icache_all)(void);
extern void (*_flush_data_cache_page)(unsigned long addr);
# 35 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h" 2
# 43 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h"
extern void clear_page(void * page);
extern void copy_page(void * to, void * from);

extern unsigned long shm_align_mask;

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long pages_do_alias(unsigned long addr1,
        unsigned long addr2)
{
        return (addr1 ^ addr2) & shm_align_mask;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void clear_user_page(void *page, unsigned long vaddr)
{
        unsigned long kaddr = (unsigned long) page;

        clear_page(page);
        if (pages_do_alias(kaddr, vaddr))
                _flush_data_cache_page(kaddr);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void copy_user_page(void * to, void * from, unsigned long vaddr)
{
        unsigned long kto = (unsigned long) to;

        copy_page(to, from);
        if (pages_do_alias(kto, vaddr))
                _flush_data_cache_page(kto);
}




typedef struct { unsigned long pte; } pte_t;
typedef struct { unsigned long pmd; } pmd_t;
typedef struct { unsigned long pgd; } pgd_t;
typedef struct { unsigned long pgprot; } pgprot_t;
# 93 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h"
static __inline__ __attribute__((always_inline)) int get_order(unsigned long size)
{
        int order;

        size = (size-1) >> (14 -1);
        order = -1;
        do {
                size >>= 1;
                order++;
        } while (size);
        return order;
}
# 20 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h" 2
# 31 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h"
struct __wait_queue {
        unsigned int flags;

        struct task_struct * task;
        struct list_head task_list;




};
typedef struct __wait_queue wait_queue_t;
# 77 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h"
struct __wait_queue_head {
        spinlock_t lock;
        struct list_head task_list;




};
typedef struct __wait_queue_head wait_queue_head_t;
# 155 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void init_waitqueue_head(wait_queue_head_t *q)
{




        q->lock = (spinlock_t) { };
        do { (&q->task_list)->next = (&q->task_list); (&q->task_list)->prev = (&q->task_list); } while (0);




}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
{




        q->flags = 0;
        q->task = p;



}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int waitqueue_active(wait_queue_head_t *q)
{






        return !list_empty(&q->task_list);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __add_wait_queue(wait_queue_head_t *head, wait_queue_t *new)
{
# 203 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h"
        list_add(&new->task_list, &head->task_list);
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __add_wait_queue_tail(wait_queue_head_t *head,
                                                wait_queue_t *new)
{
# 220 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h"
        list_add_tail(&new->task_list, &head->task_list);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __remove_wait_queue(wait_queue_head_t *head,
                                                        wait_queue_t *old)
{





        list_del(&old->task_list);
}
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/vfs.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/statfs.h" 1
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/statfs.h"
typedef __kernel_fsid_t fsid_t;



struct statfs {
        long f_type;

        long f_bsize;
        long f_frsize;
        long f_blocks;
        long f_bfree;
        long f_files;
        long f_ffree;


        long f_bavail;
        __kernel_fsid_t f_fsid;
        long f_namelen;
        long f_spare[6];
};
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/vfs.h" 2
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/net.h" 1
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/net.h"
struct poll_table_struct;
# 49 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/net.h"
typedef enum {
  SS_FREE = 0,
  SS_UNCONNECTED,
  SS_CONNECTING,
  SS_CONNECTED,
  SS_DISCONNECTING
} socket_state;
# 65 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/net.h"
struct socket
{
        socket_state state;

        unsigned long flags;
        struct proto_ops *ops;
        struct inode *inode;
        struct fasync_struct *fasync_list;
        struct file *file;
        struct sock *sk;
        wait_queue_head_t wait;

        short type;
        unsigned char passcred;
};



struct scm_cookie;
struct vm_area_struct;
struct page;

struct proto_ops {
  int family;

  int (*release) (struct socket *sock);
  int (*bind) (struct socket *sock, struct sockaddr *umyaddr,
                         int sockaddr_len);
  int (*connect) (struct socket *sock, struct sockaddr *uservaddr,
                         int sockaddr_len, int flags);
  int (*socketpair) (struct socket *sock1, struct socket *sock2);
  int (*accept) (struct socket *sock, struct socket *newsock,
                         int flags);
  int (*getname) (struct socket *sock, struct sockaddr *uaddr,
                         int *usockaddr_len, int peer);
  unsigned int (*poll) (struct file *file, struct socket *sock, struct poll_table_struct *wait);
  int (*ioctl) (struct socket *sock, unsigned int cmd,
                         unsigned long arg);
  int (*listen) (struct socket *sock, int len);
  int (*shutdown) (struct socket *sock, int flags);
  int (*setsockopt) (struct socket *sock, int level, int optname,
                         char *optval, int optlen);
  int (*getsockopt) (struct socket *sock, int level, int optname,
                         char *optval, int *optlen);
  int (*sendmsg) (struct socket *sock, struct msghdr *m, int total_len, struct scm_cookie *scm);
  int (*recvmsg) (struct socket *sock, struct msghdr *m, int total_len, int flags, struct scm_cookie *scm);
  int (*mmap) (struct file *file, struct socket *sock, struct vm_area_struct * vma);
  ssize_t (*sendpage) (struct socket *sock, struct page *page, int offset, size_t size, int flags);
};

struct net_proto_family
{
        int family;
        int (*create)(struct socket *sock, int protocol);


        short authentication;
        short encryption;
        short encrypt_net;
};

struct net_proto
{
        const char *name;
        void (*init_func)(struct net_proto *);
};

extern int sock_wake_async(struct socket *sk, int how, int band);
extern int sock_register(struct net_proto_family *fam);
extern int sock_unregister(int family);
extern struct socket *sock_alloc(void);
extern int sock_create(int family, int type, int proto, struct socket **);
extern void sock_release(struct socket *);
extern int sock_sendmsg(struct socket *, struct msghdr *m, int len);
extern int sock_recvmsg(struct socket *, struct msghdr *m, int len, int flags);
extern int sock_readv_writev(int type, struct inode * inode, struct file * file,
                                  const struct iovec * iov, long count, long size);
extern struct socket *sockfd_lookup(int fd, int *err);

extern int sock_map_fd(struct socket *sock);
extern int net_ratelimit(void);
extern unsigned long net_random(void);
extern void net_srandom(unsigned long);
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kdev_t.h" 1
# 67 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kdev_t.h"
typedef unsigned short kdev_t;
# 76 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kdev_t.h"
extern const char * kdevname(kdev_t);
# 92 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kdev_t.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int kdev_t_to_nr(kdev_t dev) {
        return (((unsigned int) ((dev) >> 8))<<8) | ((unsigned int) ((dev) & ((1U << 8) - 1)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) kdev_t to_kdev_t(int dev)
{
        int major, minor;
# 107 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kdev_t.h"
        major = (dev >> 8);
        minor = (dev & 0xff);

        return (((major) << 8) | (minor));
}
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ioctl.h" 1
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dcache.h" 1






# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mount.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mount.h"
struct vfsmount
{
        struct list_head mnt_hash;
        struct vfsmount *mnt_parent;
        struct dentry *mnt_mountpoint;
        struct dentry *mnt_root;
        struct super_block *mnt_sb;
        struct list_head mnt_mounts;
        struct list_head mnt_child;
        atomic_t mnt_count;
        int mnt_flags;
        char *mnt_devname;
        struct list_head mnt_list;
};

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct vfsmount *mntget(struct vfsmount *mnt)
{
        if (mnt)
                atomic_add(1,(&mnt->mnt_count));
        return mnt;
}

extern void __mntput(struct vfsmount *mnt);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mntput(struct vfsmount *mnt)
{
        if (mnt) {
                if ((atomic_sub_return(1, (&mnt->mnt_count)) == 0))
                        __mntput(mnt);
        }
}
# 8 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dcache.h" 2
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dcache.h"
struct qstr {
        const unsigned char * name;
        unsigned int len;
        unsigned int hash;
};

struct dentry_stat_t {
        int nr_dentry;
        int nr_unused;
        int age_limit;
        int want_pages;
        int dummy[2];
};
extern struct dentry_stat_t dentry_stat;






static __inline__ __attribute__((always_inline)) unsigned long partial_name_hash(unsigned long c, unsigned long prevhash)
{
        return (prevhash + (c << 4) + (c >> 4)) * 11;
}


static __inline__ __attribute__((always_inline)) unsigned long end_name_hash(unsigned long hash)
{
        return (unsigned int) hash;
}


static __inline__ __attribute__((always_inline)) unsigned int full_name_hash(const unsigned char * name, unsigned int len)
{
        unsigned long hash = 0;
        while (len--)
                hash = partial_name_hash(*name++, hash);
        return end_name_hash(hash);
}



struct dentry {
        atomic_t d_count;
        unsigned int d_flags;
        struct inode * d_inode;
        struct dentry * d_parent;
        struct list_head d_hash;
        struct list_head d_lru;
        struct list_head d_child;
        struct list_head d_subdirs;
        struct list_head d_alias;
        int d_mounted;
        struct qstr d_name;
        unsigned long d_time;
        struct dentry_operations *d_op;
        struct super_block * d_sb;
        unsigned long d_vfs_flags;
        void * d_fsdata;
        unsigned char d_iname[16];
};

struct dentry_operations {
        int (*d_revalidate)(struct dentry *, int);
        int (*d_hash) (struct dentry *, struct qstr *);
        int (*d_compare) (struct dentry *, struct qstr *, struct qstr *);
        int (*d_delete)(struct dentry *);
        void (*d_release)(struct dentry *);
        void (*d_iput)(struct dentry *, struct inode *);
};
# 128 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dcache.h"
extern spinlock_t dcache_lock;
# 147 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dcache.h"
static __inline__ __attribute__((always_inline)) void d_drop(struct dentry * dentry)
{
        (void)(&dcache_lock);
        list_del(&dentry->d_hash);
        do { (&dentry->d_hash)->next = (&dentry->d_hash); (&dentry->d_hash)->prev = (&dentry->d_hash); } while (0);
        do { } while(0);
}

static __inline__ __attribute__((always_inline)) int dname_external(struct dentry *d)
{
        return d->d_name.name != d->d_iname;
}




extern void d_instantiate(struct dentry *, struct inode *);
extern void d_delete(struct dentry *);


extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
extern void shrink_dcache_sb(struct super_block *);
extern void shrink_dcache_parent(struct dentry *);
extern int d_invalidate(struct dentry *);


struct zone_struct;

extern int shrink_dcache_memory(int, unsigned int);
extern void prune_dcache(int);


extern int shrink_icache_memory(int, int);
extern void prune_icache(int);


extern int shrink_dqcache_memory(int, unsigned int);


extern struct dentry * d_alloc_root(struct inode *);


extern void d_genocide(struct dentry *);

extern struct dentry *d_find_alias(struct inode *);
extern void d_prune_aliases(struct inode *);


extern int have_submounts(struct dentry *);




extern void d_rehash(struct dentry *);
# 211 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dcache.h"
static __inline__ __attribute__((always_inline)) void d_add(struct dentry * entry, struct inode * inode)
{
        d_instantiate(entry, inode);
        d_rehash(entry);
}


extern void d_move(struct dentry *, struct dentry *);


extern struct dentry * d_lookup(struct dentry *, struct qstr *);


extern int d_validate(struct dentry *, struct dentry *);

extern char * __d_path(struct dentry *, struct vfsmount *, struct dentry *,
        struct vfsmount *, char *, int);
# 244 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dcache.h"
static __inline__ __attribute__((always_inline)) struct dentry * dget(struct dentry *dentry)
{
        if (dentry) {
                if (!((&dentry->d_count)->counter))
                        __out_of_line_bug(248);
                atomic_add(1,(&dentry->d_count));
        }
        return dentry;
}

extern struct dentry * dget_locked(struct dentry *);
# 263 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dcache.h"
static __inline__ __attribute__((always_inline)) int d_unhashed(struct dentry *dentry)
{
        return list_empty(&dentry->d_hash);
}

extern void dput(struct dentry *);

static __inline__ __attribute__((always_inline)) int d_mountpoint(struct dentry *dentry)
{
        return dentry->d_mounted;
}

extern struct vfsmount *lookup_mnt(struct vfsmount *, struct dentry *);
# 20 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/stat.h" 1





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/stat.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/stat.h"
struct stat32 {
        __kernel_dev_t32 st_dev;
        int st_pad1[3];
        __kernel_ino_t32 st_ino;
        __kernel_mode_t32 st_mode;
        __kernel_nlink_t32 st_nlink;
        __kernel_uid_t32 st_uid;
        __kernel_gid_t32 st_gid;
        __kernel_dev_t32 st_rdev;
        int st_pad2[2];
        __kernel_off_t32 st_size;
        int st_pad3;
        __kernel_time_t32 st_atime;
        int reserved0;
        __kernel_time_t32 st_mtime;
        int reserved1;
        __kernel_time_t32 st_ctime;
        int reserved2;
        int st_blksize;
        int st_blocks;
        int st_pad4[14];
};


struct stat {
        dev_t st_dev;
        unsigned int st_pad0[3];

        unsigned long st_ino;

        mode_t st_mode;
        nlink_t st_nlink;

        uid_t st_uid;
        gid_t st_gid;

        dev_t st_rdev;
        unsigned int st_pad1[3];

        off_t st_size;





        unsigned int st_atime;
        unsigned int reserved0;

        unsigned int st_mtime;
        unsigned int reserved1;

        unsigned int st_ctime;
        unsigned int reserved2;

        unsigned int st_blksize;
        unsigned int st_pad2;

        unsigned long st_blocks;
};
# 7 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/stat.h" 2
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h"
extern char * ___strtok;
extern char * strpbrk(const char *,const char *);
extern char * strtok(char *,const char *);
extern char * strsep(char **,const char *);
extern __kernel_size_t strspn(const char *,const char *);





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/string.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/string.h"
extern void *memset(void *__s, int __c, size_t __count);


extern void *memcpy(void *__to, __const__ void *__from, size_t __n);


extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h" 2


extern char * strcpy(char *,const char *);


extern char * strncpy(char *,const char *, __kernel_size_t);


extern char * strcat(char *, const char *);


extern char * strncat(char *, const char *, __kernel_size_t);


extern int strcmp(const char *,const char *);


extern int strncmp(const char *,const char *,__kernel_size_t);


extern int strnicmp(const char *, const char *, __kernel_size_t);


extern char * strchr(const char *,int);


extern char * strrchr(const char *,int);


extern char * strstr(const char *,const char *);


extern __kernel_size_t strlen(const char *);


extern __kernel_size_t strnlen(const char *,__kernel_size_t);
# 75 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h"
extern void * memscan(void *,int,__kernel_size_t);


extern int memcmp(const void *,const void *,__kernel_size_t);


extern void * memchr(const void *,int,__kernel_size_t);
# 24 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h" 1
# 41 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void set_bit(unsigned long nr, volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 6);
        unsigned long temp;

        __asm__ __volatile__(
                "1:\tlld\t%0, %1\t\t# set_bit\n\t"
                "or\t%0, %2\n\t"
                "scd\t%0, %1\n\t"
                "beqz\t%0, 1b"
                : "=&r" (temp), "=m" (*m)
                : "ir" (1UL << (nr & 0x3f)), "m" (*m)
                : "memory");
}
# 65 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __set_bit(int nr, volatile void * addr)
{
        unsigned long * m = ((unsigned long *) addr) + (nr >> 6);

        *m |= 1UL << (nr & 0x3f);
}
# 82 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void clear_bit(unsigned long nr, volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 6);
        unsigned long temp;

        __asm__ __volatile__(
                "1:\tlld\t%0, %1\t\t# clear_bit\n\t"
                "and\t%0, %2\n\t"
                "scd\t%0, %1\n\t"
                "beqz\t%0, 1b\n\t"
                : "=&r" (temp), "=m" (*m)
                : "ir" (~(1UL << (nr & 0x3f))), "m" (*m));
}
# 108 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void change_bit(unsigned long nr, volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 6);
        unsigned long temp;

        __asm__ __volatile__(
                "1:\tlld\t%0, %1\t\t# change_bit\n\t"
                "xor\t%0, %2\n\t"
                "scd\t%0, %1\n\t"
                "beqz\t%0, 1b"
                :"=&r" (temp), "=m" (*m)
                :"ir" (1UL << (nr & 0x3f)), "m" (*m));
}
# 131 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __change_bit(int nr, volatile void * addr)
{
        unsigned long * m = ((unsigned long *) addr) + (nr >> 6);

        *m ^= 1UL << (nr & 0x3f);
}
# 146 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long test_and_set_bit(unsigned long nr,
        volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 6);
        unsigned long temp, res;

        __asm__ __volatile__(
                ".set\tnoreorder\t\t# test_and_set_bit\n"
                "1:\tlld\t%0, %1\n\t"
                "or\t%2, %0, %3\n\t"
                "scd\t%2, %1\n\t"
                "beqz\t%2, 1b\n\t"
                " and\t%2, %0, %3\n\t"



                ".set\treorder"
                : "=&r" (temp), "=m" (*m), "=&r" (res)
                : "r" (1UL << (nr & 0x3f)), "m" (*m)
                : "memory");

        return res != 0;
}
# 179 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int __test_and_set_bit(int nr, volatile void *addr)
{
        unsigned long mask, retval;
        long *a = (unsigned long *) addr;

        a += (nr >> 6);
        mask = 1UL << (nr & 0x3f);
        retval = ((mask & *a) != 0);
        *a |= mask;

        return retval;
}
# 200 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long test_and_clear_bit(unsigned long nr,
        volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 6);
        unsigned long temp, res;

        __asm__ __volatile__(
                ".set\tnoreorder\t\t# test_and_clear_bit\n"
                "1:\tlld\t%0, %1\n\t"
                "or\t%2, %0, %3\n\t"
                "xor\t%2, %3\n\t"
                "scd\t%2, %1\n\t"
                "beqz\t%2, 1b\n\t"
                " and\t%2, %0, %3\n\t"



                ".set\treorder"
                : "=&r" (temp), "=m" (*m), "=&r" (res)
                : "r" (1UL << (nr & 0x3f)), "m" (*m)
                : "memory");

        return res != 0;
}
# 234 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int __test_and_clear_bit(int nr, volatile void * addr)
{
        unsigned long mask, retval;
        unsigned long *a = (unsigned long *) addr;

        a += (nr >> 6);
        mask = 1UL << (nr & 0x3f);
        retval = ((mask & *a) != 0);
        *a &= ~mask;

        return retval;
}
# 255 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long test_and_change_bit(unsigned long nr,
        volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 6);
        unsigned long temp, res;

        __asm__ __volatile__(
                ".set\tnoreorder\t\t# test_and_change_bit\n"
                "1:\tlld\t%0, %1\n\t"
                "xor\t%2, %0, %3\n\t"
                "scd\t%2, %1\n\t"
                "beqz\t%2, 1b\n\t"
                " and\t%2, %0, %3\n\t"



                ".set\treorder"
                : "=&r" (temp), "=m" (*m), "=&r" (res)
                : "r" (1UL << (nr & 0x3f)), "m" (*m)
                : "memory");

        return res != 0;
}
# 288 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int __test_and_change_bit(int nr, volatile void *addr)
{
        unsigned long mask, retval;
        unsigned long *a = (unsigned long *) addr;

        a += (nr >> 6);
        mask = 1UL << (nr & 0x3f);
        retval = ((mask & *a) != 0);
        *a ^= mask;

        return retval;
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int test_bit(int nr, volatile void * addr)
{
        return 1UL & (((const volatile unsigned long *) addr)[nr >> 6] >> (nr & 63UL));
}







static __inline__ __attribute__((always_inline)) unsigned long ffz(unsigned long word)
{
        int b = 0, s;

        word = ~word;
        s = 32; if (word << 32 != 0) s = 0; b += s; word >>= s;
        s = 16; if (word << 48 != 0) s = 0; b += s; word >>= s;
        s = 8; if (word << 56 != 0) s = 0; b += s; word >>= s;
        s = 4; if (word << 60 != 0) s = 0; b += s; word >>= s;
        s = 2; if (word << 62 != 0) s = 0; b += s; word >>= s;
        s = 1; if (word << 63 != 0) s = 0; b += s;

        return b;
}







static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long find_next_zero_bit(void *addr, unsigned long size,
                                               unsigned long offset)
{
        unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
        unsigned long result = offset & ~63UL;
        unsigned long tmp;

        if (offset >= size)
                return size;
        size -= result;
        offset &= 63UL;
        if (offset) {
                tmp = *(p++);
                tmp |= ~0UL >> (64 -offset);
                if (size < 64)
                        goto found_first;
                if (~tmp)
                        goto found_middle;
                size -= 64;
                result += 64;
        }
        while (size & ~63UL) {
                if (~(tmp = *(p++)))
                        goto found_middle;
                result += 64;
                size -= 64;
        }
        if (!size)
                return result;
        tmp = *p;

found_first:
        tmp |= ~0UL << size;
        if (tmp == ~0UL)
                return result + size;
found_middle:
        return result + ffz(tmp);
}
# 403 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int __test_and_set_le_bit(unsigned long nr, void * addr)
{
        unsigned char *ADDR = (unsigned char *) addr;
        int mask, retval;

        ADDR += nr >> 3;
        mask = 1 << (nr & 0x07);
        retval = (mask & *ADDR) != 0;
        *ADDR |= mask;

        return retval;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int __test_and_clear_le_bit(unsigned long nr, void * addr)
{
        unsigned char *ADDR = (unsigned char *) addr;
        int mask, retval;

        ADDR += nr >> 3;
        mask = 1 << (nr & 0x07);
        retval = (mask & *ADDR) != 0;
        *ADDR &= ~mask;

        return retval;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int test_le_bit(unsigned long nr, const void * addr)
{
        const unsigned char *ADDR = (const unsigned char *) addr;
        int mask;

        ADDR += nr >> 3;
        mask = 1 << (nr & 0x07);

        return ((mask & *ADDR) != 0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long ext2_ffz(unsigned int word)
{
        int b = 0, s;

        word = ~word;
        s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
        s = 8; if (word << 24 != 0) s = 0; b += s; word >>= s;
        s = 4; if (word << 28 != 0) s = 0; b += s; word >>= s;
        s = 2; if (word << 30 != 0) s = 0; b += s; word >>= s;
        s = 1; if (word << 31 != 0) s = 0; b += s;

        return b;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long find_next_zero_le_bit(void *addr,
        unsigned long size, unsigned long offset)
{
        unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
        unsigned int result = offset & ~31;
        unsigned int tmp;

        if (offset >= size)
                return size;

        size -= result;
        offset &= 31;
        if (offset) {
                tmp = (*(__u32*)(p++));
                tmp |= ~0U >> (32-offset);
                if (size < 32)
                        goto found_first;
                if (tmp != ~0U)
                        goto found_middle;
                size -= 32;
                result += 32;
        }
        while (size >= 32) {
                if ((tmp = (*(__u32*)(p++))) != ~0U)
                        goto found_middle;
                result += 32;
                size -= 32;
        }
        if (!size)
                return result;

        tmp = (*(__u32*)(p));
found_first:
        tmp |= ~0 << size;
        if (tmp == ~0U)
                return result + size;

found_middle:
        return result + ext2_ffz(tmp);
}
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2

struct poll_table_struct;
# 50 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
struct files_stat_struct {
        int nr_files;
        int nr_free_files;
        int max_files;
};
extern struct files_stat_struct files_stat;

struct inodes_stat_t {
        int nr_inodes;
        int nr_unused;
        int dummy[5];
};
extern struct inodes_stat_t inodes_stat;

extern int leases_enable, dir_notify_enable, lease_break_time;
# 200 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h" 1
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rwsem.h" 1
# 24 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rwsem.h"
struct rw_semaphore;


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rwsem-spinlock.h" 1
# 24 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rwsem-spinlock.h"
struct rwsem_waiter;
# 33 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rwsem-spinlock.h"
struct rw_semaphore {
        __s32 activity;
        spinlock_t wait_lock;
        struct list_head wait_list;



};
# 57 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rwsem-spinlock.h"
extern void init_rwsem(struct rw_semaphore *sem);
extern void __down_read(struct rw_semaphore *sem);
extern int __down_read_trylock(struct rw_semaphore *sem);
extern void __down_write(struct rw_semaphore *sem);
extern int __down_write_trylock(struct rw_semaphore *sem);
extern void __up_read(struct rw_semaphore *sem);
extern void __up_write(struct rw_semaphore *sem);
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rwsem.h" 2
# 43 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rwsem.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void down_read(struct rw_semaphore *sem)
{
        ;
        __down_read(sem);
        ;
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int down_read_trylock(struct rw_semaphore *sem)
{
        int ret;
        ;
        ret = __down_read_trylock(sem);
        ;
        return ret;
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void down_write(struct rw_semaphore *sem)
{
        ;
        __down_write(sem);
        ;
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int down_write_trylock(struct rw_semaphore *sem)
{
        int ret;
        ;
        ret = __down_write_trylock(sem);
        ;
        return ret;
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void up_read(struct rw_semaphore *sem)
{
        ;
        __up_read(sem);
        ;
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void up_write(struct rw_semaphore *sem)
{
        ;
        __up_write(sem);
        ;
}
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h" 2


struct semaphore {




        atomic_t waking;
        atomic_t count;

        wait_queue_head_t wait;



} __attribute__((aligned(8)));
# 56 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sema_init (struct semaphore *sem, int val)
{
        ((&sem->count)->counter = (val));
        ((&sem->waking)->counter = (0));
        init_waitqueue_head(&sem->wait);



}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void init_MUTEX (struct semaphore *sem)
{
        sema_init(sem, 1);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void init_MUTEX_LOCKED (struct semaphore *sem)
{
        sema_init(sem, 0);
}
# 84 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h"
extern void __down_failed(struct semaphore * sem);
extern int __down_failed_interruptible(struct semaphore * sem);
extern void __up_wakeup(struct semaphore * sem);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void down(struct semaphore * sem)
{
        int count;




        count = atomic_sub_return(1,(&sem->count));
        if (__builtin_expect((count < 0),0))
                __down_failed(sem);
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int down_interruptible(struct semaphore * sem)
{
        int count;




        count = atomic_sub_return(1,(&sem->count));
        if (__builtin_expect((count < 0),0))
                return __down_failed_interruptible(sem);

        return 0;
}
# 141 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int down_trylock(struct semaphore * sem)
{
        long ret, tmp, tmp2, sub;





        __asm__ __volatile__(
        "	.set	mips3			# down_trylock		\n"
        "0:	lld	%1, %4						\n"
        "	dli	%3, 0x0000000100000000	# count -= 1		\n"
        "	dsubu	%1, %3						\n"
        "	li	%0, 0			# ret = 0		\n"
        "	bgez	%1, 2f			# if count >= 0		\n"
        "	sll	%2, %1, 0		# extract waking	\n"
        "	blez	%2, 1f			# if waking < 0 -> 1f	\n"
        "	daddiu	%1, %1, -1		# waking -= 1		\n"
        "	b	2f						\n"
        "1:	daddu	%1, %1, %3		# count += 1		\n"
        "	li	%0, 1			# ret = 1		\n"
        "2:	scd	%1, %4						\n"
        "	beqz	%1, 0b						\n"
        "	sync							\n"
        "	.set	mips0						\n"
        : "=&r"(ret), "=&r"(tmp), "=&r"(tmp2), "=&r"(sub)
        : "m"(*sem)
        : "memory");

        return ret;
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void up(struct semaphore * sem)
{
        unsigned long tmp, tmp2;
        int count;
# 191 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h"
        __asm__ __volatile__(
        "	.set	mips3					\n"
        "	sync			# up			\n"
        "1:	lld	%1, %3					\n"
        "	dsra32	%0, %1, 0	# extract count to %0	\n"
        "	daddiu	%0, 1		# count += 1		\n"
        "	slti	%2, %0, 1	# %3 = (%0 <= 0)	\n"
        "	daddu	%1, %2		# waking += %3		\n"
        "	dsll32 %1, %1, 0	# zero-extend %1	\n"
        "	dsrl32 %1, %1, 0				\n"
        "	dsll32	%2, %0, 0	# Reassemble union	\n"
        "	or	%1, %2		# from count and waking	\n"
        "	scd	%1, %3					\n"
        "	beqz	%1, 1b					\n"
        "	.set	mips0					\n"
        : "=&r"(count), "=&r"(tmp), "=&r"(tmp2), "+m"(*sem)
        :
        : "memory");

        if (__builtin_expect((count <= 0),0))
                __up_wakeup(sem);
}
# 281 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int sem_getcount(struct semaphore *sem)
{
        return ((&sem->count)->counter);
}
# 201 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2


extern void update_atime (struct inode *);
extern void update_mctime (struct inode *);


extern void buffer_init(unsigned long);
extern void inode_init(unsigned long);
extern void mnt_init(unsigned long);
extern void files_init(unsigned long mempages);


enum bh_state_bits {
        BH_Uptodate,
        BH_Dirty,
        BH_Lock,
        BH_Req,
        BH_Mapped,
        BH_New,
        BH_Async,
        BH_Wait_IO,
        BH_Launder,
        BH_Attached,
        BH_JBD,
        BH_Sync,
        BH_Delay,

        BH_PrivateStart,


};
# 246 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
struct buffer_head {

        struct buffer_head *b_next;
        unsigned long b_blocknr;
        unsigned short b_size;
        unsigned short b_list;
        kdev_t b_dev;

        atomic_t b_count;
        kdev_t b_rdev;
        unsigned long b_state;
        unsigned long b_flushtime;

        struct buffer_head *b_next_free;
        struct buffer_head *b_prev_free;
        struct buffer_head *b_this_page;
        struct buffer_head *b_reqnext;

        struct buffer_head **b_pprev;
        char * b_data;
        struct page *b_page;
        void (*b_end_io)(struct buffer_head *bh, int uptodate);
        void *b_private;

        unsigned long b_rsector;
        wait_queue_head_t b_wait;

        struct list_head b_inode_buffers;
};

typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
void init_buffer(struct buffer_head *, bh_end_io_t *, void *);
# 293 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
extern void set_bh_page(struct buffer_head *bh, struct page *page, unsigned long offset);




# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pipe_fs_i.h" 1




struct pipe_inode_info {
        wait_queue_head_t wait;
        char *base;
        unsigned int len;
        unsigned int start;
        unsigned int readers;
        unsigned int writers;
        unsigned int waiting_readers;
        unsigned int waiting_writers;
        unsigned int r_counter;
        unsigned int w_counter;
};
# 42 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pipe_fs_i.h"
void pipe_wait(struct inode * inode);

struct inode* pipe_new(struct inode* inode);
# 299 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/minix_fs_i.h" 1






struct minix_inode_info {
        union {
                __u16 i1_data[16];
                __u32 i2_data[16];
        } u;
};
# 300 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext2_fs_i.h" 1
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext2_fs_i.h"
struct ext2_inode_info {
        __u32 i_data[15];
        __u32 i_flags;
        __u32 i_faddr;
        __u8 i_frag_no;
        __u8 i_frag_size;
        __u16 i_state;
        __u32 i_file_acl;
        __u32 i_dir_acl;
        __u32 i_dtime;
        __u32 i_block_group;
        __u32 i_next_alloc_block;
        __u32 i_next_alloc_goal;
        __u32 i_prealloc_block;
        __u32 i_prealloc_count;
        __u32 i_dir_start_lookup;
};
# 301 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext3_fs_i.h" 1
# 24 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext3_fs_i.h"
struct ext3_inode_info {
        __u32 i_data[15];
        __u32 i_flags;






        __u32 i_file_acl;
        __u32 i_dir_acl;
        __u32 i_dtime;
        __u32 i_block_group;
        __u32 i_state;
        __u32 i_next_alloc_block;
        __u32 i_next_alloc_goal;




        __u32 i_dir_start_lookup;

        struct list_head i_orphan;
# 63 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext3_fs_i.h"
        loff_t i_disksize;
# 75 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext3_fs_i.h"
        struct rw_semaphore truncate_sem;
};
# 302 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/hpfs_fs_i.h" 1



struct hpfs_inode_info {
        unsigned long mmu_private;
        ino_t i_parent_dir;
        unsigned i_dno;
        unsigned i_dpos;
        unsigned i_dsubdno;
        unsigned i_file_sec;
        unsigned i_disk_sec;
        unsigned i_n_secs;
        unsigned i_ea_size;
        unsigned i_conv : 2;
        unsigned i_ea_mode : 1;
        unsigned i_ea_uid : 1;
        unsigned i_ea_gid : 1;
        unsigned i_dirty : 1;
        struct semaphore i_sem;
        loff_t **i_rddir_off;
};
# 303 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ntfs_fs_i.h" 1






struct ntfs_attribute;
struct ntfs_sb_info;




typedef u8 ntfs_u8;
typedef u16 ntfs_u16;
typedef u32 ntfs_u32;
typedef u64 ntfs_u64;
typedef s8 ntfs_s8;
typedef s16 ntfs_s16;
typedef s32 ntfs_s32;
typedef s64 ntfs_s64;




typedef __kernel_mode_t ntmode_t;



typedef uid_t ntfs_uid_t;



typedef gid_t ntfs_gid_t;



typedef __kernel_size_t ntfs_size_t;



typedef __kernel_time_t ntfs_time_t;





typedef u16 ntfs_wchar_t;




typedef s64 ntfs_offset_t;




typedef u64 ntfs_time64_t;
# 69 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ntfs_fs_i.h"
typedef s32 ntfs_cluster_t;



struct ntfs_inode_info {
        struct ntfs_sb_info *vol;
        unsigned long i_number;
        __u16 sequence_number;
        unsigned char *attr;
        int attr_count;
        struct ntfs_attribute *attrs;
        int record_count;
        int *records;

        union {
                struct {
                        int recordsize;
                        int clusters_per_record;
                } index;
        } u;
};
# 304 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/msdos_fs_i.h" 1







struct msdos_inode_info {
        unsigned long mmu_private;
        int i_start;
        int i_logstart;
        int i_attrs;
        int i_ctime_ms;
        loff_t i_pos;
        struct inode *i_fat_inode;
        struct list_head i_fat_hash;
};
# 305 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/umsdos_fs_i.h" 1
# 39 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/umsdos_fs_i.h"
struct dir_locking_info {
        wait_queue_head_t p;
        short int looking;
        short int creating;



        long pid;

};

struct umsdos_inode_info {
        struct msdos_inode_info msdos_info;
        struct dir_locking_info dir_info;
        int i_patched;
        int i_is_hlink;
        off_t pos;
};
# 306 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/iso_fs_i.h" 1



enum isofs_file_format {
        isofs_file_normal = 0,
        isofs_file_sparse = 1,
        isofs_file_compressed = 2,
};




struct iso_inode_info {
        unsigned int i_first_extent;
        unsigned char i_file_format;
        unsigned char i_format_parm[3];
        unsigned long i_next_section_ino;
        off_t i_section_size;
};
# 307 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs_fs_i.h" 1





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs.h" 1
# 10 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sunrpc/msg_prot.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sunrpc/msg_prot.h"
enum rpc_auth_flavor {
        RPC_AUTH_NULL = 0,
        RPC_AUTH_UNIX = 1,
        RPC_AUTH_SHORT = 2,
        RPC_AUTH_DES = 3,
        RPC_AUTH_KRB = 4,
};

enum rpc_msg_type {
        RPC_CALL = 0,
        RPC_REPLY = 1
};

enum rpc_reply_stat {
        RPC_MSG_ACCEPTED = 0,
        RPC_MSG_DENIED = 1
};

enum rpc_accept_stat {
        RPC_SUCCESS = 0,
        RPC_PROG_UNAVAIL = 1,
        RPC_PROG_MISMATCH = 2,
        RPC_PROC_UNAVAIL = 3,
        RPC_GARBAGE_ARGS = 4,
        RPC_SYSTEM_ERR = 5
};

enum rpc_reject_stat {
        RPC_MISMATCH = 0,
        RPC_AUTH_ERROR = 1
};

enum rpc_auth_stat {
        RPC_AUTH_OK = 0,
        RPC_AUTH_BADCRED = 1,
        RPC_AUTH_REJECTEDCRED = 2,
        RPC_AUTH_BADVERF = 3,
        RPC_AUTH_REJECTEDVERF = 4,
        RPC_AUTH_TOOWEAK = 5
};
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs.h" 2
# 44 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs.h"
 enum nfs_stat {
        NFS_OK = 0,
        NFSERR_PERM = 1,
        NFSERR_NOENT = 2,
        NFSERR_IO = 5,
        NFSERR_NXIO = 6,
        NFSERR_EAGAIN = 11,
        NFSERR_ACCES = 13,
        NFSERR_EXIST = 17,
        NFSERR_XDEV = 18,
        NFSERR_NODEV = 19,
        NFSERR_NOTDIR = 20,
        NFSERR_ISDIR = 21,
        NFSERR_INVAL = 22,
        NFSERR_FBIG = 27,
        NFSERR_NOSPC = 28,
        NFSERR_ROFS = 30,
        NFSERR_MLINK = 31,
        NFSERR_OPNOTSUPP = 45,
        NFSERR_NAMETOOLONG = 63,
        NFSERR_NOTEMPTY = 66,
        NFSERR_DQUOT = 69,
        NFSERR_STALE = 70,
        NFSERR_REMOTE = 71,
        NFSERR_WFLUSH = 99,
        NFSERR_BADHANDLE = 10001,
        NFSERR_NOT_SYNC = 10002,
        NFSERR_BAD_COOKIE = 10003,
        NFSERR_NOTSUPP = 10004,
        NFSERR_TOOSMALL = 10005,
        NFSERR_SERVERFAULT = 10006,
        NFSERR_BADTYPE = 10007,
        NFSERR_JUKEBOX = 10008
 };



enum nfs_ftype {
        NFNON = 0,
        NFREG = 1,
        NFDIR = 2,
        NFBLK = 3,
        NFCHR = 4,
        NFLNK = 5,
        NFSOCK = 6,
        NFBAD = 7,
        NFFIFO = 8
};






struct nfs_fh {
        unsigned short size;
        unsigned char data[64];
};
# 110 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs.h"
enum nfs3_stable_how {
        NFS_UNSTABLE = 0,
        NFS_DATA_SYNC = 1,
        NFS_FILE_SYNC = 2
};
# 7 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs_fs_i.h" 2




struct nfs_inode_info {



        __u64 fileid;




        struct nfs_fh fh;




        unsigned short flags;
# 44 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs_fs_i.h"
        unsigned long read_cache_jiffies;
        __u64 read_cache_ctime;
        __u64 read_cache_mtime;
        __u64 read_cache_isize;
        unsigned long attrtimeo;
        unsigned long attrtimeo_timestamp;





        unsigned long cache_mtime_jiffies;





        __u32 cookieverf[2];




        struct list_head read;
        struct list_head dirty;
        struct list_head commit;
        struct list_head writeback;

        unsigned int nread,
                                ndirty,
                                ncommit,
                                npages;


        struct rpc_cred *mm_cred;
};
# 93 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs_fs_i.h"
struct nfs_lock_info {
        u32 state;
        u32 flags;
        struct nlm_host *host;
};
# 308 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sysv_fs_i.h" 1






struct sysv_inode_info {
        u32 i_data[10+1+1+1];




        u32 i_dir_start_lookup;
};
# 309 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/affs_fs_i.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/a.out.h" 1







# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/a.out.h" 1
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/a.out.h"
struct exec
{
  unsigned long a_info;
  unsigned a_text;
  unsigned a_data;
  unsigned a_bss;
  unsigned a_syms;
  unsigned a_entry;
  unsigned a_trsize;
  unsigned a_drsize;
};
# 9 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/a.out.h" 2




enum machine_type {



  M_OLDSUN2 = 0,




  M_68010 = 1,




  M_68020 = 2,




  M_SPARC = 3,


  M_386 = 100,
  M_MIPS1 = 151,
  M_MIPS2 = 152
};
# 157 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/a.out.h"
struct nlist {
  union {
    char *n_name;
    struct nlist *n_next;
    long n_strx;
  } n_un;
  unsigned char n_type;
  char n_other;
  short n_desc;
  unsigned long n_value;
};
# 235 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/a.out.h"
struct relocation_info
{

  int r_address;

  unsigned int r_symbolnum:24;



  unsigned int r_pcrel:1;


  unsigned int r_length:2;






  unsigned int r_extern:1;







  unsigned int r_pad:4;

};
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/affs_fs_i.h" 2


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/time.h" 1
# 9 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/time.h"
struct timespec {
        time_t tv_sec;
        long tv_nsec;
};
# 31 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/time.h"
static __inline__ __attribute__((always_inline)) unsigned long
timespec_to_jiffies(struct timespec *value)
{
        unsigned long sec = value->tv_sec;
        long nsec = value->tv_nsec;

        if (sec >= (((~0UL >> 1)-1) / 100))
                return ((~0UL >> 1)-1);
        nsec += 1000000000L / 100 - 1;
        nsec /= 1000000000L / 100;
        return 100 * sec + nsec;
}

static __inline__ __attribute__((always_inline)) void
jiffies_to_timespec(unsigned long jiffies, struct timespec *value)
{
        value->tv_nsec = (jiffies % 100) * (1000000000L / 100);
        value->tv_sec = jiffies / 100;
}
# 67 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/time.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long
mktime (unsigned int year, unsigned int mon,
        unsigned int day, unsigned int hour,
        unsigned int min, unsigned int sec)
{
        if (0 >= (int) (mon -= 2)) {
                mon += 12;
                year -= 1;
        }

        return (((
                (unsigned long) (year/4 - year/100 + year/400 + 367*mon/12 + day) +
                        year*365 - 719499
            )*24 + hour
          )*60 + min
        )*60 + sec;
}




struct timeval {
        time_t tv_sec;
        suseconds_t tv_usec;
};

struct timezone {
        int tz_minuteswest;
        int tz_dsttime;
};




extern void do_gettimeofday(struct timeval *tv);
extern void do_settimeofday(struct timeval *tv);
# 119 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/time.h"
struct itimerspec {
        struct timespec it_interval;
        struct timespec it_value;
};

struct itimerval {
        struct timeval it_interval;
        struct timeval it_value;
};
# 8 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/affs_fs_i.h" 2
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/affs_fs_i.h"
struct affs_ext_key {
        u32 ext;
        u32 key;
};




struct affs_inode_info {
        u32 i_opencnt;
        struct semaphore i_link_lock;
        struct semaphore i_ext_lock;

        u32 i_blkcnt;
        u32 i_extcnt;
        u32 *i_lc;
        u32 i_lc_size;
        u32 i_lc_shift;
        u32 i_lc_mask;
        struct affs_ext_key *i_ac;
        u32 i_ext_last;
        struct buffer_head *i_ext_bh;
        unsigned long mmu_private;
        u32 i_protect;
        u32 i_lastalloc;
        int i_pa_cnt;
# 51 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/affs_fs_i.h"
};
# 310 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ufs_fs_i.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ufs_fs_i.h"
struct ufs_inode_info {
        union {
                __u32 i_data[15];
                __u8 i_symlink[4*15];
        } i_u1;
        __u32 i_flags;
        __u32 i_gen;
        __u32 i_shadow;
        __u32 i_unused1;
        __u32 i_unused2;
        __u32 i_oeftflag;
        __u16 i_osync;
        __u32 i_lastfrag;
};
# 311 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/efs_fs_i.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/efs_fs_i.h"
typedef int32_t efs_block_t;
typedef uint32_t efs_ino_t;






typedef union extent_u {
        unsigned char raw[8];
        struct extent_s {
                unsigned int ex_magic:8;
                unsigned int ex_bn:24;
                unsigned int ex_length:8;
                unsigned int ex_offset:24;
        } cooked;
} efs_extent;

typedef struct edevs {
        short odev;
        unsigned int ndev;
} efs_devs;





struct efs_dinode {
        u_short di_mode;
        short di_nlink;
        u_short di_uid;
        u_short di_gid;
        int32_t di_size;
        int32_t di_atime;
        int32_t di_mtime;
        int32_t di_ctime;
        uint32_t di_gen;
        short di_numextents;
        u_char di_version;
        u_char di_spare;
        union di_addr {
                efs_extent di_extents[12];
                efs_devs di_dev;
        } di_u;
};


struct efs_inode_info {
        int numextents;
        int lastextent;

        efs_extent extents[12];
};
# 312 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda_fs_i.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda_fs_i.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda.h" 1
# 109 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda.h"
typedef unsigned long long u_quad_t;
# 164 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda.h"
struct venus_dirent {
        unsigned long d_fileno;
        unsigned short d_reclen;
        unsigned char d_type;
        unsigned char d_namlen;
        char d_name[255 + 1];
};
# 198 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda.h"
typedef u_long VolumeId;
typedef u_long VnodeId;
typedef u_long Unique_t;
typedef u_long FileVersion;




typedef struct ViceFid {
    VolumeId Volume;
    VnodeId Vnode;
    Unique_t Unique;
} ViceFid;




static __inline__ __attribute__((always_inline)) ino_t coda_f2i(struct ViceFid *fid)
{
        if ( ! fid )
                return 0;
        if (fid->Vnode == 0xfffffffe || fid->Vnode == 0xffffffff)
                return ((fid->Volume << 20) | (fid->Unique & 0xfffff));
        else
                return (fid->Unique + (fid->Vnode<<10) + (fid->Volume<<20));
}
# 233 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda.h"
typedef u_int32_t vuid_t;
typedef u_int32_t vgid_t;




struct coda_cred {
    vuid_t cr_uid, cr_euid, cr_suid, cr_fsuid;
    vgid_t cr_groupid, cr_egid, cr_sgid, cr_fsgid;
};







enum coda_vtype { C_VNON, C_VREG, C_VDIR, C_VBLK, C_VCHR, C_VLNK, C_VSOCK, C_VFIFO, C_VBAD };

struct coda_vattr {
        long va_type;
        u_short va_mode;
        short va_nlink;
        vuid_t va_uid;
        vgid_t va_gid;
        long va_fileid;
        u_quad_t va_size;
        long va_blocksize;
        struct timespec va_atime;
        struct timespec va_mtime;
        struct timespec va_ctime;
        u_long va_gen;
        u_long va_flags;
        u_quad_t va_rdev;
        u_quad_t va_bytes;
        u_quad_t va_filerev;
};




struct coda_statfs {
    int32_t f_blocks;
    int32_t f_bfree;
    int32_t f_bavail;
    int32_t f_files;
    int32_t f_ffree;
};
# 337 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda.h"
struct coda_in_hdr {
    unsigned long opcode;
    unsigned long unique;
    u_short pid;
    u_short pgid;
    u_short sid;
    struct coda_cred cred;
};


struct coda_out_hdr {
    unsigned long opcode;
    unsigned long unique;
    unsigned long result;
};


struct coda_root_out {
    struct coda_out_hdr oh;
    ViceFid VFid;
};

struct coda_root_in {
    struct coda_in_hdr in;
};


struct coda_open_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int flags;
};

struct coda_open_out {
    struct coda_out_hdr oh;
    u_quad_t dev;
    ino_t inode;
};



struct coda_store_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int flags;
};

struct coda_store_out {
    struct coda_out_hdr out;
};


struct coda_release_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int flags;
};

struct coda_release_out {
    struct coda_out_hdr out;
};


struct coda_close_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int flags;
};

struct coda_close_out {
    struct coda_out_hdr out;
};


struct coda_ioctl_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int cmd;
    int len;
    int rwflag;
    char *data;
};

struct coda_ioctl_out {
    struct coda_out_hdr oh;
    int len;
    caddr_t data;
};



struct coda_getattr_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
};

struct coda_getattr_out {
    struct coda_out_hdr oh;
    struct coda_vattr attr;
};



struct coda_setattr_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    struct coda_vattr attr;
};

struct coda_setattr_out {
    struct coda_out_hdr out;
};


struct coda_access_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int flags;
};

struct coda_access_out {
    struct coda_out_hdr out;
};







struct coda_lookup_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int name;
    int flags;
};

struct coda_lookup_out {
    struct coda_out_hdr oh;
    ViceFid VFid;
    int vtype;
};



struct coda_create_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    struct coda_vattr attr;
    int excl;
    int mode;
    int name;
};

struct coda_create_out {
    struct coda_out_hdr oh;
    ViceFid VFid;
    struct coda_vattr attr;
};



struct coda_remove_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int name;
};

struct coda_remove_out {
    struct coda_out_hdr out;
};


struct coda_link_in {
    struct coda_in_hdr ih;
    ViceFid sourceFid;
    ViceFid destFid;
    int tname;
};

struct coda_link_out {
    struct coda_out_hdr out;
};



struct coda_rename_in {
    struct coda_in_hdr ih;
    ViceFid sourceFid;
    int srcname;
    ViceFid destFid;
    int destname;
};

struct coda_rename_out {
    struct coda_out_hdr out;
};


struct coda_mkdir_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    struct coda_vattr attr;
    int name;
};

struct coda_mkdir_out {
    struct coda_out_hdr oh;
    ViceFid VFid;
    struct coda_vattr attr;
};



struct coda_rmdir_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int name;
};

struct coda_rmdir_out {
    struct coda_out_hdr out;
};


struct coda_symlink_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int srcname;
    struct coda_vattr attr;
    int tname;
};

struct coda_symlink_out {
    struct coda_out_hdr out;
};


struct coda_readlink_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
};

struct coda_readlink_out {
    struct coda_out_hdr oh;
    int count;
    caddr_t data;
};



struct coda_fsync_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
};

struct coda_fsync_out {
    struct coda_out_hdr out;
};


struct coda_vget_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
};

struct coda_vget_out {
    struct coda_out_hdr oh;
    ViceFid VFid;
    int vtype;
};
# 616 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda.h"
struct coda_purgeuser_out {
    struct coda_out_hdr oh;
    struct coda_cred cred;
};



struct coda_zapfile_out {
    struct coda_out_hdr oh;
    ViceFid CodaFid;
};



struct coda_zapdir_out {
    struct coda_out_hdr oh;
    ViceFid CodaFid;
};



struct coda_zapvnode_out {
    struct coda_out_hdr oh;
    struct coda_cred cred;
    ViceFid VFid;
};



struct coda_purgefid_out {
    struct coda_out_hdr oh;
    ViceFid CodaFid;
};



struct coda_replace_out {
    struct coda_out_hdr oh;
    ViceFid NewFid;
    ViceFid OldFid;
};


struct coda_open_by_fd_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int flags;
};

struct coda_open_by_fd_out {
    struct coda_out_hdr oh;
    int fd;


    struct file *fh;

};


struct coda_open_by_path_in {
    struct coda_in_hdr ih;
    ViceFid VFid;
    int flags;
};

struct coda_open_by_path_out {
    struct coda_out_hdr oh;
        int path;
};


struct coda_statfs_in {
    struct coda_in_hdr in;
};

struct coda_statfs_out {
    struct coda_out_hdr oh;
    struct coda_statfs stat;
};
# 703 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda.h"
union inputArgs {
    struct coda_in_hdr ih;
    struct coda_open_in coda_open;
    struct coda_store_in coda_store;
    struct coda_release_in coda_release;
    struct coda_close_in coda_close;
    struct coda_ioctl_in coda_ioctl;
    struct coda_getattr_in coda_getattr;
    struct coda_setattr_in coda_setattr;
    struct coda_access_in coda_access;
    struct coda_lookup_in coda_lookup;
    struct coda_create_in coda_create;
    struct coda_remove_in coda_remove;
    struct coda_link_in coda_link;
    struct coda_rename_in coda_rename;
    struct coda_mkdir_in coda_mkdir;
    struct coda_rmdir_in coda_rmdir;
    struct coda_symlink_in coda_symlink;
    struct coda_readlink_in coda_readlink;
    struct coda_fsync_in coda_fsync;
    struct coda_vget_in coda_vget;
    struct coda_open_by_fd_in coda_open_by_fd;
    struct coda_open_by_path_in coda_open_by_path;
    struct coda_statfs_in coda_statfs;
};

union outputArgs {
    struct coda_out_hdr oh;
    struct coda_root_out coda_root;
    struct coda_open_out coda_open;
    struct coda_ioctl_out coda_ioctl;
    struct coda_getattr_out coda_getattr;
    struct coda_lookup_out coda_lookup;
    struct coda_create_out coda_create;
    struct coda_mkdir_out coda_mkdir;
    struct coda_readlink_out coda_readlink;
    struct coda_vget_out coda_vget;
    struct coda_purgeuser_out coda_purgeuser;
    struct coda_zapfile_out coda_zapfile;
    struct coda_zapdir_out coda_zapdir;
    struct coda_zapvnode_out coda_zapvnode;
    struct coda_purgefid_out coda_purgefid;
    struct coda_replace_out coda_replace;
    struct coda_open_by_fd_out coda_open_by_fd;
    struct coda_open_by_path_out coda_open_by_path;
    struct coda_statfs_out coda_statfs;
};

union coda_downcalls {


    struct coda_purgeuser_out purgeuser;
    struct coda_zapfile_out zapfile;
    struct coda_zapdir_out zapdir;
    struct coda_zapvnode_out zapvnode;
    struct coda_purgefid_out purgefid;
    struct coda_replace_out replace;
};







struct ViceIoctl {
        caddr_t in, out;
        u_short in_size;
        u_short out_size;
};

struct PioctlData {
        const char *path;
        int follow;
        struct ViceIoctl vi;
};
# 797 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda.h"
struct coda_mount_data {
        int version;
        int fd;
};
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda_fs_i.h" 2




struct coda_inode_info {
        struct ViceFid c_fid;
        u_short c_flags;
        struct list_head c_cilist;
        int c_mapcount;
        struct coda_cred c_cached_cred;
        unsigned int c_cached_perm;
};





struct coda_file_info {
        int cfi_magic;
        int cfi_mapcount;
        struct file *cfi_container;
        struct coda_cred cfi_cred;
};
# 47 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/coda_fs_i.h"
int coda_cnode_make(struct inode **, struct ViceFid *, struct super_block *);
struct inode *coda_iget(struct super_block *sb, struct ViceFid *fid, struct coda_vattr *attr);
int coda_cnode_makectl(struct inode **inode, struct super_block *sb);
struct inode *coda_fid_to_inode(ViceFid *fid, struct super_block *sb);
void coda_replace_fid(struct inode *, ViceFid *, ViceFid *);
# 313 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/romfs_fs_i.h" 1





struct romfs_inode_info {
        unsigned long i_metasize;
        unsigned long i_dataoffset;
};
# 314 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/shmem_fs.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/shmem_fs.h"
typedef struct {
        unsigned long val;
} swp_entry_t;

struct shmem_inode_info {
        spinlock_t lock;
        unsigned long next_index;
        swp_entry_t i_direct[16];
        void **i_indirect;
        unsigned long swapped;
        unsigned long flags;
        struct list_head list;
        struct inode *inode;
};

struct shmem_sb_info {
        unsigned long max_blocks;
        unsigned long free_blocks;
        unsigned long max_inodes;
        unsigned long free_inodes;
        spinlock_t stat_lock;
};
# 315 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smb_fs_i.h" 1
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smb_fs_i.h"
struct smb_inode_info {





        unsigned int open;
        __u16 fileid;
        __u16 attr;

        __u16 access;
        __u16 flags;
        unsigned long oldmtime;
        unsigned long closed;
        unsigned openers;
};
# 316 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/hfs_fs_i.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/hfs_fs_i.h"
struct hfs_inode_info {
        int magic;

        unsigned long mmu_private;
        struct hfs_cat_entry *entry;


        struct hfs_fork *fork;
        int convert;


        ino_t file_type;
        char dir_size;


        const struct hfs_hdr_layout *default_layout;
        struct hfs_hdr_layout *layout;


        int tz_secondswest;


        void (*d_drop_op)(struct dentry *, const ino_t);
};
# 317 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/adfs_fs_i.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/adfs_fs_i.h"
struct adfs_inode_info {
        unsigned long mmu_private;
        unsigned long parent_id;
        __u32 loadaddr;
        __u32 execaddr;
        unsigned int filetype;
        unsigned int attr;
        int stamped:1;
};
# 318 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnx4_fs_i.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnx4_fs_i.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnxtypes.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnxtypes.h"
typedef __u16 qnx4_nxtnt_t;
typedef __u8 qnx4_ftype_t;

typedef struct {
        __u32 xtnt_blk;
        __u32 xtnt_size;
} qnx4_xtnt_t;

typedef __u16 qnx4_mode_t;
typedef __u16 qnx4_muid_t;
typedef __u16 qnx4_mgid_t;
typedef __u32 qnx4_off_t;
typedef __u16 qnx4_nlink_t;
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnx4_fs_i.h" 2




struct qnx4_inode_info {
        char i_reserved[16];
        qnx4_off_t i_size;
        qnx4_xtnt_t i_first_xtnt;
        __u32 i_xblk;
        __s32 i_ftime;
        __s32 i_mtime;
        __s32 i_atime;
        __s32 i_ctime;
        qnx4_nxtnt_t i_num_xtnts;
        qnx4_mode_t i_mode;
        qnx4_muid_t i_uid;
        qnx4_mgid_t i_gid;
        qnx4_nlink_t i_nlink;
        __u8 i_zero[4];
        qnx4_ftype_t i_type;
        __u8 i_status;
        unsigned long mmu_private;
};
# 319 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/reiserfs_fs_i.h" 1
# 10 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/reiserfs_fs_i.h"
typedef enum {



    i_item_key_version_mask = 0x0001,


    i_stat_data_version_mask = 0x0002,

    i_pack_on_close_mask = 0x0004,

    i_nopack_mask = 0x0008,



    i_link_saved_unlink_mask = 0x0010,
    i_link_saved_truncate_mask = 0x0020
} reiserfs_inode_flags;


struct reiserfs_inode_info {
    __u32 i_key [4];



    __u32 i_flags;

    __u32 i_first_direct_byte;


    __u32 i_attrs;

    int i_prealloc_block;
    int i_prealloc_count;
    struct list_head i_prealloc_list;


    int new_packing_locality:1;






    unsigned long i_trans_id ;
    unsigned long i_trans_index ;





    unsigned long i_tail_trans_id;
    unsigned long i_tail_trans_index;
};
# 320 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/bfs_fs_i.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/bfs_fs_i.h"
struct bfs_inode_info {
        unsigned long i_dsk_ino;
        unsigned long i_sblock;
        unsigned long i_eblock;
};
# 321 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/udf_fs_i.h" 1
# 24 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/udf_fs_i.h"
typedef struct
{
        __u32 logicalBlockNum;
        __u16 partitionReferenceNum;
} __attribute__ ((packed)) lb_addr;


struct udf_inode_info
{
        long i_umtime;
        long i_uctime;
        long i_crtime;
        long i_ucrtime;

        lb_addr i_location;
        __u64 i_unique;
        __u32 i_lenEAttr;
        __u32 i_lenAlloc;
        __u64 i_lenExtents;
        __u32 i_next_alloc_block;
        __u32 i_next_alloc_goal;
        unsigned i_alloc_type : 3;
        unsigned i_extended_fe : 1;
        unsigned i_strat_4096 : 1;
        unsigned i_new_inode : 1;
        unsigned reserved : 26;
};
# 322 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_fs_i.h" 1
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_fs_i.h"
struct ncp_inode_info {
        __u32 dirEntNum;
        __u32 DosDirNum;
        __u32 volNumber;
        __u32 nwattr;
        struct semaphore open_sem;
        atomic_t opened;
        int access;
        __u32 server_file_handle;
        __u8 open_create_action;
        __u8 file_handle[6];
};
# 323 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/proc_fs_i.h" 1
struct proc_inode_info {
        struct task_struct *task;
        int type;
        union {
                int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
                int (*proc_read)(struct task_struct *task, char *page);
        } op;
        struct file *file;
};
# 324 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/usbdev_fs_i.h" 1
struct usb_device;
struct usb_bus;

struct usbdev_inode_info {
        struct list_head dlist;
        struct list_head slist;
        union {
                struct usb_device *dev;
                struct usb_bus *bus;
        } p;
};
# 325 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/jffs2_fs_i.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/jffs2_fs_i.h"
struct jffs2_inode_info {
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/jffs2_fs_i.h"
        struct semaphore sem;


        __u32 highest_version;


        struct jffs2_node_frag *fraglist;






        struct jffs2_full_dnode *metadata;


        struct jffs2_full_dirent *dents;


        struct jffs2_inode_cache *inocache;





        __u16 flags;
        __u8 usercompr;
};
# 326 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/cramfs_fs_sb.h" 1






struct cramfs_sb_info {
                        unsigned long magic;
                        unsigned long size;
                        unsigned long blocks;
                        unsigned long files;
                        unsigned long flags;
};
# 327 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 353 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
struct iattr {
        unsigned int ia_valid;
        umode_t ia_mode;
        uid_t ia_uid;
        gid_t ia_gid;
        loff_t ia_size;
        time_t ia_atime;
        time_t ia_mtime;
        time_t ia_ctime;
        unsigned int ia_attr_flags;
};
# 377 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h" 1
# 42 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/errno.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/errno.h" 1
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/errno.h" 2
# 43 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h" 2





typedef __kernel_uid32_t qid_t;
typedef __u64 qsize_t;
# 107 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h"
struct if_dqblk {
        __u64 dqb_bhardlimit;
        __u64 dqb_bsoftlimit;
        __u64 dqb_curspace;
        __u64 dqb_ihardlimit;
        __u64 dqb_isoftlimit;
        __u64 dqb_curinodes;
        __u64 dqb_btime;
        __u64 dqb_itime;
        __u32 dqb_valid;
};
# 128 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h"
struct if_dqinfo {
        __u64 dqi_bgrace;
        __u64 dqi_igrace;
        __u32 dqi_flags;
        __u32 dqi_valid;
};



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dqblk_xfs.h" 1
# 46 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dqblk_xfs.h"
typedef struct fs_disk_quota {
        __s8 d_version;
        __s8 d_flags;
        __u16 d_fieldmask;
        __u32 d_id;
        __u64 d_blk_hardlimit;
        __u64 d_blk_softlimit;
        __u64 d_ino_hardlimit;
        __u64 d_ino_softlimit;
        __u64 d_bcount;
        __u64 d_icount;
        __s32 d_itimer;

        __s32 d_btimer;
        __u16 d_iwarns;
        __u16 d_bwarns;
        __s32 d_padding2;
        __u64 d_rtb_hardlimit;
        __u64 d_rtb_softlimit;
        __u64 d_rtbcount;
        __s32 d_rtbtimer;
        __u16 d_rtbwarns;
        __s16 d_padding3;
        char d_padding4[8];
} fs_disk_quota_t;
# 133 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dqblk_xfs.h"
typedef struct fs_qfilestat {
        __u64 qfs_ino;
        __u64 qfs_nblks;
        __u32 qfs_nextents;
} fs_qfilestat_t;

typedef struct fs_quota_stat {
        __s8 qs_version;
        __u16 qs_flags;
        __s8 qs_pad;
        fs_qfilestat_t qs_uquota;
        fs_qfilestat_t qs_gquota;
        __u32 qs_incoredqs;
        __s32 qs_btimelimit;
        __s32 qs_itimelimit;
        __s32 qs_rtbtimelimit;
        __u16 qs_bwarnlimit;
        __u16 qs_iwarnlimit;
} fs_quota_stat_t;
# 138 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dqblk_v1.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dqblk_v1.h"
struct v1_mem_dqinfo {
};
# 139 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dqblk_v2.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dqblk_v2.h"
struct v2_mem_dqinfo {
        unsigned int dqi_blocks;
        unsigned int dqi_free_blk;
        unsigned int dqi_free_entry;
};
# 140 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h" 2




struct mem_dqblk {
        __u32 dqb_bhardlimit;
        __u32 dqb_bsoftlimit;
        qsize_t dqb_curspace;
        __u32 dqb_ihardlimit;
        __u32 dqb_isoftlimit;
        __u32 dqb_curinodes;
        time_t dqb_btime;
        time_t dqb_itime;
};




struct quota_format_type;

struct mem_dqinfo {
        struct quota_format_type *dqi_format;
        int dqi_flags;
        unsigned int dqi_bgrace;
        unsigned int dqi_igrace;
        union {
                struct v1_mem_dqinfo v1_i;
                struct v2_mem_dqinfo v2_i;
        } u;
};





extern __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mark_info_dirty(struct mem_dqinfo *info)
{
        info->dqi_flags |= 0x10000;
}
# 187 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h"
struct dqstats {
        int lookups;
        int drops;
        int reads;
        int writes;
        int cache_hits;
        int allocated_dquots;
        int free_dquots;
        int syncs;
};

extern struct dqstats dqstats;
# 209 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h"
struct dquot {
        struct list_head dq_hash;
        struct list_head dq_inuse;
        struct list_head dq_free;
        wait_queue_head_t dq_wait_lock;
        wait_queue_head_t dq_wait_free;
        int dq_count;
        int dq_dup_ref;


        struct super_block *dq_sb;
        unsigned int dq_id;
        kdev_t dq_dev;
        loff_t dq_off;
        short dq_type;
        short dq_flags;
        struct mem_dqblk dq_dqb;
};







struct quota_format_ops {
        int (*check_quota_file)(struct super_block *sb, int type);
        int (*read_file_info)(struct super_block *sb, int type);
        int (*write_file_info)(struct super_block *sb, int type);
        int (*free_file_info)(struct super_block *sb, int type);
        int (*read_dqblk)(struct dquot *dquot);
        int (*commit_dqblk)(struct dquot *dquot);
};


struct dquot_operations {
        void (*initialize) (struct inode *, int);
        void (*drop) (struct inode *);
        int (*alloc_space) (struct inode *, qsize_t, int);
        int (*alloc_inode) (const struct inode *, unsigned long);
        void (*free_space) (struct inode *, qsize_t);
        void (*free_inode) (const struct inode *, unsigned long);
        int (*transfer) (struct inode *, struct iattr *);
        int (*write_dquot) (struct dquot *);
};


struct quotactl_ops {
        int (*quota_on)(struct super_block *, int, int, char *);
        int (*quota_off)(struct super_block *, int);
        int (*quota_sync)(struct super_block *, int);
        int (*get_info)(struct super_block *, int, struct if_dqinfo *);
        int (*set_info)(struct super_block *, int, struct if_dqinfo *);
        int (*get_dqblk)(struct super_block *, int, qid_t, struct if_dqblk *);
        int (*set_dqblk)(struct super_block *, int, qid_t, struct if_dqblk *);
        int (*get_xstate)(struct super_block *, struct fs_quota_stat *);
        int (*set_xstate)(struct super_block *, unsigned int, int);
        int (*get_xquota)(struct super_block *, int, qid_t, struct fs_disk_quota *);
        int (*set_xquota)(struct super_block *, int, qid_t, struct fs_disk_quota *);
};

struct quota_format_type {
        int qf_fmt_id;
        struct quota_format_ops *qf_ops;
        struct module *qf_owner;
        struct quota_format_type *qf_next;
};




struct quota_info {
        unsigned int flags;
        struct semaphore dqio_sem;
        struct semaphore dqoff_sem;
        struct file *files[2];
        struct mem_dqinfo info[2];
        struct quota_format_ops *ops[2];
};
# 297 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/quota.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int is_enabled(struct quota_info *dqopt, int type)
{
        switch (type) {
                case 0:
                        return dqopt->flags & 0x01;
                case 1:
                        return dqopt->flags & 0x02;
        }
        return 0;
}





int register_quota_format(struct quota_format_type *fmt);
void unregister_quota_format(struct quota_format_type *fmt);
void init_dquot_operations(struct dquot_operations *fsdqops);
# 378 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2





struct page;
struct address_space;
struct kiobuf;

struct address_space_operations {
        int (*writepage)(struct page *);
        int (*readpage)(struct file *, struct page *);
        int (*sync_page)(struct page *);




        int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
        int (*commit_write)(struct file *, struct page *, unsigned, unsigned);

        int (*bmap)(struct address_space *, long);
        int (*flushpage) (struct page *, unsigned long);
        int (*releasepage) (struct page *, int);

        int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);

        int (*direct_fileIO)(int, struct file *, struct kiobuf *, unsigned long, int);
        void (*removepage)(struct page *);
};

struct address_space {
        struct list_head clean_pages;
        struct list_head dirty_pages;
        struct list_head locked_pages;
        unsigned long nrpages;
        struct address_space_operations *a_ops;
        struct inode *host;
        struct vm_area_struct *i_mmap;
        struct vm_area_struct *i_mmap_shared;
        spinlock_t i_shared_lock;
        int gfp_mask;
};

struct char_device {
        struct list_head hash;
        atomic_t count;
        dev_t dev;
        atomic_t openers;
        struct semaphore sem;
};

struct block_device {
        struct list_head bd_hash;
        atomic_t bd_count;
        struct inode * bd_inode;
        dev_t bd_dev;
        int bd_openers;
        const struct block_device_operations *bd_op;
        struct semaphore bd_sem;
        struct list_head bd_inodes;
};

struct inode {
        struct list_head i_hash;
        struct list_head i_list;
        struct list_head i_dentry;

        struct list_head i_dirty_buffers;
        struct list_head i_dirty_data_buffers;

        unsigned long i_ino;
        atomic_t i_count;
        kdev_t i_dev;
        umode_t i_mode;
        unsigned int i_nlink;
        uid_t i_uid;
        gid_t i_gid;
        kdev_t i_rdev;
        loff_t i_size;
        time_t i_atime;
        time_t i_mtime;
        time_t i_ctime;
        unsigned int i_blkbits;
        unsigned long i_blksize;
        unsigned long i_blocks;
        unsigned long i_version;
        unsigned short i_bytes;
        struct semaphore i_sem;
        struct rw_semaphore i_alloc_sem;
        struct semaphore i_zombie;
        struct inode_operations *i_op;
        struct file_operations *i_fop;
        struct super_block *i_sb;
        wait_queue_head_t i_wait;
        struct file_lock *i_flock;
        struct address_space *i_mapping;
        struct address_space i_data;
        struct dquot *i_dquot[2];

        struct list_head i_devices;
        struct pipe_inode_info *i_pipe;
        struct block_device *i_bdev;
        struct char_device *i_cdev;

        unsigned long i_dnotify_mask;
        struct dnotify_struct *i_dnotify;

        unsigned long i_state;

        unsigned int i_flags;
        unsigned char i_sock;

        atomic_t i_writecount;
        unsigned int i_attr_flags;
        __u32 i_generation;
        union {
                struct minix_inode_info minix_i;
                struct ext2_inode_info ext2_i;
                struct ext3_inode_info ext3_i;
                struct hpfs_inode_info hpfs_i;
                struct ntfs_inode_info ntfs_i;
                struct msdos_inode_info msdos_i;
                struct umsdos_inode_info umsdos_i;
                struct iso_inode_info isofs_i;
                struct nfs_inode_info nfs_i;
                struct sysv_inode_info sysv_i;
                struct affs_inode_info affs_i;
                struct ufs_inode_info ufs_i;
                struct efs_inode_info efs_i;
                struct romfs_inode_info romfs_i;
                struct shmem_inode_info shmem_i;
                struct coda_inode_info coda_i;
                struct smb_inode_info smbfs_i;
                struct hfs_inode_info hfs_i;
                struct adfs_inode_info adfs_i;
                struct qnx4_inode_info qnx4_i;
                struct reiserfs_inode_info reiserfs_i;
                struct bfs_inode_info bfs_i;
                struct udf_inode_info udf_i;
                struct ncp_inode_info ncpfs_i;
                struct proc_inode_info proc_i;
                struct socket socket_i;
                struct usbdev_inode_info usbdev_i;
                struct jffs2_inode_info jffs2_i;
                void *generic_ip;
        } u;
};

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void inode_add_bytes(struct inode *inode, loff_t bytes)
{
        inode->i_blocks += bytes >> 9;
        bytes &= 511;
        inode->i_bytes += bytes;
        if (inode->i_bytes >= 512) {
                inode->i_blocks++;
                inode->i_bytes -= 512;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void inode_sub_bytes(struct inode *inode, loff_t bytes)
{
        inode->i_blocks -= bytes >> 9;
        bytes &= 511;
        if (inode->i_bytes < bytes) {
                inode->i_blocks--;
                inode->i_bytes += 512;
        }
        inode->i_bytes -= bytes;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) loff_t inode_get_bytes(struct inode *inode)
{
        return (((loff_t)inode->i_blocks) << 9) + inode->i_bytes;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void inode_set_bytes(struct inode *inode, loff_t bytes)
{
        inode->i_blocks = bytes >> 9;
        inode->i_bytes = bytes & 511;
}

struct fown_struct {
        int pid;
        uid_t uid, euid;
        int signum;
};

struct file {
        struct list_head f_list;
        struct dentry *f_dentry;
        struct vfsmount *f_vfsmnt;
        struct file_operations *f_op;
        atomic_t f_count;
        unsigned int f_flags;
        mode_t f_mode;
        loff_t f_pos;
        unsigned long f_reada, f_ramax, f_raend, f_ralen, f_rawin;
        struct fown_struct f_owner;
        unsigned int f_uid, f_gid;
        int f_error;

        size_t f_maxcount;
        unsigned long f_version;


        void *private_data;


        struct kiobuf *f_iobuf;
        long f_iobuf_lock;
};
extern spinlock_t files_lock;






extern int init_private_file(struct file *, struct dentry *, int);
# 622 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
typedef struct files_struct *fl_owner_t;

struct file_lock {
        struct file_lock *fl_next;
        struct list_head fl_link;
        struct list_head fl_block;
        fl_owner_t fl_owner;
        unsigned int fl_pid;
        wait_queue_head_t fl_wait;
        struct file *fl_file;
        unsigned char fl_flags;
        unsigned char fl_type;
        loff_t fl_start;
        loff_t fl_end;

        void (*fl_notify)(struct file_lock *);
        void (*fl_insert)(struct file_lock *);
        void (*fl_remove)(struct file_lock *);

        struct fasync_struct * fl_fasync;
        unsigned long fl_break_time;

        union {
                struct nfs_lock_info nfs_fl;
        } fl_u;
};
# 656 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
extern struct list_head file_lock_list;

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fcntl.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/fcntl.h" 1
# 79 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/fcntl.h"
typedef struct flock {
        short l_type;
        short l_whence;
        __kernel_off_t l_start;
        __kernel_off_t l_len;
        __kernel_pid_t l_pid;
} flock_t;


struct flock32 {
        short l_type;
        short l_whence;
        __kernel_off_t32 l_start;
        __kernel_off_t32 l_len;
        __s32 l_sysid;
        __kernel_pid_t32 l_pid;
        short __unused;
        __s32 pad[4];
};
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fcntl.h" 2
# 659 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2

extern int fcntl_getlk(unsigned int, struct flock *);
extern int fcntl_setlk(unsigned int, struct file *, unsigned int,
                        struct flock *);

extern int fcntl_getlk64(unsigned int, struct flock *);
extern int fcntl_setlk64(unsigned int, struct file *, unsigned int,
                        struct flock *);


extern void locks_init_lock(struct file_lock *);
extern void locks_copy_lock(struct file_lock *, struct file_lock *);
extern void locks_remove_posix(struct file *, fl_owner_t);
extern void locks_remove_flock(struct file *);
extern struct file_lock *posix_test_lock(struct file *, struct file_lock *);
extern int posix_lock_file(struct file *, struct file_lock *, unsigned int);
extern void posix_block_lock(struct file_lock *, struct file_lock *);
extern void posix_unblock_lock(struct file_lock *);
extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);
extern int __get_lease(struct inode *inode, unsigned int flags);
extern time_t lease_get_mtime(struct inode *);
extern int lock_may_read(struct inode *, loff_t start, unsigned long count);
extern int lock_may_write(struct inode *, loff_t start, unsigned long count);
extern void steal_locks(fl_owner_t from);

struct fasync_struct {
        int magic;
        int fa_fd;
        struct fasync_struct *fa_next;
        struct file *fa_file;
};




extern int fasync_helper(int, struct file *, int, struct fasync_struct **);

extern void kill_fasync(struct fasync_struct **, int, int);

extern void __kill_fasync(struct fasync_struct *, int, int);

struct nameidata {
        struct dentry *dentry;
        struct vfsmount *mnt;
        struct qstr last;
        unsigned int flags;
        int last_type;
};
# 715 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/minix_fs_sb.h" 1






struct minix_sb_info {
                        unsigned long s_ninodes;
                        unsigned long s_nzones;
                        unsigned long s_imap_blocks;
                        unsigned long s_zmap_blocks;
                        unsigned long s_firstdatazone;
                        unsigned long s_log_zone_size;
                        unsigned long s_max_size;
                        int s_dirsize;
                        int s_namelen;
                        int s_link_max;
                        struct buffer_head ** s_imap;
                        struct buffer_head ** s_zmap;
                        struct buffer_head * s_sbh;
                        struct minix_super_block * s_ms;
                        unsigned short s_mount_state;
                        unsigned short s_version;
};
# 716 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext2_fs_sb.h" 1
# 30 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext2_fs_sb.h"
struct ext2_sb_info {
        unsigned long s_frag_size;
        unsigned long s_frags_per_block;
        unsigned long s_inodes_per_block;
        unsigned long s_frags_per_group;
        unsigned long s_blocks_per_group;
        unsigned long s_inodes_per_group;
        unsigned long s_itb_per_group;
        unsigned long s_gdb_count;
        unsigned long s_desc_per_block;
        unsigned long s_groups_count;
        struct buffer_head * s_sbh;
        struct ext2_super_block * s_es;
        struct buffer_head ** s_group_desc;
        unsigned short s_loaded_inode_bitmaps;
        unsigned short s_loaded_block_bitmaps;
        unsigned long s_inode_bitmap_number[8];
        struct buffer_head * s_inode_bitmap[8];
        unsigned long s_block_bitmap_number[8];
        struct buffer_head * s_block_bitmap[8];
        unsigned long s_mount_opt;
        uid_t s_resuid;
        gid_t s_resgid;
        unsigned short s_mount_state;
        unsigned short s_pad;
        int s_addr_per_block_bits;
        int s_desc_per_block_bits;
        int s_inode_size;
        int s_first_ino;
};
# 717 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext3_fs_sb.h" 1
# 20 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext3_fs_sb.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/timer.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/timer.h"
struct timer_list {
        struct list_head list;
        unsigned long expires;
        unsigned long data;
        void (*function)(unsigned long);
};

extern void add_timer(struct timer_list * timer);
extern int del_timer(struct timer_list * timer);
# 41 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/timer.h"
int mod_timer(struct timer_list *timer, unsigned long expires);

extern void it_real_fn(unsigned long);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void init_timer(struct timer_list * timer)
{
        timer->list.next = timer->list.prev = ((void *)0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int timer_pending (const struct timer_list * timer)
{
        return timer->list.next != ((void *)0);
}
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext3_fs_sb.h" 2
# 35 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ext3_fs_sb.h"
struct ext3_sb_info {
        unsigned long s_frag_size;
        unsigned long s_frags_per_block;
        unsigned long s_inodes_per_block;
        unsigned long s_frags_per_group;
        unsigned long s_blocks_per_group;
        unsigned long s_inodes_per_group;
        unsigned long s_itb_per_group;
        unsigned long s_gdb_count;
        unsigned long s_desc_per_block;
        unsigned long s_groups_count;
        struct buffer_head * s_sbh;
        struct ext3_super_block * s_es;
        struct buffer_head ** s_group_desc;
        unsigned short s_loaded_inode_bitmaps;
        unsigned short s_loaded_block_bitmaps;
        unsigned long s_inode_bitmap_number[8];
        struct buffer_head * s_inode_bitmap[8];
        unsigned long s_block_bitmap_number[8];
        struct buffer_head * s_block_bitmap[8];
        unsigned long s_mount_opt;
        uid_t s_resuid;
        gid_t s_resgid;
        unsigned short s_mount_state;
        unsigned short s_pad;
        int s_addr_per_block_bits;
        int s_desc_per_block_bits;
        int s_inode_size;
        int s_first_ino;
        u32 s_next_generation;


        struct inode * s_journal_inode;
        struct journal_s * s_journal;
        struct list_head s_orphan;
        unsigned long s_commit_interval;
        struct block_device *journal_bdev;




};
# 718 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/hpfs_fs_sb.h" 1



struct hpfs_sb_info {
        ino_t sb_root;
        unsigned sb_fs_size;
        unsigned sb_bitmaps;
        unsigned sb_dirband_start;
        unsigned sb_dirband_size;
        unsigned sb_dmap;
        unsigned sb_n_free;
        unsigned sb_n_free_dnodes;
        uid_t sb_uid;
        gid_t sb_gid;
        umode_t sb_mode;
        unsigned sb_conv : 2;
        unsigned sb_eas : 2;
        unsigned sb_err : 2;
        unsigned sb_chk : 2;
        unsigned sb_lowercase : 1;
        unsigned sb_was_error : 1;
        unsigned sb_chkdsk : 2;
        unsigned sb_rd_fnode : 2;
        unsigned sb_rd_inode : 2;


        wait_queue_head_t sb_iget_q;
        unsigned char *sb_cp_table;


        unsigned *sb_bmp_dir;
        unsigned sb_c_bitmap;
        unsigned sb_max_fwd_alloc;
        wait_queue_head_t sb_creation_de;

        unsigned sb_creation_de_lock : 1;

        int sb_timeshift;
};
# 719 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ntfs_fs_sb.h" 1





struct ntfs_sb_info{

        ntfs_uid_t uid;
        ntfs_gid_t gid;
        ntmode_t umask;
        void *nls_map;
        unsigned int ngt;
        char mft_zone_multiplier;
        unsigned long mft_data_pos;
        ntfs_cluster_t mft_zone_pos;
        ntfs_cluster_t mft_zone_start;
        ntfs_cluster_t mft_zone_end;
        ntfs_cluster_t data1_zone_pos;
        ntfs_cluster_t data2_zone_pos;


        ntfs_size_t partition_bias;

        ntfs_u32 at_standard_information;
        ntfs_u32 at_attribute_list;
        ntfs_u32 at_file_name;
        ntfs_u32 at_volume_version;
        ntfs_u32 at_security_descriptor;
        ntfs_u32 at_volume_name;
        ntfs_u32 at_volume_information;
        ntfs_u32 at_data;
        ntfs_u32 at_index_root;
        ntfs_u32 at_index_allocation;
        ntfs_u32 at_bitmap;
        ntfs_u32 at_symlink;

        int sector_size;
        int cluster_size;
        int cluster_size_bits;
        int mft_clusters_per_record;
        int mft_record_size;
        int mft_record_size_bits;
        int index_clusters_per_record;
        int index_record_size;
        int index_record_size_bits;
        ntfs_cluster_t nr_clusters;
        ntfs_cluster_t mft_lcn;
        ntfs_cluster_t mft_mirr_lcn;

        unsigned char *mft;
        unsigned short *upcase;
        unsigned int upcase_length;

        struct ntfs_inode_info *mft_ino;
        struct ntfs_inode_info *mftmirr;
        struct ntfs_inode_info *bitmap;
        struct super_block *sb;
        unsigned char ino_flags;
};
# 720 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/msdos_fs_sb.h" 1


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fat_cvf.h" 1





struct cvf_format
{ int cvf_version;
  char* cvf_version_text;
  unsigned long flags;
  int (*detect_cvf) (struct super_block*sb);
  int (*mount_cvf) (struct super_block*sb,char*options);
  int (*unmount_cvf) (struct super_block*sb);
  struct buffer_head* (*cvf_bread) (struct super_block*sb,int block);
  struct buffer_head* (*cvf_getblk) (struct super_block*sb,int block);
  void (*cvf_brelse) (struct super_block *sb,struct buffer_head *bh);
  void (*cvf_mark_buffer_dirty) (struct super_block *sb,
                              struct buffer_head *bh);
  void (*cvf_set_uptodate) (struct super_block *sb,
                         struct buffer_head *bh,
                         int val);
  int (*cvf_is_uptodate) (struct super_block *sb,struct buffer_head *bh);
  void (*cvf_ll_rw_block) (struct super_block *sb,
                        int opr,
                        int nbreq,
                        struct buffer_head *bh[32]);
  int (*fat_access) (struct super_block *sb,int nr,int new_value);
  int (*cvf_statfs) (struct super_block *sb,struct statfs *buf, int bufsiz);
  int (*cvf_bmap) (struct inode *inode,int block);
  ssize_t (*cvf_file_read) ( struct file *, char *, size_t, loff_t *);
  ssize_t (*cvf_file_write) ( struct file *, const char *, size_t, loff_t *);
  int (*cvf_mmap) (struct file *, struct vm_area_struct *);
  int (*cvf_readpage) (struct inode *, struct page *);
  int (*cvf_writepage) (struct inode *, struct page *);
  int (*cvf_dir_ioctl) (struct inode * inode, struct file * filp,
                        unsigned int cmd, unsigned long arg);
  void (*zero_out_cluster) (struct inode*, int clusternr);
};

int register_cvf_format(struct cvf_format*cvf_format);
int unregister_cvf_format(struct cvf_format*cvf_format);
void dec_cvf_format_use_count_by_version(int version);
int detect_cvf(struct super_block*sb,char*force);

extern struct cvf_format *cvf_formats[];
extern int cvf_format_use_count[];
# 4 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/msdos_fs_sb.h" 2





struct fat_mount_options {
        uid_t fs_uid;
        gid_t fs_gid;
        unsigned short fs_umask;
        unsigned short codepage;
        char *iocharset;
        unsigned short shortname;
        unsigned char name_check;
        unsigned char conversion;
        unsigned quiet:1,
                 showexec:1,
                 sys_immutable:1,
                 dotsOK:1,
                 isvfat:1,
                 utf8:1,
                 unicode_xlate:1,
                 posixfs:1,
                 numtail:1,
                 atari:1,
                 fat32:1,
                 nocase:1;
};

struct msdos_sb_info {
        unsigned short cluster_size;
        unsigned short cluster_bits;
        unsigned char fats,fat_bits;
        unsigned short fat_start;
        unsigned long fat_length;
        unsigned long dir_start;
        unsigned short dir_entries;
        unsigned long data_start;
        unsigned long clusters;
        unsigned long root_cluster;
        unsigned long fsinfo_sector;
        struct semaphore fat_lock;
        int prev_free;
        int free_clusters;
        struct fat_mount_options options;
        struct nls_table *nls_disk;
        struct nls_table *nls_io;
        struct cvf_format* cvf_format;
        void *dir_ops;
        void *private_data;
        int dir_per_block;
        int dir_per_block_bits;
};
# 721 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/iso_fs_sb.h" 1






struct isofs_sb_info {
        unsigned long s_ninodes;
        unsigned long s_nzones;
        unsigned long s_firstdatazone;
        unsigned long s_log_zone_size;
        unsigned long s_max_size;

        unsigned char s_high_sierra;
        unsigned char s_mapping;
        int s_rock_offset;
        unsigned char s_rock;
        unsigned char s_joliet_level;
        unsigned char s_utf8;
        unsigned char s_cruft;


        unsigned char s_unhide;
        unsigned char s_nosuid;
        unsigned char s_nodev;
        unsigned char s_nocompress;

        mode_t s_mode;
        gid_t s_gid;
        uid_t s_uid;
        struct nls_table *s_nls_iocharset;
};
# 722 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs_fs_sb.h" 1
# 9 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/nfs_fs_sb.h"
struct nfs_server {
        struct rpc_clnt * client;
        struct nfs_rpc_ops * rpc_ops;
        int flags;
        unsigned int rsize;
        unsigned int rpages;
        unsigned int wsize;
        unsigned int wpages;
        unsigned int dtsize;
        unsigned int bsize;
        unsigned int acregmin;
        unsigned int acregmax;
        unsigned int acdirmin;
        unsigned int acdirmax;
        unsigned int namelen;
        char * hostname;
        struct nfs_reqlist * rw_requests;
        struct list_head lru_read,
                                lru_dirty,
                                lru_commit,
                                lru_busy;
};




struct nfs_sb_info {
        struct nfs_server s_server;
};
# 723 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sysv_fs_sb.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sysv_fs_sb.h"
struct sysv_sb_info {
        int s_type;
        char s_bytesex;
        char s_truncate;

        nlink_t s_link_max;
        unsigned int s_inodes_per_block;
        unsigned int s_inodes_per_block_1;
        unsigned int s_inodes_per_block_bits;
        unsigned int s_ind_per_block;
        unsigned int s_ind_per_block_bits;
        unsigned int s_ind_per_block_2;
        unsigned int s_toobig_block;
        unsigned int s_block_base;
        unsigned short s_fic_size;
        unsigned short s_flc_size;

        struct buffer_head *s_bh1;
        struct buffer_head *s_bh2;


        char * s_sbd1;
        char * s_sbd2;
        u16 *s_sb_fic_count;
        u16 *s_sb_fic_inodes;
        u16 *s_sb_total_free_inodes;
        u16 *s_bcache_count;
        u32 *s_bcache;
        u32 *s_free_blocks;
        u32 *s_sb_time;
        u32 *s_sb_state;


        u32 s_firstinodezone;
        u32 s_firstdatazone;
        u32 s_ninodes;
        u32 s_ndatazones;
        u32 s_nzones;
        u16 s_namelen;
};
# 724 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/affs_fs_sb.h" 1
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/affs_fs_sb.h"
struct affs_bm_info {
        u32 bm_key;
        u32 bm_free;
};

struct affs_sb_info {
        int s_partition_size;
        int s_reserved;

        u32 s_data_blksize;
        u32 s_root_block;
        int s_hashsize;
        unsigned long s_flags;
        uid_t s_uid;
        gid_t s_gid;
        umode_t s_mode;
        struct buffer_head *s_root_bh;
        struct semaphore s_bmlock;
        struct affs_bm_info *s_bitmap;
        u32 s_bmap_count;
        u32 s_bmap_bits;
        u32 s_last_bmap;
        struct buffer_head *s_bmap_bh;
        char *s_prefix;
        int s_prefix_len;
        char s_volume[32];
};
# 725 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ufs_fs_sb.h" 1
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ufs_fs_sb.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ufs_fs.h" 1
# 237 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ufs_fs.h"
struct ufs_timeval {
        __s32 tv_sec;
        __s32 tv_usec;
};

struct ufs_dir_entry {
        __u32 d_ino;
        __u16 d_reclen;
        union {
                __u16 d_namlen;
                struct {
                        __u8 d_type;
                        __u8 d_namlen;
                } d_44;
        } d_u;
        __u8 d_name[255 + 1];
};

struct ufs_csum {
        __u32 cs_ndir;
        __u32 cs_nbfree;
        __u32 cs_nifree;
        __u32 cs_nffree;
};




struct ufs_super_block {
        __u32 fs_link;
        __u32 fs_rlink;
        __u32 fs_sblkno;
        __u32 fs_cblkno;
        __u32 fs_iblkno;
        __u32 fs_dblkno;
        __u32 fs_cgoffset;
        __u32 fs_cgmask;
        __u32 fs_time;
        __u32 fs_size;
        __u32 fs_dsize;
        __u32 fs_ncg;
        __u32 fs_bsize;
        __u32 fs_fsize;
        __u32 fs_frag;

        __u32 fs_minfree;
        __u32 fs_rotdelay;
        __u32 fs_rps;

        __u32 fs_bmask;
        __u32 fs_fmask;
        __u32 fs_bshift;
        __u32 fs_fshift;

        __u32 fs_maxcontig;
        __u32 fs_maxbpg;

        __u32 fs_fragshift;
        __u32 fs_fsbtodb;
        __u32 fs_sbsize;
        __u32 fs_csmask;
        __u32 fs_csshift;
        __u32 fs_nindir;
        __u32 fs_inopb;
        __u32 fs_nspf;

        __u32 fs_optim;

        union {
                struct {
                        __u32 fs_npsect;
                } fs_sun;
                struct {
                        __s32 fs_state;
                } fs_sunx86;
        } fs_u1;
        __u32 fs_interleave;
        __u32 fs_trackskew;




        __u32 fs_id[2];

        __u32 fs_csaddr;
        __u32 fs_cssize;
        __u32 fs_cgsize;

        __u32 fs_ntrak;
        __u32 fs_nsect;
        __u32 fs_spc;

        __u32 fs_ncyl;

        __u32 fs_cpg;
        __u32 fs_ipg;
        __u32 fs_fpg;

        struct ufs_csum fs_cstotal;

        __s8 fs_fmod;
        __s8 fs_clean;
        __s8 fs_ronly;
        __s8 fs_flags;
        __s8 fs_fsmnt[512];

        __u32 fs_cgrotor;
        __u32 fs_csp[31];
        __u32 fs_maxcluster;
        __u32 fs_cpc;
        __u16 fs_opostbl[16][8];
        union {
                struct {
                        __s32 fs_sparecon[53];
                        __s32 fs_reclaim;
                        __s32 fs_sparecon2[1];
                        __s32 fs_state;
                        __u32 fs_qbmask[2];
                        __u32 fs_qfmask[2];
                } fs_sun;
                struct {
                        __s32 fs_sparecon[53];
                        __s32 fs_reclaim;
                        __s32 fs_sparecon2[1];
                        __u32 fs_npsect;
                        __u32 fs_qbmask[2];
                        __u32 fs_qfmask[2];
                } fs_sunx86;
                struct {
                        __s32 fs_sparecon[50];
                        __s32 fs_contigsumsize;
                        __s32 fs_maxsymlinklen;
                        __s32 fs_inodefmt;
                        __u32 fs_maxfilesize[2];
                        __u32 fs_qbmask[2];
                        __u32 fs_qfmask[2];
                        __s32 fs_state;
                } fs_44;
        } fs_u2;
        __s32 fs_postblformat;
        __s32 fs_nrpos;
        __s32 fs_postbloff;
        __s32 fs_rotbloff;
        __s32 fs_magic;
        __u8 fs_space[1];
};
# 415 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ufs_fs.h"
struct ufs_cylinder_group {
        __u32 cg_link;
        __u32 cg_magic;
        __u32 cg_time;
        __u32 cg_cgx;
        __u16 cg_ncyl;
        __u16 cg_niblk;
        __u32 cg_ndblk;
        struct ufs_csum cg_cs;
        __u32 cg_rotor;
        __u32 cg_frotor;
        __u32 cg_irotor;
        __u32 cg_frsum[(8192 / 1024)];
        __u32 cg_btotoff;
        __u32 cg_boff;
        __u32 cg_iusedoff;
        __u32 cg_freeoff;
        __u32 cg_nextfreeoff;
        union {
                struct {
                        __u32 cg_clustersumoff;
                        __u32 cg_clusteroff;
                        __u32 cg_nclusterblks;
                        __u32 cg_sparecon[13];
                } cg_44;
                __u32 cg_sparecon[16];
        } cg_u;
        __u8 cg_space[1];

};




struct ufs_inode {
        __u16 ui_mode;
        __u16 ui_nlink;
        union {
                struct {
                        __u16 ui_suid;
                        __u16 ui_sgid;
                } oldids;
                __u32 ui_inumber;
                __u32 ui_author;
        } ui_u1;
        __u64 ui_size;
        struct ufs_timeval ui_atime;
        struct ufs_timeval ui_mtime;
        struct ufs_timeval ui_ctime;
        union {
                struct {
                        __u32 ui_db[12];
                        __u32 ui_ib[3];
                } ui_addr;
                __u8 ui_symlink[4*(12 +3)];
        } ui_u2;
        __u32 ui_flags;
        __u32 ui_blocks;
        __u32 ui_gen;
        union {
                struct {
                        __u32 ui_shadow;
                        __u32 ui_uid;
                        __u32 ui_gid;
                        __u32 ui_oeftflag;
                } ui_sun;
                struct {
                        __u32 ui_uid;
                        __u32 ui_gid;
                        __s32 ui_spare[2];
                } ui_44;
                struct {
                        __u32 ui_uid;
                        __u32 ui_gid;
                        __u16 ui_modeh;
                        __u16 ui_spare;
                        __u32 ui_trans;
                } ui_hurd;
        } ui_u3;
};
# 514 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ufs_fs.h"
extern void ufs_free_fragments (struct inode *, unsigned, unsigned);
extern void ufs_free_blocks (struct inode *, unsigned, unsigned);
extern unsigned ufs_new_fragments (struct inode *, u32 *, unsigned, unsigned, unsigned, int *);


extern struct ufs_cg_private_info * ufs_load_cylinder (struct super_block *, unsigned);
extern void ufs_put_cylinder (struct super_block *, unsigned);


extern struct inode_operations ufs_dir_inode_operations;
extern int ufs_check_dir_entry (const char *, struct inode *, struct ufs_dir_entry *, struct buffer_head *, unsigned long);
extern int ufs_add_link (struct dentry *, struct inode *);
extern ino_t ufs_inode_by_name(struct inode *, struct dentry *);
extern int ufs_make_empty(struct inode *, struct inode *);
extern struct ufs_dir_entry * ufs_find_entry (struct dentry *, struct buffer_head **);
extern int ufs_delete_entry (struct inode *, struct ufs_dir_entry *, struct buffer_head *);
extern int ufs_empty_dir (struct inode *);
extern struct ufs_dir_entry * ufs_dotdot (struct inode *, struct buffer_head **);
extern void ufs_set_link(struct inode *, struct ufs_dir_entry *, struct buffer_head *, struct inode *);


extern struct inode_operations ufs_file_inode_operations;
extern struct file_operations ufs_file_operations;

extern struct address_space_operations ufs_aops;


extern void ufs_free_inode (struct inode *inode);
extern struct inode * ufs_new_inode (const struct inode *, int);


extern int ufs_frag_map (struct inode *, int);
extern void ufs_read_inode (struct inode *);
extern void ufs_put_inode (struct inode *);
extern void ufs_write_inode (struct inode *, int);
extern int ufs_sync_inode (struct inode *);
extern void ufs_delete_inode (struct inode *);
extern struct buffer_head * ufs_getfrag (struct inode *, unsigned, int, int *);
extern struct buffer_head * ufs_bread (struct inode *, unsigned, int, int *);


extern struct file_operations ufs_dir_operations;


extern void ufs_warning (struct super_block *, const char *, const char *, ...) __attribute__ ((format (printf, 3, 4)));
extern void ufs_error (struct super_block *, const char *, const char *, ...) __attribute__ ((format (printf, 3, 4)));
extern void ufs_panic (struct super_block *, const char *, const char *, ...) __attribute__ ((format (printf, 3, 4)));
extern void ufs_write_super (struct super_block *);


extern struct inode_operations ufs_fast_symlink_inode_operations;


extern void ufs_truncate (struct inode *);
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ufs_fs_sb.h" 2





struct ufs_buffer_head {
        unsigned fragment;
        unsigned count;
        struct buffer_head * bh[(8192 / 1024)];
};

struct ufs_cg_private_info {
        struct ufs_cylinder_group ucg;
        __u32 c_cgx;
        __u16 c_ncyl;
        __u16 c_niblk;
        __u32 c_ndblk;
        __u32 c_rotor;
        __u32 c_frotor;
        __u32 c_irotor;
        __u32 c_btotoff;
        __u32 c_boff;
        __u32 c_iusedoff;
        __u32 c_freeoff;
        __u32 c_nextfreeoff;
        __u32 c_clustersumoff;
        __u32 c_clusteroff;
        __u32 c_nclusterblks;
};

struct ufs_sb_private_info {
        struct ufs_buffer_head s_ubh;
        __u32 s_sblkno;
        __u32 s_cblkno;
        __u32 s_iblkno;
        __u32 s_dblkno;
        __u32 s_cgoffset;
        __u32 s_cgmask;
        __u32 s_size;
        __u32 s_dsize;
        __u32 s_ncg;
        __u32 s_bsize;
        __u32 s_fsize;
        __u32 s_fpb;
        __u32 s_minfree;
        __u32 s_bmask;
        __u32 s_fmask;
        __u32 s_bshift;
        __u32 s_fshift;
        __u32 s_fpbshift;
        __u32 s_fsbtodb;
        __u32 s_sbsize;
        __u32 s_csmask;
        __u32 s_csshift;
        __u32 s_nindir;
        __u32 s_inopb;
        __u32 s_nspf;
        __u32 s_npsect;
        __u32 s_interleave;
        __u32 s_trackskew;
        __u32 s_csaddr;
        __u32 s_cssize;
        __u32 s_cgsize;
        __u32 s_ntrak;
        __u32 s_nsect;
        __u32 s_spc;
        __u32 s_ipg;
        __u32 s_fpg;
        __u32 s_cpc;
        __s32 s_contigsumsize;
        __s64 s_qbmask;
        __s64 s_qfmask;
        __s32 s_postblformat;
        __s32 s_nrpos;
        __s32 s_postbloff;
        __s32 s_rotbloff;

        __u32 s_fpbmask;
        __u32 s_apb;
        __u32 s_2apb;
        __u32 s_3apb;
        __u32 s_apbmask;
        __u32 s_apbshift;
        __u32 s_2apbshift;
        __u32 s_3apbshift;
        __u32 s_nspfshift;
        __u32 s_nspb;
        __u32 s_inopf;
        __u32 s_sbbase;
        __u32 s_bpf;
        __u32 s_bpfshift;
        __u32 s_bpfmask;

        __u32 s_maxsymlinklen;
};





struct ufs_sb_info {
        struct ufs_sb_private_info * s_uspi;
        struct ufs_csum * s_csp[31];
        unsigned s_bytesex;
        unsigned s_flags;
        struct buffer_head ** s_ucg;
        struct ufs_cg_private_info * s_ucpi[8];
        unsigned s_cgno[8];
        unsigned short s_cg_loaded;
        unsigned s_mount_opt;
};







struct ufs_super_block_first {
        __u32 fs_link;
        __u32 fs_rlink;
        __u32 fs_sblkno;
        __u32 fs_cblkno;
        __u32 fs_iblkno;
        __u32 fs_dblkno;
        __u32 fs_cgoffset;
        __u32 fs_cgmask;
        __u32 fs_time;
        __u32 fs_size;
        __u32 fs_dsize;
        __u32 fs_ncg;
        __u32 fs_bsize;
        __u32 fs_fsize;
        __u32 fs_frag;
        __u32 fs_minfree;
        __u32 fs_rotdelay;
        __u32 fs_rps;
        __u32 fs_bmask;
        __u32 fs_fmask;
        __u32 fs_bshift;
        __u32 fs_fshift;
        __u32 fs_maxcontig;
        __u32 fs_maxbpg;
        __u32 fs_fragshift;
        __u32 fs_fsbtodb;
        __u32 fs_sbsize;
        __u32 fs_csmask;
        __u32 fs_csshift;
        __u32 fs_nindir;
        __u32 fs_inopb;
        __u32 fs_nspf;
        __u32 fs_optim;
        union {
                struct {
                        __u32 fs_npsect;
                } fs_sun;
                struct {
                        __s32 fs_state;
                } fs_sunx86;
        } fs_u1;
        __u32 fs_interleave;
        __u32 fs_trackskew;
        __u32 fs_id[2];
        __u32 fs_csaddr;
        __u32 fs_cssize;
        __u32 fs_cgsize;
        __u32 fs_ntrak;
        __u32 fs_nsect;
        __u32 fs_spc;
        __u32 fs_ncyl;
        __u32 fs_cpg;
        __u32 fs_ipg;
        __u32 fs_fpg;
        struct ufs_csum fs_cstotal;
        __s8 fs_fmod;
        __s8 fs_clean;
        __s8 fs_ronly;
        __s8 fs_flags;
        __s8 fs_fsmnt[512 - 212];

};

struct ufs_super_block_second {
        __s8 fs_fsmnt[212];
        __u32 fs_cgrotor;
        __u32 fs_csp[31];
        __u32 fs_maxcluster;
        __u32 fs_cpc;
        __u16 fs_opostbl[82];
};

struct ufs_super_block_third {
        __u16 fs_opostbl[46];
        union {
                struct {
                        __s32 fs_sparecon[53];
                        __s32 fs_reclaim;
                        __s32 fs_sparecon2[1];
                        __s32 fs_state;
                        __u32 fs_qbmask[2];
                        __u32 fs_qfmask[2];
                } fs_sun;
                struct {
                        __s32 fs_sparecon[53];
                        __s32 fs_reclaim;
                        __s32 fs_sparecon2[1];
                        __u32 fs_npsect;
                        __u32 fs_qbmask[2];
                        __u32 fs_qfmask[2];
                } fs_sunx86;
                struct {
                        __s32 fs_sparecon[50];
                        __s32 fs_contigsumsize;
                        __s32 fs_maxsymlinklen;
                        __s32 fs_inodefmt;
                        __u32 fs_maxfilesize[2];
                        __u32 fs_qbmask[2];
                        __u32 fs_qfmask[2];
                        __s32 fs_state;
                } fs_44;
        } fs_u2;
        __s32 fs_postblformat;
        __s32 fs_nrpos;
        __s32 fs_postbloff;
        __s32 fs_rotbloff;
        __s32 fs_magic;
        __u8 fs_space[1];
};
# 726 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/efs_fs_sb.h" 1
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/efs_fs_sb.h"
struct efs_super {
        int32_t fs_size;
        int32_t fs_firstcg;
        int32_t fs_cgfsize;
        short fs_cgisize;
        short fs_sectors;
        short fs_heads;
        short fs_ncg;
        short fs_dirty;
        int32_t fs_time;
        int32_t fs_magic;
        char fs_fname[6];
        char fs_fpack[6];
        int32_t fs_bmsize;
        int32_t fs_tfree;
        int32_t fs_tinode;
        int32_t fs_bmblock;
        int32_t fs_replsb;
        int32_t fs_lastialloc;
        char fs_spare[20];
        int32_t fs_checksum;
};


struct efs_sb_info {
        int32_t fs_magic;
        int32_t fs_start;
        int32_t first_block;
        int32_t total_blocks;
        int32_t group_size;
        int32_t data_free;
        int32_t inode_free;
        short inode_blocks;
        short total_groups;
};
# 727 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/romfs_fs_sb.h" 1





struct romfs_sb_info {
        unsigned long s_maxsize;
};
# 728 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smb_fs_sb.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smb_fs_sb.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smb.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smb.h"
enum smb_protocol {
        SMB_PROTOCOL_NONE,
        SMB_PROTOCOL_CORE,
        SMB_PROTOCOL_COREPLUS,
        SMB_PROTOCOL_LANMAN1,
        SMB_PROTOCOL_LANMAN2,
        SMB_PROTOCOL_NT1
};

enum smb_case_hndl {
        SMB_CASE_DEFAULT,
        SMB_CASE_LOWER,
        SMB_CASE_UPPER
};

struct smb_dskattr {
        __u16 total;
        __u16 allocblocks;
        __u16 blocksize;
        __u16 free;
};

struct smb_conn_opt {


        unsigned int fd;

        enum smb_protocol protocol;
        enum smb_case_hndl case_handling;



        __u32 max_xmit;
        __u16 server_uid;
        __u16 tid;


        __u16 secmode;
        __u16 maxmux;
        __u16 maxvcs;
        __u16 rawmode;
        __u32 sesskey;


        __u32 maxraw;
        __u32 capabilities;
        __s16 serverzone;
};




struct smb_nls_codepage {
        char local_name[20];
        char remote_name[20];
};
# 78 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smb.h"
struct smb_fattr {

        __u16 attr;

        unsigned long f_ino;
        umode_t f_mode;
        nlink_t f_nlink;
        uid_t f_uid;
        gid_t f_gid;
        kdev_t f_rdev;
        loff_t f_size;
        time_t f_atime;
        time_t f_mtime;
        time_t f_ctime;
        unsigned long f_blksize;
        unsigned long f_blocks;
        int f_unix;
};

enum smb_conn_state {
        CONN_VALID,
        CONN_INVALID,

        CONN_RETRIED,
        CONN_RETRYING
};
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smb_fs_sb.h" 2







struct smb_sb_info {
        enum smb_conn_state state;
        struct file * sock_file;

        struct smb_mount_data_kernel *mnt;
        unsigned char *temp_buf;




        unsigned int generation;
        pid_t conn_pid;
        struct smb_conn_opt opt;

        struct semaphore sem;
        wait_queue_head_t wait;

        __u32 packet_size;
        unsigned char * packet;
        unsigned short rcls;
        unsigned short err;


        void *data_ready;


        struct nls_table *remote_nls;
        struct nls_table *local_nls;




        char *name_buf;

        struct smb_ops *ops;
};


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void
smb_lock_server(struct smb_sb_info *server)
{
        down(&(server->sem));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void
smb_unlock_server(struct smb_sb_info *server)
{
        up(&(server->sem));
}
# 729 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/hfs_fs_sb.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/hfs_fs_sb.h"
struct hfs_name;

typedef int (*hfs_namein_fn) (char *, const struct hfs_name *);
typedef void (*hfs_nameout_fn) (struct hfs_name *, const char *, int);
typedef void (*hfs_ifill_fn) (struct inode *, ino_t, const int);






struct hfs_sb_info {
        int magic;
        struct hfs_mdb *s_mdb;
        int s_quiet;

        int s_lowercase;
        int s_afpd;
        int s_version;
        hfs_namein_fn s_namein;


        hfs_nameout_fn s_nameout;


        hfs_ifill_fn s_ifill;

        const struct hfs_name *s_reserved1;
        const struct hfs_name *s_reserved2;
        __u32 s_type;
        __u32 s_creator;
        umode_t s_umask;

        uid_t s_uid;
        gid_t s_gid;
        char s_conv;
};
# 730 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/adfs_fs_sb.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/adfs_fs_sb.h"
struct adfs_discmap;
struct adfs_dir_ops;




struct adfs_sb_info {
        struct adfs_discmap *s_map;
        struct adfs_dir_ops *s_dir;

        uid_t s_uid;
        gid_t s_gid;
        umode_t s_owner_mask;
        umode_t s_other_mask;

        __u32 s_ids_per_zone;
        __u32 s_idlen;
        __u32 s_map_size;
        unsigned long s_size;
        signed int s_map2blk;
        unsigned int s_log2sharesize;
        unsigned int s_version;
        unsigned int s_namelen;
};
# 731 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnx4_fs_sb.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnx4_fs_sb.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnx4_fs.h" 1
# 45 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnx4_fs.h"
struct qnx4_inode_entry {
        char di_fname[16];
        qnx4_off_t di_size;
        qnx4_xtnt_t di_first_xtnt;
        __u32 di_xblk;
        __s32 di_ftime;
        __s32 di_mtime;
        __s32 di_atime;
        __s32 di_ctime;
        qnx4_nxtnt_t di_num_xtnts;
        qnx4_mode_t di_mode;
        qnx4_muid_t di_uid;
        qnx4_mgid_t di_gid;
        qnx4_nlink_t di_nlink;
        __u8 di_zero[4];
        qnx4_ftype_t di_type;
        __u8 di_status;
};

struct qnx4_link_info {
        char dl_fname[48];
        __u32 dl_inode_blk;
        __u8 dl_inode_ndx;
        __u8 dl_spare[10];
        __u8 dl_status;
};

struct qnx4_xblk {
        __u32 xblk_next_xblk;
        __u32 xblk_prev_xblk;
        __u8 xblk_num_xtnts;
        __u8 xblk_spare[3];
        __s32 xblk_num_blocks;
        qnx4_xtnt_t xblk_xtnts[60];
        char xblk_signature[8];
        qnx4_xtnt_t xblk_first_xtnt;
};

struct qnx4_super_block {
        struct qnx4_inode_entry RootDir;
        struct qnx4_inode_entry Inode;
        struct qnx4_inode_entry Boot;
        struct qnx4_inode_entry AltBoot;
};
# 100 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnx4_fs.h"
extern struct dentry *qnx4_lookup(struct inode *dir, struct dentry *dentry);
extern unsigned long qnx4_count_free_blocks(struct super_block *sb);
extern unsigned long qnx4_block_map(struct inode *inode, long iblock);

extern struct buffer_head *qnx4_getblk(struct inode *, int, int);
extern struct buffer_head *qnx4_bread(struct inode *, int, int);

extern int qnx4_create(struct inode *dir, struct dentry *dentry, int mode);
extern struct inode_operations qnx4_file_inode_operations;
extern struct inode_operations qnx4_dir_inode_operations;
extern struct file_operations qnx4_file_operations;
extern struct file_operations qnx4_dir_operations;
extern int qnx4_is_free(struct super_block *sb, long block);
extern int qnx4_set_bitmap(struct super_block *sb, long block, int busy);
extern int qnx4_create(struct inode *inode, struct dentry *dentry, int mode);
extern void qnx4_truncate(struct inode *inode);
extern void qnx4_free_inode(struct inode *inode);
extern int qnx4_unlink(struct inode *dir, struct dentry *dentry);
extern int qnx4_rmdir(struct inode *dir, struct dentry *dentry);
extern int qnx4_sync_file(struct file *file, struct dentry *dentry, int);
extern int qnx4_sync_inode(struct inode *inode);
extern int qnx4_get_block(struct inode *inode, long iblock, struct buffer_head *bh, int create);
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/qnx4_fs_sb.h" 2





struct qnx4_sb_info {
        struct buffer_head *sb_buf;
        struct qnx4_super_block *sb;
        unsigned int Version;
        struct qnx4_inode_entry *BitMap;
};
# 732 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/reiserfs_fs_sb.h" 1







# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tqueue.h" 1
# 38 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tqueue.h"
struct tq_struct {
        struct list_head list;
        unsigned long sync;
        void (*routine)(void *);
        void *data;
};
# 64 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tqueue.h"
typedef struct list_head task_queue;




extern task_queue tq_timer, tq_immediate, tq_disk;
# 94 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tqueue.h"
extern spinlock_t tqueue_lock;





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int queue_task(struct tq_struct *bh_pointer, task_queue *bh_list)
{
        int ret = 0;
        if (!test_and_set_bit(0,&bh_pointer->sync)) {
                unsigned long flags;
                do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&tqueue_lock); } while (0);
                list_add_tail(&bh_pointer->list, bh_list);
                do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);
                ret = 1;
        }
        return ret;
}





extern void __run_task_queue(task_queue *list);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void run_task_queue(task_queue *list)
{
        if ((!list_empty(&*list)))
                __run_task_queue(list);
}
# 9 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/reiserfs_fs_sb.h" 2
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/reiserfs_fs_sb.h"
typedef enum {
  reiserfs_attrs_cleared = 0x00000001,
} reiserfs_super_block_flags;
# 147 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/reiserfs_fs_sb.h"
struct reiserfs_journal_cnode {
  struct buffer_head *bh ;
  kdev_t dev ;
  unsigned long blocknr ;
  long state ;
  struct reiserfs_journal_list *jlist ;
  struct reiserfs_journal_cnode *next ;
  struct reiserfs_journal_cnode *prev ;
  struct reiserfs_journal_cnode *hprev ;
  struct reiserfs_journal_cnode *hnext ;
};

struct reiserfs_bitmap_node {
  int id ;
  char *data ;
  struct list_head list ;
} ;

struct reiserfs_list_bitmap {
  struct reiserfs_journal_list *journal_list ;
  struct reiserfs_bitmap_node **bitmaps ;
} ;




struct reiserfs_transaction_handle {

  char *t_caller ;
  int t_blocks_logged ;
  int t_blocks_allocated ;
  unsigned long t_trans_id ;
  struct super_block *t_super ;

  int displace_new_blocks:1;

} ;







struct reiserfs_journal_list {
  unsigned long j_start ;
  unsigned long j_len ;
  atomic_t j_nonzerolen ;
  atomic_t j_commit_left ;
  atomic_t j_flushing ;
  atomic_t j_commit_flushing ;
  atomic_t j_older_commits_done ;
  unsigned long j_trans_id ;
  time_t j_timestamp ;
  struct reiserfs_list_bitmap *j_list_bitmap ;
  struct buffer_head *j_commit_bh ;
  struct reiserfs_journal_cnode *j_realblock ;
  struct reiserfs_journal_cnode *j_freedlist ;
  wait_queue_head_t j_commit_wait ;
  wait_queue_head_t j_flush_wait ;
} ;

struct reiserfs_page_list ;

struct reiserfs_journal {
  struct buffer_head ** j_ap_blocks ;
  struct reiserfs_journal_cnode *j_last ;
  struct reiserfs_journal_cnode *j_first ;

  kdev_t j_dev;
  struct file *j_dev_file;
  struct block_device *j_dev_bd;
        int j_1st_reserved_block;

  long j_state ;
  unsigned long j_trans_id ;
  unsigned long j_mount_id ;
  unsigned long j_start ;
  unsigned long j_len ;
  unsigned long j_len_alloc ;
  atomic_t j_wcount ;
  unsigned long j_bcount ;
  unsigned long j_first_unflushed_offset ;
  unsigned long j_last_flush_trans_id ;
  struct buffer_head *j_header_bh ;




  struct reiserfs_page_list *j_flush_pages ;
  time_t j_trans_start_time ;
  wait_queue_head_t j_wait ;
  atomic_t j_wlock ;
  wait_queue_head_t j_join_wait ;
  atomic_t j_jlock ;
  int j_journal_list_index ;
  int j_list_bitmap_index ;
  int j_must_wait ;
  int j_next_full_flush ;
  int j_next_async_flush ;

  int j_cnode_used ;
  int j_cnode_free ;

  unsigned int s_journal_trans_max ;
  unsigned int s_journal_max_batch ;
  unsigned int s_journal_max_commit_age ;
  unsigned int s_journal_max_trans_age ;

  struct reiserfs_journal_cnode *j_cnode_free_list ;
  struct reiserfs_journal_cnode *j_cnode_free_orig ;

  int j_free_bitmap_nodes ;
  int j_used_bitmap_nodes ;
  struct list_head j_bitmap_nodes ;
  struct list_head j_dirty_buffers ;
  struct reiserfs_list_bitmap j_list_bitmap[5] ;
  struct reiserfs_journal_list j_journal_list[64] ;
  struct reiserfs_journal_cnode *j_hash_table[8192] ;
  struct reiserfs_journal_cnode *j_list_hash_table[8192] ;

  struct list_head j_prealloc_list;
};




typedef __u32 (*hashf_t) (const signed char *, int);

struct reiserfs_bitmap_info
{

    __u16 first_zero_hint;
    __u16 free_count;
    struct buffer_head *bh;
};

struct proc_dir_entry;
# 355 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/reiserfs_fs_sb.h"
typedef struct reiserfs_proc_info_data
{} reiserfs_proc_info_data_t;



struct reiserfs_sb_info
{
    struct buffer_head * s_sbh;


    struct reiserfs_super_block * s_rs;
    struct reiserfs_bitmap_info * s_ap_bitmap;
    struct reiserfs_journal *s_journal ;
    unsigned short s_mount_state;


    void (*end_io_handler)(struct buffer_head *, int);
    hashf_t s_hash_function;


    unsigned long s_mount_opt;



    struct {
        unsigned long bits;
        unsigned long large_file_size;
        int border;
        int preallocmin;
        int preallocsize;


    } s_alloc_options;


    wait_queue_head_t s_wait;

    atomic_t s_generation_counter;

    unsigned long s_properties;



    int s_kmallocs;
    int s_disk_reads;
    int s_disk_writes;
    int s_fix_nodes;
    int s_do_balance;
    int s_unneeded_left_neighbor;
    int s_good_search_by_key_reada;
    int s_bmaps;
    int s_bmaps_without_search;
    int s_direct2indirect;
    int s_indirect2direct;



    int s_is_unlinked_ok;
    reiserfs_proc_info_data_t s_proc_info_data;
    struct proc_dir_entry *procdir;
    int reserved_blocks;
};
# 481 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/reiserfs_fs_sb.h"
void reiserfs_file_buffer (struct buffer_head * bh, int list);
int reiserfs_is_super(struct super_block *s) ;
int journal_mark_dirty(struct reiserfs_transaction_handle *, struct super_block *, struct buffer_head *bh) ;
int flush_old_commits(struct super_block *s, int) ;
int show_reiserfs_locks(void) ;
int reiserfs_resize(struct super_block *, unsigned long) ;
# 733 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/bfs_fs_sb.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/bfs_fs_sb.h"
struct bfs_sb_info {
        unsigned long si_blocks;
        unsigned long si_freeb;
        unsigned long si_freei;
        unsigned long si_lf_ioff;
        unsigned long si_lf_sblk;
        unsigned long si_lf_eblk;
        unsigned long si_lasti;
        char * si_imap;
        struct buffer_head * si_sbh;
        struct bfs_super_block * si_bfs_sb;
};
# 734 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/udf_fs_sb.h" 1
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/udf_fs_sb.h"
#pragma pack(1)
# 30 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/udf_fs_sb.h"
struct udf_sparing_data
{
        __u16 s_packet_len;
        struct buffer_head *s_spar_map[4];
};

struct udf_virtual_data
{
        __u32 s_num_entries;
        __u16 s_start_offset;
};

struct udf_bitmap
{
        __u32 s_extLength;
        __u32 s_extPosition;
        __u16 s_nr_groups;
        struct buffer_head **s_block_bitmap;
};

struct udf_part_map
{
        union
        {
                struct udf_bitmap *s_bitmap;
                struct inode *s_table;
        } s_uspace;
        union
        {
                struct udf_bitmap *s_bitmap;
                struct inode *s_table;
        } s_fspace;
        __u32 s_partition_root;
        __u32 s_partition_len;
        __u16 s_partition_type;
        __u16 s_partition_num;
        union
        {
                struct udf_sparing_data s_sparing;
                struct udf_virtual_data s_virtual;
        } s_type_specific;
        __u32 (*s_partition_func)(struct super_block *, __u32, __u16, __u32);
        __u16 s_volumeseqnum;
        __u16 s_partition_flags;
};

#pragma pack()

struct udf_sb_info
{
        struct udf_part_map *s_partmaps;
        __u8 s_volident[32];


        __u16 s_partitions;
        __u16 s_partition;


        __s32 s_session;
        __u32 s_anchor[4];
        __u32 s_lastblock;

        struct buffer_head *s_lvidbh;


        mode_t s_umask;
        gid_t s_gid;
        uid_t s_uid;


        time_t s_recordtime;


        __u16 s_serialnum;


        __u16 s_udfrev;


        __u32 s_flags;


        struct nls_table *s_nls_map;


        struct inode *s_vat;
};
# 735 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_fs_sb.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_fs_sb.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_mount.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_mount.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp.h" 1
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp.h"
struct ncp_request_header {
        __u16 type;
        __u8 sequence;
        __u8 conn_low;
        __u8 task;
        __u8 conn_high;
        __u8 function;
        __u8 data[0];
} __attribute__((packed));




struct ncp_reply_header {
        __u16 type;
        __u8 sequence;
        __u8 conn_low;
        __u8 task;
        __u8 conn_high;
        __u8 completion_code;
        __u8 connection_state;
        __u8 data[0];
} __attribute__((packed));



struct ncp_volume_info {
        __u32 total_blocks;
        __u32 free_blocks;
        __u32 purgeable_blocks;
        __u32 not_yet_purgeable_blocks;
        __u32 total_dir_entries;
        __u32 available_dir_entries;
        __u8 sectors_per_block;
        char volume_name[(16) + 1];
};
# 112 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp.h"
struct nw_info_struct {
        __u32 spaceAlloc;
        __u32 attributes;
        __u16 flags;
        __u32 dataStreamSize;
        __u32 totalStreamSize;
        __u16 numberOfStreams;
        __u16 creationTime;
        __u16 creationDate;
        __u32 creatorID;
        __u16 modifyTime;
        __u16 modifyDate;
        __u32 modifierID;
        __u16 lastAccessDate;
        __u16 archiveTime;
        __u16 archiveDate;
        __u32 archiverID;
        __u16 inheritedRightsMask;
        __u32 dirEntNum;
        __u32 DosDirNum;
        __u32 volNumber;
        __u32 EADataSize;
        __u32 EAKeyCount;
        __u32 EAKeySize;
        __u32 NSCreator;
        __u8 nameLen;
        __u8 entryName[256];
} __attribute__((packed));
# 156 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp.h"
struct nw_modify_dos_info {
        __u32 attributes;
        __u16 creationDate;
        __u16 creationTime;
        __u32 creatorID;
        __u16 modifyDate;
        __u16 modifyTime;
        __u32 modifierID;
        __u16 archiveDate;
        __u16 archiveTime;
        __u32 archiverID;
        __u16 lastAccessDate;
        __u16 inheritanceGrantMask;
        __u16 inheritanceRevokeMask;
        __u32 maximumSpace;
} __attribute__((packed));

struct nw_search_sequence {
        __u8 volNumber;
        __u32 dirBase;
        __u32 sequence;
} __attribute__((packed));
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_mount.h" 2
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_mount.h"
struct ncp_mount_data {
        int version;
        unsigned int ncp_fd;
        __kernel_uid_t mounted_uid;
        __kernel_pid_t wdog_pid;

        unsigned char mounted_vol[(16) + 1];
        unsigned int time_out;

        unsigned int retry_count;
        unsigned int flags;

        __kernel_uid_t uid;
        __kernel_gid_t gid;
        __kernel_mode_t file_mode;
        __kernel_mode_t dir_mode;
};



struct ncp_mount_data_v4 {
        int version;
        unsigned long flags;


        unsigned long mounted_uid;

        long wdog_pid;

        unsigned int ncp_fd;
        unsigned int time_out;

        unsigned int retry_count;



        unsigned long uid;
        unsigned long gid;

        unsigned long file_mode;
        unsigned long dir_mode;
};



struct ncp_mount_data_kernel {
        unsigned long flags;
        unsigned int int_flags;

        __kernel_uid32_t mounted_uid;
        __kernel_pid_t wdog_pid;
        unsigned int ncp_fd;
        unsigned int time_out;

        unsigned int retry_count;
        unsigned char mounted_vol[(16) + 1];
        __kernel_uid32_t uid;
        __kernel_gid32_t gid;
        __kernel_mode_t file_mode;
        __kernel_mode_t dir_mode;
};
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_fs_sb.h" 2





struct ncp_server {

        struct ncp_mount_data_kernel m;



        __u8 name_space[(256) + 2];

        struct file *ncp_filp;

        u8 sequence;
        u8 task;
        u16 connection;

        u8 completion;
        u8 conn_status;



        int buffer_size;

        int reply_size;

        int packet_size;
        unsigned char *packet;


        int lock;
        struct semaphore sem;

        int current_size;
        int has_subfunction;
        int ncp_reply_size;

        int root_setuped;


        int sign_wanted;
        int sign_active;
        char sign_root[8];
        char sign_last[16];


        struct {
                int auth_type;
                size_t object_name_len;
                void* object_name;
                int object_type;
        } auth;

        struct {
                size_t len;
                void* data;
        } priv;


        struct nls_table *nls_vol;
        struct nls_table *nls_io;


        int dentry_ttl;


        unsigned int flags;
};
# 92 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ncp_fs_sb.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int ncp_conn_valid(struct ncp_server *server)
{
        return ((server->conn_status & 0x11) == 0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void ncp_invalidate_conn(struct ncp_server *server)
{
        server->conn_status |= 0x01;
}
# 736 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/usbdev_fs_sb.h" 1
struct usbdev_sb_info {
        struct list_head slist;
        struct list_head ilist;
        uid_t devuid;
        gid_t devgid;
        umode_t devmode;
        uid_t busuid;
        gid_t busgid;
        umode_t busmode;
        uid_t listuid;
        gid_t listgid;
        umode_t listmode;
};
# 737 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/jffs2_fs_sb.h" 1







# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/completion.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/completion.h"
struct completion {
        unsigned int done;
        wait_queue_head_t wait;
};







static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void init_completion(struct completion *x)
{
        x->done = 0;
        init_waitqueue_head(&x->wait);
}

extern void wait_for_completion(struct completion *);
extern void complete(struct completion *);
# 9 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/jffs2_fs_sb.h" 2
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/jffs2_fs_sb.h"
struct jffs2_sb_info {
        struct mtd_info *mtd;

        __u32 highest_ino;
        unsigned int flags;
        spinlock_t nodelist_lock;


        struct task_struct *gc_task;
        struct semaphore gc_thread_start;
        struct completion gc_thread_exit;



        struct semaphore alloc_sem;




        __u32 flash_size;
        __u32 used_size;
        __u32 dirty_size;
        __u32 free_size;
        __u32 erasing_size;
        __u32 bad_size;
        __u32 sector_size;



        __u32 nr_free_blocks;
        __u32 nr_erasing_blocks;

        __u32 nr_blocks;
        struct jffs2_eraseblock *blocks;

        struct jffs2_eraseblock *nextblock;

        struct jffs2_eraseblock *gcblock;

        struct list_head clean_list;
        struct list_head dirty_list;
        struct list_head erasing_list;
        struct list_head erase_pending_list;
        struct list_head erase_complete_list;
        struct list_head free_list;
        struct list_head bad_list;
        struct list_head bad_used_list;

        spinlock_t erase_completion_lock;

        wait_queue_head_t erase_wait;
        struct jffs2_inode_cache *inocache_list[1];
        spinlock_t inocache_lock;
};
# 739 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2

extern struct list_head super_blocks;
extern spinlock_t sb_lock;



struct super_block {
        struct list_head s_list;
        kdev_t s_dev;
        unsigned long s_blocksize;
        unsigned char s_blocksize_bits;
        unsigned char s_dirt;
        unsigned long long s_maxbytes;
        struct file_system_type *s_type;
        struct super_operations *s_op;
        struct dquot_operations *dq_op;
        struct quotactl_ops *s_qcop;
        unsigned long s_flags;
        unsigned long s_magic;
        struct dentry *s_root;
        struct rw_semaphore s_umount;
        struct semaphore s_lock;
        int s_count;
        atomic_t s_active;

        struct list_head s_dirty;
        struct list_head s_locked_inodes;
        struct list_head s_files;

        struct block_device *s_bdev;
        struct list_head s_instances;
        struct quota_info s_dquot;

        union {
                struct minix_sb_info minix_sb;
                struct ext2_sb_info ext2_sb;
                struct ext3_sb_info ext3_sb;
                struct hpfs_sb_info hpfs_sb;
                struct ntfs_sb_info ntfs_sb;
                struct msdos_sb_info msdos_sb;
                struct isofs_sb_info isofs_sb;
                struct nfs_sb_info nfs_sb;
                struct sysv_sb_info sysv_sb;
                struct affs_sb_info affs_sb;
                struct ufs_sb_info ufs_sb;
                struct efs_sb_info efs_sb;
                struct shmem_sb_info shmem_sb;
                struct romfs_sb_info romfs_sb;
                struct smb_sb_info smbfs_sb;
                struct hfs_sb_info hfs_sb;
                struct adfs_sb_info adfs_sb;
                struct qnx4_sb_info qnx4_sb;
                struct reiserfs_sb_info reiserfs_sb;
                struct bfs_sb_info bfs_sb;
                struct udf_sb_info udf_sb;
                struct ncp_server ncpfs_sb;
                struct usbdev_sb_info usbdevfs_sb;
                struct jffs2_sb_info jffs2_sb;
                struct cramfs_sb_info cramfs_sb;
                void *generic_sbp;
        } u;




        struct semaphore s_vfs_rename_sem;
# 813 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
        struct semaphore s_nfsd_free_path_sem;
};




extern int vfs_create(struct inode *, struct dentry *, int);
extern int vfs_mkdir(struct inode *, struct dentry *, int);
extern int vfs_mknod(struct inode *, struct dentry *, int, dev_t);
extern int vfs_symlink(struct inode *, struct dentry *, const char *);
extern int vfs_link(struct dentry *, struct inode *, struct dentry *);
extern int vfs_rmdir(struct inode *, struct dentry *);
extern int vfs_unlink(struct inode *, struct dentry *);
extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
# 847 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
typedef int (*filldir_t)(void *, const char *, int, loff_t, ino_t, unsigned);

struct block_device_operations {
        int (*open) (struct inode *, struct file *);
        int (*release) (struct inode *, struct file *);
        int (*ioctl) (struct inode *, struct file *, unsigned, unsigned long);
        int (*check_media_change) (kdev_t);
        int (*revalidate) (kdev_t);
        struct module *owner;
};






struct file_operations {
        struct module *owner;
        loff_t (*llseek) (struct file *, loff_t, int);
        ssize_t (*read) (struct file *, char *, size_t, loff_t *);
        ssize_t (*write) (struct file *, const char *, size_t, loff_t *);
        int (*readdir) (struct file *, void *, filldir_t);
        unsigned int (*poll) (struct file *, struct poll_table_struct *);
        int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
        int (*mmap) (struct file *, struct vm_area_struct *);
        int (*open) (struct inode *, struct file *);
        int (*flush) (struct file *);
        int (*release) (struct inode *, struct file *);
        int (*fsync) (struct file *, struct dentry *, int datasync);
        int (*fasync) (int, struct file *, int);
        int (*lock) (struct file *, int, struct file_lock *);
        ssize_t (*readv) (struct file *, const struct iovec *, unsigned long, loff_t *);
        ssize_t (*writev) (struct file *, const struct iovec *, unsigned long, loff_t *);
        ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
        unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
};

struct inode_operations {
        int (*create) (struct inode *,struct dentry *,int);
        struct dentry * (*lookup) (struct inode *,struct dentry *);
        int (*link) (struct dentry *,struct inode *,struct dentry *);
        int (*unlink) (struct inode *,struct dentry *);
        int (*symlink) (struct inode *,struct dentry *,const char *);
        int (*mkdir) (struct inode *,struct dentry *,int);
        int (*rmdir) (struct inode *,struct dentry *);
        int (*mknod) (struct inode *,struct dentry *,int,int);
        int (*rename) (struct inode *, struct dentry *,
                        struct inode *, struct dentry *);
        int (*readlink) (struct dentry *, char *,int);
        int (*follow_link) (struct dentry *, struct nameidata *);
        void (*truncate) (struct inode *);
        int (*permission) (struct inode *, int);
        int (*revalidate) (struct dentry *);
        int (*setattr) (struct dentry *, struct iattr *);
        int (*getattr) (struct dentry *, struct iattr *);
        int (*setxattr) (struct dentry *, const char *, void *, size_t, int);
        ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
        ssize_t (*listxattr) (struct dentry *, char *, size_t);
        int (*removexattr) (struct dentry *, const char *);
};

struct seq_file;





struct super_operations {
        struct inode *(*alloc_inode)(struct super_block *sb);
        void (*destroy_inode)(struct inode *);

        void (*read_inode) (struct inode *);







        void (*read_inode2) (struct inode *, void *) ;
        void (*dirty_inode) (struct inode *);
        void (*write_inode) (struct inode *, int);
        void (*put_inode) (struct inode *);
        void (*delete_inode) (struct inode *);
        void (*put_super) (struct super_block *);
        void (*write_super) (struct super_block *);
        int (*sync_fs) (struct super_block *);
        void (*write_super_lockfs) (struct super_block *);
        void (*unlockfs) (struct super_block *);
        int (*statfs) (struct super_block *, struct statfs *);
        int (*remount_fs) (struct super_block *, int *, char *);
        void (*clear_inode) (struct inode *);
        void (*umount_begin) (struct super_block *);
# 963 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
        struct dentry * (*fh_to_dentry)(struct super_block *sb, __u32 *fh, int len, int fhtype, int parent);
        int (*dentry_to_fh)(struct dentry *, __u32 *fh, int *lenp, int need_parent);
        int (*show_options)(struct seq_file *, struct vfsmount *);
};
# 979 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
extern void __mark_inode_dirty(struct inode *, int);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mark_inode_dirty(struct inode *inode)
{
        __mark_inode_dirty(inode, (1 | 2 | 4));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mark_inode_dirty_sync(struct inode *inode)
{
        __mark_inode_dirty(inode, 1);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mark_inode_dirty_pages(struct inode *inode)
{
        __mark_inode_dirty(inode, 4);
}

struct file_system_type {
        const char *name;
        int fs_flags;
        struct super_block *(*read_super) (struct super_block *, void *, int);
        struct module *owner;
        struct file_system_type * next;
        struct list_head fs_supers;
};
# 1027 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
extern int register_filesystem(struct file_system_type *);
extern int unregister_filesystem(struct file_system_type *);
extern struct vfsmount *kern_mount(struct file_system_type *);
extern int may_umount(struct vfsmount *);
extern long do_mount(char *, char *, char *, unsigned long, void *);



extern int vfs_statfs(struct super_block *, struct statfs *);
# 1045 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
extern int locks_mandatory_locked(struct inode *);
extern int locks_mandatory_area(int, struct inode *, struct file *, loff_t, size_t);
# 1055 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int locks_verify_locked(struct inode *inode)
{
        if ((((inode)->i_sb->s_flags & (64)) && ((inode)->i_mode & (0002000 | 00010)) == 0002000))
                return locks_mandatory_locked(inode);
        return 0;
}

extern int rw_verify_area(int, struct file *, loff_t *, size_t);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int locks_verify_area(int read_write, struct inode *inode,
                                    struct file *filp, loff_t offset,
                                    size_t count)
{
        if (inode->i_flock && (((inode)->i_sb->s_flags & (64)) && ((inode)->i_mode & (0002000 | 00010)) == 0002000))
                return locks_mandatory_area(read_write, inode, filp, offset, count);
        return 0;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int locks_verify_truncate(struct inode *inode,
                                    struct file *filp,
                                    loff_t size)
{
        if (inode->i_flock && (((inode)->i_sb->s_flags & (64)) && ((inode)->i_mode & (0002000 | 00010)) == 0002000))
                return locks_mandatory_area(
                        2, inode, filp,
                        size < inode->i_size ? size : inode->i_size,
                        (size < inode->i_size ? inode->i_size - size
                         : size - inode->i_size)
                );
        return 0;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int get_lease(struct inode *inode, unsigned int mode)
{
        if (inode->i_flock)
                return __get_lease(inode, mode);
        return 0;
}



 long sys_open(const char *, int, int);
 long sys_close(unsigned int);
extern int do_truncate(struct dentry *, loff_t start);

extern struct file *filp_open(const char *, int, int);
extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
extern int filp_close(struct file *, fl_owner_t id);
extern char * getname(const char *);


extern void vfs_caches_init(unsigned long);




enum {BDEV_FILE, BDEV_SWAP, BDEV_FS, BDEV_RAW};
extern int register_blkdev(unsigned int, const char *, struct block_device_operations *);
extern int unregister_blkdev(unsigned int, const char *);
extern struct block_device *bdget(dev_t);
extern int bd_acquire(struct inode *inode);
extern void bd_forget(struct inode *inode);
extern void bdput(struct block_device *);
extern struct char_device *cdget(dev_t);
extern void cdput(struct char_device *);
extern int blkdev_open(struct inode *, struct file *);
extern int blkdev_close(struct inode *, struct file *);
extern struct file_operations def_blk_fops;
extern struct address_space_operations def_blk_aops;
extern struct file_operations def_fifo_fops;
extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
extern int blkdev_get(struct block_device *, mode_t, unsigned, int);
extern int blkdev_put(struct block_device *, int);


extern const struct block_device_operations *get_blkfops(unsigned int);
extern int register_chrdev(unsigned int, const char *, struct file_operations *);
extern int unregister_chrdev(unsigned int, const char *);
extern int chrdev_open(struct inode *, struct file *);
extern const char * bdevname(kdev_t);
extern const char * cdevname(kdev_t);
extern const char * kdevname(kdev_t);
extern void init_special_inode(struct inode *, umode_t, int);


extern void make_bad_inode(struct inode *);
extern int is_bad_inode(struct inode *);

extern struct file_operations read_fifo_fops;
extern struct file_operations write_fifo_fops;
extern struct file_operations rdwr_fifo_fops;
extern struct file_operations read_pipe_fops;
extern struct file_operations write_pipe_fops;
extern struct file_operations rdwr_pipe_fops;

extern int fs_may_remount_ro(struct super_block *);

extern int try_to_free_buffers(struct page *, unsigned int);
extern void refile_buffer(struct buffer_head * buf);
extern void create_empty_buffers(struct page *, kdev_t, unsigned long);
extern void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
extern void end_buffer_io_async(struct buffer_head *bh, int uptodate);


extern void set_buffer_async_io(struct buffer_head *bh) ;






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void get_bh(struct buffer_head * bh)
{
        atomic_add(1,(&(bh)->b_count));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void put_bh(struct buffer_head *bh)
{
        __asm__ __volatile__("": : :"memory");
        atomic_sub(1,(&bh->b_count));
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mark_buffer_uptodate(struct buffer_head * bh, int on)
{
        if (on)
                set_bit(BH_Uptodate, &bh->b_state);
        else
                clear_bit(BH_Uptodate, &bh->b_state);
}



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __mark_buffer_clean(struct buffer_head *bh)
{
        refile_buffer(bh);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mark_buffer_clean(struct buffer_head * bh)
{
        if (test_and_clear_bit(BH_Dirty, &(bh)->b_state))
                __mark_buffer_clean(bh);
}

extern void __mark_dirty(struct buffer_head *bh);
extern void __mark_buffer_dirty(struct buffer_head *bh);
extern void mark_buffer_dirty(struct buffer_head *bh);

extern void buffer_insert_list(struct buffer_head *, struct list_head *);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
{
        buffer_insert_list(bh, &inode->i_dirty_buffers);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
{
        buffer_insert_list(bh, &inode->i_dirty_data_buffers);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int atomic_set_buffer_dirty(struct buffer_head *bh)
{
        return test_and_set_bit(BH_Dirty, &bh->b_state);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mark_buffer_async(struct buffer_head * bh, int on)
{
        if (on)
                set_bit(BH_Async, &bh->b_state);
        else
                clear_bit(BH_Async, &bh->b_state);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void set_buffer_attached(struct buffer_head *bh)
{
        set_bit(BH_Attached, &bh->b_state);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void clear_buffer_attached(struct buffer_head *bh)
{
        clear_bit(BH_Attached, &bh->b_state);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int buffer_attached(struct buffer_head *bh)
{
        return test_bit(BH_Attached, &bh->b_state);
}







static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void buffer_IO_error(struct buffer_head * bh)
{
        mark_buffer_clean(bh);



        bh->b_end_io(bh, 0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
{
        mark_buffer_dirty(bh);
        buffer_insert_inode_queue(bh, inode);
}

extern void set_buffer_flushtime(struct buffer_head *);
extern int get_buffer_flushtime(void);
extern void balance_dirty(void);
extern int check_disk_change(kdev_t);
extern int invalidate_inodes(struct super_block *);
extern int invalidate_device(kdev_t, int);
extern void invalidate_inode_pages(struct inode *);
extern void invalidate_inode_pages2(struct address_space *);
extern void invalidate_inode_buffers(struct inode *);


extern void invalidate_bdev(struct block_device *, int);
extern void __invalidate_buffers(kdev_t dev, int);
extern void sync_inodes(kdev_t);
extern void sync_unlocked_inodes(void);
extern void write_inode_now(struct inode *, int);
extern int sync_buffers(kdev_t, int);
extern void sync_dev(kdev_t);
extern int fsync_dev(kdev_t);
extern int fsync_super(struct super_block *);
extern int fsync_no_super(kdev_t);
extern void sync_inodes_sb(struct super_block *);
extern int fsync_buffers_list(struct list_head *);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int fsync_inode_buffers(struct inode *inode)
{
        return fsync_buffers_list(&inode->i_dirty_buffers);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int fsync_inode_data_buffers(struct inode *inode)
{
        return fsync_buffers_list(&inode->i_dirty_data_buffers);
}
extern int inode_has_buffers(struct inode *);
extern int do_fdatasync(struct file *);
extern int filemap_fdatawrite(struct address_space *);
extern int filemap_fdatasync(struct address_space *);
extern int filemap_fdatawait(struct address_space *);
extern void sync_supers(kdev_t dev, int wait);
extern int bmap(struct inode *, int);
extern int notify_change(struct dentry *, struct iattr *);
extern int permission(struct inode *, int);
extern int vfs_permission(struct inode *, int);
extern int get_write_access(struct inode *);
extern int deny_write_access(struct file *);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void put_write_access(struct inode * inode)
{
        atomic_sub(1,(&inode->i_writecount));
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void allow_write_access(struct file *file)
{
        if (file)
                atomic_add(1,(&file->f_dentry->d_inode->i_writecount));
}
extern int do_pipe(int *);

extern int open_namei(const char *, int, int, struct nameidata *);

extern int kernel_read(struct file *, unsigned long, char *, unsigned long);
extern struct file * open_exec(const char *);


extern int is_subdir(struct dentry *, struct dentry *);
extern ino_t find_inode_number(struct dentry *, struct qstr *);
# 1336 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void *ERR_PTR(long error)
{
        return (void *) error;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long PTR_ERR(const void *ptr)
{
        return (long) ptr;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long IS_ERR(const void *ptr)
{
        return (unsigned long)ptr > (unsigned long)-1000L;
}
# 1367 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
# 1378 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
typedef struct {
        size_t written;
        size_t count;
        char * buf;
        int error;
} read_descriptor_t;

typedef int (*read_actor_t)(read_descriptor_t *, struct page *, unsigned long, unsigned long);


extern loff_t default_llseek(struct file *file, loff_t offset, int origin);

extern int __user_walk(const char *, unsigned, struct nameidata *);
extern int path_init(const char *, unsigned, struct nameidata *);
extern int path_walk(const char *, struct nameidata *);
extern int path_lookup(const char *, unsigned, struct nameidata *);
extern int link_path_walk(const char *, struct nameidata *);
extern void path_release(struct nameidata *);
extern int follow_down(struct vfsmount **, struct dentry **);
extern int follow_up(struct vfsmount **, struct dentry **);
extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
extern struct dentry * lookup_hash(struct qstr *, struct dentry *);



extern void inode_init_once(struct inode *);
extern void __inode_init_once(struct inode *);
extern void iput(struct inode *);
extern void refile_inode(struct inode *inode);
extern void force_delete(struct inode *);
extern struct inode * igrab(struct inode *);
extern struct inode * ilookup(struct super_block *, unsigned long);
extern ino_t iunique(struct super_block *, ino_t);
extern void unlock_new_inode(struct inode *);

typedef int (*find_inode_t)(struct inode *, unsigned long, void *);

extern struct inode * iget4_locked(struct super_block *, unsigned long,
                                   find_inode_t, void *);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct inode *iget4(struct super_block *sb, unsigned long ino,
                                  find_inode_t find_actor, void *opaque)
{
        struct inode *inode = iget4_locked(sb, ino, find_actor, opaque);

        if (inode && (inode->i_state & 64)) {



                if (sb->s_op->read_inode2)
                        sb->s_op->read_inode2(inode, opaque);
                else
                        sb->s_op->read_inode(inode);
                unlock_new_inode(inode);
        }

        return inode;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct inode *iget(struct super_block *sb, unsigned long ino)
{
        struct inode *inode = iget4_locked(sb, ino, ((void *)0), ((void *)0));

        if (inode && (inode->i_state & 64)) {
                sb->s_op->read_inode(inode);
                unlock_new_inode(inode);
        }

        return inode;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct inode *iget_locked(struct super_block *sb, unsigned long ino)
{
        return iget4_locked(sb, ino, ((void *)0), ((void *)0));
}

extern void clear_inode(struct inode *);
extern struct inode *new_inode(struct super_block *sb);
extern void remove_suid(struct inode *inode);

extern void insert_inode_hash(struct inode *);
extern void remove_inode_hash(struct inode *);
extern struct file * get_empty_filp(void);
extern void file_move(struct file *f, struct list_head *list);
extern struct buffer_head * get_hash_table(kdev_t, int, int);
extern struct buffer_head * getblk(kdev_t, int, int);
extern void ll_rw_block(int, int, struct buffer_head * bh[]);
extern void submit_bh(int, struct buffer_head *);
extern int is_read_only(kdev_t);
extern void __brelse(struct buffer_head *);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void brelse(struct buffer_head *buf)
{
        if (buf)
                __brelse(buf);
}
extern void __bforget(struct buffer_head *);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void bforget(struct buffer_head *buf)
{
        if (buf)
                __bforget(buf);
}
extern int set_blocksize(kdev_t, int);
extern int sb_set_blocksize(struct super_block *, int);
extern int sb_min_blocksize(struct super_block *, int);
extern struct buffer_head * bread(kdev_t, int, int);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct buffer_head * sb_bread(struct super_block *sb, int block)
{
        return bread(sb->s_dev, block, sb->s_blocksize);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct buffer_head * sb_getblk(struct super_block *sb, int block)
{
        return getblk(sb->s_dev, block, sb->s_blocksize);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct buffer_head * sb_get_hash_table(struct super_block *sb, int block)
{
        return get_hash_table(sb->s_dev, block, sb->s_blocksize);
}
extern void wakeup_bdflush(void);
extern void wakeup_kupdate(void);
extern void put_unused_buffer_head(struct buffer_head * bh);
extern struct buffer_head * get_unused_buffer_head(int async);
extern int block_dump;

extern int brw_page(int, struct page *, kdev_t, int [], int);

typedef int (get_block_t)(struct inode*,long,struct buffer_head*,int);


extern int try_to_release_page(struct page * page, int gfp_mask);
extern int discard_bh_page(struct page *, unsigned long, int);


extern int __block_symlink(struct inode *, const char *, int, unsigned int);
extern int block_symlink(struct inode *, const char *, int);
extern int block_write_full_page(struct page*, get_block_t*);
extern int block_read_full_page(struct page*, get_block_t*);
extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
                                unsigned long *);
extern int generic_cont_expand(struct inode *inode, loff_t size) ;
extern int block_commit_write(struct page *page, unsigned from, unsigned to);
extern int block_sync_page(struct page *);

int generic_block_bmap(struct address_space *, long, get_block_t *);
int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
int block_truncate_page(struct address_space *, loff_t, get_block_t *);
extern int generic_direct_IO(int, struct inode *, struct kiobuf *, unsigned long, int, get_block_t *);
extern int waitfor_one_page(struct page *);
extern int writeout_one_page(struct page *);

extern int generic_file_mmap(struct file *, struct vm_area_struct *);
extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
extern ssize_t do_generic_direct_read(struct file *, char *, size_t, loff_t *);
extern int precheck_file_write(struct file *, struct inode *, size_t *, loff_t *);
extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
extern ssize_t do_generic_file_write(struct file *, const char *, size_t, loff_t *);
extern ssize_t do_generic_direct_write(struct file *, const char *, size_t, loff_t *);
extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
extern ssize_t generic_read_dir(struct file *, char *, size_t, loff_t *);
extern int generic_file_open(struct inode * inode, struct file * filp);

extern struct file_operations generic_ro_fops;

extern int vfs_readlink(struct dentry *, char *, int, const char *);
extern int vfs_follow_link(struct nameidata *, const char *);
extern int page_readlink(struct dentry *, char *, int);
extern int page_follow_link(struct dentry *, struct nameidata *);
extern struct inode_operations page_symlink_inode_operations;

extern int vfs_readdir(struct file *, filldir_t, void *);
extern int dcache_dir_open(struct inode *, struct file *);
extern int dcache_dir_close(struct inode *, struct file *);
extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
extern int dcache_dir_fsync(struct file *, struct dentry *, int);
extern int dcache_readdir(struct file *, void *, filldir_t);
extern struct file_operations dcache_dir_ops;

extern struct file_system_type *get_fs_type(const char *name);
extern struct super_block *get_super(kdev_t);
extern void drop_super(struct super_block *sb);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int is_mounted(kdev_t dev)
{
        struct super_block *sb = get_super(dev);
        if (sb) {
                drop_super(sb);
                return 1;
        }
        return 0;
}
unsigned long generate_cluster(kdev_t, int b[], int);
unsigned long generate_cluster_swab32(kdev_t, int b[], int);
extern kdev_t ROOT_DEV;


extern void show_buffers(void);





extern ssize_t char_read(struct file *, char *, size_t, loff_t *);
extern ssize_t block_read(struct file *, char *, size_t, loff_t *);
extern int read_ahead[];

extern ssize_t char_write(struct file *, const char *, size_t, loff_t *);
extern ssize_t block_write(struct file *, const char *, size_t, loff_t *);

extern int file_fsync(struct file *, struct dentry *, int);
extern int generic_buffer_fdatasync(struct inode *inode, unsigned long start_idx, unsigned long end_idx);
extern int generic_osync_inode(struct inode *, int);




extern int inode_change_ok(struct inode *, struct iattr *);
extern int inode_setattr(struct inode *, struct iattr *);


extern int unshare_files(void);
# 1620 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct dentry *lock_parent(struct dentry *dentry)
{
        struct dentry *dir = dget(dentry->d_parent);

        down(&dir->d_inode->i_sem);
        return dir;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct dentry *get_parent(struct dentry *dentry)
{
        return dget(dentry->d_parent);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void unlock_dir(struct dentry *dir)
{
        up(&dir->d_inode->i_sem);
        dput(dir);
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void double_down(struct semaphore *s1, struct semaphore *s2)
{
        if (s1 != s2) {
                if ((unsigned long) s1 < (unsigned long) s2) {
                        struct semaphore *tmp = s2;
                        s2 = s1; s1 = tmp;
                }
                down(s1);
        }
        down(s2);
}
# 1664 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void triple_down(struct semaphore *s1,
                               struct semaphore *s2,
                               struct semaphore *s3)
{
        if (s1 != s2) {
                if ((unsigned long) s1 < (unsigned long) s2) {
                        if ((unsigned long) s1 < (unsigned long) s3) {
                                struct semaphore *tmp = s3;
                                s3 = s1; s1 = tmp;
                        }
                        if ((unsigned long) s1 < (unsigned long) s2) {
                                struct semaphore *tmp = s2;
                                s2 = s1; s1 = tmp;
                        }
                } else {
                        if ((unsigned long) s1 < (unsigned long) s3) {
                                struct semaphore *tmp = s3;
                                s3 = s1; s1 = tmp;
                        }
                        if ((unsigned long) s2 < (unsigned long) s3) {
                                struct semaphore *tmp = s3;
                                s3 = s2; s2 = tmp;
                        }
                }
                down(s1);
        } else if ((unsigned long) s2 < (unsigned long) s3) {
                struct semaphore *tmp = s3;
                s3 = s2; s2 = tmp;
        }
        down(s2);
        down(s3);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void double_up(struct semaphore *s1, struct semaphore *s2)
{
        up(s1);
        if (s1 != s2)
                up(s2);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void triple_up(struct semaphore *s1,
                             struct semaphore *s2,
                             struct semaphore *s3)
{
        up(s1);
        if (s1 != s2)
                up(s2);
        up(s3);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void double_lock(struct dentry *d1, struct dentry *d2)
{
        double_down(&d1->d_inode->i_sem, &d2->d_inode->i_sem);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void double_unlock(struct dentry *d1, struct dentry *d2)
{
        double_up(&d1->d_inode->i_sem,&d2->d_inode->i_sem);
        dput(d1);
        dput(d2);
}
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/capability.h" 2
# 32 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/capability.h"
typedef struct __user_cap_header_struct {
        __u32 version;
        int pid;
} *cap_user_header_t;

typedef struct __user_cap_data_struct {
        __u32 effective;
        __u32 permitted;
        __u32 inheritable;
} *cap_user_data_t;
# 55 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/capability.h"
typedef __u32 kernel_cap_t;
# 282 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/capability.h"
extern kernel_cap_t cap_bset;
# 320 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/capability.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) kernel_cap_t cap_combine(kernel_cap_t a, kernel_cap_t b)
{
     kernel_cap_t dest;
     (dest) = (a) | (b);
     return dest;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) kernel_cap_t cap_intersect(kernel_cap_t a, kernel_cap_t b)
{
     kernel_cap_t dest;
     (dest) = (a) & (b);
     return dest;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) kernel_cap_t cap_drop(kernel_cap_t a, kernel_cap_t drop)
{
     kernel_cap_t dest;
     (dest) = (a) & ~(drop);
     return dest;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) kernel_cap_t cap_invert(kernel_cap_t c)
{
     kernel_cap_t dest;
     (dest) = ~(c);
     return dest;
}
# 6 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/binfmts.h" 2
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/binfmts.h"
struct linux_binprm{
        char buf[128];
        struct page *page[32];
        unsigned long p;
        int sh_bang;
        struct file * file;
        int e_uid, e_gid;
        kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
        int argc, envc;
        char * filename;
        unsigned long loader, exec;
};





struct linux_binfmt {
        struct linux_binfmt * next;
        struct module *module;
        int (*load_binary)(struct linux_binprm *, struct pt_regs * regs);
        int (*load_shlib)(struct file *);
        int (*core_dump)(long signr, struct pt_regs * regs, struct file * file);
        unsigned long min_coredump;
};

extern int register_binfmt(struct linux_binfmt *);
extern int unregister_binfmt(struct linux_binfmt *);

extern int prepare_binprm(struct linux_binprm *);
extern void remove_arg_zero(struct linux_binprm *);
extern int search_binary_handler(struct linux_binprm *,struct pt_regs *);
extern int flush_old_exec(struct linux_binprm * bprm);
extern int setup_arg_pages(struct linux_binprm * bprm);
extern int copy_strings(int argc,char ** argv,struct linux_binprm *bprm);
extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);
extern void compute_creds(struct linux_binprm *binprm);
extern int do_coredump(long signr, struct pt_regs * regs);
extern void set_binfmt(struct linux_binfmt *new);
# 10 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/threads.h" 1
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/times.h" 1



struct tms {
        clock_t tms_utime;
        clock_t tms_stime;
        clock_t tms_cutime;
        clock_t tms_cstime;
};
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/timex.h" 1
# 152 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/timex.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/timex.h" 1
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/timex.h"
typedef unsigned int cycles_t;
extern cycles_t cacheflush_time;

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) cycles_t get_cycles (void)
{
        return ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$9" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$9" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; });
}
# 153 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/timex.h" 2
# 161 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/timex.h"
struct timex {
        unsigned int modes;
        long offset;
        long freq;
        long maxerror;
        long esterror;
        int status;
        long constant;
        long precision;
        long tolerance;


        struct timeval time;
        long tick;

        long ppsfreq;
        long jitter;
        int shift;
        long stabil;
        long jitcnt;
        long calcnt;
        long errcnt;
        long stbcnt;

        int :32; int :32; int :32; int :32;
        int :32; int :32; int :32; int :32;
        int :32; int :32; int :32; int :32;
};
# 253 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/timex.h"
extern long tick;
extern int tickadj;




extern int time_state;
extern int time_status;
extern long time_offset;
extern long time_constant;
extern long time_tolerance;
extern long time_precision;
extern long time_maxerror;
extern long time_esterror;

extern long time_phase;
extern long time_freq;
extern long time_adj;
extern long time_reftime;

extern long time_adjust;


extern long pps_offset;
extern long pps_jitter;
extern long pps_freq;
extern long pps_stabil;
extern long pps_valid;


extern int pps_shift;
extern long pps_jitcnt;
extern long pps_calcnt;
extern long pps_errcnt;
extern long pps_stbcnt;
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rbtree.h" 1
# 100 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/rbtree.h"
typedef struct rb_node_s
{
        struct rb_node_s * rb_parent;
        int rb_color;


        struct rb_node_s * rb_right;
        struct rb_node_s * rb_left;
}
rb_node_t;

typedef struct rb_root_s
{
        struct rb_node_s * rb_node;
}
rb_root_t;





extern void rb_insert_color(rb_node_t *, rb_root_t *);
extern void rb_erase(rb_node_t *, rb_root_t *);


extern rb_node_t *rb_next(rb_node_t *);
extern rb_node_t *rb_prev(rb_node_t *);
extern rb_node_t *rb_first(rb_root_t *);
extern rb_node_t *rb_last(rb_root_t *);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void rb_link_node(rb_node_t * node, rb_node_t * parent, rb_node_t ** rb_link)
{
        node->rb_parent = parent;
        node->rb_color = 0;
        node->rb_left = node->rb_right = ((void *)0);

        *rb_link = node;
}
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mmu.h" 1



typedef unsigned long mm_context_t[1];
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h" 1
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/major.h" 1
# 180 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/major.h"
static __inline__ __attribute__((always_inline)) int scsi_blk_major(int m) {
        return (((m) == 8 || ((m) >= 65 && (m) <= 71)) || (m) == 11);
}
# 193 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/major.h"
static __inline__ __attribute__((always_inline)) int ide_blk_major(int m)
{
        return ((m) == 3 || (m) == 22 || (m) == 33 || (m) == 34 || (m) == 56 || (m) == 57 || (m) == 88 || (m) == 89 || (m) == 90 || (m) == 91);
}
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/termios.h" 1




# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termios.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termios.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termbits.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termbits.h"
typedef unsigned char cc_t;





typedef __u32 speed_t;
typedef __u32 tcflag_t;







struct termios {
        tcflag_t c_iflag;
        tcflag_t c_oflag;
        tcflag_t c_cflag;
        tcflag_t c_lflag;
        cc_t c_line;
        cc_t c_cc[23];
};
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termios.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ioctls.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termios.h" 2

struct sgttyb {
        char sg_ispeed;
        char sg_ospeed;
        char sg_erase;
        char sg_kill;
        int sg_flags;
};

struct tchars {
        char t_intrc;
        char t_quitc;
        char t_startc;
        char t_stopc;
        char t_eofc;
        char t_brkc;
};

struct ltchars {
        char t_suspc;
        char t_dsuspc;
        char t_rprntc;
        char t_flushc;
        char t_werasc;
        char t_lnextc;
};




struct winsize {
        unsigned short ws_row;
        unsigned short ws_col;
        unsigned short ws_xpixel;
        unsigned short ws_ypixel;
};


struct termio {
        unsigned short c_iflag;
        unsigned short c_oflag;
        unsigned short c_cflag;
        unsigned short c_lflag;
        char c_line;
        unsigned char c_cc[23];
};
# 6 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/termios.h" 2
# 23 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty_driver.h" 1
# 120 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty_driver.h"
struct tty_driver {
        int magic;
        const char *driver_name;
        const char *name;
        int name_base;
        short major;
        short minor_start;
        short num;
        short type;
        short subtype;
        struct termios init_termios;
        int flags;
        int *refcount;
        struct proc_dir_entry *proc_entry;
        struct tty_driver *other;




        struct tty_struct **table;
        struct termios **termios;
        struct termios **termios_locked;
        void *driver_state;





        int (*open)(struct tty_struct * tty, struct file * filp);
        void (*close)(struct tty_struct * tty, struct file * filp);
        int (*write)(struct tty_struct * tty, int from_user,
                      const unsigned char *buf, int count);
        void (*put_char)(struct tty_struct *tty, unsigned char ch);
        void (*flush_chars)(struct tty_struct *tty);
        int (*write_room)(struct tty_struct *tty);
        int (*chars_in_buffer)(struct tty_struct *tty);
        int (*ioctl)(struct tty_struct *tty, struct file * file,
                    unsigned int cmd, unsigned long arg);
        void (*set_termios)(struct tty_struct *tty, struct termios * old);
        void (*throttle)(struct tty_struct * tty);
        void (*unthrottle)(struct tty_struct * tty);
        void (*stop)(struct tty_struct *tty);
        void (*start)(struct tty_struct *tty);
        void (*hangup)(struct tty_struct *tty);
        void (*break_ctl)(struct tty_struct *tty, int state);
        void (*flush_buffer)(struct tty_struct *tty);
        void (*set_ldisc)(struct tty_struct *tty);
        void (*wait_until_sent)(struct tty_struct *tty, int timeout);
        void (*send_xchar)(struct tty_struct *tty, char ch);
        int (*read_proc)(char *page, char **start, off_t off,
                          int count, int *eof, void *data);
        int (*write_proc)(struct file *file, const char *buffer,
                          unsigned long count, void *data);




        struct tty_driver *next;
        struct tty_driver *prev;
};
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty_ldisc.h" 1
# 110 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty_ldisc.h"
struct tty_ldisc {
        int magic;
        char *name;
        int num;
        int flags;



        int (*open)(struct tty_struct *);
        void (*close)(struct tty_struct *);
        void (*flush_buffer)(struct tty_struct *tty);
        ssize_t (*chars_in_buffer)(struct tty_struct *tty);
        ssize_t (*read)(struct tty_struct * tty, struct file * file,
                        unsigned char * buf, size_t nr);
        ssize_t (*write)(struct tty_struct * tty, struct file * file,
                         const unsigned char * buf, size_t nr);
        int (*ioctl)(struct tty_struct * tty, struct file * file,
                         unsigned int cmd, unsigned long arg);
        void (*set_termios)(struct tty_struct *tty, struct termios * old);
        unsigned int (*poll)(struct tty_struct *, struct file *,
                             struct poll_table_struct *);
        int (*hangup)(struct tty_struct *tty);




        void (*receive_buf)(struct tty_struct *, const unsigned char *cp,
                               char *fp, int count);
        int (*receive_room)(struct tty_struct *);
        void (*write_wakeup)(struct tty_struct *);
        int refcount;
};
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h" 2
# 59 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h"
struct screen_info {
        u8 orig_x;
        u8 orig_y;
        u16 dontuse1;
        u16 orig_video_page;
        u8 orig_video_mode;
        u8 orig_video_cols;
        u16 unused2;
        u16 orig_video_ega_bx;
        u16 unused3;
        u8 orig_video_lines;
        u8 orig_video_isVGA;
        u16 orig_video_points;


        u16 lfb_width;
        u16 lfb_height;
        u16 lfb_depth;
        u32 lfb_base;
        u32 lfb_size;
        u16 dontuse2, dontuse3;
        u16 lfb_linelength;
        u8 red_size;
        u8 red_pos;
        u8 green_size;
        u8 green_pos;
        u8 blue_size;
        u8 blue_pos;
        u8 rsvd_size;
        u8 rsvd_pos;
        u16 vesapm_seg;
        u16 vesapm_off;
        u16 pages;

};

extern struct screen_info screen_info;
# 139 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h"
struct tty_flip_buffer {
        struct tq_struct tqueue;
        struct semaphore pty_sem;
        char *char_buf_ptr;
        unsigned char *flag_buf_ptr;
        int count;
        int buf_num;
        unsigned char char_buf[2*512];
        char flag_buf[2*512];
        unsigned char slop[4];
};
# 259 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h"
struct tty_struct {
        int magic;
        struct tty_driver driver;
        struct tty_ldisc ldisc;
        struct semaphore termios_sem;
        struct termios *termios, *termios_locked;
        int pgrp;
        int session;
        kdev_t device;
        unsigned long flags;
        int count;
        struct winsize winsize;
        unsigned char stopped:1, hw_stopped:1, flow_stopped:1, packet:1;
        unsigned char low_latency:1, warned:1;
        unsigned char ctrl_status;

        struct tty_struct *link;
        struct fasync_struct *fasync;
        struct tty_flip_buffer flip;
        int max_flip_cnt;
        int alt_speed;
        wait_queue_head_t write_wait;
        wait_queue_head_t read_wait;
        struct tq_struct tq_hangup;
        void *disc_data;
        void *driver_data;
        struct list_head tty_files;







        unsigned int column;
        unsigned char lnext:1, erasing:1, raw:1, real_raw:1, icanon:1;
        unsigned char closing:1;
        unsigned short minimum_to_wake;
        unsigned long overrun_time;
        int num_overrun;
        unsigned long process_char_map[256/(8*sizeof(unsigned long))];
        char *read_buf;
        int read_head;
        int read_tail;
        int read_cnt;
        unsigned long read_flags[4096/(8*sizeof(unsigned long))];
        int canon_data;
        unsigned long canon_head;
        unsigned int canon_column;
        struct semaphore atomic_read;
        struct semaphore atomic_write;
        spinlock_t read_lock;

        struct tq_struct SAK_tq;
};
# 344 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/tty.h"
extern void tty_write_flush(struct tty_struct *);

extern struct termios tty_std_termios;
extern struct tty_ldisc tty_ldiscs[];
extern int fg_console, last_console, want_console;

extern int kmsg_redirect;

extern void con_init(void);
extern void console_init(void);

extern int lp_init(void);
extern int pty_init(void);
extern void tty_init(void);
extern int mxser_init(void);
extern int moxa_init(void);
extern int ip2_init(void);
extern int pcxe_init(void);
extern int pc_init(void);
extern int vcs_init(void);
extern int rp_init(void);
extern int cy_init(void);
extern int stl_init(void);
extern int stli_init(void);
extern int specialix_init(void);
extern int espserial_init(void);
extern int macserial_init(void);
extern int a2232board_init(void);

extern int tty_paranoia_check(struct tty_struct *tty, kdev_t device,
                              const char *routine);
extern char *tty_name(struct tty_struct *tty, char *buf);
extern void tty_wait_until_sent(struct tty_struct * tty, long timeout);
extern int tty_check_change(struct tty_struct * tty);
extern void stop_tty(struct tty_struct * tty);
extern void start_tty(struct tty_struct * tty);
extern int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc);
extern int tty_register_driver(struct tty_driver *driver);
extern int tty_unregister_driver(struct tty_driver *driver);
extern void tty_register_devfs (struct tty_driver *driver, unsigned int flags,
                                unsigned minor);
extern void tty_unregister_devfs (struct tty_driver *driver, unsigned minor);
extern int tty_read_raw_data(struct tty_struct *tty, unsigned char *bufp,
                             int buflen);
extern void tty_write_message(struct tty_struct *tty, char *msg);

extern int is_orphaned_pgrp(int pgrp);
extern int is_ignored(int sig);
extern int tty_signal(int sig, struct tty_struct *tty);
extern void tty_hangup(struct tty_struct * tty);
extern void tty_vhangup(struct tty_struct * tty);
extern void tty_unhangup(struct file *filp);
extern int tty_hung_up_p(struct file * filp);
extern void do_SAK(struct tty_struct *tty);
extern void disassociate_ctty(int priv);
extern void tty_flip_buffer_push(struct tty_struct *tty);
extern int tty_get_baud_rate(struct tty_struct *tty);

extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
extern void tty_ldisc_deref(struct tty_ldisc *);
extern struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *);

extern struct tty_ldisc *tty_ldisc_get(int);
extern void tty_ldisc_put(int);

extern void tty_wakeup(struct tty_struct *tty);
extern void tty_ldisc_flush(struct tty_struct *tty);



extern struct tty_ldisc tty_ldisc_N_TTY;


extern int n_tty_ioctl(struct tty_struct * tty, struct file * file,
                       unsigned int cmd, unsigned long arg);



extern void serial_console_init(void);



extern int pcxe_open(struct tty_struct *tty, struct file *filp);



extern void console_print(const char *);



extern int vt_ioctl(struct tty_struct *tty, struct file * file,
                    unsigned int cmd, unsigned long arg);
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sem.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ipc.h" 1
# 9 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ipc.h"
struct ipc_perm
{
        __kernel_key_t key;
        __kernel_uid_t uid;
        __kernel_gid_t gid;
        __kernel_uid_t cuid;
        __kernel_gid_t cgid;
        __kernel_mode_t mode;
        unsigned short seq;
};


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ipcbuf.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ipcbuf.h"
struct ipc64_perm
{
        __kernel_key_t key;
        __kernel_uid_t uid;
        __kernel_gid_t gid;
        __kernel_uid_t cuid;
        __kernel_gid_t cgid;
        __kernel_mode_t mode;
        unsigned short seq;
        unsigned short __pad1;
        unsigned long __unused1;
        unsigned long __unused2;
};
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ipc.h" 2
# 57 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ipc.h"
struct kern_ipc_perm
{
        key_t key;
        uid_t uid;
        gid_t gid;
        uid_t cuid;
        gid_t cgid;
        mode_t mode;
        unsigned long seq;
};
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sem.h" 2
# 23 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sem.h"
struct semid_ds {
        struct ipc_perm sem_perm;
        __kernel_time_t sem_otime;
        __kernel_time_t sem_ctime;
        struct sem *sem_base;
        struct sem_queue *sem_pending;
        struct sem_queue **sem_pending_last;
        struct sem_undo *undo;
        unsigned short sem_nsems;
};


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sembuf.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sembuf.h"
struct semid64_ds {
        struct ipc64_perm sem_perm;
        __kernel_time_t sem_otime;
        __kernel_time_t sem_ctime;
        unsigned long sem_nsems;
        unsigned long __unused1;
        unsigned long __unused2;
};
# 36 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sem.h" 2


struct sembuf {
        unsigned short sem_num;
        short sem_op;
        short sem_flg;
};


union semun {
        int val;
        struct semid_ds *buf;
        unsigned short *array;
        struct seminfo *__buf;
        void *__pad;
};

struct seminfo {
        int semmap;
        int semmni;
        int semmns;
        int semmnu;
        int semmsl;
        int semopm;
        int semume;
        int semusz;
        int semvmx;
        int semaem;
};
# 82 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sem.h"
struct sem {
        int semval;
        int sempid;
};


struct sem_array {
        struct kern_ipc_perm sem_perm;
        time_t sem_otime;
        time_t sem_ctime;
        struct sem *sem_base;
        struct sem_queue *sem_pending;
        struct sem_queue **sem_pending_last;
        struct sem_undo *undo;
        unsigned long sem_nsems;
};


struct sem_queue {
        struct sem_queue * next;
        struct sem_queue ** prev;
        struct task_struct* sleeper;
        struct sem_undo * undo;
        int pid;
        int status;
        struct sem_array * sma;
        int id;
        struct sembuf * sops;
        int nsops;
        int alter;
};




struct sem_undo {
        struct sem_undo * proc_next;
        struct sem_undo * id_next;
        int semid;
        short * semadj;
};

 long sys_semget (key_t key, int nsems, int semflg);
 long sys_semop (int semid, struct sembuf *sops, unsigned nsops);
 long sys_semctl (int semid, int semnum, int cmd, union semun arg);
 long sys_semtimedop (int semid, struct sembuf *sops,
                        unsigned nsops, const struct timespec *timeout);
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/signal.h" 1
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/signal.h"
typedef struct {
        unsigned long sig[(128 / 64)];
} sigset_t;





typedef struct {
        unsigned int sig[(128 / 32)];
} sigset_t32;

typedef unsigned long old_sigset_t;
typedef unsigned int old_sigset_t32;
# 131 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/signal.h"
typedef void (*__sighandler_t)(int);






struct sigaction {
        unsigned int sa_flags;
        __sighandler_t sa_handler;
        sigset_t sa_mask;
};

struct k_sigaction {
        struct sigaction sa;
};


typedef struct sigaltstack {
        void *ss_sp;
        size_t ss_size;
        int ss_flags;
} stack_t;


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sigcontext.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sigcontext.h"
struct sigcontext {
        unsigned long long sc_regs[32];
        unsigned long long sc_fpregs[32];
        unsigned long long sc_mdhi;
        unsigned long long sc_mdlo;
        unsigned long long sc_pc;
        unsigned int sc_status;
        unsigned int sc_fpc_csr;
        unsigned int sc_fpc_eir;
        unsigned int sc_used_math;
        unsigned int sc_cause;
        unsigned int sc_badvaddr;
};


struct sigcontext32 {
        u32 sc_regmask;
        u32 sc_status;
        u64 sc_pc;
        u64 sc_regs[32];
        u64 sc_fpregs[32];
        u32 sc_ownedfp;
        u32 sc_fpc_csr;
        u32 sc_fpc_eir;
        u32 sc_used_math;
        u32 sc_ssflags;
        u64 sc_mdhi;
        u64 sc_mdlo;

        u32 sc_cause;
        u32 sc_badvaddr;

        u32 sc_sigset[4];
};
# 157 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/signal.h" 2
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/siginfo.h" 1
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/siginfo.h"
typedef union sigval {
        int sival_int;
        void *sival_ptr;
} sigval_t;
# 33 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/siginfo.h"
typedef struct siginfo {
        int si_signo;
        int si_code;
        int si_errno;
        int __pad0[128 / sizeof(int) - ((128/sizeof(int)) - 4) - 3];

        union {
                int _pad[((128/sizeof(int)) - 4)];


                struct {
                        pid_t _pid;
                        uid_t _uid;
                } _kill;


                struct {
                        pid_t _pid;
                        uid_t _uid;
                        int _status;
                        clock_t _utime;
                        clock_t _stime;
                } _sigchld;


                struct {
                        pid_t _pid;
                        clock_t _utime;
                        int _status;
                        clock_t _stime;
                } _irix_sigchld;


                struct {
                        void *_addr;
                } _sigfault;


                struct {
                        long _band;
                        int _fd;
                } _sigpoll;


                struct {
                        unsigned int _timer1;
                        unsigned int _timer2;
                } _timer;


                struct {
                        pid_t _pid;
                        uid_t _uid;
                        sigval_t _sigval;
                } _rt;

        } _sifields;
} siginfo_t;
# 228 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/siginfo.h"
typedef struct sigevent {
        sigval_t sigev_value;
        int sigev_signo;
        int sigev_notify;
        union {
                int _pad[((64 -(sizeof(long) + 2*sizeof(int))) / sizeof(int))];

                struct {
                        void (*_function)(sigval_t);
                        void *_attribute;
                } _sigev_thread;
        } _sigev_un;
} sigevent_t;







static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void copy_siginfo(siginfo_t *to, siginfo_t *from)
{
        if (from->si_code < 0)
                memcpy(to, from, sizeof(siginfo_t));
        else

                memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
}

extern int copy_siginfo_to_user(siginfo_t *to, siginfo_t *from);
# 6 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h" 2






struct sigqueue {
        struct sigqueue *next;
        siginfo_t info;
};

struct sigpending {
        struct sigqueue *head, **tail;
        sigset_t signal;
};
# 31 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigaddset(sigset_t *set, int _sig)
{
        unsigned long sig = _sig - 1;
        if ((128 / 64) == 1)
                set->sig[0] |= 1UL << sig;
        else
                set->sig[sig / 64] |= 1UL << (sig % 64);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigdelset(sigset_t *set, int _sig)
{
        unsigned long sig = _sig - 1;
        if ((128 / 64) == 1)
                set->sig[0] &= ~(1UL << sig);
        else
                set->sig[sig / 64] &= ~(1UL << (sig % 64));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int sigismember(sigset_t *set, int _sig)
{
        unsigned long sig = _sig - 1;
        if ((128 / 64) == 1)
                return 1 & (set->sig[0] >> sig);
        else
                return 1 & (set->sig[sig / 64] >> (sig % 64));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int sigfindinword(unsigned long word)
{
        return ffz(~word);
}
# 108 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigorsets(sigset_t *r, const sigset_t *a, const sigset_t *b) { unsigned long a0, a1, a2, a3, b0, b1, b2, b3; unsigned long i; for (i = 0; i < (128 / 64)/4; ++i) { a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; a3 = a->sig[4*i+3]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; b3 = b->sig[4*i+3]; r->sig[4*i+0] = ((a0) | (b0)); r->sig[4*i+1] = ((a1) | (b1)); r->sig[4*i+2] = ((a2) | (b2)); r->sig[4*i+3] = ((a3) | (b3)); } switch ((128 / 64) % 4) { case 3: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; r->sig[4*i+0] = ((a0) | (b0)); r->sig[4*i+1] = ((a1) | (b1)); r->sig[4*i+2] = ((a2) | (b2)); break; case 2: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; r->sig[4*i+0] = ((a0) | (b0)); r->sig[4*i+1] = ((a1) | (b1)); break; case 1: a0 = a->sig[4*i+0]; b0 = b->sig[4*i+0]; r->sig[4*i+0] = ((a0) | (b0)); break; } }


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigandsets(sigset_t *r, const sigset_t *a, const sigset_t *b) { unsigned long a0, a1, a2, a3, b0, b1, b2, b3; unsigned long i; for (i = 0; i < (128 / 64)/4; ++i) { a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; a3 = a->sig[4*i+3]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; b3 = b->sig[4*i+3]; r->sig[4*i+0] = ((a0) & (b0)); r->sig[4*i+1] = ((a1) & (b1)); r->sig[4*i+2] = ((a2) & (b2)); r->sig[4*i+3] = ((a3) & (b3)); } switch ((128 / 64) % 4) { case 3: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; r->sig[4*i+0] = ((a0) & (b0)); r->sig[4*i+1] = ((a1) & (b1)); r->sig[4*i+2] = ((a2) & (b2)); break; case 2: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; r->sig[4*i+0] = ((a0) & (b0)); r->sig[4*i+1] = ((a1) & (b1)); break; case 1: a0 = a->sig[4*i+0]; b0 = b->sig[4*i+0]; r->sig[4*i+0] = ((a0) & (b0)); break; } }


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void signandsets(sigset_t *r, const sigset_t *a, const sigset_t *b) { unsigned long a0, a1, a2, a3, b0, b1, b2, b3; unsigned long i; for (i = 0; i < (128 / 64)/4; ++i) { a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; a3 = a->sig[4*i+3]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; b3 = b->sig[4*i+3]; r->sig[4*i+0] = ((a0) & ~(b0)); r->sig[4*i+1] = ((a1) & ~(b1)); r->sig[4*i+2] = ((a2) & ~(b2)); r->sig[4*i+3] = ((a3) & ~(b3)); } switch ((128 / 64) % 4) { case 3: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; r->sig[4*i+0] = ((a0) & ~(b0)); r->sig[4*i+1] = ((a1) & ~(b1)); r->sig[4*i+2] = ((a2) & ~(b2)); break; case 2: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; r->sig[4*i+0] = ((a0) & ~(b0)); r->sig[4*i+1] = ((a1) & ~(b1)); break; case 1: a0 = a->sig[4*i+0]; b0 = b->sig[4*i+0]; r->sig[4*i+0] = ((a0) & ~(b0)); break; } }
# 140 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void signotset(sigset_t *set) { unsigned long i; for (i = 0; i < (128 / 64)/4; ++i) { set->sig[4*i+0] = (~(set->sig[4*i+0])); set->sig[4*i+1] = (~(set->sig[4*i+1])); set->sig[4*i+2] = (~(set->sig[4*i+2])); set->sig[4*i+3] = (~(set->sig[4*i+3])); } switch ((128 / 64) % 4) { case 3: set->sig[4*i+2] = (~(set->sig[4*i+2])); case 2: set->sig[4*i+1] = (~(set->sig[4*i+1])); case 1: set->sig[4*i+0] = (~(set->sig[4*i+0])); } }




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigemptyset(sigset_t *set)
{
        switch ((128 / 64)) {
        default:
                memset(set, 0, sizeof(sigset_t));
                break;
        case 2: set->sig[1] = 0;
        case 1: set->sig[0] = 0;
                break;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigfillset(sigset_t *set)
{
        switch ((128 / 64)) {
        default:
                memset(set, -1, sizeof(sigset_t));
                break;
        case 2: set->sig[1] = (unsigned long)-1;
        case 1: set->sig[0] = (unsigned long)-1;
                break;
        }
}

extern char * render_sigset_t(sigset_t *set, char *buffer);



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigaddsetmask(sigset_t *set, unsigned long mask)
{
        set->sig[0] |= mask;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigdelsetmask(sigset_t *set, unsigned long mask)
{
        set->sig[0] &= ~mask;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int sigtestsetmask(sigset_t *set, unsigned long mask)
{
        return (set->sig[0] & mask) != 0;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void siginitset(sigset_t *set, unsigned long mask)
{
        set->sig[0] = mask;
        switch ((128 / 64)) {
        default:
                memset(&set->sig[1], 0, sizeof(long)*((128 / 64)-1));
                break;
        case 2: set->sig[1] = 0;
        case 1: ;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void siginitsetinv(sigset_t *set, unsigned long mask)
{
        set->sig[0] = ~mask;
        switch ((128 / 64)) {
        default:
                memset(&set->sig[1], -1, sizeof(long)*((128 / 64)-1));
                break;
        case 2: set->sig[1] = (unsigned long)-1;
        case 1: ;
        }
}



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void init_sigpending(struct sigpending *sig)
{
        sigemptyset(&sig->signal);
        sig->head = ((void *)0);
        sig->tail = &sig->head;
}

extern long do_sigpending(void *, unsigned long);
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/securebits.h" 1





extern unsigned securebits;
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs_struct.h" 1




struct fs_struct {
        atomic_t count;
        rwlock_t lock;
        int umask;
        struct dentry * root, * pwd, * altroot;
        struct vfsmount * rootmnt, * pwdmnt, * altrootmnt;
};
# 20 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs_struct.h"
extern void exit_fs(struct task_struct *);
extern void set_fs_altroot(void);






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void set_fs_root(struct fs_struct *fs,
        struct vfsmount *mnt,
        struct dentry *dentry)
{
        struct dentry *old_root;
        struct vfsmount *old_rootmnt;
        (void)(&fs->lock);
        old_root = fs->root;
        old_rootmnt = fs->rootmnt;
        fs->rootmnt = mntget(mnt);
        fs->root = dget(dentry);
        do { } while(0);
        if (old_root) {
                dput(old_root);
                mntput(old_rootmnt);
        }
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void set_fs_pwd(struct fs_struct *fs,
        struct vfsmount *mnt,
        struct dentry *dentry)
{
        struct dentry *old_pwd;
        struct vfsmount *old_pwdmnt;
        (void)(&fs->lock);
        old_pwd = fs->pwd;
        old_pwdmnt = fs->pwdmnt;
        fs->pwdmnt = mntget(mnt);
        fs->pwd = dget(dentry);
        do { } while(0);
        if (old_pwd) {
                dput(old_pwd);
                mntput(old_pwdmnt);
        }
}

struct fs_struct *copy_fs_struct(struct fs_struct *old);
void put_fs_struct(struct fs_struct *fs);
# 29 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2

struct exec_domain;
# 59 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
extern unsigned long avenrun[];
# 76 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
extern int nr_running, nr_threads;
extern int last_pid;



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/param.h" 1
# 82 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/resource.h" 1
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/resource.h"
struct rusage {
        struct timeval ru_utime;
        struct timeval ru_stime;
        long ru_maxrss;
        long ru_ixrss;
        long ru_idrss;
        long ru_isrss;
        long ru_minflt;
        long ru_majflt;
        long ru_nswap;
        long ru_inblock;
        long ru_oublock;
        long ru_msgsnd;
        long ru_msgrcv;
        long ru_nsignals;
        long ru_nvcsw;
        long ru_nivcsw;
};

struct rlimit {
        unsigned long rlim_cur;
        unsigned long rlim_max;
};
# 56 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/resource.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/resource.h" 1
# 57 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/resource.h" 2
# 83 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2
# 118 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
struct sched_param {
        int sched_priority;
};

struct completion;
# 134 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
extern rwlock_t tasklist_lock;
extern spinlock_t runqueue_lock;
extern spinlock_t mmlist_lock;

extern void sched_init(void);
extern void init_idle(void);
extern void show_state(void);
extern void cpu_init (void);
extern void trap_init(void);
extern void update_process_times(int user);
extern void update_one_process(struct task_struct *p, unsigned long user,
                               unsigned long system, int cpu);


extern signed long schedule_timeout(signed long timeout);
 void schedule(void);

extern int schedule_task(struct tq_struct *task);
extern void flush_scheduled_tasks(void);
extern int start_context_thread(void);
extern int current_is_keventd(void);
# 168 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
struct namespace;



struct files_struct {
        atomic_t count;
        rwlock_t file_lock;
        int max_fds;
        int max_fdset;
        int next_fd;
        struct file ** fd;
        fd_set *close_on_exec;
        fd_set *open_fds;
        fd_set close_on_exec_init;
        fd_set open_fds_init;
        struct file * fd_array[64];
};
# 204 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
extern int max_map_count;

struct mm_struct {
        struct vm_area_struct * mmap;
        rb_root_t mm_rb;
        struct vm_area_struct * mmap_cache;
        pgd_t * pgd;
        atomic_t mm_users;
        atomic_t mm_count;
        int map_count;
        struct rw_semaphore mmap_sem;
        spinlock_t page_table_lock;

        struct list_head mmlist;




        unsigned long start_code, end_code, start_data, end_data;
        unsigned long start_brk, brk, start_stack;
        unsigned long arg_start, arg_end, env_start, env_end;
        unsigned long rss, total_vm, locked_vm;
        unsigned long def_flags;
        unsigned long cpu_vm_mask;
        unsigned long swap_address;

        unsigned dumpable:1;


        mm_context_t context;
};

extern int mmlist_nr;
# 249 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
struct signal_struct {
        atomic_t count;
        struct k_sigaction action[128];
        spinlock_t siglock;
};
# 265 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
struct user_struct {
        atomic_t __count;
        atomic_t processes;
        atomic_t files;


        struct user_struct *next, **pprev;
        uid_t uid;
};






extern struct user_struct root_user;


struct task_struct {



        volatile long state;
        unsigned long flags;
        int sigpending;
        mm_segment_t addr_limit;



        struct exec_domain *exec_domain;
        volatile long need_resched;
        unsigned long ptrace;

        int lock_depth;






        long counter;
        long nice;
        unsigned long policy;
        struct mm_struct *mm;
        int processor;
# 318 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
        unsigned long cpus_runnable, cpus_allowed;




        struct list_head run_list;
        unsigned long sleep_time;

        struct task_struct *next_task, *prev_task;
        struct mm_struct *active_mm;
        struct list_head local_pages;
        unsigned int allocation_order, nr_local_pages;


        struct linux_binfmt *binfmt;
        int exit_code, exit_signal;
        int pdeath_signal;

        unsigned long personality;
        int did_exec:1;
        unsigned task_dumpable:1;
        pid_t pid;
        pid_t pgrp;
        pid_t tty_old_pgrp;
        pid_t session;
        pid_t tgid;

        int leader;





        struct task_struct *p_opptr, *p_pptr, *p_cptr, *p_ysptr, *p_osptr;
        struct list_head thread_group;


        struct task_struct *pidhash_next;
        struct task_struct **pidhash_pprev;

        wait_queue_head_t wait_chldexit;
        struct completion *vfork_done;
        unsigned long rt_priority;
        unsigned long it_real_value, it_prof_value, it_virt_value;
        unsigned long it_real_incr, it_prof_incr, it_virt_incr;
        struct timer_list real_timer;
        struct tms times;
        unsigned long start_time;
        long per_cpu_utime[1], per_cpu_stime[1];

        unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
        int swappable:1;

        uid_t uid,euid,suid,fsuid;
        gid_t gid,egid,sgid,fsgid;
        int ngroups;
        gid_t groups[32];
        kernel_cap_t cap_effective, cap_inheritable, cap_permitted;
        int keep_capabilities:1;
        struct user_struct *user;

        struct rlimit rlim[11];
        unsigned short used_math;
        char comm[16];

        int link_count, total_link_count;
        struct tty_struct *tty;
        unsigned int locks;

        struct sem_undo *semundo;
        struct sem_queue *semsleeping;

        struct thread_struct thread;

        struct fs_struct *fs;

        struct files_struct *files;

        struct namespace *namespace;

        spinlock_t sigmask_lock;
        struct signal_struct *sig;

        sigset_t blocked;
        struct sigpending pending;

        unsigned long sas_ss_sp;
        size_t sas_ss_size;
        int (*notifier)(void *priv);
        void *notifier_data;
        sigset_t *notifier_mask;


        u32 parent_exec_id;
        u32 self_exec_id;

        spinlock_t alloc_lock;


        void *journal_info;

        struct list_head *scm_work_list;
};
# 463 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
extern void yield(void);




extern struct exec_domain default_exec_domain;
# 522 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
union task_union {
        struct task_struct task;
        unsigned long stack[2048*sizeof(long)/sizeof(long)];
};

extern union task_union init_task_union;

extern struct mm_struct init_mm;
extern struct task_struct *init_tasks[1];



extern struct task_struct *pidhash[(4096 >> 2)];



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void hash_pid(struct task_struct *p)
{
        struct task_struct **htable = &pidhash[((((p->pid) >> 8) ^ (p->pid)) & ((4096 >> 2) - 1))];

        if((p->pidhash_next = *htable) != ((void *)0))
                (*htable)->pidhash_pprev = &p->pidhash_next;
        *htable = p;
        p->pidhash_pprev = htable;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void unhash_pid(struct task_struct *p)
{
        if(p->pidhash_next)
                p->pidhash_next->pidhash_pprev = p->pidhash_pprev;
        *p->pidhash_pprev = p->pidhash_next;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct task_struct *find_task_by_pid(int pid)
{
        struct task_struct *p, **htable = &pidhash[((((pid) >> 8) ^ (pid)) & ((4096 >> 2) - 1))];

        for(p = *htable; p && p->pid != pid; p = p->pidhash_next)
                ;

        return p;
}



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void task_set_cpu(struct task_struct *tsk, unsigned int cpu)
{
        tsk->processor = cpu;
        tsk->cpus_runnable = 1UL << cpu;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void task_release_cpu(struct task_struct *tsk)
{
        tsk->cpus_runnable = ~0UL;
}


extern struct user_struct * alloc_uid(uid_t);
extern void free_uid(struct user_struct *);
extern void switch_uid(struct user_struct *);

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/current.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/current.h"
register struct task_struct *current asm("$28");
# 584 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 2

extern unsigned long volatile jiffies;
extern unsigned long itimer_ticks;
extern unsigned long itimer_next;
extern struct timeval xtime;
extern void do_timer(struct pt_regs *);

extern unsigned int * prof_buffer;
extern unsigned long prof_len;
extern unsigned long prof_shift;



extern void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr);
extern void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr);
extern void sleep_on(wait_queue_head_t *q);
extern long sleep_on_timeout(wait_queue_head_t *q, signed long timeout);

extern void interruptible_sleep_on(wait_queue_head_t *q);
extern long interruptible_sleep_on_timeout(wait_queue_head_t *q, signed long timeout);

extern int wake_up_process(struct task_struct * tsk);
# 617 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
 long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);

extern int in_group_p(gid_t);
extern int in_egroup_p(gid_t);

extern void proc_caches_init(void);
extern void flush_signals(struct task_struct *);
extern void flush_signal_handlers(struct task_struct *);
extern void sig_exit(int, int, struct siginfo *);
extern int dequeue_signal(sigset_t *, siginfo_t *);
extern void block_all_signals(int (*notifier)(void *priv), void *priv,
                              sigset_t *mask);
extern void unblock_all_signals(void);
extern int send_sig_info(int, struct siginfo *, struct task_struct *);
extern int force_sig_info(int, struct siginfo *, struct task_struct *);
extern int kill_pg_info(int, struct siginfo *, pid_t);
extern int kill_sl_info(int, struct siginfo *, pid_t);
extern int kill_proc_info(int, struct siginfo *, pid_t);
extern void notify_parent(struct task_struct *, int);
extern void do_notify_parent(struct task_struct *, int);
extern void force_sig(int, struct task_struct *);
extern int send_sig(int, struct task_struct *, int);
extern int kill_pg(pid_t, int, int);
extern int kill_sl(pid_t, int, int);
extern int kill_proc(pid_t, int, int);
extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
extern int do_sigaltstack(const stack_t *, stack_t *, unsigned long);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int signal_pending(struct task_struct *p)
{
        return (p->sigpending != 0);
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int has_pending_signals(sigset_t *signal, sigset_t *blocked)
{
        unsigned long ready;
        long i;

        switch ((128 / 64)) {
        default:
                for (i = (128 / 64), ready = 0; --i >= 0 ;)
                        ready |= signal->sig[i] &~ blocked->sig[i];
                break;

        case 4: ready = signal->sig[3] &~ blocked->sig[3];
                ready |= signal->sig[2] &~ blocked->sig[2];
                ready |= signal->sig[1] &~ blocked->sig[1];
                ready |= signal->sig[0] &~ blocked->sig[0];
                break;

        case 2: ready = signal->sig[1] &~ blocked->sig[1];
                ready |= signal->sig[0] &~ blocked->sig[0];
                break;

        case 1: ready = signal->sig[0] &~ blocked->sig[0];
        }
        return ready != 0;
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void recalc_sigpending(struct task_struct *t)
{
        t->sigpending = has_pending_signals(&t->pending.signal, &t->blocked);
}



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int on_sig_stack(unsigned long sp)
{
        return (sp - current->sas_ss_sp < current->sas_ss_size);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int sas_ss_flags(unsigned long sp)
{
        return (current->sas_ss_size == 0 ? 2
                : on_sig_stack(sp) ? 1 : 0);
}

extern int request_irq(unsigned int,
                       void (*handler)(int, void *, struct pt_regs *),
                       unsigned long, const char *, void *);
extern void free_irq(unsigned int, void *);
# 721 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int suser(void)
{
        if (!( (1 << (0 +1)) & 0x00000000 ? (1 << (0)) & 0x00000000 : (1 << (0)) & securebits ) && current->euid == 0) {
                current->flags |= 0x00000100;
                return 1;
        }
        return 0;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int fsuser(void)
{
        if (!( (1 << (0 +1)) & 0x00000000 ? (1 << (0)) & 0x00000000 : (1 << (0)) & securebits ) && current->fsuid == 0) {
                current->flags |= 0x00000100;
                return 1;
        }
        return 0;
}







static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int capable(int cap)
{

        if (((current->cap_effective) & (1 << (cap))))



        {
                current->flags |= 0x00000100;
                return 1;
        }
        return 0;
}




extern struct mm_struct * mm_alloc(void);

extern struct mm_struct * start_lazy_tlb(void);
extern void end_lazy_tlb(struct mm_struct *mm);


extern void __mmdrop(struct mm_struct *);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mmdrop(struct mm_struct * mm)
{
        if ((atomic_sub_return(1, (&mm->mm_count)) == 0))
                __mmdrop(mm);
}


extern void mmput(struct mm_struct *);

extern void mm_release(void);




extern struct file ** alloc_fd_array(int);
extern int expand_fd_array(struct files_struct *, int nr);
extern void free_fd_array(struct file **, int);

extern fd_set *alloc_fdset(int);
extern int expand_fdset(struct files_struct *, int nr);
extern void free_fdset(fd_set *, int);

extern int copy_thread(int, unsigned long, unsigned long, unsigned long, struct task_struct *, struct pt_regs *);
extern void flush_thread(void);
extern void exit_thread(void);

extern void exit_mm(struct task_struct *);
extern void exit_files(struct task_struct *);
extern void exit_sighand(struct task_struct *);

extern void reparent_to_init(void);
extern void daemonize(void);

extern int do_execve(char *, char **, char **, struct pt_regs *);
extern int do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long);

extern void set_task_comm(struct task_struct *tsk, char *from);
extern void get_task_comm(char *to, struct task_struct *tsk);

extern void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait);
extern void add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait);
extern void remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait);

extern long kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
# 899 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void del_from_runqueue(struct task_struct * p)
{
        nr_running--;
        p->sleep_time = jiffies;
        list_del(&p->run_list);
        p->run_list.next = ((void *)0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int task_on_runqueue(struct task_struct *p)
{
        return (p->run_list.next != ((void *)0));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void unhash_process(struct task_struct *p)
{
        if (task_on_runqueue(p))
                __out_of_line_bug(915);
        do { do { rthal.disint(); } while(0);; (void)(&tasklist_lock); } while (0);
        nr_threads--;
        unhash_pid(p);
        do { (p)->next_task->prev_task = (p)->prev_task; (p)->prev_task->next_task = (p)->next_task; if ((p)->p_osptr) (p)->p_osptr->p_ysptr = (p)->p_ysptr; if ((p)->p_ysptr) (p)->p_ysptr->p_osptr = (p)->p_osptr; else (p)->p_pptr->p_cptr = (p)->p_osptr; } while (0);
        list_del(&p->thread_group);
        do { do { } while(0); do { rthal.enint(); } while(0);; } while (0);
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void task_lock(struct task_struct *p)
{
        (void)(&p->alloc_lock);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void task_unlock(struct task_struct *p)
{
        do { } while(0);
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) char * d_path(struct dentry *dentry, struct vfsmount *vfsmnt,
                                char *buf, int buflen)
{
        char *res;
        struct vfsmount *rootmnt;
        struct dentry *root;
        (void)(&current->fs->lock);
        rootmnt = mntget(current->fs->rootmnt);
        root = dget(current->fs->root);
        (void)(&current->fs->lock);
        (void)(&dcache_lock);
        res = __d_path(dentry, vfsmnt, root, rootmnt, buf, buflen);
        do { } while(0);
        dput(root);
        mntput(rootmnt);
        return res;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int need_resched(void)
{
        return (__builtin_expect((current->need_resched),0));
}

extern void __cond_resched(void);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void cond_resched(void)
{
        if (need_resched())
                __cond_resched();
}
# 20 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h" 2






# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mmzone.h" 1
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mmzone.h"
typedef struct free_area_struct {
        struct list_head free_list;
        unsigned long *map;
} free_area_t;

struct pglist_data;

typedef struct zone_watermarks_s {
        unsigned long min, low, high;
} zone_watermarks_t;
# 47 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mmzone.h"
typedef struct zone_struct {



        spinlock_t lock;
        unsigned long free_pages;







        zone_watermarks_t watermarks[3];







        unsigned long need_balance;

        unsigned long nr_active_pages, nr_inactive_pages;

        unsigned long nr_cache_pages;





        free_area_t free_area[10];
# 105 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mmzone.h"
        wait_queue_head_t * wait_table;
        unsigned long wait_table_size;
        unsigned long wait_table_shift;




        struct pglist_data *zone_pgdat;
        struct page *zone_mem_map;
        unsigned long zone_start_paddr;
        unsigned long zone_start_mapnr;




        char *name;
        unsigned long size;
        unsigned long realsize;
} zone_t;
# 136 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mmzone.h"
typedef struct zonelist_struct {
        zone_t * zones [3 +1];
} zonelist_t;
# 153 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mmzone.h"
struct bootmem_data;
typedef struct pglist_data {
        zone_t node_zones[3];
        zonelist_t node_zonelists[0x0f +1];
        int nr_zones;
        struct page *node_mem_map;
        unsigned long *valid_addr_bitmap;
        struct bootmem_data *bdata;
        unsigned long node_start_paddr;
        unsigned long node_start_mapnr;
        unsigned long node_size;
        int node_id;
        struct pglist_data *node_next;
} pg_data_t;

extern int numnodes;
extern pg_data_t *pgdat_list;
# 178 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mmzone.h"
struct page;
extern void show_free_areas_core(pg_data_t *pgdat);
extern void free_area_init_core(int nid, pg_data_t *pgdat, struct page **gmap,
  unsigned long *zones_size, unsigned long paddr, unsigned long *zholes_size,
  struct page *pmap);

extern pg_data_t contig_page_data;
# 205 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mmzone.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) zone_t *next_zone(zone_t *zone)
{
        pg_data_t *pgdat = zone->zone_pgdat;

        if (zone - pgdat->node_zones < 3 - 1)
                zone++;

        else if (pgdat->node_next) {
                pgdat = pgdat->node_next;
                zone = pgdat->node_zones;
        } else
                zone = ((void *)0);

        return zone;
}
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/swap.h" 1
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/swap.h"
union swap_header {
        struct
        {
                char reserved[(1UL << 14) - 10];
                char magic[10];
        } magic;
        struct
        {
                char bootbits[1024];
                unsigned int version;
                unsigned int last_page;
                unsigned int nr_badpages;
                unsigned int padding[125];
                unsigned int badpages[1];
        } info;
};
# 64 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/swap.h"
struct swap_info_struct {
        unsigned int flags;
        kdev_t swap_device;
        spinlock_t sdev_lock;
        struct dentry * swap_file;
        struct vfsmount *swap_vfsmnt;
        unsigned short * swap_map;
        unsigned int lowest_bit;
        unsigned int highest_bit;
        unsigned int cluster_next;
        unsigned int cluster_nr;
        int prio;
        int pages;
        unsigned long max;
        int next;
};

extern int nr_swap_pages;




extern unsigned int nr_free_pages(void);
extern unsigned int nr_free_buffer_pages(void);
extern unsigned int freeable_lowmem(void);
extern int nr_active_pages;
extern int nr_inactive_pages;
extern unsigned long page_cache_size;
extern atomic_t buffermem_pages;

extern spinlock_cacheline_t pagecache_lock_cacheline;


extern void __remove_inode_page(struct page *);


struct task_struct;
struct vm_area_struct;
struct sysinfo;

struct zone_t;


extern void lru_cache_add(struct page *);
extern void __lru_cache_del(struct page *);
extern void lru_cache_del(struct page *);

extern void activate_page(struct page *);

extern void swap_setup(void);


extern wait_queue_head_t kswapd_wait;
extern int try_to_free_pages_zone(zone_t *, unsigned int);
extern int try_to_free_pages(unsigned int);
extern int vm_vfs_scan_ratio, vm_cache_scan_ratio, vm_lru_balance_ratio, vm_passes, vm_gfp_debug, vm_mapped_ratio, vm_anon_lru;


extern void rw_swap_page(int, struct page *);
extern void rw_swap_page_nolock(int, swp_entry_t, char *);






extern void show_swap_cache_info(void);

extern int add_to_swap_cache(struct page *, swp_entry_t);
extern void __delete_from_swap_cache(struct page *page);
extern void delete_from_swap_cache(struct page *page);
extern void free_page_and_swap_cache(struct page *page);
extern struct page * lookup_swap_cache(swp_entry_t);
extern struct page * read_swap_cache_async(swp_entry_t);


extern void out_of_memory(void);


extern int total_swap_pages;
extern unsigned int nr_swapfiles;
extern struct swap_info_struct swap_info[];
extern int is_swap_partition(kdev_t);
extern void si_swapinfo(struct sysinfo *);
extern swp_entry_t get_swap_page(void);
extern void get_swaphandle_info(swp_entry_t, unsigned long *, kdev_t *,
                                        struct inode **);
extern int swap_duplicate(swp_entry_t);
extern int valid_swaphandles(swp_entry_t, unsigned long *);
extern void swap_free(swp_entry_t);
extern void free_swap_and_cache(swp_entry_t);
struct swap_list_t {
        int head;
        int next;
};
extern struct swap_list_t swap_list;
 long sys_swapoff(const char *);
 long sys_swapon(const char *, int);

extern spinlock_cacheline_t pagemap_lru_lock_cacheline;


extern void mark_page_accessed(struct page *);
# 180 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/swap.h"
extern void delta_nr_active_pages(struct page *page, long delta);



extern void delta_nr_inactive_pages(struct page *page, long delta);
# 216 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/swap.h"
extern void delta_nr_cache_pages(struct page *page, long delta);



extern spinlock_t swaplock;






extern int shmem_unuse(swp_entry_t entry, struct page *page);
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h" 2


extern unsigned long max_mapnr;
extern unsigned long num_physpages;
extern unsigned long num_mappedpages;
extern void * high_memory;
extern int page_cluster;

extern struct list_head active_list;
extern struct list_head inactive_list;


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h" 1
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h" 1
# 55 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mach-loongson/io.h" 1
# 56 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h" 2
# 150 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void * ioremap(unsigned long offset, unsigned long size)
{
        return (void *) (0x9000000000000000 | offset);
}
# 174 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void * ioremap_nocache (unsigned long offset, unsigned long size)
{
        return (void *) (0x9000000000000000 | offset);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void iounmap(void *addr)
{
}
# 216 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
extern unsigned long isa_slot_offset;
# 255 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int check_signature(unsigned long io_addr,
        const unsigned char *signature, int length)
{
        int retval = 0;
        do {
                if ((*(volatile unsigned char *)(io_addr)) != *signature)
                        goto out;
                io_addr++;
                signature++;
                length--;
        } while (length);
        retval = 1;
out:
        return retval;
}
# 284 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int isa_check_signature(unsigned long io_addr,
        const unsigned char *signature, int length)
{
        int retval = 0;
        do {
                if ((*(volatile unsigned char *)(((char *)(isa_slot_offset)) + (io_addr))) != *signature)
                        goto out;
                io_addr++;
                signature++;
                length--;
        } while (length);
        retval = 1;
out:
        return retval;
}
# 313 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long virt_to_phys(volatile void * address)
{
        return (unsigned long)address - 0x9800000000000000UL;
}
# 331 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void * phys_to_virt(unsigned long address)
{
        return (void *)(address + 0x9800000000000000UL);
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long virt_to_bus(volatile void * address)
{
        return (unsigned long)address - 0x9800000000000000UL;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void * bus_to_virt(unsigned long address)
{
        return (void *)(address + 0x9800000000000000UL);
}
# 360 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
extern const unsigned long mips_io_port_base;
# 415 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char inb(unsigned long port)
{
        return *(volatile u8 *)(mips_io_port_base + port);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned short inw(unsigned long port)
{
        port = (port);

        return (*(volatile u16 *)(mips_io_port_base + port));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int inl(unsigned long port)
{
        return (*(volatile u32 *)(mips_io_port_base + port));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char inb_p(unsigned long port)
{
        u8 __val;

        __val = *(volatile u8 *)(mips_io_port_base + port);
        ;

        return __val;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned short inw_p(unsigned long port)
{
        u16 __val;

        port = (port);
        __val = *(volatile u16 *)(mips_io_port_base + port);
        ;

        return (__val);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int inl_p(unsigned long port)
{
        u32 __val;

        __val = *(volatile u32 *)(mips_io_port_base + port);
        ;
        return (__val);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __outsb(unsigned long port, void *addr, unsigned int count)
{
        while (count--) {
                do { *(volatile u8 *)(mips_io_port_base + (port)) = (*(u8 *)addr); } while(0);
                addr++;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __insb(unsigned long port, void *addr, unsigned int count)
{
        while (count--) {
                *(u8 *)addr = inb(port);
                addr++;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __outsw(unsigned long port, void *addr, unsigned int count)
{
        while (count--) {
                do { *(volatile u16 *)(mips_io_port_base + (port)) = (*(u16 *)addr); } while(0);
                addr += 2;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __insw(unsigned long port, void *addr, unsigned int count)
{
        while (count--) {
                *(u16 *)addr = inw(port);
                addr += 2;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __outsl(unsigned long port, void *addr, unsigned int count)
{
        while (count--) {
                do { *(volatile u32 *)(mips_io_port_base + (port)) = (*(u32 *)addr);} while(0);
                addr += 4;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __insl(unsigned long port, void *addr, unsigned int count)
{
        while (count--) {
                *(u32 *)addr = inl(port);
                addr += 4;
        }
}
# 23 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h" 2
# 116 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable-bits.h" 1
# 117 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h" 2
# 169 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
extern unsigned long empty_zero_page;
extern unsigned long zero_page_mask;




extern pte_t invalid_pte_table[(1UL << 14)/sizeof(pte_t)];
extern pte_t empty_bad_page_table[(1UL << 14)/sizeof(pte_t)];
extern pmd_t invalid_pmd_table[2*(1UL << 14)/sizeof(pmd_t)];
extern pmd_t empty_bad_pmd_table[2*(1UL << 14)/sizeof(pmd_t)];





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long pmd_page(pmd_t pmd)
{
        return ((pmd).pmd);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long pgd_page(pgd_t pgd)
{
        return ((pgd).pgd);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pmd_set(pmd_t * pmdp, pte_t * ptep)
{
        ((*pmdp).pmd) = (((unsigned long) ptep) & (~((1UL << 14)-1)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
{
        ((*pgdp).pgd) = (((unsigned long) pmdp) & (~((1UL << 14)-1)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_none(pte_t pte)
{
        return !(((pte).pte) & ~(1<<6));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_present(pte_t pte)
{
        return ((pte).pte) & (1<<0);
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void set_pte(pte_t *ptep, pte_t pteval)
{
        *ptep = pteval;

        if (((pteval).pte) & (1<<6)) {
                pte_t *buddy = ((pte_t *)((unsigned long)(ptep) ^ sizeof(pte_t)));




                if (pte_none(*buddy))
                        ((*buddy).pte) = ((*buddy).pte) | (1<<6);
        }

}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pte_clear(pte_t *ptep)
{


        if (((*((pte_t *)((unsigned long)(ptep) ^ sizeof(pte_t)))).pte) & (1<<6))
                set_pte(ptep, ((pte_t) { ((1<<6)) } ));
        else

                set_pte(ptep, ((pte_t) { (0) } ));
}
# 256 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pmd_none(pmd_t pmd)
{
        return ((pmd).pmd) == (unsigned long) invalid_pte_table;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pmd_bad(pmd_t pmd)
{
        return ((pmd).pmd) &~ (~((1UL << 14)-1));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pmd_present(pmd_t pmd)
{
        return ((pmd).pmd) != (unsigned long) invalid_pte_table;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pmd_clear(pmd_t *pmdp)
{
        ((*pmdp).pmd) = ((unsigned long) invalid_pte_table);
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pgd_none(pgd_t pgd)
{
        return ((pgd).pgd) == (unsigned long) invalid_pmd_table;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pgd_bad(pgd_t pgd)
{
        return ((pgd).pgd) &~ (~((1UL << 14)-1));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pgd_present(pgd_t pgd)
{
        return ((pgd).pgd) != (unsigned long) invalid_pmd_table;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pgd_clear(pgd_t *pgdp)
{
        ((*pgdp).pgd) = ((unsigned long) invalid_pmd_table);
}
# 312 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_read(pte_t pte)
{
        return ((pte).pte) & (1<<1);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_write(pte_t pte)
{
        return ((pte).pte) & (1<<2);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_dirty(pte_t pte)
{
        return ((pte).pte) & (1<<4);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_young(pte_t pte)
{
        return ((pte).pte) & (1<<3);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_wrprotect(pte_t pte)
{
        ((pte).pte) &= ~((1<<2) | (1<<8));
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_rdprotect(pte_t pte)
{
        ((pte).pte) &= ~((1<<1) | (1<<7));
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkclean(pte_t pte)
{
        ((pte).pte) &= ~((1<<4)|(1<<8));
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkold(pte_t pte)
{
        ((pte).pte) &= ~((1<<3)|(1<<7));
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkwrite(pte_t pte)
{
        ((pte).pte) |= (1<<2);
        if (((pte).pte) & (1<<4))
                ((pte).pte) |= (1<<8);
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkread(pte_t pte)
{
        ((pte).pte) |= (1<<1);
        if (((pte).pte) & (1<<3))
                ((pte).pte) |= (1<<7);
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkdirty(pte_t pte)
{
        ((pte).pte) |= (1<<4);
        if (((pte).pte) & (1<<2))
                ((pte).pte) |= (1<<8);
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkyoung(pte_t pte)
{
        ((pte).pte) |= (1<<3);
        if (((pte).pte) & (1<<1))
                ((pte).pte) |= (1<<7);
        return pte;
}
# 396 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pgprot_t pgprot_noncached(pgprot_t _prot)
{
        unsigned long prot = ((_prot).pgprot);

        prot = (prot & ~(7<<9)) | (2<<9);

        return ((pgprot_t) { (prot) } );
}
# 426 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
{
        return ((pte_t) { (physpage | ((pgprot).pgprot)) } );
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_modify(pte_t pte, pgprot_t newprot)
{
        return ((pte_t) { ((((pte).pte) & ((~((1UL << 14)-1)) | (1<<3) | (1<<4) | (7<<9))) | ((newprot).pgprot)) } );
}
# 444 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pgd_t *pgd_offset(struct mm_struct *mm, unsigned long address)
{
        return mm->pgd + ((address >> ((14 + (14 - 3)) + (14 + 1 - 3))) & ((((1UL << 14) << 0) / sizeof(pgd_t)) - 1));
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
{
        return (pmd_t *) pgd_page(*dir) +
               ((address >> (14 + (14 - 3))) & ((((1UL << 14) << 0) / sizeof(pmd_t)) - 1));
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t *pte_offset(pmd_t * dir, unsigned long address)
{
        return (pte_t *) (pmd_page(*dir)) +
               ((address >> 14) & ((((1UL << 14) << 0) / sizeof(pte_t)) - 1));
}




extern void pgd_init(unsigned long page);
extern void pmd_init(unsigned long page, unsigned long pagetable);

extern pgd_t swapper_pg_dir[(((1UL << 14) << 0) / sizeof(pgd_t))];
extern void paging_init(void);

extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
        pte_t pte);
extern void __update_cache(struct vm_area_struct *vma, unsigned long address,
        pte_t pte);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void update_mmu_cache(struct vm_area_struct *vma,
        unsigned long address, pte_t pte)
{
        __update_tlb(vma, address, pte);
        __update_cache(vma, address, pte);
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t mk_swap_pte(unsigned long type, unsigned long offset)
{ pte_t pte; ((pte).pte) = (type << 32) | (offset << 40); return pte; }
# 508 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm-generic/pgtable.h" 1



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int ptep_test_and_clear_young(pte_t *ptep)
{
        pte_t pte = *ptep;
        if (!pte_young(pte))
                return 0;
        set_pte(ptep, pte_mkold(pte));
        return 1;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int ptep_test_and_clear_dirty(pte_t *ptep)
{
        pte_t pte = *ptep;
        if (!pte_dirty(pte))
                return 0;
        set_pte(ptep, pte_mkclean(pte));
        return 1;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t ptep_get_and_clear(pte_t *ptep)
{
        pte_t pte = *ptep;
        pte_clear(ptep);
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void ptep_set_wrprotect(pte_t *ptep)
{
        pte_t old_pte = *ptep;
        set_pte(ptep, pte_wrprotect(old_pte));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void ptep_mkdirty(pte_t *ptep)
{
        pte_t old_pte = *ptep;
        set_pte(ptep, pte_mkdirty(old_pte));
}
# 509 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h" 2
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h" 2
# 44 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
struct vm_area_struct {
        struct mm_struct * vm_mm;
        unsigned long vm_start;
        unsigned long vm_end;



        struct vm_area_struct *vm_next;

        pgprot_t vm_page_prot;
        unsigned long vm_flags;

        rb_node_t vm_rb;






        struct vm_area_struct *vm_next_share;
        struct vm_area_struct **vm_pprev_share;


        struct vm_operations_struct * vm_ops;


        unsigned long vm_pgoff;

        struct file * vm_file;
        unsigned long vm_raend;
        void * vm_private_data;
};
# 118 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
extern int vm_min_readahead;
extern int vm_max_readahead;
extern unsigned long mmap_min_addr;





extern pgprot_t protection_map[16];







struct vm_operations_struct {
        void (*open)(struct vm_area_struct * area);
        void (*close)(struct vm_area_struct * area);
        struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int unused);
};
# 155 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
typedef struct page {
        struct list_head list;
        struct address_space *mapping;
        unsigned long index;
        struct page *next_hash;

        atomic_t count;
        unsigned long flags;

        struct list_head lru;

        struct page **pprev_hash;
        struct buffer_head * buffers;
# 183 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
} mem_map_t;
# 203 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct page *nth_page(struct page *page, int n)
{
        return page + n;
}
# 342 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
struct zone_struct;
extern struct zone_struct *zone_table[];

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) zone_t *page_zone(struct page *page)
{
        return zone_table[page->flags >> (64 - 8)];
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void set_page_zone(struct page *page, unsigned long zone_num)
{
        page->flags &= ~(~0UL << (64 - 8));
        page->flags |= zone_num << (64 - 8);
}
# 389 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
extern void set_page_dirty(struct page *);
# 433 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
extern mem_map_t * mem_map;







extern struct page * _alloc_pages(unsigned int gfp_mask, unsigned int order);
extern struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist);
extern struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned int order);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct page * alloc_pages(unsigned int gfp_mask, unsigned int order)
{



        if (order >= 10)
                return ((void *)0);
        return _alloc_pages(gfp_mask, order);
}



extern unsigned long __get_free_pages(unsigned int gfp_mask, unsigned int order);
extern unsigned long get_zeroed_page(unsigned int gfp_mask);
# 474 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
extern void __free_pages(struct page *page, unsigned int order);
extern void free_pages(unsigned long addr, unsigned int order);




extern void show_free_areas(void);
extern void show_free_areas_node(pg_data_t *pgdat);

extern void clear_page_tables(struct mm_struct *, unsigned long, int);

extern int fail_writepage(struct page *);
struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int unused);
struct file *shmem_file_setup(char * name, loff_t size);
extern void shmem_lock(struct file * file, int lock);
extern int shmem_zero_setup(struct vm_area_struct *);

extern void zap_page_range(struct mm_struct *mm, unsigned long address, unsigned long size);
extern int copy_page_range(struct mm_struct *dst, struct mm_struct *src, struct vm_area_struct *vma);
extern int remap_page_range(unsigned long from, unsigned long to, unsigned long size, pgprot_t prot);
extern int zeromap_page_range(unsigned long from, unsigned long size, pgprot_t prot);

extern int vmtruncate(struct inode * inode, loff_t offset);
extern pmd_t *__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address);
extern pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address);
extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
extern int make_pages_present(unsigned long addr, unsigned long end);
extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len);
extern int ptrace_writedata(struct task_struct *tsk, char * src, unsigned long dst, int len);
extern int ptrace_attach(struct task_struct *tsk);
extern int ptrace_detach(struct task_struct *, unsigned int);
extern void ptrace_disable(struct task_struct *);
extern int ptrace_check_attach(struct task_struct *task, int kill);

int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
                int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pmd_t *pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
{
        if (pgd_none(*pgd))
                return __pmd_alloc(mm, pgd, address);
        return pmd_offset(pgd, address);
}

extern int pgt_cache_water[2];
extern int check_pgt_cache(void);

extern void free_area_init(unsigned long * zones_size);
extern void free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
        unsigned long * zones_size, unsigned long zone_start_paddr,
        unsigned long *zholes_size);
extern void mem_init(void);
extern void show_mem(void);
extern void si_meminfo(struct sysinfo * val);
extern void swapin_readahead(swp_entry_t);

extern struct address_space swapper_space;


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int is_page_cache_freeable(struct page * page)
{
        return ((&(page)->count)->counter) - !!page->buffers == 1;
}

extern int can_share_swap_page(struct page *);
extern int remove_exclusive_swap_page(struct page *);

extern void __free_pte(pte_t);


extern void lock_vma_mappings(struct vm_area_struct *);
extern void unlock_vma_mappings(struct vm_area_struct *);
extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
extern void __insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
extern void build_mmap_rb(struct mm_struct *);
extern void exit_mmap(struct mm_struct *);

extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);

extern unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
        unsigned long len, unsigned long prot,
        unsigned long flag, unsigned long pgoff);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long do_mmap(struct file *file, unsigned long addr,
        unsigned long len, unsigned long prot,
        unsigned long flag, unsigned long offset)
{
        unsigned long ret = -22;
        if ((offset + (((len)+(1UL << 14)-1)&(~((1UL << 14)-1)))) < offset)
                goto out;
        if (!(offset & ~(~((1UL << 14)-1))))
                ret = do_mmap_pgoff(file, addr, len, prot, flag, offset >> 14);
out:
        return ret;
}

extern int do_munmap(struct mm_struct *, unsigned long, size_t);

extern unsigned long do_brk(unsigned long, unsigned long);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __vma_unlink(struct mm_struct * mm, struct vm_area_struct * vma, struct vm_area_struct * prev)
{
        prev->vm_next = vma->vm_next;
        rb_erase(&vma->vm_rb, &mm->mm_rb);
        if (mm->mmap_cache == vma)
                mm->mmap_cache = prev;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int can_vma_merge(struct vm_area_struct * vma, unsigned long vm_flags)
{
        if (!vma->vm_file && vma->vm_flags == vm_flags)
                return 1;
        else
                return 0;
}

struct zone_t;

extern void remove_inode_page(struct page *);
extern unsigned long page_unuse(struct page *);
extern void truncate_inode_pages(struct address_space *, loff_t);


extern int filemap_sync(struct vm_area_struct *, unsigned long, size_t, unsigned int);
extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int);
# 635 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mm.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int pf_gfp_mask(unsigned int gfp_mask)
{

        if (current->flags & 0x00004000)
                gfp_mask &= ~(0x40 | 0x80 | 0x100);

        return gfp_mask;
}



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int expand_stack(struct vm_area_struct * vma, unsigned long address)
{
        unsigned long grow;






        address &= (~((1UL << 14)-1));


        if (address < mmap_min_addr && !capable(17))
                return -1;

        (void)(&vma->vm_mm->page_table_lock);


        if (vma->vm_start <= address) {
                do { } while(0);
                return 0;
        }

        grow = (vma->vm_start - address) >> 14;
        if (vma->vm_end - address > current->rlim[3].rlim_cur ||
            ((vma->vm_mm->total_vm + grow) << 14) > current->rlim[6].rlim_cur) {
                do { } while(0);
                return -12;
        }

        if ((vma->vm_flags & 0x00002000) &&
            ((vma->vm_mm->locked_vm + grow) << 14) > current->rlim[9].rlim_cur) {
                do { } while(0);
                return -12;
        }


        vma->vm_start = address;
        vma->vm_pgoff -= grow;
        vma->vm_mm->total_vm += grow;
        if (vma->vm_flags & 0x00002000)
                vma->vm_mm->locked_vm += grow;
        do { } while(0);
        return 0;
}


extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
                                             struct vm_area_struct **pprev);



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct vm_area_struct * find_vma_intersection(struct mm_struct * mm, unsigned long start_addr, unsigned long end_addr)
{
        struct vm_area_struct * vma = find_vma(mm,start_addr);

        if (vma && end_addr <= vma->vm_start)
                vma = ((void *)0);
        return vma;
}

extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);

extern struct page * vmalloc_to_page(void *addr);
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/highmem.h" 1




# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgalloc.h" 1
# 23 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgalloc.h"
extern void local_flush_tlb_all(void);
extern void local_flush_tlb_mm(struct mm_struct *mm);
extern void local_flush_tlb_range(struct mm_struct *mm, unsigned long start,
                               unsigned long end);
extern void local_flush_tlb_page(struct vm_area_struct *vma,
                                 unsigned long page);
extern void local_flush_tlb_one(unsigned long page);
# 47 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgalloc.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void flush_tlb_pgtables(struct mm_struct *mm,
                                      unsigned long start, unsigned long end)
{

}
# 66 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgalloc.h"
extern pgd_t *get_pgd_slow(void);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pgd_t *get_pgd_fast(void)
{
        unsigned long *ret;

        if((ret = (cpu_data[0].pgd_quick)) != ((void *)0)) {
                (cpu_data[0].pgd_quick) = (unsigned long *)(*ret);
                ret[0] = ret[1];
                (cpu_data[0].pgtable_cache_sz)--;
                return (pgd_t *)ret;
        }

        ret = (unsigned long *) get_pgd_slow();
        return (pgd_t *)ret;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void free_pgd_fast(pgd_t *pgd)
{
        *(unsigned long *)pgd = (unsigned long) (cpu_data[0].pgd_quick);
        (cpu_data[0].pgd_quick) = (unsigned long *) pgd;
        (cpu_data[0].pgtable_cache_sz)++;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void free_pgd_slow(pgd_t *pgd)
{
        free_pages((unsigned long)pgd, 0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t *pte_alloc_one(struct mm_struct *mm, unsigned long address)
{
        pte_t *pte;

        pte = (pte_t *) __get_free_pages((0x20 | 0x10 | 0x40 | 0x80 | 0x100), 0);
        if (pte)
                clear_page(pte);
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t *pte_alloc_one_fast(struct mm_struct *mm, unsigned long address)
{
        unsigned long *ret;

        if ((ret = (unsigned long *)(cpu_data[0].pte_quick)) != ((void *)0)) {
                (cpu_data[0].pte_quick) = (unsigned long *)(*ret);
                ret[0] = ret[1];
                (cpu_data[0].pgtable_cache_sz)--;
        }
        return (pte_t *)ret;
}

extern pte_t *get_pte_slow(pmd_t *pmd, unsigned long address_preadjusted);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t *get_pte_fast(void)
{
        unsigned long *ret;

        if((ret = (unsigned long *)(cpu_data[0].pte_quick)) != ((void *)0)) {
                (cpu_data[0].pte_quick) = (unsigned long *)(*ret);
                ret[0] = ret[1];
                (cpu_data[0].pgtable_cache_sz)--;
        }
        return (pte_t *)ret;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void free_pte_fast(pte_t *pte)
{
        *(unsigned long *)pte = (unsigned long) (cpu_data[0].pte_quick);
        (cpu_data[0].pte_quick) = (unsigned long *) pte;
        (cpu_data[0].pgtable_cache_sz)++;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void free_pte_slow(pte_t *pte)
{
        free_pages((unsigned long)pte, 0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
{
        pmd_t *pmd;

        pmd = (pmd_t *) __get_free_pages((0x20 | 0x10 | 0x40 | 0x80 | 0x100), 0);
        if (pmd)
                pmd_init((unsigned long)pmd, (unsigned long)invalid_pte_table);
        return pmd;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pmd_t *pmd_alloc_one_fast(struct mm_struct *mm, unsigned long address)
{
        unsigned long *ret;

        if ((ret = (unsigned long *)(cpu_data[0].pmd_quick)) != ((void *)0)) {
                (cpu_data[0].pmd_quick) = (unsigned long *)(*ret);
                ret[0] = ret[1];
                (cpu_data[0].pgtable_cache_sz)--;
        }
        return (pmd_t *)ret;
}

extern pmd_t *get_pmd_slow(pgd_t *pgd, unsigned long address_preadjusted);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pmd_t *get_pmd_fast(void)
{
        unsigned long *ret;

        if ((ret = (unsigned long *)(cpu_data[0].pmd_quick)) != ((void *)0)) {
                (cpu_data[0].pmd_quick) = (unsigned long *)(*ret);
                ret[0] = ret[1];
                (cpu_data[0].pgtable_cache_sz)--;
                return (pmd_t *)ret;
        }

        return (pmd_t *)ret;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void free_pmd_fast(pmd_t *pmd)
{
        *(unsigned long *)pmd = (unsigned long) (cpu_data[0].pmd_quick);
        (cpu_data[0].pmd_quick) = (unsigned long *) pmd;
        (cpu_data[0].pgtable_cache_sz)++;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void free_pmd_slow(pmd_t *pmd)
{
        free_pages((unsigned long)pmd, 0);
}






extern pte_t kptbl[((1UL << 14) << 0)/sizeof(pte_t)];
extern pmd_t kpmdtbl[(((1UL << 14) << 0) / sizeof(pmd_t))];

extern int do_check_pgt_cache(int, int);
# 6 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/highmem.h" 2
# 66 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/highmem.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int nr_free_highpages(void) { return 0; }

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void *kmap(struct page *page) { return ((void *)((unsigned long) ((((page) - page_zone(page)->zone_mem_map) << 14) + page_zone(page)->zone_start_paddr) + 0x9800000000000000UL)); }
# 84 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/highmem.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void clear_user_highpage(struct page *page, unsigned long vaddr)
{
        void *addr = kmap(page);
        clear_user_page(addr, vaddr);
        do { } while (0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void clear_highpage(struct page *page)
{
        clear_page(kmap(page));
        do { } while (0);
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void memclear_highpage_flush(struct page *page, unsigned int offset, unsigned int size)
{
        char *kaddr;

        if (offset + size > (1UL << 14))
                __out_of_line_bug(105);
        kaddr = kmap(page);
        memset(kaddr + offset, 0, size);
        flush_dcache_page(page);
        do { } while (0);
        do { } while (0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
{
        char *vfrom, *vto;

        vfrom = kmap(from);
        vto = kmap(to);
        copy_user_page(vto, vfrom, vaddr);
        do { } while (0);
        do { } while (0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void copy_highpage(struct page *to, struct page *from)
{
        char *vfrom, *vto;

        vfrom = kmap(from);
        vto = kmap(to);
        copy_page(vto, vfrom);
        do { } while (0);
        do { } while (0);
}
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h" 2
# 97 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
struct sk_buff_head {

        struct sk_buff * next;
        struct sk_buff * prev;

        __u32 qlen;
        spinlock_t lock;
};

struct sk_buff;



typedef struct skb_frag_struct skb_frag_t;

struct skb_frag_struct
{
        struct page *page;
        __u16 page_offset;
        __u16 size;
};




struct skb_shared_info {
        atomic_t dataref;
        unsigned int nr_frags;
        struct sk_buff *frag_list;
        skb_frag_t frags[6];
};

struct sk_buff {

        struct sk_buff * next;
        struct sk_buff * prev;

        struct sk_buff_head * list;
        struct sock *sk;
        struct timeval stamp;
        struct net_device *dev;
        struct net_device *real_dev;





        union
        {
                struct tcphdr *th;
                struct udphdr *uh;
                struct icmphdr *icmph;
                struct igmphdr *igmph;
                struct iphdr *ipiph;
                struct spxhdr *spxh;
                unsigned char *raw;
        } h;


        union
        {
                struct iphdr *iph;
                struct ipv6hdr *ipv6h;
                struct arphdr *arph;
                struct ipxhdr *ipxh;
                unsigned char *raw;
        } nh;


        union
        {
                struct ethhdr *ethernet;
                unsigned char *raw;
        } mac;

        struct dst_entry *dst;







        char cb[48];

        unsigned int len;
        unsigned int data_len;
        unsigned int csum;
        unsigned char __unused,
                        cloned,
                        pkt_type,
                        ip_summed;
        __u32 priority;
        atomic_t users;
        unsigned short protocol;
        unsigned short security;
        unsigned int truesize;

        unsigned char *head;
        unsigned char *data;
        unsigned char *tail;
        unsigned char *end;

        void (*destructor)(struct sk_buff *);
# 222 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
};





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/slab.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/slab.h"
typedef struct kmem_cache_s kmem_cache_t;
# 49 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/slab.h"
extern void kmem_cache_init(void);
extern void kmem_cache_sizes_init(void);

extern kmem_cache_t *kmem_find_general_cachep(size_t, int gfpflags);
extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long,
                                       void (*)(void *, kmem_cache_t *, unsigned long),
                                       void (*)(void *, kmem_cache_t *, unsigned long));
extern int kmem_cache_destroy(kmem_cache_t *);
extern int kmem_cache_shrink(kmem_cache_t *);
extern void *kmem_cache_alloc(kmem_cache_t *, int);
extern void kmem_cache_free(kmem_cache_t *, void *);
extern unsigned int kmem_cache_size(kmem_cache_t *);

extern void *kmalloc(size_t, int);
extern void kfree(const void *);

extern int kmem_cache_reap(int);


extern kmem_cache_t *vm_area_cachep;
extern kmem_cache_t *mm_cachep;
extern kmem_cache_t *names_cachep;
extern kmem_cache_t *files_cachep;
extern kmem_cache_t *filp_cachep;
extern kmem_cache_t *dquot_cachep;
extern kmem_cache_t *bh_cachep;
extern kmem_cache_t *fs_cachep;
extern kmem_cache_t *sigact_cachep;
# 229 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h" 2



extern void __kfree_skb(struct sk_buff *skb);
extern struct sk_buff * alloc_skb(unsigned int size, int priority);
extern void kfree_skbmem(struct sk_buff *skb);
extern struct sk_buff * skb_clone(struct sk_buff *skb, int priority);
extern struct sk_buff * skb_copy(const struct sk_buff *skb, int priority);
extern struct sk_buff * pskb_copy(struct sk_buff *skb, int gfp_mask);
extern int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail, int gfp_mask);
extern struct sk_buff * skb_realloc_headroom(struct sk_buff *skb, unsigned int headroom);
extern struct sk_buff * skb_copy_expand(const struct sk_buff *skb,
                                                int newheadroom,
                                                int newtailroom,
                                                int priority);
extern struct sk_buff * skb_pad(struct sk_buff *skb, int pad);

extern void skb_over_panic(struct sk_buff *skb, int len, void *here);
extern void skb_under_panic(struct sk_buff *skb, int len, void *here);
# 259 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int skb_queue_empty(struct sk_buff_head *list)
{
        return (list->next == (struct sk_buff *) list);
}
# 272 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *skb_get(struct sk_buff *skb)
{
        atomic_add(1,(&skb->users));
        return skb;
}
# 291 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void kfree_skb(struct sk_buff *skb)
{
        if (__builtin_expect((((&skb->users)->counter) == 1),1))
                __asm__ __volatile__("": : :"memory");
        else if (__builtin_expect((!(atomic_sub_return(1, (&skb->users)) == 0)),1))
                return;
        __kfree_skb(skb);
}
# 309 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int skb_cloned(struct sk_buff *skb)
{
        return skb->cloned && ((&((struct skb_shared_info *)((skb)->end))->dataref)->counter) != 1;
}
# 322 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int skb_shared(struct sk_buff *skb)
{
        return (((&skb->users)->counter) != 1);
}
# 341 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *skb_share_check(struct sk_buff *skb, int pri)
{
        if (skb_shared(skb)) {
                struct sk_buff *nskb;
                nskb = skb_clone(skb, pri);
                kfree_skb(skb);
                return nskb;
        }
        return skb;
}
# 374 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *skb_unshare(struct sk_buff *skb, int pri)
{
        struct sk_buff *nskb;
        if(!skb_cloned(skb))
                return skb;
        nskb=skb_copy(skb, pri);
        kfree_skb(skb);
        return nskb;
}
# 398 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *skb_peek(struct sk_buff_head *list_)
{
        struct sk_buff *list = ((struct sk_buff *)list_)->next;
        if (list == (struct sk_buff *)list_)
                list = ((void *)0);
        return list;
}
# 420 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *skb_peek_tail(struct sk_buff_head *list_)
{
        struct sk_buff *list = ((struct sk_buff *)list_)->prev;
        if (list == (struct sk_buff *)list_)
                list = ((void *)0);
        return list;
}
# 435 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) __u32 skb_queue_len(struct sk_buff_head *list_)
{
        return(list_->qlen);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_queue_head_init(struct sk_buff_head *list)
{
        do { } while(0);
        list->prev = (struct sk_buff *)list;
        list->next = (struct sk_buff *)list;
        list->qlen = 0;
}
# 466 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __skb_queue_head(struct sk_buff_head *list, struct sk_buff *newsk)
{
        struct sk_buff *prev, *next;

        newsk->list = list;
        list->qlen++;
        prev = (struct sk_buff *)list;
        next = prev->next;
        newsk->next = next;
        newsk->prev = prev;
        next->prev = newsk;
        prev->next = newsk;
}
# 493 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_queue_head(struct sk_buff_head *list, struct sk_buff *newsk)
{
        unsigned long flags;

        do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&list->lock); } while (0);
        __skb_queue_head(list, newsk);
        do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);
}
# 514 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __skb_queue_tail(struct sk_buff_head *list, struct sk_buff *newsk)
{
        struct sk_buff *prev, *next;

        newsk->list = list;
        list->qlen++;
        next = (struct sk_buff *)list;
        prev = next->prev;
        newsk->next = next;
        newsk->prev = prev;
        next->prev = newsk;
        prev->next = newsk;
}
# 540 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_queue_tail(struct sk_buff_head *list, struct sk_buff *newsk)
{
        unsigned long flags;

        do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&list->lock); } while (0);
        __skb_queue_tail(list, newsk);
        do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);
}
# 558 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *__skb_dequeue(struct sk_buff_head *list)
{
        struct sk_buff *next, *prev, *result;

        prev = (struct sk_buff *) list;
        next = prev->next;
        result = ((void *)0);
        if (next != prev) {
                result = next;
                next = next->next;
                list->qlen--;
                next->prev = prev;
                prev->next = next;
                result->next = ((void *)0);
                result->prev = ((void *)0);
                result->list = ((void *)0);
        }
        return result;
}
# 587 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *skb_dequeue(struct sk_buff_head *list)
{
        unsigned long flags;
        struct sk_buff *result;

        do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&list->lock); } while (0);
        result = __skb_dequeue(list);
        do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);
        return result;
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __skb_insert(struct sk_buff *newsk,
        struct sk_buff * prev, struct sk_buff *next,
        struct sk_buff_head * list)
{
        newsk->next = next;
        newsk->prev = prev;
        next->prev = newsk;
        prev->next = newsk;
        newsk->list = list;
        list->qlen++;
}
# 624 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_insert(struct sk_buff *old, struct sk_buff *newsk)
{
        unsigned long flags;

        do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&old->list->lock); } while (0);
        __skb_insert(newsk, old->prev, old, old->list);
        do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __skb_append(struct sk_buff *old, struct sk_buff *newsk)
{
        __skb_insert(newsk, old, old->next, old->list);
}
# 653 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_append(struct sk_buff *old, struct sk_buff *newsk)
{
        unsigned long flags;

        do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&old->list->lock); } while (0);
        __skb_append(old, newsk);
        do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __skb_unlink(struct sk_buff *skb, struct sk_buff_head *list)
{
        struct sk_buff * next, * prev;

        list->qlen--;
        next = skb->next;
        prev = skb->prev;
        skb->next = ((void *)0);
        skb->prev = ((void *)0);
        skb->list = ((void *)0);
        next->prev = prev;
        prev->next = next;
}
# 694 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_unlink(struct sk_buff *skb)
{
        struct sk_buff_head *list = skb->list;

        if(list) {
                unsigned long flags;

                do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&list->lock); } while (0);
                if(skb->list == list)
                        __skb_unlink(skb, skb->list);
                do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);
        }
}
# 719 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *__skb_dequeue_tail(struct sk_buff_head *list)
{
        struct sk_buff *skb = skb_peek_tail(list);
        if (skb)
                __skb_unlink(skb, list);
        return skb;
}
# 736 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *skb_dequeue_tail(struct sk_buff_head *list)
{
        unsigned long flags;
        struct sk_buff *result;

        do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&list->lock); } while (0);
        result = __skb_dequeue_tail(list);
        do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);
        return result;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int skb_is_nonlinear(const struct sk_buff *skb)
{
        return skb->data_len;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int skb_headlen(const struct sk_buff *skb)
{
        return skb->len - skb->data_len;
}
# 765 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char *__skb_put(struct sk_buff *skb, unsigned int len)
{
        unsigned char *tmp=skb->tail;
        do { if (skb_is_nonlinear(skb)) __out_of_line_bug(768); } while (0);
        skb->tail+=len;
        skb->len+=len;
        return tmp;
}
# 784 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char *skb_put(struct sk_buff *skb, unsigned int len)
{
        unsigned char *tmp=skb->tail;
        do { if (skb_is_nonlinear(skb)) __out_of_line_bug(787); } while (0);
        skb->tail+=len;
        skb->len+=len;
        if(skb->tail>skb->end) {
                skb_over_panic(skb, len, ({ void *_a; __asm__ ("bal\t1f\t\t\t# current_text_addr\n" "1:\tmove\t%0, $31" : "=r" (_a) : : "$31"); _a; }));
        }
        return tmp;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char *__skb_push(struct sk_buff *skb, unsigned int len)
{
        skb->data-=len;
        skb->len+=len;
        return skb->data;
}
# 813 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char *skb_push(struct sk_buff *skb, unsigned int len)
{
        skb->data-=len;
        skb->len+=len;
        if(skb->data<skb->head) {
                skb_under_panic(skb, len, ({ void *_a; __asm__ ("bal\t1f\t\t\t# current_text_addr\n" "1:\tmove\t%0, $31" : "=r" (_a) : : "$31"); _a; }));
        }
        return skb->data;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) char *__skb_pull(struct sk_buff *skb, unsigned int len)
{
        skb->len-=len;
        if (skb->len < skb->data_len)
                __out_of_line_bug(827);
        return skb->data+=len;
}
# 842 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char * skb_pull(struct sk_buff *skb, unsigned int len)
{
        if (len > skb->len)
                return ((void *)0);
        return __skb_pull(skb,len);
}

extern unsigned char * __pskb_pull_tail(struct sk_buff *skb, int delta);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) char *__pskb_pull(struct sk_buff *skb, unsigned int len)
{
        if (len > skb_headlen(skb) &&
            __pskb_pull_tail(skb, len-skb_headlen(skb)) == ((void *)0))
                return ((void *)0);
        skb->len -= len;
        return skb->data += len;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char * pskb_pull(struct sk_buff *skb, unsigned int len)
{
        if (len > skb->len)
                return ((void *)0);
        return __pskb_pull(skb,len);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pskb_may_pull(struct sk_buff *skb, unsigned int len)
{
        if (len <= skb_headlen(skb))
                return 1;
        if (len > skb->len)
                return 0;
        return (__pskb_pull_tail(skb, len-skb_headlen(skb)) != ((void *)0));
}
# 883 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int skb_headroom(const struct sk_buff *skb)
{
        return skb->data-skb->head;
}
# 895 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int skb_tailroom(const struct sk_buff *skb)
{
        return skb_is_nonlinear(skb) ? 0 : skb->end-skb->tail;
}
# 909 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_reserve(struct sk_buff *skb, unsigned int len)
{
        skb->data+=len;
        skb->tail+=len;
}

extern int ___pskb_trim(struct sk_buff *skb, unsigned int len, int realloc);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __skb_trim(struct sk_buff *skb, unsigned int len)
{
        if (!skb->data_len) {
                skb->len = len;
                skb->tail = skb->data+len;
        } else {
                ___pskb_trim(skb, len, 0);
        }
}
# 936 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_trim(struct sk_buff *skb, unsigned int len)
{
        if (skb->len > len) {
                __skb_trim(skb, len);
        }
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int __pskb_trim(struct sk_buff *skb, unsigned int len)
{
        if (!skb->data_len) {
                skb->len = len;
                skb->tail = skb->data+len;
                return 0;
        } else {
                return ___pskb_trim(skb, len, 1);
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pskb_trim(struct sk_buff *skb, unsigned int len)
{
        if (len < skb->len)
                return __pskb_trim(skb, len);
        return 0;
}
# 972 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_orphan(struct sk_buff *skb)
{
        if (skb->destructor)
                skb->destructor(skb);
        skb->destructor = ((void *)0);
        skb->sk = ((void *)0);
}
# 990 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void skb_queue_purge(struct sk_buff_head *list)
{
        struct sk_buff *skb;
        while ((skb=skb_dequeue(list))!=((void *)0))
                kfree_skb(skb);
}
# 1007 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __skb_queue_purge(struct sk_buff_head *list)
{
        struct sk_buff *skb;
        while ((skb=__skb_dequeue(list))!=((void *)0))
                kfree_skb(skb);
}
# 1027 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *__dev_alloc_skb(unsigned int length,
                                              int gfp_mask)
{
        struct sk_buff *skb;

        skb = alloc_skb(length+16, gfp_mask);
        if (skb)
                skb_reserve(skb,16);
        return skb;
}
# 1051 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *dev_alloc_skb(unsigned int length)
{
        return __dev_alloc_skb(length, (0x20));
}
# 1069 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int
skb_cow(struct sk_buff *skb, unsigned int headroom)
{
        int delta = (headroom > 16 ? headroom : 16) - skb_headroom(skb);

        if (delta < 0)
                delta = 0;

        if (delta || skb_cloned(skb))
                return pskb_expand_head(skb, (delta+15)&~15, 0, (0x20));
        return 0;
}
# 1094 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct sk_buff *skb_padto(struct sk_buff *skb, unsigned int len)
{
        unsigned int size = skb->len;
        if(__builtin_expect((size >= len),1))
                return skb;
        return skb_pad(skb, len-size);
}
# 1109 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
int skb_linearize(struct sk_buff *skb, int gfp);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void *kmap_skb_frag(const skb_frag_t *frag)
{






        return kmap(frag->page);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void kunmap_skb_frag(void *vaddr)
{
        do { } while (0);



}







extern struct sk_buff * skb_recv_datagram(struct sock *sk,unsigned flags,int noblock, int *err);
extern unsigned int datagram_poll(struct file *file, struct socket *sock, struct poll_table_struct *wait);
extern int skb_copy_datagram(const struct sk_buff *from, int offset, char *to,int size);
extern int skb_copy_datagram_iovec(const struct sk_buff *from, int offset, struct iovec *to,int size);
extern int skb_copy_and_csum_datagram(const struct sk_buff *skb, int offset, u8 *to, int len, unsigned int *csump);
extern int skb_copy_and_csum_datagram_iovec(const struct sk_buff *skb, int hlen, struct iovec *iov);
extern void skb_free_datagram(struct sock * sk, struct sk_buff *skb);

extern unsigned int skb_checksum(const struct sk_buff *skb, int offset, int len, unsigned int csum);
extern int skb_copy_bits(const struct sk_buff *skb, int offset, void *to, int len);
extern unsigned int skb_copy_and_csum_bits(const struct sk_buff *skb, int offset, u8 *to, int len, unsigned int csum);
extern void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to);

extern void skb_init(void);
extern void skb_add_mtu(int mtu);
# 1175 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/skbuff.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void nf_reset(struct sk_buff *skb) {}
# 155 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h" 2

struct neighbour;
struct neigh_parms;
struct sk_buff;

struct netif_rx_stats
{
        unsigned total;
        unsigned dropped;
        unsigned time_squeeze;
        unsigned throttled;
        unsigned fastroute_hit;
        unsigned fastroute_success;
        unsigned fastroute_defer;
        unsigned fastroute_deferred_out;
        unsigned fastroute_latency_reduction;
        unsigned cpu_collision;
} __attribute__((__aligned__(32)));

extern struct netif_rx_stats netdev_rx_stat[];






struct dev_mc_list
{
        struct dev_mc_list *next;
        __u8 dmi_addr[8];
        unsigned char dmi_addrlen;
        int dmi_users;
        int dmi_gusers;
};

struct hh_cache
{
        struct hh_cache *hh_next;
        atomic_t hh_refcnt;
        unsigned short hh_type;



        int hh_len;
        int (*hh_output)(struct sk_buff *skb);
        rwlock_t hh_lock;







        unsigned long hh_data[(((32)+(16 -1))&~(16 - 1)) / sizeof(long)];
};






enum netdev_state_t
{
        __LINK_STATE_XOFF=0,
        __LINK_STATE_START,
        __LINK_STATE_PRESENT,
        __LINK_STATE_SCHED,
        __LINK_STATE_NOCARRIER,
        __LINK_STATE_RX_SCHED
};






struct netdev_boot_setup {
        char name[16];
        struct ifmap map;
};
# 248 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h"
struct net_device
{






        char name[16];





        unsigned long rmem_end;
        unsigned long rmem_start;
        unsigned long mem_end;
        unsigned long mem_start;
        unsigned long base_addr;
        unsigned int irq;






        unsigned char if_port;
        unsigned char dma;

        unsigned long state;

        struct net_device *next;


        int (*init)(struct net_device *dev);



        struct net_device *next_sched;


        int ifindex;
        int iflink;


        struct net_device_stats* (*get_stats)(struct net_device *dev);
        struct iw_statistics* (*get_wireless_stats)(struct net_device *dev);



        struct iw_handler_def * wireless_handlers;

        struct ethtool_ops *ethtool_ops;
# 309 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h"
        unsigned long trans_start;
        unsigned long last_rx;

        unsigned short flags;
        unsigned short gflags;
        unsigned short priv_flags;
        unsigned short unused_alignment_fixer;



        unsigned mtu;
        unsigned short type;
        unsigned short hard_header_len;
        void *priv;

        struct net_device *master;




        unsigned char broadcast[8];
        unsigned char dev_addr[8];
        unsigned char addr_len;

        struct dev_mc_list *mc_list;
        int mc_count;
        int promiscuity;
        int allmulti;

        int watchdog_timeo;
        struct timer_list watchdog_timer;



        void *atalk_ptr;
        void *ip_ptr;
        void *dn_ptr;
        void *ip6_ptr;
        void *ec_ptr;

        struct list_head poll_list;
        int quota;
        int weight;

        struct Qdisc *qdisc;
        struct Qdisc *qdisc_sleeping;
        struct Qdisc *qdisc_ingress;
        struct list_head qdisc_list;
        unsigned long tx_queue_len;


        spinlock_t xmit_lock;



        int xmit_lock_owner;

        spinlock_t queue_lock;

        atomic_t refcnt;

        int deadbeaf;


        int features;
# 387 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h"
        void (*uninit)(struct net_device *dev);

        void (*destructor)(struct net_device *dev);


        int (*open)(struct net_device *dev);
        int (*stop)(struct net_device *dev);
        int (*hard_start_xmit) (struct sk_buff *skb,
                                                    struct net_device *dev);

        int (*poll) (struct net_device *dev, int *quota);
        int (*hard_header) (struct sk_buff *skb,
                                                struct net_device *dev,
                                                unsigned short type,
                                                void *daddr,
                                                void *saddr,
                                                unsigned len);
        int (*rebuild_header)(struct sk_buff *skb);

        void (*set_multicast_list)(struct net_device *dev);

        int (*set_mac_address)(struct net_device *dev,
                                                   void *addr);

        int (*do_ioctl)(struct net_device *dev,
                                            struct ifreq *ifr, int cmd);

        int (*set_config)(struct net_device *dev,
                                              struct ifmap *map);

        int (*hard_header_cache)(struct neighbour *neigh,
                                                     struct hh_cache *hh);
        void (*header_cache_update)(struct hh_cache *hh,
                                                       struct net_device *dev,
                                                       unsigned char * haddr);

        int (*change_mtu)(struct net_device *dev, int new_mtu);


        void (*tx_timeout) (struct net_device *dev);

        void (*vlan_rx_register)(struct net_device *dev,
                                                    struct vlan_group *grp);
        void (*vlan_rx_add_vid)(struct net_device *dev,
                                                   unsigned short vid);
        void (*vlan_rx_kill_vid)(struct net_device *dev,
                                                    unsigned short vid);

        int (*hard_header_parse)(struct sk_buff *skb,
                                                     unsigned char *haddr);
        int (*neigh_setup)(struct net_device *dev, struct neigh_parms *);
        int (*accept_fastpath)(struct net_device *, struct dst_entry*);


        struct module *owner;


        struct net_bridge_port *br_port;
# 456 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h"
};




struct packet_type
{
        unsigned short type;
        struct net_device *dev;
        int (*func) (struct sk_buff *, struct net_device *,
                                         struct packet_type *);
        void *data;
        struct packet_type *next;
};

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void *netdev_priv(struct net_device *dev)
{
        return dev->priv;
}

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h"
typedef void irqreturn_t;




struct irqaction {
        void (*handler)(int, void *, struct pt_regs *);
        unsigned long flags;
        unsigned long mask;
        const char *name;
        void *dev_id;
        struct irqaction *next;
};





enum {
        TIMER_BH = 0,
        TQUEUE_BH,
        DIGI_BH,
        SERIAL_BH,
        RISCOM8_BH,
        SPECIALIX_BH,
        AURORA_BH,
        ESP_BH,
        SCSI_BH,
        IMMEDIATE_BH,
        CYCLADES_BH,
        CM206_BH,
        JS_BH,
        MACSERIAL_BH,
        ISICOM_BH
};

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/hardirq.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/hardirq.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/irq.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/irq.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/irq.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/irq.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/arch.h" 1
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/arch.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/types.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/types.h"
typedef unsigned long cpuid_t;
typedef unsigned long cnodemask_t;
typedef signed short nasid_t;
typedef signed short cnodeid_t;
typedef signed char partid_t;
typedef signed short moduleid_t;
typedef signed short cmoduleid_t;
typedef unsigned char clusterid_t;
typedef unsigned long pfn_t;

typedef dev_t vertex_hdl_t;
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/arch.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/sn0/arch.h" 1
# 20 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/arch.h" 2





typedef u64 hubreg_t;
typedef u64 nic_t;
# 55 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/arch.h"
extern nasid_t get_nasid(void);
extern cnodeid_t get_cpu_cnode(cpuid_t);
extern int get_cpu_slice(cpuid_t);






extern cnodeid_t nasid_to_compact_node[256];
extern nasid_t compact_to_nasid_node[64];
# 79 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/arch.h"
extern cnodeid_t nasid_to_compact_node[256];
extern nasid_t compact_to_nasid_node[64];
extern cnodeid_t cpuid_to_compact_node[128];
# 103 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sn/arch.h"
extern int node_getlastslot(cnodeid_t);
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/irq.h" 2
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/irq.h"
extern int node_level_to_irq[64][64];
# 38 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/irq.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int irq_cannonicalize(int irq)
{
        return ((irq == 2) ? 9 : irq);
}




extern void disable_irq(unsigned int);
extern void disable_irq_nosync(unsigned int);
extern void enable_irq(unsigned int);

struct pt_regs;
extern unsigned int do_IRQ(int irq, struct pt_regs *regs);


extern void (*irq_setup)(void);

extern void init_generic_irq(void);
# 20 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/irq.h" 2
# 39 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/irq.h"
struct hw_interrupt_type {
        const char * typename;
        unsigned int (*startup)(unsigned int irq);
        void (*shutdown)(unsigned int irq);
        void (*enable)(unsigned int irq);
        void (*disable)(unsigned int irq);
        void (*ack)(unsigned int irq);
        void (*end)(unsigned int irq);
        void (*set_affinity)(unsigned int irq, unsigned long mask);
};

typedef struct hw_interrupt_type hw_irq_controller;
# 59 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/irq.h"
typedef struct {
        unsigned int status;
        hw_irq_controller *handler;
        struct irqaction *action;
        unsigned int depth;
        spinlock_t lock;
} __attribute__((__aligned__(32))) irq_desc_t;

extern irq_desc_t irq_desc [256];

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/hw_irq.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/hw_irq.h"
extern atomic_t irq_err_count;


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
{
}
# 70 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/irq.h" 2

extern int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
extern int setup_irq(unsigned int , struct irqaction * );

extern hw_irq_controller no_irq_type;
extern void no_action(int cpl, void *dev_id, struct pt_regs *regs);
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/hardirq.h" 2

typedef struct {
        unsigned int __softirq_pending;
        unsigned int __local_irq_count;
        unsigned int __local_bh_count;
        unsigned int __syscall_count;
        struct task_struct * __ksoftirqd_task;
} __attribute__((__aligned__(32))) irq_cpustat_t;

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/irq_cpustat.h" 1
# 20 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/irq_cpustat.h"
extern irq_cpustat_t irq_stat[];
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/hardirq.h" 2
# 53 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/softirq.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/softirq.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void cpu_bh_disable(int cpu)
{
        (irq_stat[((void)((cpu)), 0)].__local_bh_count)++;
        __asm__ __volatile__("": : :"memory");
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __cpu_bh_enable(int cpu)
{
        __asm__ __volatile__("": : :"memory");
        (irq_stat[((void)((cpu)), 0)].__local_bh_count)--;
}
# 54 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h" 2
# 63 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h"
enum
{
        HI_SOFTIRQ=0,
        NET_TX_SOFTIRQ,
        NET_RX_SOFTIRQ,
        TASKLET_SOFTIRQ
};





struct softirq_action
{
        void (*action)(struct softirq_action *);
        void *data;
};

 void do_softirq(void);
extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
extern void softirq_init(void);

extern void cpu_raise_softirq(unsigned int cpu, unsigned int nr);
extern void raise_softirq(unsigned int nr);
# 110 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h"
struct tasklet_struct
{
        struct tasklet_struct *next;
        unsigned long state;
        atomic_t count;
        void (*func)(unsigned long);
        unsigned long data;
};
# 126 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h"
enum
{
        TASKLET_STATE_SCHED,
        TASKLET_STATE_RUN
};

struct tasklet_head
{
        struct tasklet_struct *list;
} __attribute__ ((__aligned__(32)));

extern struct tasklet_head tasklet_vec[1];
extern struct tasklet_head tasklet_hi_vec[1];
# 162 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h"
extern void __tasklet_schedule(struct tasklet_struct *t);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tasklet_schedule(struct tasklet_struct *t)
{
        if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
                __tasklet_schedule(t);
}

extern void __tasklet_hi_schedule(struct tasklet_struct *t);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tasklet_hi_schedule(struct tasklet_struct *t)
{
        if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
                __tasklet_hi_schedule(t);
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tasklet_disable_nosync(struct tasklet_struct *t)
{
        atomic_add(1,(&t->count));
        __asm__ __volatile__("": : :"memory");
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tasklet_disable(struct tasklet_struct *t)
{
        tasklet_disable_nosync(t);
        do { } while (0);
        __asm__ __volatile__("": : :"memory");
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tasklet_enable(struct tasklet_struct *t)
{
        __asm__ __volatile__("": : :"memory");
        atomic_sub(1,(&t->count));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void tasklet_hi_enable(struct tasklet_struct *t)
{
        __asm__ __volatile__("": : :"memory");
        atomic_sub(1,(&t->count));
}

extern void tasklet_kill(struct tasklet_struct *t);
extern void tasklet_init(struct tasklet_struct *t,
                         void (*func)(unsigned long), unsigned long data);
# 229 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h"
extern struct tasklet_struct bh_task_vec[];


extern spinlock_t global_bh_lock;

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mark_bh(int nr)
{
        tasklet_hi_schedule(bh_task_vec+nr);
}

extern void init_bh(int nr, void (*routine)(void));
extern void remove_bh(int nr);
# 270 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/interrupt.h"
extern unsigned long probe_irq_on(void);
extern int probe_irq_off(unsigned long);
extern unsigned int probe_irq_mask(unsigned long);
# 477 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/notifier.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/notifier.h"
struct notifier_block
{
        int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
        struct notifier_block *next;
        int priority;
};




extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
# 478 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h" 2

extern struct net_device loopback_dev;
extern struct net_device *dev_base;
extern rwlock_t dev_base_lock;

extern int netdev_boot_setup_add(char *name, struct ifmap *map);
extern int netdev_boot_setup_check(struct net_device *dev);
extern struct net_device *dev_getbyhwaddr(unsigned short type, char *hwaddr);
extern void dev_add_pack(struct packet_type *pt);
extern void dev_remove_pack(struct packet_type *pt);
extern int dev_get(const char *name);
extern struct net_device *dev_get_by_flags(unsigned short flags,
                                        unsigned short mask);
extern struct net_device *__dev_get_by_flags(unsigned short flags,
                                        unsigned short mask);
extern struct net_device *dev_get_by_name(const char *name);
extern struct net_device *__dev_get_by_name(const char *name);
extern struct net_device *dev_alloc(const char *name, int *err);
extern int dev_alloc_name(struct net_device *dev, const char *name);
extern int dev_open(struct net_device *dev);
extern int dev_close(struct net_device *dev);
extern int dev_queue_xmit(struct sk_buff *skb);
extern int register_netdevice(struct net_device *dev);
extern int unregister_netdevice(struct net_device *dev);
extern int register_netdevice_notifier(struct notifier_block *nb);
extern int unregister_netdevice_notifier(struct notifier_block *nb);
extern int dev_new_index(void);
extern struct net_device *dev_get_by_index(int ifindex);
extern struct net_device *__dev_get_by_index(int ifindex);
extern int dev_restart(struct net_device *dev);

typedef int gifconf_func_t(struct net_device * dev, char * bufptr, int len);
extern int register_gifconf(unsigned int family, gifconf_func_t * gifconf);
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int unregister_gifconf(unsigned int family)
{
        return register_gifconf(family, 0);
}






struct softnet_data
{
        int throttle;
        int cng_level;
        int avg_blog;
        struct sk_buff_head input_pkt_queue;
        struct list_head poll_list;
        struct net_device *output_queue;
        struct sk_buff *completion_queue;

        struct net_device blog_dev;
} __attribute__((__aligned__(32)));


extern struct softnet_data softnet_data[1];



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __netif_schedule(struct net_device *dev)
{
        if (!test_and_set_bit(__LINK_STATE_SCHED, &dev->state)) {
                unsigned long flags;
                int cpu = 0;

                do { flags = rthal.getflags_and_cli(); } while(0);;
                dev->next_sched = softnet_data[cpu].output_queue;
                softnet_data[cpu].output_queue = dev;
                cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
                do { rthal.setflags(flags); } while(0);;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_schedule(struct net_device *dev)
{
        if (!test_bit(__LINK_STATE_XOFF, &dev->state))
                __netif_schedule(dev);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_start_queue(struct net_device *dev)
{
        clear_bit(__LINK_STATE_XOFF, &dev->state);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_wake_queue(struct net_device *dev)
{
        if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))
                __netif_schedule(dev);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_stop_queue(struct net_device *dev)
{
        set_bit(__LINK_STATE_XOFF, &dev->state);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int netif_queue_stopped(struct net_device *dev)
{
        return test_bit(__LINK_STATE_XOFF, &dev->state);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int netif_running(struct net_device *dev)
{
        return test_bit(__LINK_STATE_START, &dev->state);
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void dev_kfree_skb_irq(struct sk_buff *skb)
{
        if ((atomic_sub_return(1, (&skb->users)) == 0)) {
                int cpu =0;
                unsigned long flags;

                do { flags = rthal.getflags_and_cli(); } while(0);;
                skb->next = softnet_data[cpu].completion_queue;
                softnet_data[cpu].completion_queue = skb;
                cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
                do { rthal.setflags(flags); } while(0);;
        }
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void dev_kfree_skb_any(struct sk_buff *skb)
{
        if (((irq_stat[((void)((0)), 0)].__local_irq_count) != 0))
                dev_kfree_skb_irq(skb);
        else
                kfree_skb(skb);
}


extern int netif_rx(struct sk_buff *skb);

extern int netif_receive_skb(struct sk_buff *skb);
extern int dev_ioctl(unsigned int cmd, void *);
extern int dev_ethtool(struct ifreq *);
extern int dev_change_flags(struct net_device *, unsigned);
extern void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev);

extern void dev_init(void);

extern int netdev_nit;




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int netif_rx_ni(struct sk_buff *skb)
{
       int err = netif_rx(skb);
       if ((irq_stat[((void)((0)), 0)].__softirq_pending))
               do_softirq();
       return err;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void dev_init_buffers(struct net_device *dev)
{

}

extern int netdev_finish_unregister(struct net_device *dev);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void dev_put(struct net_device *dev)
{
        if ((atomic_sub_return(1, (&dev->refcnt)) == 0))
                netdev_finish_unregister(dev);
}
# 659 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int netif_carrier_ok(struct net_device *dev)
{
        return !test_bit(__LINK_STATE_NOCARRIER, &dev->state);
}

extern void __netdev_watchdog_up(struct net_device *dev);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_carrier_on(struct net_device *dev)
{
        clear_bit(__LINK_STATE_NOCARRIER, &dev->state);
        if (netif_running(dev))
                __netdev_watchdog_up(dev);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_carrier_off(struct net_device *dev)
{
        set_bit(__LINK_STATE_NOCARRIER, &dev->state);
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int netif_device_present(struct net_device *dev)
{
        return test_bit(__LINK_STATE_PRESENT, &dev->state);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_device_detach(struct net_device *dev)
{
        if (test_and_clear_bit(__LINK_STATE_PRESENT, &dev->state) &&
            netif_running(dev)) {
                netif_stop_queue(dev);
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_device_attach(struct net_device *dev)
{
        if (!test_and_set_bit(__LINK_STATE_PRESENT, &dev->state) &&
            netif_running(dev)) {
                netif_wake_queue(dev);
                __netdev_watchdog_up(dev);
        }
}






enum {
        NETIF_MSG_DRV = 0x0001,
        NETIF_MSG_PROBE = 0x0002,
        NETIF_MSG_LINK = 0x0004,
        NETIF_MSG_TIMER = 0x0008,
        NETIF_MSG_IFDOWN = 0x0010,
        NETIF_MSG_IFUP = 0x0020,
        NETIF_MSG_RX_ERR = 0x0040,
        NETIF_MSG_TX_ERR = 0x0080,
        NETIF_MSG_TX_QUEUED = 0x0100,
        NETIF_MSG_INTR = 0x0200,
        NETIF_MSG_TX_DONE = 0x0400,
        NETIF_MSG_RX_STATUS = 0x0800,
        NETIF_MSG_PKTDATA = 0x1000,
        NETIF_MSG_HW = 0x2000,
        NETIF_MSG_WOL = 0x4000,
};
# 740 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/netdevice.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
{

        if (debug_value < 0 || debug_value >= (sizeof(u32) * 8))
                return default_msg_enable_bits;
        if (debug_value == 0)
                return 0;

        return (1 << debug_value) - 1;
}



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int netif_rx_schedule_prep(struct net_device *dev)
{
        return netif_running(dev) &&
                !test_and_set_bit(__LINK_STATE_RX_SCHED, &dev->state);
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __netif_rx_schedule(struct net_device *dev)
{
        unsigned long flags;
        int cpu = 0;

        do { flags = rthal.getflags_and_cli(); } while(0);;
        atomic_add(1,(&(dev)->refcnt));
        list_add_tail(&dev->poll_list, &softnet_data[cpu].poll_list);
        if (dev->quota < 0)
                dev->quota += dev->weight;
        else
                dev->quota = dev->weight;
        do { (irq_stat[((void)((cpu)), 0)].__softirq_pending) |= 1UL << (NET_RX_SOFTIRQ); } while (0);
        do { rthal.setflags(flags); } while(0);;
}



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_rx_schedule(struct net_device *dev)
{
        if (netif_rx_schedule_prep(dev))
                __netif_rx_schedule(dev);
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int netif_rx_reschedule(struct net_device *dev, int undo)
{
        if (netif_rx_schedule_prep(dev)) {
                unsigned long flags;
                int cpu = 0;

                dev->quota += undo;

                do { flags = rthal.getflags_and_cli(); } while(0);;
                list_add_tail(&dev->poll_list, &softnet_data[cpu].poll_list);
                do { (irq_stat[((void)((cpu)), 0)].__softirq_pending) |= 1UL << (NET_RX_SOFTIRQ); } while (0);
                do { rthal.setflags(flags); } while(0);;
                return 1;
        }
        return 0;
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_rx_complete(struct net_device *dev)
{
        unsigned long flags;

        do { flags = rthal.getflags_and_cli(); } while(0);;
        if (!test_bit(__LINK_STATE_RX_SCHED, &dev->state)) do { __asm__ __volatile__("break %0" : : "i" (512)); } while (0);
        list_del(&dev->poll_list);
        __asm__ __volatile__("": : :"memory");
        clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
        do { rthal.setflags(flags); } while(0);;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_poll_disable(struct net_device *dev)
{
        while (test_and_set_bit(__LINK_STATE_RX_SCHED, &dev->state)) {

                current->state = 1;
                schedule_timeout(1);
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_poll_enable(struct net_device *dev)
{
        clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __netif_rx_complete(struct net_device *dev)
{
        if (!test_bit(__LINK_STATE_RX_SCHED, &dev->state)) do { __asm__ __volatile__("break %0" : : "i" (512)); } while (0);
        list_del(&dev->poll_list);
        __asm__ __volatile__("": : :"memory");
        clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void netif_tx_disable(struct net_device *dev)
{
        do { cpu_bh_disable(0); (void)(&dev->xmit_lock); } while (0);
        netif_stop_queue(dev);
        do { do { } while(0); do { int cpu; __asm__ __volatile__("": : :"memory"); cpu = 0; if (!--(irq_stat[((void)((cpu)), 0)].__local_bh_count) && (irq_stat[((void)((cpu)), 0)].__softirq_pending)) do_softirq(); } while (0); } while (0);
}



extern void ether_setup(struct net_device *dev);
extern void fddi_setup(struct net_device *dev);
extern void tr_setup(struct net_device *dev);
extern void fc_setup(struct net_device *dev);
extern void fc_freedev(struct net_device *dev);

extern struct net_device *alloc_netdev(int sizeof_priv, const char *name,
                                       void (*setup)(struct net_device *));
extern int register_netdev(struct net_device *dev);
extern void unregister_netdev(struct net_device *dev);

extern void dev_mc_upload(struct net_device *dev);
extern int dev_mc_delete(struct net_device *dev, void *addr, int alen, int all);
extern int dev_mc_add(struct net_device *dev, void *addr, int alen, int newonly);
extern void dev_mc_discard(struct net_device *dev);
extern void dev_set_promiscuity(struct net_device *dev, int inc);
extern void dev_set_allmulti(struct net_device *dev, int inc);
extern void netdev_state_change(struct net_device *dev);

extern void dev_load(const char *name);
extern void dev_mcast_init(void);
extern int netdev_register_fc(struct net_device *dev, void (*stimul)(struct net_device *dev));
extern void netdev_unregister_fc(int bit);
extern int netdev_max_backlog;
extern int weight_p;
extern unsigned long netdev_fc_xoff;
extern atomic_t netdev_dropping;
extern int netdev_set_master(struct net_device *dev, struct net_device *master);
extern struct sk_buff * skb_checksum_help(struct sk_buff *skb);






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void free_netdev(struct net_device *dev)
{
        kfree(dev);
}
# 6 "drivers/debug26/lib/main.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/init.h" 1
# 49 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/init.h"
typedef int (*initcall_t)(void);
typedef void (*exitcall_t)(void);

extern initcall_t __initcall_start, __initcall_end;
# 62 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/init.h"
struct kernel_param {
        const char *str;
        int (*setup_func)(char *);
};

extern struct kernel_param __setup_start, __setup_end;
# 7 "drivers/debug26/lib/main.c" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h" 1
# 130 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int verify_area(int type, const void * addr, unsigned long size)
{
        return __builtin_expect(((((signed long)(((current->thread.current_ds).seg) & (((unsigned long)(addr)) | (((unsigned long)(addr)) + ((size))) | ((__builtin_constant_p((size)) && (signed long) ((size)) > 0) ? 0 : ((size)))))) == 0)),1) ? 0 : -14;
}
# 219 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
struct __large_struct { unsigned long buf[100]; };
# 310 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
extern void __get_user_unknown(void);
# 395 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
extern void __put_user_unknown(void);
# 412 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
extern size_t __copy_user(void *__to, const void *__from, size_t __n);
# 585 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) __kernel_size_t
__clear_user(void *addr, __kernel_size_t size)
{
        __kernel_size_t res;

        __asm__ __volatile__(
                "move\t$4, %1\n\t"
                "move\t$5, $0\n\t"
                "move\t$6, %2\n\t"
                "jal\t" "__bzero" "\n\t"
                "move\t%0, $6"
                : "=r" (res)
                : "r" (addr), "r" (size)
                : "$4", "$5", "$6", "$12", "$13", "$31");

        return res;
}
# 633 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long
__strncpy_from_user(char *__to, const char *__from, long __len)
{
        long res;

        __asm__ __volatile__(
                "move\t$4, %1\n\t"
                "move\t$5, %2\n\t"
                "move\t$6, %3\n\t"
                "jal\t" "__strncpy_from_user_nocheck_asm" "\n\t"
                "move\t%0, $2"
                : "=r" (res)
                : "r" (__to), "r" (__from), "r" (__len)
                : "$2", "$3", "$4", "$5", "$6", "$12", "$31", "memory");

        return res;
}
# 669 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long
strncpy_from_user(char *__to, const char *__from, long __len)
{
        long res;

        __asm__ __volatile__(
                "move\t$4, %1\n\t"
                "move\t$5, %2\n\t"
                "move\t$6, %3\n\t"
                "jal\t" "__strncpy_from_user_asm" "\n\t"
                "move\t%0, $2"
                : "=r" (res)
                : "r" (__to), "r" (__from), "r" (__len)
                : "$2", "$3", "$4", "$5", "$6", "$12", "$31", "memory");

        return res;
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long __strlen_user(const char *s)
{
        long res;

        __asm__ __volatile__(
                "move\t$4, %1\n\t"
                "jal\t" "__strlen_user_nocheck_asm" "\n\t"
                "move\t%0, $2"
                : "=r" (res)
                : "r" (s)
                : "$2", "$4", "$12", "$31");

        return res;
}
# 717 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long strlen_user(const char *s)
{
        long res;

        __asm__ __volatile__(
                "move\t$4, %1\n\t"
                "jal\t" "__strlen_user_asm" "\n\t"
                "move\t%0, $2"
                : "=r" (res)
                : "r" (s)
                : "$2", "$4", "$12", "$31");

        return res;
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long __strnlen_user(const char *s, long n)
{
        long res;

        __asm__ __volatile__(
                "move\t$4, %1\n\t"
                "move\t$5, %2\n\t"
                "jal\t" "__strnlen_user_nocheck_asm" "\n\t"
                "move\t%0, $2"
                : "=r" (res)
                : "r" (s), "r" (n)
                : "$2", "$4", "$5", "$12", "$31");

        return res;
}
# 763 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/uaccess.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long strnlen_user(const char *s, long n)
{
        long res;

        __asm__ __volatile__(
                "move\t$4, %1\n\t"
                "move\t$5, %2\n\t"
                "jal\t" "__strnlen_user_asm" "\n\t"
                "move\t%0, $2"
                : "=r" (res)
                : "r" (s), "r" (n)
                : "$2", "$4", "$5", "$12", "$31");

        return res;
}

struct exception_table_entry
{
        unsigned long insn;
        unsigned long nextinsn;
};


extern unsigned long search_exception_table(unsigned long addr);
# 9 "drivers/debug26/lib/main.c" 2


static int errno=0;

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/proc_fs.h" 1
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/proc_fs.h"
enum {
        PROC_ROOT_INO = 1,
};
# 47 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/proc_fs.h"
typedef int (read_proc_t)(char *page, char **start, off_t off,
                          int count, int *eof, void *data);
typedef int (write_proc_t)(struct file *file, const char *buffer,
                           unsigned long count, void *data);
typedef int (get_info_t)(char *, char **, off_t, int);

struct proc_dir_entry {
        unsigned short low_ino;
        unsigned short namelen;
        const char *name;
        mode_t mode;
        nlink_t nlink;
        uid_t uid;
        gid_t gid;
        unsigned long size;
        struct inode_operations * proc_iops;
        struct file_operations * proc_fops;
        get_info_t *get_info;
        struct module *owner;
        struct proc_dir_entry *next, *parent, *subdir;
        void *data;
        read_proc_t *read_proc;
        write_proc_t *write_proc;
        atomic_t count;
        int deleted;
        kdev_t rdev;
        void *set;
};





extern struct proc_dir_entry proc_root;
extern struct proc_dir_entry *proc_root_fs;
extern struct proc_dir_entry *proc_net;
extern struct proc_dir_entry *proc_net_stat;
extern struct proc_dir_entry *proc_bus;
extern struct proc_dir_entry *proc_root_driver;
extern struct proc_dir_entry *proc_root_kcore;

extern void proc_root_init(void);
extern void proc_misc_init(void);

struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry);
void proc_pid_delete_inode(struct inode *inode);
int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir);

extern struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
                                                struct proc_dir_entry *parent);
extern void remove_proc_entry(const char *name, struct proc_dir_entry *parent);

extern struct vfsmount *proc_mnt;
extern struct super_block *proc_read_super(struct super_block *,void *,int);
extern struct inode * proc_get_inode(struct super_block *, int, struct proc_dir_entry *);

extern int proc_match(int, const char *,struct proc_dir_entry *);
# 112 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/proc_fs.h"
extern int proc_readdir(struct file *, void *, filldir_t);
extern struct dentry *proc_lookup(struct inode *, struct dentry *);

extern struct file_operations proc_kcore_operations;
extern struct file_operations proc_kmsg_operations;
extern struct file_operations ppc_htab_operations;




struct tty_driver;
extern void proc_tty_init(void);
extern void proc_tty_register_driver(struct tty_driver *driver);
extern void proc_tty_unregister_driver(struct tty_driver *driver);




extern void proc_device_tree_init(void);




extern void proc_rtas_init(void);




extern void proc_ppc64_init(void);
extern void iSeries_proc_create(void);

extern struct proc_dir_entry *proc_symlink(const char *,
                struct proc_dir_entry *, const char *);
extern struct proc_dir_entry *proc_mknod(const char *,mode_t,
                struct proc_dir_entry *,kdev_t);
extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
extern struct proc_dir_entry *proc_mkdir_mode(const char *name, mode_t mode,
                        struct proc_dir_entry *parent);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct proc_dir_entry *create_proc_read_entry(const char *name,
        mode_t mode, struct proc_dir_entry *base,
        read_proc_t *read_proc, void * data)
{
        struct proc_dir_entry *res=create_proc_entry(name,mode,base);
        if (res) {
                res->read_proc=read_proc;
                res->data=data;
        }
        return res;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct proc_dir_entry *create_proc_info_entry(const char *name,
        mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
{
        struct proc_dir_entry *res=create_proc_entry(name,mode,base);
        if (res) res->get_info=get_info;
        return res;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct proc_dir_entry *proc_net_create(const char *name,
        mode_t mode, get_info_t *get_info)
{
        return create_proc_info_entry(name,mode,proc_net,get_info);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct proc_dir_entry *proc_net_fops_create(const char *name,
        mode_t mode, struct file_operations *fops)
{
        struct proc_dir_entry *res = create_proc_entry(name, mode, proc_net);

        if (res)
                res->proc_fops = fops;
        return res;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void proc_net_remove(const char *name)
{
        remove_proc_entry(name,proc_net);
}
# 226 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/proc_fs.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct proc_dir_entry *PDE(const struct inode *inode)
{
        return (struct proc_dir_entry *)inode->u.generic_ip;
}
# 14 "drivers/debug26/lib/main.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/file.h" 1







extern void fput(struct file *);
extern struct file * fget(unsigned int fd);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int get_close_on_exec(unsigned int fd)
{
        struct files_struct *files = current->files;
        int res;
        (void)(&files->file_lock);
        res = __FD_ISSET(fd,files->close_on_exec);
        (void)(&files->file_lock);
        return res;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void set_close_on_exec(unsigned int fd, int flag)
{
        struct files_struct *files = current->files;
        (void)(&files->file_lock);
        if (flag)
                __FD_SET(fd,files->close_on_exec);
        else
                __FD_CLR(fd,files->close_on_exec);
        do { } while(0);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct file * fcheck_files(struct files_struct *files, unsigned int fd)
{
        struct file * file = ((void *)0);

        if (fd < files->max_fds)
                file = files->fd[fd];
        return file;
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct file * fcheck(unsigned int fd)
{
        struct file * file = ((void *)0);
        struct files_struct *files = current->files;

        if (fd < files->max_fds)
                file = files->fd[fd];
        return file;
}

extern void put_filp(struct file *);

extern int get_unused_fd(void);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void __put_unused_fd(struct files_struct *files, unsigned int fd)
{
        __FD_CLR(fd,files->open_fds);
        if (fd < files->next_fd)
                files->next_fd = fd;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void put_unused_fd(unsigned int fd)
{
        struct files_struct *files = current->files;

        (void)(&files->file_lock);
        __put_unused_fd(files, fd);
        do { } while(0);
}

void fd_install(unsigned int fd, struct file * file);
void put_files_struct(struct files_struct *fs);
# 15 "drivers/debug26/lib/main.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm-mips/mipsregs.h" 1
# 16 "drivers/debug26/lib/main.c" 2





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/unistd.h" 1
# 22 "drivers/debug26/lib/main.c" 2
# 288 "drivers/debug26/lib/main.c"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pause(void) { register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %2\t\t\t# " "pause" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "i" ((5000 + 33)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (int) __v0; errno = __v0; return (int) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int sync(void) { register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %2\t\t\t# " "sync" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "i" ((5000 + 157)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (int) __v0; errno = __v0; return (int) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pid_t setsid(void) { register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %2\t\t\t# " "setsid" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "i" ((5000 + 110)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (pid_t) __v0; errno = __v0; return (pid_t) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int write(int fd, const char * buf, off_t count) { register unsigned long __a0 asm("$4") = (unsigned long) fd; register unsigned long __a1 asm("$5") = (unsigned long) buf; register unsigned long __a2 asm("$6") = (unsigned long) count; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %5\t\t\t# " "write" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "i" ((5000 + 1)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (int) __v0; errno = __v0; return (int) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int read(int fd, char * buf, off_t count) { register unsigned long __a0 asm("$4") = (unsigned long) fd; register unsigned long __a1 asm("$5") = (unsigned long) buf; register unsigned long __a2 asm("$6") = (unsigned long) count; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %5\t\t\t# " "read" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "i" ((5000 + 0)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (int) __v0; errno = __v0; return (int) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) off_t lseek(int fd, off_t offset, int count) { register unsigned long __a0 asm("$4") = (unsigned long) fd; register unsigned long __a1 asm("$5") = (unsigned long) offset; register unsigned long __a2 asm("$6") = (unsigned long) count; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %5\t\t\t# " "lseek" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "i" ((5000 + 8)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (off_t) __v0; errno = __v0; return (off_t) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int dup(int fd) { register unsigned long __a0 asm("$4") = (unsigned long) fd; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %3\t\t\t# " "dup" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "i" ((5000 + 31)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (int) __v0; errno = __v0; return (int) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int execve(const char * file, char ** argv, char ** envp) { register unsigned long __a0 asm("$4") = (unsigned long) file; register unsigned long __a1 asm("$5") = (unsigned long) argv; register unsigned long __a2 asm("$6") = (unsigned long) envp; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %5\t\t\t# " "execve" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "i" ((5000 + 57)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (int) __v0; errno = __v0; return (int) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int open(const char * file, int flag, int mode) { register unsigned long __a0 asm("$4") = (unsigned long) file; register unsigned long __a1 asm("$5") = (unsigned long) flag; register unsigned long __a2 asm("$6") = (unsigned long) mode; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %5\t\t\t# " "open" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "i" ((5000 + 2)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (int) __v0; errno = __v0; return (int) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int close(int fd) { register unsigned long __a0 asm("$4") = (unsigned long) fd; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %3\t\t\t# " "close" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "i" ((5000 + 3)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (int) __v0; errno = __v0; return (int) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void exit(int exitcode) { register unsigned long __a0 asm("$4") = (unsigned long) exitcode; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %3\t\t\t# " "exit" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "i" ((5000 + 58)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (void) __v0; errno = __v0; return (void) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int delete_module(const char * name) { register unsigned long __a0 asm("$4") = (unsigned long) name; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %3\t\t\t# " "delete_module" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "i" ((5000 + 169)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (int) __v0; errno = __v0; return (int) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long mknod(const char * filename, int mode, dev_t dev) { register unsigned long __a0 asm("$4") = (unsigned long) filename; register unsigned long __a1 asm("$5") = (unsigned long) mode; register unsigned long __a2 asm("$6") = (unsigned long) dev; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %5\t\t\t# " "mknod" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "i" ((5000 + 131)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long mount (char * dev_name,char * dir_name,char * type,unsigned long flags,void * data) { register unsigned long __a0 asm("$4") = (unsigned long) dev_name; register unsigned long __a1 asm("$5") = (unsigned long) dir_name; register unsigned long __a2 asm("$6") = (unsigned long) type; register unsigned long __a3 asm("$7") = (unsigned long) flags; register unsigned long __a4 asm("$8") = (unsigned long) data; unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %6\t\t\t# " "mount" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "+r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "r" (__a4), "i" ((5000 + 160)) : "$2", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; };
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long ioctl(unsigned int fd, unsigned int cmd, unsigned long arg) { register unsigned long __a0 asm("$4") = (unsigned long) fd; register unsigned long __a1 asm("$5") = (unsigned long) cmd; register unsigned long __a2 asm("$6") = (unsigned long) arg; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %5\t\t\t# " "ioctl" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "i" ((5000 + 15)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; };
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long chroot(const char * filename) { register unsigned long __a0 asm("$4") = (unsigned long) filename; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %3\t\t\t# " "chroot" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "i" ((5000 + 156)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; };
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long mkdir(const char * pathname, int mode) { register unsigned long __a0 asm("$4") = (unsigned long) pathname; register unsigned long __a1 asm("$5") = (unsigned long) mode; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %4\t\t\t# " "mkdir" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "i" ((5000 + 81)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; }

static int syscall_addrtype=0;

struct __myenv_s;
static char *getenv(char *name);
static void do_cmd(char *p);

# 1 "drivers/debug26/lib/malloc.c" 1
# 38 "drivers/debug26/lib/malloc.c"
static char Malloc_Memory[0x1000];
static char *Malloc_MemTop=Malloc_Memory;
static char *Malloc_MemBot=Malloc_Memory;
static char *sbrk(int size)
{
char *p;
if(Malloc_MemTop+size>=&Malloc_Memory[0x1000])
p=0;
else
{
p=Malloc_MemTop;
Malloc_MemTop +=size;
}
return p;
}

typedef double ALIGN;

static void nr_free(void *ap);

union header {
    struct {
        union header *ptr;
        unsigned size;
    } s;
    ALIGN x;
};

typedef union header HEADER;

static HEADER base;
static HEADER *allocp;
# 78 "drivers/debug26/lib/malloc.c"
static HEADER *morecore (unsigned nbyte);

static void *
nr_malloc(size_t nbytes)
{
        HEADER *p, *q;
        unsigned nunits;

        nunits = (nbytes + sizeof (HEADER) - 1) / sizeof (HEADER) + 1;
        if ((q = allocp) == ((void *)0)) {
                base.s.ptr = allocp = q = &base;
                base.s.size = 0;
        }
        for (p = q->s.ptr;; q = p, p = p->s.ptr) {
                if (p->s.size >= nunits) {
                        if (p->s.size == nunits)
                                q->s.ptr = p->s.ptr;
                        else {
                                p->s.size -= nunits;
                                p += p->s.size;
                                p->s.size = nunits;
                        }
                        allocp = q;
                        return ((char *)(p + 1));
                }
                if (p == allocp)
                        if ((p = morecore (nunits)) == ((void *)0))
                                return (((void *)0));
        }
}


static HEADER *
morecore(unsigned nu)
{
        char *cp;
        HEADER *up;
        int rnu;

        rnu = 128 * ((nu + 128 - 1) / 128);
        cp = sbrk(rnu * sizeof (HEADER));
        if (cp == (char *)((void *)0))
                return (((void *)0));
        up = (HEADER *) cp;
        up->s.size = rnu;
        nr_free ((char *)(up + 1));
        return (allocp);
}


void
nr_free(void *ap)
{
        HEADER *p, *q;
        if((char *)ap<Malloc_MemBot||(char *)ap>Malloc_MemTop)return;

        p = (HEADER *) ap - 1;
        for (q = allocp; !(p > q && p < q->s.ptr); q = q->s.ptr)
                if (q >= q->s.ptr && (p > q || p < q->s.ptr))
                        break;
        if (p + p->s.size == q->s.ptr) {
                p->s.size += q->s.ptr->s.size;
                p->s.ptr = q->s.ptr->s.ptr;
        } else
                p->s.ptr = q->s.ptr;
        if (q + q->s.size == p) {
                q->s.size += p->s.size;
                q->s.ptr = p->s.ptr;
        } else
                q->s.ptr = p;
        allocp = q;
}
# 313 "drivers/debug26/lib/main.c" 2
# 1 "drivers/debug26/lib/ctype.h" 1
# 18 "drivers/debug26/lib/ctype.h"
static unsigned char _ctype[];
# 37 "drivers/debug26/lib/ctype.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char __tolower(unsigned char c)
{
        if ((((_ctype[(int)(unsigned char)(c)])&(0x01)) != 0))
                c -= 'A'-'a';
        return c;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned char __toupper(unsigned char c)
{
        if ((((_ctype[(int)(unsigned char)(c)])&(0x02)) != 0))
                c -= 'a'-'A';
        return c;
}
# 314 "drivers/debug26/lib/main.c" 2
# 1 "drivers/debug26/lib/ctype.c" 1
# 9 "drivers/debug26/lib/ctype.c"
static unsigned char _ctype[] = {
0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,
0x08,0x08|0x20,0x08|0x20,0x08|0x20,0x08|0x20,0x08|0x20,0x08,0x08,
0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,
0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,
0x20|0x80,0x10,0x10,0x10,0x10,0x10,0x10,0x10,
0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,
0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x04,
0x04,0x04,0x10,0x10,0x10,0x10,0x10,0x10,
0x10,0x01|0x40,0x01|0x40,0x01|0x40,0x01|0x40,0x01|0x40,0x01|0x40,0x01,
0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,
0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,
0x01,0x01,0x01,0x10,0x10,0x10,0x10,0x10,
0x10,0x02|0x40,0x02|0x40,0x02|0x40,0x02|0x40,0x02|0x40,0x02|0x40,0x02,
0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x10,0x10,0x10,0x10,0x08,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0x20|0x80,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,
0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,0x10,
0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,
0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x10,0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x02,
0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x10,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02};
# 315 "drivers/debug26/lib/main.c" 2

static void sleep(unsigned howlong)
{
        current->state=1;
        schedule_timeout(howlong);
}
static int sleepcmd(int argc,char **argv)
{
        if(argc!=2)return -1;
        sleep(simple_strtol(argv[1],0,0));
        return 0;
}

static int busysleepcmd(int argc,char **argv)
{
        unsigned long cnt0,cnt,t;
        if(argc!=2)return -1;
        t = simple_strtol(argv[1],0,0);
        cnt0 = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$9" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$9" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; });
        while(1)
        {
        cnt = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$9" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$9" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; });
        if((cnt - cnt0) > t) break;
        }
        return 0;
}
# 350 "drivers/debug26/lib/main.c"
static int nr_gets(char *s,int size);
# 360 "drivers/debug26/lib/main.c"
static void chfs(int save)
{
static mm_segment_t old_fs[10];
static int idx=0;
        if(save)
        {
        old_fs[idx++]=(current->thread.current_ds);
        (current->thread.current_ds = (((mm_segment_t) { 0UL })));
        }
        else (current->thread.current_ds = (old_fs[--idx]));
}
# 384 "drivers/debug26/lib/main.c"
int getDebugChar();
static int prom_gets(char *s,int size)
{
int count=0;
while(count<size-1)
{
char c;
 c=getDebugChar();
 if(c=='\r')c='\n';
 s[count++]=c;
 if(c!='\n') putDebugChar(c);
 break;
}
s[count]=0;
        return count;
}
# 421 "drivers/debug26/lib/main.c"
static int nr_fprintf(int fd,char *fmt,...)
{
static char buf[0x200];
mm_segment_t old_fs;
  va_list ap;
  __builtin_stdarg_start((ap),fmt);
  vsprintf(buf,fmt,ap);
  __builtin_va_end(ap);
old_fs=(current->thread.current_ds);
(current->thread.current_ds = (((mm_segment_t) { 0UL })));
write(fd,buf,strlen(buf));
(current->thread.current_ds = (old_fs));
return 0;
}

# 1 "drivers/debug26/lib/cmdparser.c" 1
# 1 "drivers/debug26/lib/argvize.c" 1
# 41 "drivers/debug26/lib/argvize.c"
int
argvize(char *av[], char *s)
{
        char **pav = av, c;
        int ac;

        for (ac = 0; ac < 100; ac++) {

                while (*s && *s <= ' ')
                        s++;

                if (!*s)
                        break;

                c = *s;

                if (c == '\'' || c == '"') {
                        if (pav)
                                *pav++ = ++s;
                        while (*s && *s != c)
                                s++;
                        if (*s)
                                *s++ = 0;
                } else {
                        if (pav)
                                *pav++ = s;
                        while (' ' < *s)
                                s++;
                }

                if (*s)
                        *s++ = 0;
        }
        return (ac);
}
# 2 "drivers/debug26/lib/cmdparser.c" 2


static char *expand (char *);
static char *expand1 (char *);
static char *getenv(char *name);

static int help(int argc,char **argv);

static int quitnow=0;
static int showcmd=0;
static int quit(int argc,char **argv)
{
quitnow=1;
return 0;
}

# 1 "drivers/debug26/lib/cmdparser.h" 1


struct mycmd{
char *name;
int (*func)(int argc,char **argv);
char *usage;
char *note;
};

struct myinit{
int (*func)(void);
};
# 19 "drivers/debug26/lib/cmdparser.c" 2
extern struct myinit __myinit_begin_begin;
extern struct myinit __myinit_begin_end;
extern struct myinit __myinit_end_begin;
extern struct myinit __myinit_end_end;

static void do_initbegin_calls(void)
{
struct myinit *p;

for(p=&__myinit_begin_begin+1;p!=&__myinit_begin_end;p++)
p->func();
}

static void do_initend_calls(void)
{
struct myinit *p;

for(p=&__myinit_begin_begin+1;p!=&__myinit_begin_end;p++)
{p->func();}
}

extern struct mycmd __mycmd_begin;
extern struct mycmd __mycmd_end;
static int help(int argc,char **argv)
{
struct mycmd *pcmd;
char str[20];
int i;
if(argc==1)
{
   for(pcmd=&__mycmd_begin+1,i=0;pcmd!=&__mycmd_end;pcmd++,i++)
        {
        prom_printf("%-10s:%-30s:%s\n",pcmd->name,pcmd->usage,pcmd->note);
        if(i%16==15){prom_printf("press enter to continue...\n");prom_gets(str,20);}
        }
}
else if(argc==2)
{
 for(pcmd=&__mycmd_begin+1;pcmd!=&__mycmd_end;pcmd++)
        if(!strcmp(pcmd->name,argv[1]))
    {
        prom_printf("%-10s:%-30s:%s\n",pcmd->name,pcmd->usage,pcmd->note);
        break;
        }
 if(pcmd==&__mycmd_end)prom_printf("can not find cmd %s\n",argv[1]);
}
else return -1;

return 0;
}
# 80 "drivers/debug26/lib/cmdparser.c"
char *_do_cmd(char *p_in,int need_end);

void do_cmd(char *p)
{
_do_cmd(p,0);
}

char *_do_cmd(char *p_in,int need_end)
{
        char *av[100];
        int32_t ac;
        int nc, j, c;
        struct mycmd *pcmd;
        char *p,*p_cmd;

cmd_loop:
        p_cmd=p_in;
        for (; *p_in;) {
                c = *p_in;
                if(c == '\'' || c == '"') {
                        p_in++;
                        while (*p_in && *p_in != c) {
                                ++p_in;
                        }
                        if(*p_in) {
                                p_in++;
                        }
                        else {
                                prom_printf("unbalanced %c\n", c);
                                return p;
                        }
                }
                else if((c == ';')||(c == '\n')) {
                        *p_in++ = 0;
                        goto run_a_cmd;
                }
                else {
                        p_in++;
                }
        }
        if(need_end)return p_cmd;
run_a_cmd:



        if(!(p = expand (p_cmd))) {
                return p_cmd;
        }

        if(!(p = expand1 (p))) {
                return p_cmd;
        }

        nc = 0;




        do{
                int stat = -1;
                if(showcmd)prom_printf("#%s\n",p);
                ac = argvize (av, p);
                if(ac == 0) {
                        break;
                }


   for(pcmd=&__mycmd_begin+1;pcmd!=&__mycmd_end;pcmd++)
   if(!strcmp(av[0],pcmd->name))break;
   if(pcmd!=&__mycmd_end)
        stat = pcmd->func(ac, av);
   else
   {prom_printf("syntax error");stat=0;}

                if(stat < 0) {
                prom_printf("usage:%-10s:%-30s:%s\n",pcmd->name,pcmd->usage,pcmd->note);
                }

                if(stat != 0) {
                        return p_in;
                }
        }while(0);

if(*p_in)goto cmd_loop;
return p_in;
}
# 174 "drivers/debug26/lib/cmdparser.c"
static char *
expand(cmdline)
        char *cmdline;
{
        char *ip, *op, *v;
        char var[256];
        static char expline[200 + 8];

        if(!strchr (cmdline, '$')) {
                return cmdline;
        }

        ip = cmdline;
        op = expline;
        while (*ip) {
                if(op >= &expline[sizeof(expline) - 1]) {
                        prom_printf ("Line too long after expansion\n");
                        return (0);
                }

                if(*ip != '$') {
                        *op++ = *ip++;
                        continue;
                }

                ip++;
                if(*ip == '$') {
                        *op++ = '$';
                        ip++;
                        continue;
                }


                v = var;
                if(*ip == '{') {

                        ip++;
                        while (*ip && *ip != '}') {
                                *v++ = *ip++;
                        }
                        if(*ip && *ip != '}') {
                                prom_printf ("Variable syntax\n");
                                return (0);
                        }
                        ip++;
                } else {

                        while ((((_ctype[(int)(unsigned char)(*ip)])&(0x01|0x02)) != 0) || (((_ctype[(int)(unsigned char)(*ip)])&(0x04)) != 0)) {
                                *v++ = *ip++;
                        }
                }

                *v = 0;
                if(!(v = getenv (var))) {
                        prom_printf ("'%s': undefined\n", var);
                        return (0);
                }

                if(op + strlen(v) >= &expline[sizeof(expline) - 1]) {
                        prom_printf ("Line expansion ovf.\n");
                        return (0);
                }

                while (*v) {
                        *op++ = *v++;
                }
        }
        *op = '\0';
        return (expline);
}

static char *expr(char *cmd)
{
char *token;
unsigned int op='+';
unsigned long result=0;
static char cmd1[0x100];
char *inp=cmd;
char *outp=cmd1;
unsigned long data;
char c=0x20;
int deep;
const char *fmt="+-*/\\%|&^hpod";

while(*inp)
{
        if(strchr(fmt,*inp)){
        if(c!=0x20){*outp++=0x20;}
        *outp++=*inp++;*outp++=0x20;c=0x20;
        continue;
        }
        if(*inp==0x20||*inp=='\t'){inp++;continue;}
        *outp++=c=*inp++;
}

*outp=0;
inp=cmd1;

   while(*inp)
   {
         while(*inp==' '||*inp=='\t')inp++;

         if(*inp=='('){
                 token=++inp;
                 deep=1;
                 while(1)
                 {
                         if(deep<1 || !*inp){prom_printf("error synax");return 0;}
                         if(*inp==')' && deep==1){*inp=0;inp++;break;}
                         if(*inp=='('){inp++;deep++;continue;}
                         if(*inp==')'){inp++;deep--;continue;}
                         ++inp;
                 }
                 token=expr(token);
         }
         else {
         token=inp;
         while(*inp!=' ' && *inp!='\t' && *inp!=0)inp++;
         if(*inp){*inp=0;inp++;}
         }

        if(!token||!*token)break;
        if(token[1]==0 && strchr(fmt,*token)){op=*token;continue;}
        data=simple_strtol(token,0,0);
        switch(op)
        {
                case '+':result=result+data;break;
                case '-':result=result-data;break;
                case '*':result=result*data;break;
                case '/':result=result/data;break;
                case '\\':result=data/result;break;
                case '%':result=result%data;break;
                case '|':result=result|data;break;
                case '&':result=result&data;break;
                case '^':result=result^data;break;
                case '~':result=~result;break;
        }

   }
   switch(op)
   {
           case 'd':sprintf(cmd1,"%ld",result);break;
           case 'p':sprintf(cmd1,"%p",(void *)result);break;
           case 'o':sprintf(cmd1,"0%lo",result);break;
           default:sprintf(cmd1,"0x%lx",result);break;
   }
   return cmd1;
}

static char *expand1(char *cmdline)
{
        char *ip, *op, *v;
        char var[256];
        static char expline[200 + 8];

        if(!strchr (cmdline, '`')) {
                return cmdline;
        }

        ip = cmdline;
        op = expline;
        while (*ip) {
                if(op >= &expline[sizeof(expline) - 1]) {
                        prom_printf ("Line too long after expansion\n");
                        return (0);
                }

                if(*ip != '`') {
                        *op++ = *ip++;
                        continue;
                }

                ip++;
                if(*ip == '`') {
                        *op++ = '`';
                        ip++;
                        continue;
                }


                v = var;
                        while (*ip && *ip != '`') {
                                *v++ = *ip++;
                        }
                        if(*ip && *ip != '`') {
                                prom_printf ("Variable syntax\n");
                                return (0);
                        }
                        ip++;

                *v = 0;
                if(!(v = expr (var))) {
                        prom_printf ("'%s': undefined\n", var);
                        return (0);
                }

                if(op + strlen(v) >= &expline[sizeof(expline) - 1]) {
                        prom_printf ("Line expansion ovf.\n");
                        return (0);
                }

                while (*v) {
                        *op++ = *v++;
                }
        }
        *op = '\0';
        return (expline);
}

int cmd_expr(int argc,char **argv)
{
        if(argc!=2)return -1;
        prom_printf("%s\n",expr(argv[1]));
        return 0;
}

struct mycmd __mycmd_h __attribute__ ((unused,__section__ (".mycmd"))) = {"h",help,"h","show this help"};;
struct mycmd __mycmd_q __attribute__ ((unused,__section__ (".mycmd"))) = {"q",quit,"q","quit this shell"};;
struct mycmd __mycmd_expr __attribute__ ((unused,__section__ (".mycmd"))) = {"expr",cmd_expr,"expr","expr"};;
# 437 "drivers/debug26/lib/main.c" 2
static void debug(void)
{
static char str[1024];
int count;
quitnow=0;
 while(!quitnow)
 {
 char *pstart=str,*pend;
 int len=1023;
    prom_printf("\n-");
    while(1)
    {
        count=prom_gets(pstart,len);
        if(count<=0)return;
        pstart[count]=0;
        pend=_do_cmd(str,1);
        if((pend-pstart)==count)break;
        strcpy(str,pend);
        pstart=str+strlen(str);
        len=1023-strlen(str);
    }
 }
}


static int debug_open(struct inode *inode, struct file *filp)
{
return 0;
}

int debug_release (struct inode *inode, struct file *filp)
{
                    return 0;
}

struct file_operations debug_fops = {
    open: debug_open,
    release: debug_release,
};

static int proc_read_debug(char *page, char **start,
                             off_t off, int count,
                             int *eof, void *data)
{
        debug();
        return 0;
}


static int proc_write_debug(struct file *file,
                             const char *buffer,
                             unsigned long count,
                             void *data)
{
        int left,len;
        static char *pdata=0;
        char *pend;
        struct file *file2,*file0;

    fput(file2=fget(2));
    if(file==file2){
        fput(file0=fget(0));
     if(file0!=file)nr_fprintf(0,"debug26:wrong fd1==fd2,loop error\n");
     else printk("<0>debug26:wrong fd1==fd2,loop error\n");
        return -1;
    }

        if(!pdata)pdata=data;
        left=count;
        while(left)
        {
        len=(left > (1UL << 14)-1-(pdata-(char *)data))?(1UL << 14)-1-(pdata-(char *)data):left;

        if(({ void *__cu_to; const void *__cu_from; long __cu_len; __cu_to = (pdata); __cu_from = (buffer+count-left); __cu_len = (len); if (__builtin_expect(((((signed long)(((current->thread.current_ds).seg) & (((unsigned long)(__cu_from)) | (((unsigned long)(__cu_from)) + ((__cu_len))) | ((__builtin_constant_p((__cu_len)) && (signed long) ((__cu_len)) > 0) ? 0 : ((__cu_len)))))) == 0)),1)) __cu_len = ({ register void *__cu_to_r __asm__ ("$4"); register const void *__cu_from_r __asm__ ("$5"); register long __cu_len_r __asm__ ("$6"); __cu_to_r = (__cu_to); __cu_from_r = (__cu_from); __cu_len_r = (__cu_len); __asm__ __volatile__( ".set\tnoreorder\n\t" "jal\t" "__copy_user" "\n\t" ".set\tnoat\n\t" "daddu" "\t$1, %1, %2\n\t" ".set\tat\n\t" ".set\treorder" : "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r) : : "$8", "$9", "$10", "$11", "$12", "$15", "$24", "$31", "memory"); __cu_len_r; }); __cu_len; })) {
                return -14;
        }

        pdata[len] = '\0';
        left-=len;
        pend=_do_cmd(data,1);
        strcpy(data,pend);
        pdata=data+strlen(data);
        }

        return count;
}

static struct proc_dir_entry *debug_proc_entry=0;
static int rcdevrv=0;


int debug26_runmydebug()
{
        do_initbegin_calls();
        debug();
        prom_printf("quit\n");
        return -1;
}


static int dummy_init_module(void)
{






         do_initbegin_calls();
         debug_proc_entry=create_proc_entry("debug",0444,0);
        if (debug_proc_entry) {
        debug_proc_entry->read_proc=proc_read_debug;
        debug_proc_entry->write_proc=proc_write_debug;
        debug_proc_entry->data=(void *)__get_free_pages(((0x20 | 0x10 | 0x40 | 0x80 | 0x100)),0);
        printk("<0>create proc file debug succeed\n");
        }
        else printk("<0>create proc file debug fail\n");

rcdevrv=register_chrdev(62, "debug", &debug_fops);
if(rcdevrv<0)
        printk("<0>register_chrdev DEBUGMAJOR 62 fail\n");
else
        printk("<0>register_chrdev DEBUGMAJOR 62 succeed\n");
return 0;


}
static void dummy_cleanup_module(void)
{
do_initend_calls();
if(debug_proc_entry)remove_proc_entry("debug",0);
if(rcdevrv>=0)unregister_chrdev(62, "debug");
if(debug_proc_entry->data)free_pages(((unsigned long)debug_proc_entry->data),0);
}
static initcall_t __initcall_dummy_init_module __attribute__((__unused__)) __attribute__((__unused__)) __attribute__ ((__section__ (".initcall.init"))) = dummy_init_module;;
static exitcall_t __exitcall_dummy_cleanup_module __attribute__((__unused__)) __attribute__ ((__section__ (".exitcall.exit"))) = dummy_cleanup_module;;
struct mycmd __mycmd_sleep __attribute__ ((unused,__section__ (".mycmd"))) = {"sleep",sleepcmd,"njiffies","sleep a little time"};;
struct mycmd __mycmd_busysleep __attribute__ ((unused,__section__ (".mycmd"))) = {"busysleep",busysleepcmd,"ms","busysleep a little time"};;
# 3 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/env.c" 1

struct __myenv_s{
char *name;
char *value;
char *msg;
};

static char env_buf[0x100];
static char *env_head=env_buf;

static struct __myenv_s __myenv_items[100];

static struct __myenv_s *getenvp(char *name,int create)
{
struct __myenv_s *p;
 for(p=__myenv_items;p<&__myenv_items[100];p++)
 if(p->name && !strcmp(p->name,name)) return p;

 if(!create)return 0;
 for(p=__myenv_items;p<&__myenv_items[100];p++)
 if(!p->name){p->value=0;p->msg=0;return p;}

return 0;
}


static int setenv(char *name,char *value,char *msg)
{
struct __myenv_s *p;
char *s;

if(!strcmp(name,"iomap"))
{
        syscall_addrtype=simple_strtol(value,0,0);
}

p=getenvp(name,1);
if(!p){prom_printf("env array full\n");return -1;}
if(!p->name)
          {
                   s=nr_malloc(strlen(name)+1);
                   if(!s)return -1;
                   strcpy(s,name);
                   p->name=s;
                  }
if(value)
{
                   s=nr_malloc(strlen(value)+1);
                   if(!s)goto error;
                   strcpy(s,value);
                   if(p->value)nr_free(p->value);
                   p->value=s;
}

if(msg)
{
                   s=nr_malloc(strlen(msg)+1);
                   if(!s)goto error;
                   strcpy(s,msg);
                   if(p->msg)nr_free(p->msg);
                   p->msg=s;
}

   return 0;
error:
if(p->name){nr_free(p->name);p->name=0;}
if(p->value){nr_free(p->value);p->value=0;}
if(p->msg){nr_free(p->msg);p->msg=0;}
return -1;
}

static char *getenv(char *name)
{
 struct __myenv_s *p;
 static char val[20];
if(!strcmp(name,"iomap"))
{
        sprintf(val,"0x%x",syscall_addrtype);
        return val;
}

p=getenvp(name,0);
        return p?p->value:0;
}

char *debug26_getenv(char *name)
{
return getenv(name);
}

int debug26_setenv(char *name,char *value,char *msg)
{
setenv(name,value,msg);
return 0;
}

static int set(int argc,char **argv)
{
struct __myenv_s *p;
if(argc>4){prom_printf("usage:set [name] [value] [msg]\n");return -1;}
if(argc==1)
{
for(p=__myenv_items;p<&__myenv_items[100];p++)
{
if(!p->name)continue;
 prom_printf("%-20s%-18s%-40s\n",p->name,p->value,p->msg);
}
return 0;
}

if(argc==2){
char *s;
p=getenvp(argv[1],0);
if(p && p->name)
        prom_printf("%-20s%-18s%-40s\n",p->name,getenv(p->name),p->msg);
else
 {
        prom_printf("can not found env var %s\n",argv[1]);return -1;
  }
return 0;
}

setenv(argv[1],argv[2],(argc==3)?0:argv[3]);
return 0;
}


static int unset(int argc,char **argv)
{
struct __myenv_s *p;
if(argc!=2){prom_printf("usage:unset name\n");return -1;}

p=getenvp(argv[1],0);
        if(!p) return 0;
if(p->name){nr_free(p->name);p->name=0;}
if(p->value){nr_free(p->value);p->value=0;}
if(p->msg){nr_free(p->msg);p->msg=0;}
return 0;
}

char *use_env(char *name)
{
struct __myenv_s *p;
char *psign,sign,*ret;
int env_v=0;
int env_l;
psign=strchr(name,'+');
if(!psign)psign=strchr(name,'-');
if(!psign)sign=0;
else if(*psign=='+')sign=1;
else sign=-1;
if(psign){
        env_v=simple_strtol(psign+1,0,0);*psign=0;
        env_v=sign*env_v;
}
p=getenvp(name,0);
if(!p)return 0;
if(psign){
        env_l=simple_strtol(p->value,0,0);
        env_v+=env_l;
ret=env_head;
env_head+=sprintf(env_head,"0x%x",env_v)+1;
}
else ret=p->value;
return ret;
}

static int envinit(void)
{
setenv("iomap","-1","iomap address,64 bit cpu address,64 bit cached phyiscal address,64 bit uncached phyiscal address");
setenv("x","d4 0x14000000 100",0);
setenv("y","wf 1.dat 0xffffffffb6000000 ",0);
return 0;
}

struct myinit __myinit_begin_envinit __attribute__ ((unused,__section__ (".myinit.begin"))) ={envinit};;
struct mycmd __mycmd_set __attribute__ ((unused,__section__ (".mycmd"))) = {"set",set,"set [name] [value] [msg]","set env var"};;
struct mycmd __mycmd_unset __attribute__ ((unused,__section__ (".mycmd"))) = {"unset",unset,"unset name","unset envvar"};;
# 4 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/mem.c" 1

static union commondata{
                unsigned char data1;
                unsigned short data2;
                unsigned int data4;
                unsigned int data8[2];
                unsigned char c[8];
}mydata,*pmydata;

static int __syscall1(int type,unsigned long long addr,union commondata *mydata);
static int __syscall2(int type,unsigned long long addr,union commondata *mydata);
static int (*syscall1)(int type,unsigned long long addr,union commondata *mydata);
static int (*syscall2)(int type,unsigned long long addr,union commondata *mydata);
# 24 "drivers/debug26/lib/mem.c"
static long myioremap(long long addr,int size)
{
long vaddr;
vaddr=ioremap(addr&(~((1UL << 14)-1)),(1UL << 14));
if(vaddr)vaddr +=addr&((1UL << 14) - 1);
return vaddr;
}
static void mymunmap(long vaddr,int size)
{
iounmap(vaddr&(~((1UL << 14)-1)));
}







int nr_ioremap(unsigned long long phyaddr,unsigned int size,unsigned long long *vaddr)
{

if((syscall_addrtype&3)==1)
{
 *vaddr=(void *)myioremap(phyaddr,size);
 if(*vaddr!=-1)return 0;
 else return -1;
}
else if((syscall_addrtype&3)==3)*vaddr=phyaddr|0x9000000000000000ULL;
else if((syscall_addrtype&3)==2)*vaddr=phyaddr|0x9800000000000000ULL;
else *vaddr=phyaddr;

return 0;
}

int nr_iounremap(unsigned long long vaddr,unsigned int size)
{
if((syscall_addrtype&3)==1) { mymunmap(vaddr,size);return 0;}
return 0;
}




static int __syscall1(int type,unsigned long long addr,union commondata *mydata)
{
union {
long long ll;
int l[2];
} a;

unsigned long long vaddr;
if(nr_ioremap(addr, type,&vaddr)<0)return -1;

a.ll=vaddr;

asm(".set mips3;");

switch(type)
{
case 1:
          ;
          asm(".set mips3;dsll32 %2,%2,0;or %1,%2;lbu $2,(%1);" "sb $2,(%0);" ::"r"(&mydata->data1),"r"(a.l[0]),"r"(a.l[1])


                  :"$2"
                 );
           break;
case 2:
          ;
          asm(".set mips3;dsll32 %2,%2,0;or %1,%2;lhu $2,(%1);" "sh $2,(%0);" ::"r"(&mydata->data2),"r"(a.l[0]),"r"(a.l[1])


                  :"$2"
                 );
           break;
case 4:
          ;
          asm(".set mips3;dsll32 %2,%2,0;or %1,%2;lwu $2,(%1);" "sw $2,(%0);" ::"r"(&mydata->data4),"r"(a.l[0]),"r"(a.l[1])


                  :"$2"
                 );
           break;
case 8:
          ;
          asm(".set mips3;dsll32 %2,%2,0;or %1,%2;ld $2,(%1);" "sd $2,(%0);" ::"r"(mydata->data8),"r"(a.l[0]),"r"(a.l[1])


                  :"$2"
                 );
           break;
}
asm(".set mips0;");

nr_iounremap(vaddr,type);
return 0;
}

static int __syscall2(int type,unsigned long long addr,union commondata *mydata)
{
union {
long long ll;
int l[2];
} a;
unsigned long long vaddr;
if(nr_ioremap(addr, type,&vaddr)<0)return -1;

a.ll=vaddr;

asm(".set mips3;");
switch(type)
{
case 1:
         ;
          asm(".set mips3;dsll32 %2,%2,0;or %1,%2;lbu $2,(%0);" "sb $2,(%1);" ::"r"(&mydata->data1),"r"(a.l[0]),"r"(a.l[1])


                  :"$2"
                 );
           break;
case 2:
          ;
          asm(".set mips3;dsll32 %2,%2,0;or %1,%2;lhu $2,(%0);" "sh $2,(%1);" ::"r"(&mydata->data2),"r"(a.l[0]),"r"(a.l[1])


                  :"$2"
                 );
          break;
case 4:
          ;
          asm(".set mips3;dsll32 %2,%2,0;or %1,%2;lwu $2,(%0);" "sw $2,(%1);" ::"r"(&mydata->data4),"r"(a.l[0]),"r"(a.l[1])


                  :"$2"
                 );
            break;
case 8:
          asm(".set mips3;dsll32 %2,%2,0;or %1,%2;ld $2,(%0);" "sd $2,(%1);" ::"r"(mydata->data8),"r"(a.l[0]),"r"(a.l[1])


                  :"$2"
                 );
           ;
           break;
}
asm(".set mips0;");

nr_iounremap(vaddr,type);
return 0;
}



static int (*syscall1)(int type,unsigned long long addr,union commondata *mydata)=&__syscall1;
static int (*syscall2)(int type,unsigned long long addr,union commondata *mydata)=&__syscall2;

static unsigned long lastaddr=0;
static int dump(int argc,char **argv)
{
                char type=4;
static unsigned long addr,count=1;
                int i,j,k;
                char memdata[16];

                if(argc>3){return -1;}

                switch(argv[0][1])
                {
                                case '1': type=1;break;
                                case '2': type=2;break;
                                case '4': type=4;break;
                                case '8': type=8;break;
                }

                if(argc>1)addr=simple_strtol(argv[1],0,0);
                else addr=lastaddr;
                if(argc>2)count=simple_strtol(argv[2],0,0);
                else if(count<=0||count>=1024) count=1;
                for(j=0;j<count;j=j+16/type,addr=addr+16/(1<<(syscall_addrtype<0?0:((syscall_addrtype>>4)&3))))
                {
                prom_printf("%08lx: ",addr);

                pmydata=(void *)memdata;
                for(i=0;type*i<16;i++)
                {
                if(syscall1(type,addr+i*type/(1<<(syscall_addrtype<0?0:((syscall_addrtype>>4)&3))),pmydata)<0){prom_printf("read address %p error\n",addr+i*type/(1<<(syscall_addrtype<0?0:((syscall_addrtype>>4)&3))));return -1;}
                pmydata=(void *)((char *)pmydata+type);
                if(j+i+1>=count)break;
                }

                pmydata=(void *)memdata;
                for(i=0;type*i<16;i++)
                {
                switch(type)
                {
                case 1: prom_printf("%02x ",pmydata->data1);break;
                case 2: prom_printf("%04x ",pmydata->data2);break;
                case 4: prom_printf("%08x ",pmydata->data4);break;
                case 8: prom_printf("%08x%08x ",pmydata->data8[1],pmydata->data8[0]);break;
                }
                if(j+i+1>=count){int k;for(i=i+1;type*i<16;i++){for(k=0;k<type;k++)prom_printf("  ");prom_printf(" ");}break;}
                pmydata=(void *)((char *)pmydata+type);
                }

                pmydata=(void *)memdata;

                for(k=0;k<16;k++)
                {
                prom_printf("%c",(((char *)pmydata)[k]<0x20 || ((char *)pmydata)[k]>0x7e)?'.':((char *)pmydata)[k]);
                if(j+(k+1)/type>=count)break;
                }
                prom_printf("\n");
                }
                lastaddr=addr+count*type;
                return 0;
}

static int getdata(char *str)
{
        static char buf[17];
        char *pstr;
        int sign=1;
        int radix=10;
        pstr=strsep(&str," \t\x0a\x0d");

                if(pstr)
                {
                if(pstr[0]=='q')return -1;
                memset(buf,'0',16); buf[17]=0;
                if(pstr[0]=='-')
                {
                sign=-1;
                pstr++;
                }
                else if(pstr[0]=='+')
                {
                        pstr++;
                }

                if(pstr[0]!='0'){radix=10;}
                else if(pstr[1]=='x'){radix=16;pstr=pstr+2;}

                memcpy(buf+16-strlen(pstr),pstr,strlen(pstr));
                pstr=buf;
                pstr[16]=pstr[8];pstr[8]=0;
                mydata.data8[1]=simple_strtol(pstr,0,radix);
                pstr[8]=pstr[16];pstr[16]=0;
                mydata.data8[0]=simple_strtol(&pstr[8],0,radix);
                if(sign==-1)
                {
                long x=mydata.data8[0];
                        mydata.data8[0]=-mydata.data8[0];
                        if(x<0)
                        mydata.data8[1]=-mydata.data8[1];
                        else mydata.data8[1]=~mydata.data8[1];

                }
                return 1;
                }
                return 0;

}

static int modify(int argc,char **argv)
{
                char type=4;
                unsigned long addr;

                char str[100];
                int i;

                if(argc<2){return -1;}

                switch(argv[0][1])
                {
                                case '1': type=1;break;
                                case '2': type=2;break;
                                case '4': type=4;break;
                                case '8': type=8;break;
                }
                addr=simple_strtol(argv[1],0,0);
                if(argc>2)
                {
                 i=2;
                  while(i<argc)
                 {
                   getdata(argv[i]);
                   if(syscall2(type,addr,&mydata)<0)
                   {prom_printf("write address %p error\n",addr);return -1;};
                   addr=addr+type/(1<<(syscall_addrtype<0?0:((syscall_addrtype>>4)&3)));
                 i++;
                 }
                  return 0;
                }


                while(1)
                {
                if(syscall1(type,addr,&mydata)<0){prom_printf("read address %p error\n",addr);return -1;};
                prom_printf("%08lx:",addr);
                switch(type)
                {
                case 1: prom_printf("%02x ",mydata.data1);break;
                case 2: prom_printf("%04x ",mydata.data2);break;
                case 4: prom_printf("%08x ",mydata.data4);break;
                case 8: prom_printf("%08x%08x ",mydata.data8[1],mydata.data8[0]);break;
                }
                memset(str,0,100);
                prom_gets(str,100);
                i=getdata(str);
                if(i<0)break;
                else if(i>0)
                {
                if(syscall2(type,addr,&mydata)<0)
                {prom_printf("write address %p error\n",addr);return -1;};
                }
        addr=addr+type/(1<<(syscall_addrtype<0?0:((syscall_addrtype>>4)&3)));
                }
                lastaddr=addr;
                return 0;
}
struct mycmd __mycmd_d1 __attribute__ ((unused,__section__ (".mycmd"))) = {"d1",dump,"d1 [addr] [count]","dump memory (byte)"};;
struct mycmd __mycmd_d2 __attribute__ ((unused,__section__ (".mycmd"))) = {"d2",dump,"d2 [addr] [count]","dump memory (half word)"};;
struct mycmd __mycmd_d4 __attribute__ ((unused,__section__ (".mycmd"))) = {"d4",dump,"d4 [addr] [count]","dump memory (word)"};;
struct mycmd __mycmd_d8 __attribute__ ((unused,__section__ (".mycmd"))) = {"d8",dump,"d8 [addr] [count]","modify memory (double word)"};;
struct mycmd __mycmd_m1 __attribute__ ((unused,__section__ (".mycmd"))) = {"m1",modify,"m1 addr","modify memory (byte)"};;
struct mycmd __mycmd_m2 __attribute__ ((unused,__section__ (".mycmd"))) = {"m2",modify,"m2 addr","modify memory (half word)"};;
struct mycmd __mycmd_m4 __attribute__ ((unused,__section__ (".mycmd"))) = {"m4",modify,"m4 addr","modify memory (word)"};;
struct mycmd __mycmd_m8 __attribute__ ((unused,__section__ (".mycmd"))) = {"m8",modify,"m8 addr","modify memory (double word)"};;
# 5 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/ls.c" 1
# 28 "drivers/debug26/lib/ls.c"
struct old_linux_dirent {
    unsigned long d_ino;
    unsigned long d_offset;
    unsigned short d_namlen;
    char d_name[100];
};

struct readdir_callback {
    struct old_linux_dirent * dirent;
    int count;
};

static int fillonedir(void * __buf, const char * name, int namlen, loff_t offset,
              ino_t ino, unsigned int d_type)
{
    struct readdir_callback * buf = (struct readdir_callback *) __buf;
    struct old_linux_dirent * dirent;

    if (buf->count)
        return -22;
    buf->count++;
    dirent = buf->dirent;
        dirent->d_ino=ino;
        dirent->d_offset=offset;
        dirent->d_namlen=namlen;

    memcpy(dirent->d_name, name, namlen);
    dirent->d_name[namlen]=0;
    return 0;
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long newlstat(char * filename, struct stat * statbuf) { register unsigned long __a0 asm("$4") = (unsigned long) filename; register unsigned long __a1 asm("$5") = (unsigned long) statbuf; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %4\t\t\t# " "newlstat" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "i" (107) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long time(int * tloc) { register unsigned long __a0 asm("$4") = (unsigned long) tloc; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %3\t\t\t# " "time" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "i" (__NR_time) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long readlink(const char * path, char * buf, int bufsiz) { register unsigned long __a0 asm("$4") = (unsigned long) path; register unsigned long __a1 asm("$5") = (unsigned long) buf; register unsigned long __a2 asm("$6") = (unsigned long) bufsiz; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %5\t\t\t# " "readlink" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "i" ((5000 + 87)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; }
# 1 "drivers/debug26/lib/mode_string.c" 1
# 41 "drivers/debug26/lib/mode_string.c"
static const int TIME_MOD = 0;
static const int TIME_CHANGE = 1;
static const int TIME_ACCESS = 2;





static const mode_t SBIT[] = {
        0, 0, 0004000,
        0, 0, 0002000,
        0, 0, 0001000
};


static const mode_t MBIT[] = {
        00400, 00200, 00100,
        00040, 00020, 00010,
        00004, 00002, 00001
};

static const char MODE1[] = "rwxrwxrwx";
static const char MODE0[] = "---------";
static const char SMODE1[] = "..s..s..t";
static const char SMODE0[] = "..S..S..T";





const char *mode_string(int mode)
{
        static char buf[12];

        int i;

        buf[0] = ("0pcCd?bB-?l?s???" [(((mode) >> 12) & 0x0f)]);
        for (i = 0; i < 9; i++) {
                if (mode & SBIT[i])
                        buf[i + 1] = (mode & MBIT[i]) ? SMODE1[i] : SMODE0[i];
                else
                        buf[i + 1] = (mode & MBIT[i]) ? MODE1[i] : MODE0[i];
        }
        return buf;
}
# 102 "drivers/debug26/lib/mode_string.c"
extern char *xreadlink(const char *path)
{

    static char buf[101];
    int bufsize = 100, readsize = 0;
chfs(1);
        readsize = readlink(path, buf, bufsize);
chfs(0);
        if (readsize == -1) {
            return ((void *)0);
        }

    buf[readsize] = '\0';

    return buf;
}

static unsigned int time_fmt=-1;
static unsigned int list_fmt=(1<<2)|(1<<3)|(1<<5)|(1<<6)|(1<<8)|(1<<10)|(1<<11)|(1<<12);
static unsigned short column = 0;

struct dnode {
    char *name;
    char *fullname;
    struct stat dstat;
    struct dnode *next;
};



static char append_char(mode_t mode)
{
        if ( !(list_fmt & (1<<12)))
                return '\0';
        if ((list_fmt & (1<<13)) && (((mode) & 00170000) == 0100000)
            && (mode & (00100 | 00010 | 00001))) return '*';
                return ("\0|\0\0/\0\0\0\0\0@\0=\0\0\0" [(((mode) >> 12) & 0x0f)]);
}

static int list_single(struct dnode *dn)
{
        int i;
        time_t ttime;
        char append;

        if (dn==((void *)0) || dn->fullname==((void *)0)) return(0);

        ttime= dn->dstat.st_mtime;
        if (time_fmt & TIME_ACCESS) ttime= dn->dstat.st_atime;
        if (time_fmt & TIME_CHANGE) ttime= dn->dstat.st_ctime;




        append = append_char(dn->dstat.st_mode);

        for (i=0; i<=31; i++) {
                switch (list_fmt & (1<<i)) {
                        case (1<<0):
                                prom_printf("%7ld ", (long int)dn->dstat.st_ino);
                                column += 8;
                                break;
                        case (1<<1):







                                prom_printf("%4ld ", dn->dstat.st_blocks>>1);


                                column += 5;
                                break;
                        case (1<<2):
                                prom_printf("%-10s ", (char *)mode_string(dn->dstat.st_mode));
                                column += 10;
                                break;
                        case (1<<3):
                                prom_printf("%4ld ", (long)dn->dstat.st_nlink);
                                column += 10;
                                break;
                        case (1<<4):
# 194 "drivers/debug26/lib/mode_string.c"
                        case (1<<5):
                                prom_printf("%-8d %-8d", dn->dstat.st_uid, dn->dstat.st_gid);
                                column += 17;
                                break;
                        case (1<<6):
                        case (1<<7):
                                if ((((dn->dstat.st_mode) & 00170000) == 0060000) || (((dn->dstat.st_mode) & 00170000) == 0020000)) {
                                        prom_printf("%4d, %3d ", (int)((unsigned int) ((dn->dstat.st_rdev) >> 8)), (int)((unsigned int) ((dn->dstat.st_rdev) & ((1U << 8) - 1))));
                                } else {





                                        {



                                                prom_printf("%9ld ", dn->dstat.st_size);

                                        }
                                }
                                column += 10;
                                break;
# 237 "drivers/debug26/lib/mode_string.c"
                        case (1<<10):
                                prom_printf("%s", dn->name);
                                column += strlen(dn->name);
                                break;
                        case (1<<11):
                                if ((((dn->dstat.st_mode) & 00170000) == 0120000)) {
                                        char *lpath = xreadlink(dn->fullname);
                                        if (lpath) {
                                                prom_printf(" -> %s", lpath);





                                                column += strlen(lpath) + 4;
                                        }
                                }
                                break;
# 264 "drivers/debug26/lib/mode_string.c"
                }
        }

        return(0);
}
# 64 "drivers/debug26/lib/ls.c" 2
static int ls(int argc,char **argv)
{
        int error,type;
        struct old_linux_dirent d;
        struct readdir_callback buf;
        static char fname[200];
        static struct stat statbuf;
        char *dirname;
        struct file *f;

        struct dnode dnode;
        if(argc>2){return -1;}
        if(argc==1)dirname=".";
        else dirname=argv[1];
        f = filp_open(dirname, 0,0);

  if(IS_ERR(f)){ prom_printf("error open file\n");return -1;}

        prom_printf("%-40s\toffset\tino\ttype\n","name");
        while(1)
        {
    buf.count = 0;
    buf.dirent = &d;
    error = vfs_readdir(f, fillonedir, &buf);

        if(IS_ERR(f)){prom_printf("error:%d\n",error);goto done;}

        if(!buf.count)break;

        strcpy(fname,dirname);
        if(dirname[strlen(dirname)-1]!='/')
        {
                strcat(fname,"/");
        }
        strcat(fname,d.d_name);

chfs(1);
        error=newlstat(fname,&statbuf);
chfs(0);
        if(error>=0)error=statbuf.st_mode;
        type=error;
        dnode.name=d.d_name;
        dnode.fullname=fname;
    dnode.dstat=statbuf;
        dnode.next=0;
        list_single(&dnode);
        prom_printf("\n");
        }
done:
        filp_close(f,current->files);
        return 0;
}

struct mycmd __mycmd_ls __attribute__ ((unused,__section__ (".mycmd"))) = {"ls",ls,"ls dir","ls dir"};;
# 6 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/pwd.c" 1

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long getcwd(char * buf, unsigned long size) { register unsigned long __a0 asm("$4") = (unsigned long) buf; register unsigned long __a1 asm("$5") = (unsigned long) size; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %4\t\t\t# " "getcwd" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "i" ((5000 + 77)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; }
static int pwd(int argc,char **argv)
{
        char buf[200];
        chfs(1);
    getcwd(buf,200);
        chfs(0);
        prom_printf("%s\n",buf);
        return 0;
}

struct mycmd __mycmd_pwd __attribute__ ((unused,__section__ (".mycmd"))) = {"pwd",pwd,"pwd","pwd"};;
# 7 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/cd.c" 1

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long chdir(char * filename) { register unsigned long __a0 asm("$4") = (unsigned long) filename; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %3\t\t\t# " "chdir" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "i" ((5000 + 78)) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (long) __v0; errno = __v0; return (long) -1; }
static int mychdir(int argc,char **argv)
{
        if(argc!=2){return -1;}
        chfs(1);
        chdir(argv[1]);
        chfs(0);
        return 0;
}

struct mycmd __mycmd_cd __attribute__ ((unused,__section__ (".mycmd"))) = {"cd",mychdir,"cd dir","cd dir"};;
# 8 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/mount.c" 1
# 9 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/pci.c" 1
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h" 1
# 311 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci_ids.h" 1
# 312 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h" 2
# 336 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ioport.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ioport.h"
struct resource {
        const char *name;
        unsigned long start, end;
        unsigned long flags;
        struct resource *parent, *sibling, *child;
};

struct resource_list {
        struct resource_list *next;
        struct resource *res;
        struct pci_dev *dev;
};
# 83 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/ioport.h"
extern struct resource ioport_resource;
extern struct resource iomem_resource;

extern int check_resource(struct resource *root, unsigned long, unsigned long);
extern int request_resource(struct resource *root, struct resource *new);
extern int release_resource(struct resource *new);
extern int allocate_resource(struct resource *root, struct resource *new,
                             unsigned long size,
                             unsigned long min, unsigned long max,
                             unsigned long align,
                             void (*alignf)(void *, struct resource *,
                                            unsigned long, unsigned long),
                             void *alignf_data);





extern struct resource * __request_region(struct resource *, unsigned long start, unsigned long n, const char *name);







extern int __check_region(struct resource *, unsigned long, unsigned long);
extern void __release_region(struct resource *, unsigned long, unsigned long);


extern void autoirq_setup(int waittime);
extern int autoirq_report(int waittime);
# 337 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h" 2




enum pci_mmap_state {
        pci_mmap_io,
        pci_mmap_mem
};
# 371 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h"
struct pci_dev {
        struct list_head global_list;
        struct list_head bus_list;
        struct pci_bus *bus;
        struct pci_bus *subordinate;

        void *sysdata;
        struct proc_dir_entry *procent;

        unsigned int devfn;
        unsigned short vendor;
        unsigned short device;
        unsigned short subsystem_vendor;
        unsigned short subsystem_device;
        unsigned int class;
        u8 hdr_type;
        u8 rom_base_reg;

        struct pci_driver *driver;
        void *driver_data;
        u64 dma_mask;





        u32 current_state;




        unsigned short vendor_compatible[4];
        unsigned short device_compatible[4];





        unsigned int irq;
        struct resource resource[12];
        struct resource dma_resource[2];
        struct resource irq_resource[2];

        char name[90];
        char slot_name[8];
        int active;
        int ro;
        unsigned short regs;


        unsigned short transparent:1;

        int (*prepare)(struct pci_dev *dev);
        int (*activate)(struct pci_dev *dev);
        int (*deactivate)(struct pci_dev *dev);
};
# 445 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h"
struct pci_bus {
        struct list_head node;
        struct pci_bus *parent;
        struct list_head children;
        struct list_head devices;
        struct pci_dev *self;
        struct resource *resource[4];

        struct pci_ops *ops;
        void *sysdata;
        struct proc_dir_entry *procdir;

        unsigned char number;
        unsigned char primary;
        unsigned char secondary;
        unsigned char subordinate;

        char name[48];
        unsigned short vendor;
        unsigned short device;
        unsigned int serial;
        unsigned char pnpver;
        unsigned char productver;
        unsigned char checksum;
        unsigned char pad1;
};



extern struct list_head pci_root_buses;
extern struct list_head pci_devices;

extern struct proc_dir_entry *proc_bus_pci_dir;
# 491 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h"
struct pci_ops {
        int (*read_byte)(struct pci_dev *, int where, u8 *val);
        int (*read_word)(struct pci_dev *, int where, u16 *val);
        int (*read_dword)(struct pci_dev *, int where, u32 *val);
        int (*write_byte)(struct pci_dev *, int where, u8 val);
        int (*write_word)(struct pci_dev *, int where, u16 val);
        int (*write_dword)(struct pci_dev *, int where, u32 val);
};

struct pbus_set_ranges_data
{
        unsigned long io_start, io_end;
        unsigned long mem_start, mem_end;
        unsigned long prefetch_start, prefetch_end;
};

struct pci_device_id {
        unsigned int vendor, device;
        unsigned int subvendor, subdevice;
        unsigned int class, class_mask;
        unsigned long driver_data;
};

struct pci_driver {
        struct list_head node;
        char *name;
        const struct pci_device_id *id_table;
        int (*probe) (struct pci_dev *dev, const struct pci_device_id *id);
        void (*remove) (struct pci_dev *dev);
        int (*save_state) (struct pci_dev *dev, u32 state);
        int (*suspend) (struct pci_dev *dev, u32 state);
        int (*resume) (struct pci_dev *dev);
        int (*enable_wake) (struct pci_dev *dev, u32 state, int enable);
};
# 559 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h"
void pcibios_init(void);
void pcibios_fixup_bus(struct pci_bus *);
int pcibios_enable_device(struct pci_dev *, int mask);
char *pcibios_setup (char *str);


void pcibios_align_resource(void *, struct resource *,
                            unsigned long, unsigned long);
void pcibios_update_resource(struct pci_dev *, struct resource *,
                             struct resource *, int);
void pcibios_update_irq(struct pci_dev *, int irq);
void pcibios_fixup_pbus_ranges(struct pci_bus *, struct pbus_set_ranges_data *);



int pcibios_present(void);
int pcibios_read_config_byte (unsigned char bus, unsigned char dev_fn,
                              unsigned char where, unsigned char *val);
int pcibios_read_config_word (unsigned char bus, unsigned char dev_fn,
                              unsigned char where, unsigned short *val);
int pcibios_read_config_dword (unsigned char bus, unsigned char dev_fn,
                               unsigned char where, unsigned int *val);
int pcibios_write_config_byte (unsigned char bus, unsigned char dev_fn,
                               unsigned char where, unsigned char val);
int pcibios_write_config_word (unsigned char bus, unsigned char dev_fn,
                               unsigned char where, unsigned short val);
int pcibios_write_config_dword (unsigned char bus, unsigned char dev_fn,
                                unsigned char where, unsigned int val);
int pcibios_find_class (unsigned int class_code, unsigned short index, unsigned char *bus, unsigned char *dev_fn);
int pcibios_find_device (unsigned short vendor, unsigned short dev_id,
                         unsigned short index, unsigned char *bus,
                         unsigned char *dev_fn);



void pci_init(void);
int pci_bus_exists(const struct list_head *list, int nr);
struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
struct pci_bus *pci_alloc_primary_bus(int bus);
struct pci_dev *pci_scan_device(struct pci_dev *temp);
struct pci_dev *pci_scan_slot(struct pci_dev *temp);
int pci_proc_attach_device(struct pci_dev *dev);
int pci_proc_detach_device(struct pci_dev *dev);
int pci_proc_attach_bus(struct pci_bus *bus);
int pci_proc_detach_bus(struct pci_bus *bus);
void pci_name_device(struct pci_dev *dev);
char *pci_class_name(u32 class);
void pci_read_bridge_bases(struct pci_bus *child);
struct resource *pci_find_parent_resource(const struct pci_dev *dev, struct resource *res);
int pci_setup_device(struct pci_dev *dev);
int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);



struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
struct pci_dev *pci_find_subsys (unsigned int vendor, unsigned int device,
                                 unsigned int ss_vendor, unsigned int ss_device,
                                 const struct pci_dev *from);
struct pci_dev *pci_find_class (unsigned int class, const struct pci_dev *from);
struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
int pci_find_capability (struct pci_dev *dev, int cap);

int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val);
int pci_read_config_word(struct pci_dev *dev, int where, u16 *val);
int pci_read_config_dword(struct pci_dev *dev, int where, u32 *val);
int pci_write_config_byte(struct pci_dev *dev, int where, u8 val);
int pci_write_config_word(struct pci_dev *dev, int where, u16 val);
int pci_write_config_dword(struct pci_dev *dev, int where, u32 val);

int pci_enable_device(struct pci_dev *dev);
int pci_enable_device_bars(struct pci_dev *dev, int mask);
void pci_disable_device(struct pci_dev *dev);
void pci_set_master(struct pci_dev *dev);

int pci_set_mwi(struct pci_dev *dev);
void pci_clear_mwi(struct pci_dev *dev);
int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
int pci_assign_resource(struct pci_dev *dev, int i);


int pci_save_state(struct pci_dev *dev, u32 *buffer);
int pci_restore_state(struct pci_dev *dev, u32 *buffer);
int pci_set_power_state(struct pci_dev *dev, int state);
int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);



int pci_claim_resource(struct pci_dev *, int);
void pci_assign_unassigned_resources(void);
void pdev_enable_device(struct pci_dev *);
void pdev_sort_resources(struct pci_dev *, struct resource_list *);
unsigned long pci_bridge_check_io(struct pci_dev *);
void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
                    int (*)(struct pci_dev *, u8, u8));

int pci_request_regions(struct pci_dev *, char *);
void pci_release_regions(struct pci_dev *);
int pci_request_region(struct pci_dev *, int, char *);
void pci_release_region(struct pci_dev *, int);


int pci_register_driver(struct pci_driver *);
void pci_unregister_driver(struct pci_driver *);
void pci_insert_device(struct pci_dev *, struct pci_bus *);
void pci_remove_device(struct pci_dev *);
struct pci_driver *pci_dev_driver(const struct pci_dev *);
const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev);
void pci_announce_device_to_drivers(struct pci_dev *);
unsigned int pci_do_scan_bus(struct pci_bus *bus);
struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);


struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
                size_t size, size_t align, size_t allocation, int flags);
void pci_pool_destroy (struct pci_pool *pool);

void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t *handle);
void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t addr);





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h" 1
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
extern unsigned int pcibios_assign_all_busses(void);
# 30 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
extern void pcibios_set_master(struct pci_dev *dev);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pcibios_penalize_isa_irq(int irq)
{

}
# 44 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/scatterlist.h" 1



struct scatterlist {
        char * address;

        struct page * page;
        unsigned int offset;
        dma_addr_t dma_address;
        unsigned int dma_length;
        unsigned long length;
};
# 45 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h" 2
# 55 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
struct pci_dev;
# 72 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
                                  dma_addr_t *dma_handle);
# 84 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
                                void *vaddr, dma_addr_t dma_handle);
# 94 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr,
                                        size_t size, int direction)
{
        unsigned long addr = (unsigned long) ptr;

        if (direction == 3)
                __out_of_line_bug(100);

        do { (void) (addr); (void) (size); } while (0);

        return ((((unsigned long) (ptr) - 0x9800000000000000UL)<0x10000000)?((((unsigned long) (ptr) - 0x9800000000000000UL))|0x80000000):((unsigned long) (ptr) - 0x9800000000000000UL));
}
# 115 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
                                    size_t size, int direction)
{
        if (direction == 3)
                __out_of_line_bug(119);

        if (direction != 1) {
                unsigned long addr;

                addr = ((dma_addr>=0x80000000 && dma_addr<0x90000000)?(dma_addr&0x7fffffff):dma_addr) + 0x9800000000000000UL;
                do { (void) (addr); (void) (size); } while (0);
        }
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page *page,
                                      unsigned long offset, size_t size,
                                      int direction)
{
        unsigned long addr;

        if (direction == 3)
                __out_of_line_bug(140);

        addr = (unsigned long) ((void *)((unsigned long) ((((page) - page_zone(page)->zone_mem_map) << 14) + page_zone(page)->zone_start_paddr) + 0x9800000000000000UL)) + offset;
        do { (void) (addr); (void) (size); } while (0);

        return ((((page - mem_map) << 14) + offset<0x10000000)?((((page - mem_map) << 14) + offset)|0x80000000):((page - mem_map) << 14) + offset);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
                                  size_t size, int direction)
{
        if (direction == 3)
                __out_of_line_bug(152);

        if (direction != 1) {
                unsigned long addr;

                addr = ((dma_address>=0x80000000 && dma_address<0x90000000)?(dma_address&0x7fffffff):dma_address) + 0x9800000000000000UL;
                do { (void) (addr); (void) (size); } while (0);
        }
}
# 186 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
                             int nents, int direction)
{
        int i;

        if (direction == 3)
                __out_of_line_bug(192);

        for (i = 0; i < nents; i++, sg++) {
                if (sg->address && sg->page)
                        __out_of_line_bug(196);
                else if (!sg->address && !sg->page)
                        __out_of_line_bug(198);

                if (sg->address) {
                        do { (void) ((unsigned long)sg->address); (void) (sg->length); } while (0);

                        sg->dma_address = ((((unsigned long) (sg->address) - 0x9800000000000000UL)<0x10000000)?((((unsigned long) (sg->address) - 0x9800000000000000UL))|0x80000000):((unsigned long) (sg->address) - 0x9800000000000000UL));
                } else {
                        sg->dma_address = ((sg->page - mem_map) << 14) +
                                          sg->offset;
                        do { (void) ((unsigned long) (((void *)((unsigned long) ((((sg->page) - page_zone(sg->page)->zone_mem_map) << 14) + page_zone(sg->page)->zone_start_paddr) + 0x9800000000000000UL)) + sg->offset)); (void) (sg->length); } while (0);


                }
        }

        return nents;
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
                                int nents, int direction)
{
        int i;

        if (direction == 3)
                __out_of_line_bug(227);

        if (direction == 1)
                return;

        for (i = 0; i < nents; i++, sg++) {
                if (sg->address && sg->page)
                        __out_of_line_bug(234);
                else if (!sg->address && !sg->page)
                        __out_of_line_bug(236);

                if (!sg->address)
                        continue;
                do { (void) ((unsigned long)sg->address); (void) (sg->length); } while (0);
        }
}
# 254 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pci_dma_sync_single(struct pci_dev *hwdev,
                                       dma_addr_t dma_handle,
                                       size_t size, int direction)
{
        unsigned long addr;

        if (direction == 3)
                __out_of_line_bug(261);

        addr = ((dma_handle>=0x80000000 && dma_handle<0x90000000)?(dma_handle&0x7fffffff):dma_handle) + 0x9800000000000000UL;
        do { (void) (addr); (void) (size); } while (0);
}
# 274 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pci_dma_sync_sg(struct pci_dev *hwdev,
                                   struct scatterlist *sg,
                                   int nelems, int direction)
{




        if (direction == 3)
                __out_of_line_bug(283);






}







static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
{
# 310 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pci.h"
        return 1;
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) dma64_addr_t pci_dac_page_to_dma(struct pci_dev *pdev,
        struct page *page, unsigned long offset, int direction)
{
        dma64_addr_t addr = ((page - mem_map) << 14) + offset;

        return (dma64_addr_t) ((addr<0x10000000)?((addr)|0x80000000):addr);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct page *pci_dac_dma_to_page(struct pci_dev *pdev,
        dma64_addr_t dma_addr)
{
        unsigned long poff = ((dma_addr>=0x80000000 && dma_addr<0x90000000)?(dma_addr&0x7fffffff):dma_addr) >> 14;

        return mem_map + poff;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long pci_dac_dma_to_offset(struct pci_dev *pdev,
        dma64_addr_t dma_addr)
{
        return dma_addr & ~(~((1UL << 14)-1));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pci_dac_dma_sync_single(struct pci_dev *pdev,
        dma64_addr_t dma_addr, size_t len, int direction)
{
        unsigned long addr;

        if (direction == 3)
                do { __asm__ __volatile__("break %0" : : "i" (512)); } while (0);

        addr = ((dma_addr>=0x80000000 && dma_addr<0x90000000)?(dma_addr&0x7fffffff):dma_addr) + 0x9800000000000000UL;
        do { (void) (addr); (void) (len); } while (0);
}
# 684 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h" 2
# 750 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pci_module_init(struct pci_driver *drv)
{
        int rc = pci_register_driver (drv);

        if (rc > 0)
                return 0;






        if (rc == 0)
                return 0;







        pci_unregister_driver (drv);

        return rc;
}
# 795 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void *pci_get_drvdata (struct pci_dev *pdev)
{
        return pdev->driver_data;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pci_set_drvdata (struct pci_dev *pdev, void *data)
{
        pdev->driver_data = data;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) char *pci_name(struct pci_dev *pdev)
{
        return pdev->slot_name;
}
# 817 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pci.h"
struct pci_fixup {
        int pass;
        u16 vendor, device;
        void (*hook)(struct pci_dev *dev);
};

extern struct pci_fixup pcibios_fixups[];




void pci_fixup_device(int pass, struct pci_dev *dev);

extern int pci_pci_problems;
# 2 "drivers/debug26/lib/pci.c" 2
static int __syscall1(int type,unsigned long long addr,union commondata *mydata);
static int __syscall2(int type,unsigned long long addr,union commondata *mydata);
extern int (*syscall1)(int type,unsigned long long addr,union commondata *mydata);
extern int (*syscall2)(int type,unsigned long long addr,union commondata *mydata);

static struct _mypciinfo{
        int bus;
        int device;
        int function;
} mpi;


static struct pci_dev *pcidev;
static int __pcisyscall1(int type,unsigned long long addr,union commondata *mydata)
{
int readdata=0;
switch(type)
{
case 1:pci_read_config_byte(pcidev,addr,(void *)&readdata);mydata->data1=readdata;break;
case 2:pci_read_config_word(pcidev,addr,(void *)&readdata);mydata->data2=readdata;break;
case 4:pci_read_config_dword(pcidev,addr,&readdata);mydata->data4=readdata;break;
case 8:pci_read_config_dword(pcidev,addr,&readdata);mydata->data8[0]=readdata;
        pci_read_config_dword(pcidev,addr+4,&readdata);mydata->data8[1]=readdata;break;
}
return 0;
}

static int __pcisyscall2(int type,unsigned long long addr,union commondata *mydata)
{
switch(type)
{
case 1:return pci_write_config_byte(pcidev,addr,mydata->data1);
case 2:return pci_write_config_word(pcidev,addr,mydata->data2);
case 4:return pci_write_config_dword(pcidev,addr,mydata->data4);
case 8:break;
}
return -1;
}
static char *str2addmsg[]={"64 bit cpu address","iomap address","64 bit cached phyiscal address","64 bit uncached phyiscal address"};
struct pci_dev *
pci_find_slot(unsigned int bus, unsigned int devfn);

static struct pci_bus *pci_find_bus(int busno)
{
        struct pci_bus *b = ((void *)0);
        for(b = ((struct pci_bus *)((char *)(pci_root_buses.next)-(unsigned long)(&((struct pci_bus *)0)->node))); b != ((struct pci_bus *)((char *)(&pci_root_buses)-(unsigned long)(&((struct pci_bus *)0)->node))); b = ((struct pci_bus *)((char *)(b->node.next)-(unsigned long)(&((struct pci_bus *)0)->node))))
        if(b->number == busno)
         return b;
        return ((void *)0);
}
static int PciConfSel(int argc,char **argv)
{
                struct pci_bus *bus;

                if(argc<2||argc>4){return -1;}
                if(argc>=2)mpi.bus=simple_strtol(argv[1],0,0);
                if(argc>=3)mpi.device=simple_strtol(argv[2],0,0);
                if(argc>=4)mpi.function=simple_strtol(argv[3],0,0);
                pcidev=(void *)0;
                bus = pci_find_bus(mpi.bus);
                if(bus)
                {
                        static struct pci_dev dev;
                        pcidev=(void *)pci_find_slot(mpi.bus,(mpi.device<<3)|mpi.function);
                        prom_printf("select pci configure space bus:%d dev:%d func:%d\n",mpi.bus,mpi.device,mpi.function);
                        if(!pcidev)
                        {
                                dev.bus=bus;
                                dev.devfn=(mpi.device<<3)| mpi.function;
                                pcidev = &dev;
                        }
                        syscall1=__pcisyscall1;
                        syscall2=__pcisyscall2;
                }
                else
                {
                prom_printf("can not find the bus\n");
                if(argc==2){
                int type=simple_strtol(argv[1],0,10);
        syscall1=__syscall1;
        syscall2=__syscall2;
        setenv("iomap",argv[1],0);
        prom_printf("select normal memory(%s)\n",str2addmsg[type&3]);
                }
                }
                return 0;
}


struct mycmd __mycmd_pcs __attribute__ ((unused,__section__ (".mycmd"))) = {"pcs",PciConfSel,"pcs bus [dev] [func]","Pci Configure sel,bus==-1 for normal memory access"};;
# 10 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/exec.c" 1



static char * envp_init[8 +2] = { "HOME=/", "TERM=linux", ((void *)0), };

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pid_t waitpid(pid_t pid, int * wait_stat, int options) { register unsigned long __a0 asm("$4") = (unsigned long) pid; register unsigned long __a1 asm("$5") = (unsigned long) wait_stat; register unsigned long __a2 asm("$6") = (unsigned long) options; register unsigned long __a3 asm("$7"); unsigned long __v0; __asm__ volatile ( ".set\tnoreorder\n\t" "li\t$2, %5\t\t\t# " "waitpid" "\n\t" "syscall\n\t" "move\t%0, $2\n\t" ".set\treorder" : "=&r" (__v0), "=r" (__a3) : "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_waitpid) : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "memory"); if (__a3 == 0) return (pid_t) __v0; errno = __v0; return (pid_t) -1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pid_t wait(int * wait_stat)
{
        return waitpid(-1,wait_stat,0);
}

static void execcmd(char **argv)
{
char path[]="/sbin/:/bin/:/usr/sbin/:/usr/bin/:/usr/local/sbin/:/usr/local/bin/";
char *token;
char *oldcmd=argv[0];
char newcmd[100];
mm_segment_t old_fs;
old_fs=(current->thread.current_ds);
(current->thread.current_ds = (((mm_segment_t) { 0UL })));
execve(argv[0],argv,envp_init);
   while(1)
   {
        token = strsep((char **)&path,":");
        if(!token||!*token)break;
        strcpy(newcmd,token);
        strcat(newcmd,oldcmd);
        argv[0]=newcmd;
        execve(argv[0],argv,envp_init);
   }
(current->thread.current_ds = (old_fs));
prom_printf("Bad exe name\n");
}


static int sh(int argc,char **argv)
{
        int id,i;
        char str[200];
 if(argc>1)
  {
        strcpy(str,argv[1]);
        for(i=2;i<argc;i++)
        {
                strcat(str," ");
                strcat(str,argv[i]);
        }
        argv[0]="/bin/sh";
        argv[1]="-c";
        argv[2]=str;
        argv[3]=0;
  }
 else
 {
        argv[0]="/bin/sh";
        argv[1]=0;
 }
        id=kernel_thread((void *)execcmd,argv,0);
        waitpid(id,((void *)0),0x80000000);
        return 0;
}


static int exec(int argc,char **argv)
{
        int id;
        if(argc<2)return -1;
        argv[argc]=0;
        id=kernel_thread((void *)execcmd,&argv[1],0);
        waitpid(id,((void *)0),0x80000000);
        return 0;
}

struct mycmd __mycmd_exec __attribute__ ((unused,__section__ (".mycmd"))) = {"exec",exec,"exec /sbin/ls -l /","execute a linux command"};;
struct mycmd __mycmd_sh __attribute__ ((unused,__section__ (".mycmd"))) = {"sh",sh,"sh pwd","execute a shell command"};;
# 11 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/writefile.c" 1

static int writefile(int argc,char **argv)
{
unsigned long addr,size,step;
char *pchar;
int fd;
mm_segment_t old_fs;
        if(argc!=5)
        {return -1;}
        addr=simple_strtol(argv[2],0,0);
        size=simple_strtol(argv[3],0,0);
        step=simple_strtol(argv[4],0,0);

pchar=(!strcmp(argv[0],"wf_ioremap"))?ioremap(addr,size):addr;
prom_printf("addr=%lx,pchar=%p,size=%lx\n",addr,pchar,size);
old_fs=(current->thread.current_ds);
(current->thread.current_ds = (((mm_segment_t) { 0UL })));
fd=open(argv[1],0x0100|0x0001|0x0200,0);
while(size)
{
prom_printf("addr=%lx\n",pchar);
write(fd,pchar,({ const typeof(step) _x = (step); const typeof(size) _y = (size); (void) (&_x == &_y); _x < _y ? _x : _y; }));
pchar+=step;
size -=({ const typeof(step) _x = (step); const typeof(size) _y = (size); (void) (&_x == &_y); _x < _y ? _x : _y; });
}
close(fd);
(current->thread.current_ds = (old_fs));
return 0;
}

static int mydumpaddr(int argc,char **argv)
{
unsigned long addr,size,step,count;
volatile int *pchar;
        if(argc!=4)
        {return -1;}
        addr=simple_strtol(argv[1],0,0);
        size=simple_strtol(argv[2],0,0);
        step=simple_strtol(argv[3],0,0);

pchar=addr;
prom_printf("addr=%lx,pchar=%p,size=%lx\n",addr,pchar,size);
count=0;
while(size>0)
{
if((count%step)==0)prom_printf("addr=%llx\n",pchar);
*pchar;
pchar++;
size=-4;
count+=4;
}
return 0;
}

struct mycmd __mycmd_dumpaddr __attribute__ ((unused,__section__ (".mycmd"))) = {"dumpaddr",mydumpaddr,"mydumpaddr addr size step","dump memory"};;
struct mycmd __mycmd_wf __attribute__ ((unused,__section__ (".mycmd"))) = {"wf",writefile,"wf filename addr size step","write memory into file"};;
struct mycmd __mycmd_wf_ioremap __attribute__ ((unused,__section__ (".mycmd"))) = {"wf_ioremap",writefile,"wf_ioremap filename iomapaddr size","write memory into file"};;
# 12 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/pcibus.c" 1




int pcibus(int argc,char **argv)
{
struct pci_bus *bus;
struct pci_dev *dev=0;
for(dev = ((struct pci_dev *)((char *)(pci_devices.next)-(unsigned long)(&((struct pci_dev *)0)->global_list))); dev != ((struct pci_dev *)((char *)(&pci_devices)-(unsigned long)(&((struct pci_dev *)0)->global_list))); dev = ((struct pci_dev *)((char *)(dev->global_list.next)-(unsigned long)(&((struct pci_dev *)0)->global_list)))) {

        if((bus=dev->subordinate))
        {
                prom_printf("bus %d at bus %d  dev %d  func %d\n",bus->number,dev->bus->number,dev->devfn>>3,dev->devfn&7);
        }
                }
return 0;
}

static int pcisave(int argc,char **argv)
{
struct pci_dev *dev=0;
unsigned int data;
int i;
prom_printf("static int pciload(struct pci_ops *ops){\n" "struct pci_bus bus;\n" "struct pci_dev dev;\n" "bus.ops=ops;\n" "dev.bus=&bus;\n"





);

for(dev = ((struct pci_dev *)((char *)(pci_devices.next)-(unsigned long)(&((struct pci_dev *)0)->global_list))); dev != ((struct pci_dev *)((char *)(&pci_devices)-(unsigned long)(&((struct pci_dev *)0)->global_list))); dev = ((struct pci_dev *)((char *)(dev->global_list.next)-(unsigned long)(&((struct pci_dev *)0)->global_list)))) {

prom_printf("//bus=%d,device=%d,func=%d\n" "bus.number=0x%x;\n" "dev.devfn=0x%x;\n" ,dev->bus->number,(((dev->devfn) >> 3) & 0x1f),((dev->devfn) & 0x07),dev->bus->number,dev->devfn);




prom_printf("//vendor=0x%04x,device=0x%04x,class=%06x(3 bytes: base,sub,prog-if)\n",dev->vendor,dev->device,dev->class);
for(i=0xc;i<0x28;i+=4)
{
pci_read_config_dword(dev,i,&data);
prom_printf("pci_write_config_dword(&dev,0x%x,0x%x);\n",i,data);

}
i=0x30;
pci_read_config_dword(dev,i,&data);
prom_printf("pci_write_config_dword(&dev,0x%x,0x%x);\n",i,data);

i=0x3c;
pci_read_config_dword(dev,i,&data);
prom_printf("pci_write_config_dword(&dev,0x%x,0x%x);\n",i,data);


                }
prom_printf("\n}\n");

return 0;
}
struct mycmd __mycmd_pb __attribute__ ((unused,__section__ (".mycmd"))) = {"pb",pcibus,"pb","pcibus"};;
struct mycmd __mycmd_pcisave __attribute__ ((unused,__section__ (".mycmd"))) = {"pcisave",pcisave,"pb","pcibus"};;
# 13 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/pager.c" 1
# 14 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/io.c" 1


static int __syscall1(int type,unsigned long long addr,union commondata *mydata);
static int __syscall2(int type,unsigned long long addr,union commondata *mydata);
extern int (*syscall1)(int type,unsigned long long addr,union commondata *mydata);
extern int (*syscall2)(int type,unsigned long long addr,union commondata *mydata);


static int __iosyscall1(int type,unsigned long long addr,union commondata *mydata)
{
switch(type)
{
case 1:mydata->data1=inb(addr);break;
case 2:mydata->data2=inw(addr);break;
case 4:mydata->data4=inl(addr);break;
case 8:mydata->data8[0]=inl(addr);
           mydata->data8[1]=inl(addr+4);break;
}
return 0;
}

static int __iosyscall2(int type,unsigned long long addr,union commondata *mydata)
{
switch(type)
{
case 1:do { *(volatile u8 *)(mips_io_port_base + (addr)) = (mydata->data1); } while(0);return 0;
case 2:do { *(volatile u16 *)(mips_io_port_base + (addr)) = (mydata->data2); } while(0);return 0;
case 4:do { *(volatile u32 *)(mips_io_port_base + (addr)) = (mydata->data4);} while(0);return 0;
case 8:break;
}
return -1;
}


static int IoS(int argc,char **argv)
{
int num=0;
                if(argc>2){prom_printf("ios [num]\n");return -1;}
                if(argc==2)num=simple_strtol(argv[1],0,0);
                if(num!=-1)
                {
        prom_printf("select io space\n");
        syscall1=__iosyscall1;
        syscall2=__iosyscall2;
                }
                else {
        syscall1=__syscall1;
        syscall2=__syscall2;
        prom_printf("select normal memory space\n");
                }
                return 0;
}
struct mycmd __mycmd_ios __attribute__ ((unused,__section__ (".mycmd"))) = {"ios",IoS,"ios [num]","io space select ,num==-1 for normal memory access"};;
# 15 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/echo.c" 1
static int echo(int argc,char **argv)
{
        int i;
if(!strcmp(argv[0],"echo_on")){showcmd=1;return 0;}
else if(!strcmp(argv[0],"echo_off")){showcmd=0;return 0;}

        for(i=1;i<argc;i++)
        prom_printf("%s ",argv[i]);
        prom_printf("\n");
return 0;
}

struct mycmd __mycmd_echo __attribute__ ((unused,__section__ (".mycmd"))) = {"echo",echo,"cmds","echo"};;
struct mycmd __mycmd_echo_on __attribute__ ((unused,__section__ (".mycmd"))) = {"echo_on",echo,"","echo on"};;
struct mycmd __mycmd_echo_off __attribute__ ((unused,__section__ (".mycmd"))) = {"echo_off",echo,"","echo off"};;
# 16 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/loop.c" 1
static int loop(int argc,char **argv)
{
        int count;
        int len;
        static char buf[1024];
        if(argc!=3)return -1;
        count=simple_strtol(argv[1],0,0);
        len=strlen(argv[2]);
        if(len>1024)len=1024;
        while(count--)
        { strncpy(buf,argv[2],len);
                do_cmd(buf);
        }
return 0;
}

struct mycmd __mycmd_loop __attribute__ ((unused,__section__ (".mycmd"))) = {"loop",loop,"count cmds","run cmds for count times"};;
# 17 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/testvga.c" 1
# 18 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/ifconfig.c" 1
# 19 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/chroot.c" 1
# 20 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/ramdisk.c" 1
# 11 "drivers/debug26/lib/ramdisk.c"
typedef unsigned char uch;
typedef unsigned short ush;
typedef unsigned long ulg;





static uch *inbuf;
static uch *window;

static unsigned insize;
static unsigned inptr;
static unsigned outcnt;
static int exit_code;
static long bytes_out;
static int crd_outfd;
# 41 "drivers/debug26/lib/ramdisk.c"
static void flush_window(void);
static void *malloc(int size);
static void free(void *where);
static void error(char *m);
static void gzip_mark(void **);
static void gzip_release(void **);

# 1 "drivers/debug26/lib/inflate.c" 1
# 130 "drivers/debug26/lib/inflate.c"
struct huft {
  uch e;
  uch b;
  union {
    ush n;
    struct huft *t;
  } v;
};



static int huft_build (unsigned *, unsigned, unsigned, const ush *, const ush *, struct huft **, int *);

static int huft_free (struct huft *);
static int inflate_codes (struct huft *, struct huft *, int, int);
static int inflate_stored (void);
static int inflate_fixed (void);
static int inflate_dynamic (void);
static int inflate_block (int *);
static int inflate (void);
# 165 "drivers/debug26/lib/inflate.c"
static const unsigned border[] = {
        16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
static const ush cplens[] = {
        3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
        35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0};

static const ush cplext[] = {
        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
        3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0, 99, 99};
static const ush cpdist[] = {
        1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
        257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
        8193, 12289, 16385, 24577};
static const ush cpdext[] = {
        0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
        7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
        12, 12, 13, 13};
# 215 "drivers/debug26/lib/inflate.c"
static ulg bb;
static unsigned bk;

static const ush mask_bits[] = {
    0x0000,
    0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
    0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff
};
# 262 "drivers/debug26/lib/inflate.c"
static const int lbits = 9;
static const int dbits = 6;







static unsigned hufts;


static int huft_build(b, n, s, d, e, t, m)
unsigned *b;
unsigned n;
unsigned s;
const ush *d;
const ush *e;
struct huft **t;
int *m;





{
  unsigned a;
  unsigned c[16 +1];
  unsigned f;
  int g;
  int h;
  register unsigned i;
  register unsigned j;
  register int k;
  int l;
  register unsigned *p;
  register struct huft *q;
  struct huft r;
  struct huft *u[16];
  unsigned v[288];
  register int w;
  unsigned x[16 +1];
  unsigned *xp;
  int y;
  unsigned z;

;


  memset ((c), 0, (sizeof(c)));
  p = b; i = n;
  do {
    ;

    c[*p]++;
    p++;
  } while (--i);
  if (c[0] == n)
  {
    *t = (struct huft *)((void *)0);
    *m = 0;
    return 0;
  }

;


  l = *m;
  for (j = 1; j <= 16; j++)
    if (c[j])
      break;
  k = j;
  if ((unsigned)l < j)
    l = j;
  for (i = 16; i; i--)
    if (c[i])
      break;
  g = i;
  if ((unsigned)l > i)
    l = i;
  *m = l;

;


  for (y = 1 << j; j < i; j++, y <<= 1)
    if ((y -= c[j]) < 0)
      return 2;
  if ((y -= c[i]) < 0)
    return 2;
  c[i] += y;

;


  x[1] = j = 0;
  p = c + 1; xp = x + 2;
  while (--i) {
    *xp++ = (j += *p++);
  }

;


  p = b; i = 0;
  do {
    if ((j = *p++) != 0)
      v[x[j]++] = i;
  } while (++i < n);

;


  x[0] = i = 0;
  p = v;
  h = -1;
  w = -l;
  u[0] = (struct huft *)((void *)0);
  q = (struct huft *)((void *)0);
  z = 0;
;


  for (; k <= g; k++)
  {
;
    a = c[k];
    while (a--)
    {
;


      while (k > w + l)
      {
;
        h++;
        w += l;


        z = (z = g - w) > (unsigned)l ? l : z;
        if ((f = 1 << (j = k - w)) > a + 1)
        {
;
          f -= a + 1;
          xp = c + k;
          while (++j < z)
          {
            if ((f <<= 1) <= *++xp)
              break;
            f -= *xp;
          }
        }
;
        z = 1 << j;


        if ((q = (struct huft *)malloc((z + 1)*sizeof(struct huft))) ==
            (struct huft *)((void *)0))
        {
          if (h)
            huft_free(u[0]);
          return 3;
        }
;
        hufts += z + 1;
        *t = q + 1;
        *(t = &(q->v.t)) = (struct huft *)((void *)0);
        u[h] = ++q;

;

        if (h)
        {
          x[h] = i;
          r.b = (uch)l;
          r.e = (uch)(16 + j);
          r.v.t = q;
          j = i >> (w - l);
          u[h-1][j] = r;
        }
;
      }
;


      r.b = (uch)(k - w);
      if (p >= v + n)
        r.e = 99;
      else if (*p < s)
      {
        r.e = (uch)(*p < 256 ? 16 : 15);
        r.v.n = (ush)(*p);
        p++;
      }
      else
      {
        r.e = (uch)e[*p - s];
        r.v.n = d[*p++ - s];
      }
;


      f = 1 << (k - w);
      for (j = i >> w; j < z; j += f)
        q[j] = r;


      for (j = 1 << (k - 1); i & j; j >>= 1)
        i ^= j;
      i ^= j;


      while ((i & ((1 << w) - 1)) != x[h])
      {
        h--;
        w -= l;
      }
;
    }
;
  }

;


  return y != 0 && g != 1;
}



static int huft_free(t)
struct huft *t;



{
  register struct huft *p, *q;



  p = t;
  while (p != (struct huft *)((void *)0))
  {
    q = (--p)->v.t;
    free((char*)p);
    p = q;
  }
  return 0;
}


static int inflate_codes(tl, td, bl, bd)
struct huft *tl, *td;
int bl, bd;


{
  register unsigned e;
  unsigned n, d;
  unsigned w;
  struct huft *t;
  unsigned ml, md;
  register ulg b;
  register unsigned k;



  b = bb;
  k = bk;
  w = outcnt;


  ml = mask_bits[bl];
  md = mask_bits[bd];
  for (;;)
  {
    {while(k<((unsigned)bl)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
    if ((e = (t = tl + ((unsigned)b & ml))->e) > 16)
      do {
        if (e == 99)
          return 1;
        {b>>=(t->b);k-=(t->b);}
        e -= 16;
        {while(k<(e)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
      } while ((e = (t = t->v.t + ((unsigned)b & mask_bits[e]))->e) > 16);
    {b>>=(t->b);k-=(t->b);}
    if (e == 16)
    {
      window[w++] = (uch)t->v.n;
      ;
      if (w == 0x10000)
      {
        (outcnt=(w),flush_window());
        w = 0;
      }
    }
    else
    {

      if (e == 15)
        break;


      {while(k<(e)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
      n = t->v.n + ((unsigned)b & mask_bits[e]);
      {b>>=(e);k-=(e);};


      {while(k<((unsigned)bd)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
      if ((e = (t = td + ((unsigned)b & md))->e) > 16)
        do {
          if (e == 99)
            return 1;
          {b>>=(t->b);k-=(t->b);}
          e -= 16;
          {while(k<(e)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
        } while ((e = (t = t->v.t + ((unsigned)b & mask_bits[e]))->e) > 16);
      {b>>=(t->b);k-=(t->b);}
      {while(k<(e)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
      d = w - t->v.n - ((unsigned)b & mask_bits[e]);
      {b>>=(e);k-=(e);}
      ;


      do {
        n -= (e = (e = 0x10000 - ((d &= 0x10000 -1) > w ? d : w)) > n ? n : e);

        if (w - d >= e)
        {
          memcpy(window + w, window + d, e);
          w += e;
          d += e;
        }
        else

          do {
            window[w++] = window[d++];
            ;
          } while (--e);
        if (w == 0x10000)
        {
          (outcnt=(w),flush_window());
          w = 0;
        }
      } while (n);
    }
  }



  outcnt = w;
  bb = b;
  bk = k;


  return 0;
}



static int inflate_stored()

{
  unsigned n;
  unsigned w;
  register ulg b;
  register unsigned k;

;


  b = bb;
  k = bk;
  w = outcnt;



  n = k & 7;
  {b>>=(n);k-=(n);};



  {while(k<(16)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
  n = ((unsigned)b & 0xffff);
  {b>>=(16);k-=(16);}
  {while(k<(16)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
  if (n != (unsigned)((~b) & 0xffff))
    return 1;
  {b>>=(16);k-=(16);}



  while (n--)
  {
    {while(k<(8)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
    window[w++] = (uch)b;
    if (w == 0x10000)
    {
      (outcnt=(w),flush_window());
      w = 0;
    }
    {b>>=(8);k-=(8);}
  }



  outcnt = w;
  bb = b;
  bk = k;

  ;
  return 0;
}



static int inflate_fixed()



{
  int i;
  struct huft *tl;
  struct huft *td;
  int bl;
  int bd;
  unsigned l[288];

;


  for (i = 0; i < 144; i++)
    l[i] = 8;
  for (; i < 256; i++)
    l[i] = 9;
  for (; i < 280; i++)
    l[i] = 7;
  for (; i < 288; i++)
    l[i] = 8;
  bl = 7;
  if ((i = huft_build(l, 288, 257, cplens, cplext, &tl, &bl)) != 0)
    return i;



  for (i = 0; i < 30; i++)
    l[i] = 5;
  bd = 5;
  if ((i = huft_build(l, 30, 0, cpdist, cpdext, &td, &bd)) > 1)
  {
    huft_free(tl);

    ;
    return i;
  }



  if (inflate_codes(tl, td, bl, bd))
    return 1;



  huft_free(tl);
  huft_free(td);
  return 0;
}



static int inflate_dynamic()

{
  int i;
  unsigned j;
  unsigned l;
  unsigned m;
  unsigned n;
  struct huft *tl;
  struct huft *td;
  int bl;
  int bd;
  unsigned nb;
  unsigned nl;
  unsigned nd;



  unsigned ll[286+30];

  register ulg b;
  register unsigned k;

;


  b = bb;
  k = bk;



  {while(k<(5)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
  nl = 257 + ((unsigned)b & 0x1f);
  {b>>=(5);k-=(5);}
  {while(k<(5)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
  nd = 1 + ((unsigned)b & 0x1f);
  {b>>=(5);k-=(5);}
  {while(k<(4)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
  nb = 4 + ((unsigned)b & 0xf);
  {b>>=(4);k-=(4);}



  if (nl > 286 || nd > 30)

    return 1;

;


  for (j = 0; j < nb; j++)
  {
    {while(k<(3)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
    ll[border[j]] = (unsigned)b & 7;
    {b>>=(3);k-=(3);}
  }
  for (; j < 19; j++)
    ll[border[j]] = 0;

;


  bl = 7;
  if ((i = huft_build(ll, 19, 19, ((void *)0), ((void *)0), &tl, &bl)) != 0)
  {
    if (i == 1)
      huft_free(tl);
    return i;
  }

;


  n = nl + nd;
  m = mask_bits[bl];
  i = l = 0;
  while ((unsigned)i < n)
  {
    {while(k<((unsigned)bl)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
    j = (td = tl + ((unsigned)b & m))->b;
    {b>>=(j);k-=(j);}
    j = td->v.n;
    if (j < 16)
      ll[i++] = l = j;
    else if (j == 16)
    {
      {while(k<(2)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
      j = 3 + ((unsigned)b & 3);
      {b>>=(2);k-=(2);}
      if ((unsigned)i + j > n)
        return 1;
      while (j--)
        ll[i++] = l;
    }
    else if (j == 17)
    {
      {while(k<(3)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
      j = 3 + ((unsigned)b & 7);
      {b>>=(3);k-=(3);}
      if ((unsigned)i + j > n)
        return 1;
      while (j--)
        ll[i++] = 0;
      l = 0;
    }
    else
    {
      {while(k<(7)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
      j = 11 + ((unsigned)b & 0x7f);
      {b>>=(7);k-=(7);}
      if ((unsigned)i + j > n)
        return 1;
      while (j--)
        ll[i++] = 0;
      l = 0;
    }
  }

;


  huft_free(tl);

;


  bb = b;
  bk = k;

;


  bl = lbits;
  if ((i = huft_build(ll, nl, 257, cplens, cplext, &tl, &bl)) != 0)
  {
;
    if (i == 1) {
      error(" incomplete literal tree\n");
      huft_free(tl);
    }
    return i;
  }
;
  bd = dbits;
  if ((i = huft_build(ll + nl, nd, 0, cpdist, cpdext, &td, &bd)) != 0)
  {
;
    if (i == 1) {
      error(" incomplete distance tree\n");




      huft_free(td);
    }
    huft_free(tl);
    return i;

  }

;


  if (inflate_codes(tl, td, bl, bd))
    return 1;

;


  huft_free(tl);
  huft_free(td);

  ;
  return 0;
}



static int inflate_block(e)
int *e;

{
  unsigned t;
  register ulg b;
  register unsigned k;

  ;


  b = bb;
  k = bk;



  {while(k<(1)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
  *e = (int)b & 1;
  {b>>=(1);k-=(1);}



  {while(k<(2)){b|=((ulg)(uch)(inbuf[inptr++]))<<k;k+=8;}}
  t = (unsigned)b & 3;
  {b>>=(2);k-=(2);}



  bb = b;
  bk = k;


  if (t == 2)
    return inflate_dynamic();
  if (t == 0)
    return inflate_stored();
  if (t == 1)
    return inflate_fixed();

  ;


  return 2;
}



static int inflate()

{
  int e;
  int r;
  unsigned h;
  void *ptr;


  outcnt = 0;
  bk = 0;
  bb = 0;



  h = 0;
  do {
    hufts = 0;
    gzip_mark(&ptr);
    if ((r = inflate_block(&e)) != 0) {
      gzip_release(&ptr);
      return r;
    }
    gzip_release(&ptr);
    if (hufts > h)
      h = hufts;
  } while (!e);




  while (bk >= 8) {
    bk -= 8;
    inptr--;
  }


  (outcnt=(outcnt),flush_window());






  return 0;
}







static ulg crc_32_tab[256];
static ulg crc;







static void
makecrc(void)
{


  unsigned long c;
  unsigned long e;
  int i;
  int k;


  static const int p[] = {0,1,2,4,5,7,8,10,11,12,16,22,23,26};


  e = 0;
  for (i = 0; i < sizeof(p)/sizeof(int); i++)
    e |= 1L << (31 - p[i]);

  crc_32_tab[0] = 0;

  for (i = 1; i < 256; i++)
  {
    c = 0;
    for (k = i | 256; k != 1; k >>= 1)
    {
      c = c & 1 ? (c >> 1) ^ e : c >> 1;
      if (k & 1)
        c ^= e;
    }
    crc_32_tab[i] = c;
  }


  crc = (ulg)0xffffffffUL;
}
# 1067 "drivers/debug26/lib/inflate.c"
static int gunzip(void)
{
    uch flags;
    unsigned char magic[2];
    char method;
    ulg orig_crc = 0;
    ulg orig_len = 0;
    int res;

    magic[0] = (unsigned char)(inbuf[inptr++]);
    magic[1] = (unsigned char)(inbuf[inptr++]);
    method = (unsigned char)(inbuf[inptr++]);

    if (magic[0] != 037 ||
        ((magic[1] != 0213) && (magic[1] != 0236))) {
            error("bad gzip magic numbers");
            return -1;
    }


    if (method != 8) {
            error("internal error, invalid method");
            return -1;
    }

    flags = (uch)(inbuf[inptr++]);
    if ((flags & 0x20) != 0) {
            error("Input is encrypted\n");
            return -1;
    }
    if ((flags & 0x02) != 0) {
            error("Multi part input\n");
            return -1;
    }
    if ((flags & 0xC0) != 0) {
            error("Input has invalid flags\n");
            return -1;
    }
    (ulg)(inbuf[inptr++]);
    ((ulg)(inbuf[inptr++])) << 8;
    ((ulg)(inbuf[inptr++])) << 16;
    ((ulg)(inbuf[inptr++])) << 24;

    (void)(inbuf[inptr++]);
    (void)(inbuf[inptr++]);

    if ((flags & 0x04) != 0) {
            unsigned len = (unsigned)(inbuf[inptr++]);
            len |= ((unsigned)(inbuf[inptr++]))<<8;
            while (len--) (void)(inbuf[inptr++]);
    }


    if ((flags & 0x08) != 0) {

            while ((inbuf[inptr++]) != 0) ;
    }


    if ((flags & 0x10) != 0) {
            while ((inbuf[inptr++]) != 0) ;
    }


    if ((res = inflate())) {
            switch (res) {
            case 0:
                    break;
            case 1:
                    error("invalid compressed format (err=1)");
                    break;
            case 2:
                    error("invalid compressed format (err=2)");
                    break;
            case 3:
                    error("out of memory");
                    break;
            default:
                    error("invalid compressed format (other)");
            }
            return -1;
    }





    orig_crc = (ulg) (inbuf[inptr++]);
    orig_crc |= (ulg) (inbuf[inptr++]) << 8;
    orig_crc |= (ulg) (inbuf[inptr++]) << 16;
    orig_crc |= (ulg) (inbuf[inptr++]) << 24;

    orig_len = (ulg) (inbuf[inptr++]);
    orig_len |= (ulg) (inbuf[inptr++]) << 8;
    orig_len |= (ulg) (inbuf[inptr++]) << 16;
    orig_len |= (ulg) (inbuf[inptr++]) << 24;


    if (orig_crc != (crc ^ 0xffffffffUL)) {
            error("crc error");
            return -1;
    }
    if (orig_len != bytes_out) {
            error("length error");
            return -1;
    }
    return 0;
}
# 49 "drivers/debug26/lib/ramdisk.c" 2

static void __attribute__ ((__section__ (".text.init"))) *malloc(int size)
{
        return kmalloc(size, (0x20 | 0x10 | 0x40 | 0x80 | 0x100));
}

static void __attribute__ ((__section__ (".text.init"))) free(void *where)
{
        kfree(where);
}

static void __attribute__ ((__section__ (".text.init"))) gzip_mark(void **ptr)
{
}

static void __attribute__ ((__section__ (".text.init"))) gzip_release(void **ptr)
{
}






static void __attribute__ ((__section__ (".text.init"))) flush_window(void)
{
    ulg c = crc;
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

static void __attribute__ ((__section__ (".text.init"))) error(char *x)
{
        printk("<3>" "%s", x);
        exit_code = 1;
}





extern void * __rd_start, * __rd_end;

static int __attribute__ ((__section__ (".text.init"))) setup_ramdisk()
{
        int result;
        unsigned long initrd_start;
        unsigned long initrd_end;
        mm_segment_t oldfs;


        oldfs=(current->thread.current_ds);
        (current->thread.current_ds = (((mm_segment_t) { 0UL })));
        initrd_start = (unsigned long)&__rd_start;
    initrd_end = (unsigned long)&__rd_end;


        insize = initrd_end-initrd_start;
        inptr = 0;
        outcnt = 0;
        exit_code = 0;
        bytes_out = 0;
        crc = (ulg)0xffffffffL;

        mknod("/ram1", 0060000|0700, (((1) << 8) | (1)));
        result=crd_outfd=open("/ram1",0x0002,0);
        if(crd_outfd<0){printk("<1>open /ram0 error\n");goto error;}

        if(ROOT_DEV!=(((1) << 8) | (1))){
        write(crd_outfd,initrd_start ,(initrd_end-initrd_start));
        result=-1;goto error0;
        }

        printk("<0>unpack ramdisk now...00%%",initrd_start,initrd_end);
        inbuf = (void *)initrd_start;

        window = kmalloc(0x10000, (0x20 | 0x10 | 0x40 | 0x80 | 0x100));
        if (window == 0) {
                printk("<3>" "RAMDISK: Couldn't allocate gzip window\n");
                kfree(inbuf);
                result=-1;
                goto error0;
        }
        makecrc();
        result = gunzip();
        printk(",done,return %d\n",result);

        if(result<0)
        {
        printk("<0>not a zip image,use it as root ramdisk directly\n");
        write(crd_outfd,initrd_start ,(initrd_end-initrd_start));
        }

        kfree(window);
error0:
        close(crd_outfd);

error:
        (current->thread.current_ds = (oldfs));
        return result;
}
struct myinit __myinit_begin_setup_ramdisk __attribute__ ((unused,__section__ (".myinit.begin"))) ={setup_ramdisk};;
# 21 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/diff.c" 1
# 22 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/dset.c" 1
char debug26_array[0x100];
static int dset(int argc,char **argv)
{
int i;
if(argc==1)
{
 for(i=0;i<0x100;i++)
  {
   if(i%16==0)prom_printf("%02x:",i);
   prom_printf("%02x ",debug26_array[i]);
   if(i%16==15)prom_printf("\n");
  }
}
else if(argc==2)
{
 i=simple_strtol(argv[1],0,0);
 prom_printf("%02x:%02x\n",i,debug26_array[i]);
}
else if(argc==3)
{
 i=simple_strtol(argv[1],0,0);
 debug26_array[i]= simple_strtol(argv[2],0,0);
}
else return -1;
return 0;
}

struct mycmd __mycmd_dset __attribute__ ((unused,__section__ (".mycmd"))) = {"dset",dset,"dset [name] [value] ","set debug env var"};;
# 23 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/plx.c" 1
# 24 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/regs.c" 1


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/r4kcache.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/r4kcache.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/asm.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/r4kcache.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cacheops.h" 1
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/r4kcache.h" 2
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/r4kcache.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void flush_icache_line_indexed(unsigned long addr)
{
        __asm__ __volatile__( "	.set	noreorder				\n" "	.set	mips3\n\t				\n" "	cache	%0, %1					\n" "	.set	mips0					\n" "	.set	reorder" : : "i" (0x00), "m" (*(unsigned char *)(addr)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void flush_dcache_line_indexed(unsigned long addr)
{
        __asm__ __volatile__( "	.set	noreorder				\n" "	.set	mips3\n\t				\n" "	cache	%0, %1					\n" "	.set	mips0					\n" "	.set	reorder" : : "i" (0x01), "m" (*(unsigned char *)(addr)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void flush_scache_line_indexed(unsigned long addr)
{
        __asm__ __volatile__( "	.set	noreorder				\n" "	.set	mips3\n\t				\n" "	cache	%0, %1					\n" "	.set	mips0					\n" "	.set	reorder" : : "i" (0x03), "m" (*(unsigned char *)(addr)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void flush_icache_line(unsigned long addr)
{
        __asm__ __volatile__( "	.set	noreorder				\n" "	.set	mips3\n\t				\n" "	cache	%0, %1					\n" "	.set	mips0					\n" "	.set	reorder" : : "i" (0x10), "m" (*(unsigned char *)(addr)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void flush_dcache_line(unsigned long addr)
{
        __asm__ __volatile__( "	.set	noreorder				\n" "	.set	mips3\n\t				\n" "	cache	%0, %1					\n" "	.set	mips0					\n" "	.set	reorder" : : "i" (0x15), "m" (*(unsigned char *)(addr)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void invalidate_dcache_line(unsigned long addr)
{
        __asm__ __volatile__( "	.set	noreorder				\n" "	.set	mips3\n\t				\n" "	cache	%0, %1					\n" "	.set	mips0					\n" "	.set	reorder" : : "i" (0x11), "m" (*(unsigned char *)(addr)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void invalidate_scache_line(unsigned long addr)
{
        __asm__ __volatile__( "	.set	noreorder				\n" "	.set	mips3\n\t				\n" "	cache	%0, %1					\n" "	.set	mips0					\n" "	.set	reorder" : : "i" (0x13), "m" (*(unsigned char *)(addr)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void flush_scache_line(unsigned long addr)
{
        __asm__ __volatile__( "	.set	noreorder				\n" "	.set	mips3\n\t				\n" "	cache	%0, %1					\n" "	.set	mips0					\n" "	.set	reorder" : : "i" (0x17), "m" (*(unsigned char *)(addr)));
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void protected_flush_icache_line(unsigned long addr)
{
        __asm__ __volatile__(
                ".set noreorder\n\t"
                ".set mips3\n"
                "1:\tcache %0,(%1)\n"
                "2:\t.set mips0\n\t"
                ".set reorder\n\t"
                ".section\t__ex_table,\"a\"\n\t"
                ".dword""\t1b,2b\n\t"
                ".previous"
                :
                : "i" (0x10), "r" (addr));
}







static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void protected_writeback_dcache_line(unsigned long addr)
{
        __asm__ __volatile__(
                ".set noreorder\n\t"
                ".set mips3\n"
                "1:\tcache %0,(%1)\n"
                "2:\t.set mips0\n\t"
                ".set reorder\n\t"
                ".section\t__ex_table,\"a\"\n\t"
                ".dword""\t1b,2b\n\t"
                ".previous"
                :
                : "i" (0x15), "r" (addr));
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void invalidate_tcache_page(unsigned long addr)
{
        __asm__ __volatile__( "	.set	noreorder				\n" "	.set	mips3\n\t				\n" "	cache	%0, %1					\n" "	.set	mips0					\n" "	.set	reorder" : : "i" (0x16), "m" (*(unsigned char *)(addr)));
}
# 141 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/r4kcache.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_dcache16(void)
{
        unsigned long start = 0xffffffff80000000;
        unsigned long end = start + cpu_data[0].dcache.waysize;
        unsigned long ws_inc = 1UL << cpu_data[0].dcache.waybit;
        unsigned long ws_end = cpu_data[0].dcache.ways <<
                               cpu_data[0].dcache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x200)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x010(%0)	\n" "	cache %1, 0x020(%0); cache %1, 0x030(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x050(%0)	\n" "	cache %1, 0x060(%0); cache %1, 0x070(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x090(%0)	\n" "	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)	\n" "	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x110(%0)	\n" "	cache %1, 0x120(%0); cache %1, 0x130(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x150(%0)	\n" "	cache %1, 0x160(%0); cache %1, 0x170(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x190(%0)	\n" "	cache %1, 0x1a0(%0); cache %1, 0x1b0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1d0(%0)	\n" "	cache %1, 0x1e0(%0); cache %1, 0x1f0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x01));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_dcache16_page(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);

        do {
                __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x010(%0)	\n" "	cache %1, 0x020(%0); cache %1, 0x030(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x050(%0)	\n" "	cache %1, 0x060(%0); cache %1, 0x070(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x090(%0)	\n" "	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)	\n" "	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x110(%0)	\n" "	cache %1, 0x120(%0); cache %1, 0x130(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x150(%0)	\n" "	cache %1, 0x160(%0); cache %1, 0x170(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x190(%0)	\n" "	cache %1, 0x1a0(%0); cache %1, 0x1b0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1d0(%0)	\n" "	cache %1, 0x1e0(%0); cache %1, 0x1f0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (start), "i" (0x15));;
                start += 0x200;
        } while (start < end);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_dcache16_page_indexed(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);
        unsigned long ws_inc = 1UL << cpu_data[0].dcache.waybit;
        unsigned long ws_end = cpu_data[0].dcache.ways <<
                               cpu_data[0].dcache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x200)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x010(%0)	\n" "	cache %1, 0x020(%0); cache %1, 0x030(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x050(%0)	\n" "	cache %1, 0x060(%0); cache %1, 0x070(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x090(%0)	\n" "	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)	\n" "	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x110(%0)	\n" "	cache %1, 0x120(%0); cache %1, 0x130(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x150(%0)	\n" "	cache %1, 0x160(%0); cache %1, 0x170(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x190(%0)	\n" "	cache %1, 0x1a0(%0); cache %1, 0x1b0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1d0(%0)	\n" "	cache %1, 0x1e0(%0); cache %1, 0x1f0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x01));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_icache16(void)
{
        unsigned long start = 0xffffffff80000000;
        unsigned long end = start + cpu_data[0].icache.waysize;
        unsigned long ws_inc = 1UL << cpu_data[0].icache.waybit;
        unsigned long ws_end = cpu_data[0].icache.ways <<
                               cpu_data[0].icache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x200)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x010(%0)	\n" "	cache %1, 0x020(%0); cache %1, 0x030(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x050(%0)	\n" "	cache %1, 0x060(%0); cache %1, 0x070(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x090(%0)	\n" "	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)	\n" "	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x110(%0)	\n" "	cache %1, 0x120(%0); cache %1, 0x130(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x150(%0)	\n" "	cache %1, 0x160(%0); cache %1, 0x170(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x190(%0)	\n" "	cache %1, 0x1a0(%0); cache %1, 0x1b0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1d0(%0)	\n" "	cache %1, 0x1e0(%0); cache %1, 0x1f0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x00));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_icache16_page(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);

        do {
                __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x010(%0)	\n" "	cache %1, 0x020(%0); cache %1, 0x030(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x050(%0)	\n" "	cache %1, 0x060(%0); cache %1, 0x070(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x090(%0)	\n" "	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)	\n" "	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x110(%0)	\n" "	cache %1, 0x120(%0); cache %1, 0x130(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x150(%0)	\n" "	cache %1, 0x160(%0); cache %1, 0x170(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x190(%0)	\n" "	cache %1, 0x1a0(%0); cache %1, 0x1b0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1d0(%0)	\n" "	cache %1, 0x1e0(%0); cache %1, 0x1f0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (start), "i" (0x10));;
                start += 0x200;
        } while (start < end);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_icache16_page_indexed(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);
        unsigned long ws_inc = 1UL << cpu_data[0].icache.waybit;
        unsigned long ws_end = cpu_data[0].icache.ways <<
                               cpu_data[0].icache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x200)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x010(%0)	\n" "	cache %1, 0x020(%0); cache %1, 0x030(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x050(%0)	\n" "	cache %1, 0x060(%0); cache %1, 0x070(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x090(%0)	\n" "	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)	\n" "	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x110(%0)	\n" "	cache %1, 0x120(%0); cache %1, 0x130(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x150(%0)	\n" "	cache %1, 0x160(%0); cache %1, 0x170(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x190(%0)	\n" "	cache %1, 0x1a0(%0); cache %1, 0x1b0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1d0(%0)	\n" "	cache %1, 0x1e0(%0); cache %1, 0x1f0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x00));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache16(void)
{
        unsigned long start = 0xffffffff80000000;
        unsigned long end = start + cpu_data[0].scache.waysize;
        unsigned long ws_inc = 1UL << cpu_data[0].scache.waybit;
        unsigned long ws_end = cpu_data[0].scache.ways <<
                               cpu_data[0].scache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x200)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x010(%0)	\n" "	cache %1, 0x020(%0); cache %1, 0x030(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x050(%0)	\n" "	cache %1, 0x060(%0); cache %1, 0x070(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x090(%0)	\n" "	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)	\n" "	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x110(%0)	\n" "	cache %1, 0x120(%0); cache %1, 0x130(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x150(%0)	\n" "	cache %1, 0x160(%0); cache %1, 0x170(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x190(%0)	\n" "	cache %1, 0x1a0(%0); cache %1, 0x1b0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1d0(%0)	\n" "	cache %1, 0x1e0(%0); cache %1, 0x1f0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x03));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache16_page(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = page + (1UL << 14);

        do {
                __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x010(%0)	\n" "	cache %1, 0x020(%0); cache %1, 0x030(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x050(%0)	\n" "	cache %1, 0x060(%0); cache %1, 0x070(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x090(%0)	\n" "	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)	\n" "	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x110(%0)	\n" "	cache %1, 0x120(%0); cache %1, 0x130(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x150(%0)	\n" "	cache %1, 0x160(%0); cache %1, 0x170(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x190(%0)	\n" "	cache %1, 0x1a0(%0); cache %1, 0x1b0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1d0(%0)	\n" "	cache %1, 0x1e0(%0); cache %1, 0x1f0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (start), "i" (0x17));;
                start += 0x200;
        } while (start < end);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache16_page_indexed(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);
        unsigned long ws_inc = 1UL << cpu_data[0].scache.waybit;
        unsigned long ws_end = cpu_data[0].scache.ways <<
                               cpu_data[0].scache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x200)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x010(%0)	\n" "	cache %1, 0x020(%0); cache %1, 0x030(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x050(%0)	\n" "	cache %1, 0x060(%0); cache %1, 0x070(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x090(%0)	\n" "	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)	\n" "	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x110(%0)	\n" "	cache %1, 0x120(%0); cache %1, 0x130(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x150(%0)	\n" "	cache %1, 0x160(%0); cache %1, 0x170(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x190(%0)	\n" "	cache %1, 0x1a0(%0); cache %1, 0x1b0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1d0(%0)	\n" "	cache %1, 0x1e0(%0); cache %1, 0x1f0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x03));;
}
# 284 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/r4kcache.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_dcache32(void)
{
        unsigned long start = 0xffffffff80000000;
        unsigned long end = start + cpu_data[0].dcache.waysize;
        unsigned long ws_inc = 1UL << cpu_data[0].dcache.waybit;
        unsigned long ws_end = cpu_data[0].dcache.ways <<
                               cpu_data[0].dcache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x400)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x020(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x060(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0a0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x120(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x160(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1a0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1e0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x220(%0)	\n" "	cache %1, 0x240(%0); cache %1, 0x260(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2a0(%0)	\n" "	cache %1, 0x2c0(%0); cache %1, 0x2e0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x320(%0)	\n" "	cache %1, 0x340(%0); cache %1, 0x360(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3a0(%0)	\n" "	cache %1, 0x3c0(%0); cache %1, 0x3e0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x01));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_dcache32_page(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);

        do {
                __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x020(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x060(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0a0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x120(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x160(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1a0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1e0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x220(%0)	\n" "	cache %1, 0x240(%0); cache %1, 0x260(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2a0(%0)	\n" "	cache %1, 0x2c0(%0); cache %1, 0x2e0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x320(%0)	\n" "	cache %1, 0x340(%0); cache %1, 0x360(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3a0(%0)	\n" "	cache %1, 0x3c0(%0); cache %1, 0x3e0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (start), "i" (0x15));;
                start += 0x400;
        } while (start < end);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_dcache32_page_indexed(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);
        unsigned long ws_inc = 1UL << cpu_data[0].dcache.waybit;
        unsigned long ws_end = cpu_data[0].dcache.ways <<
                               cpu_data[0].dcache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x400)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x020(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x060(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0a0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x120(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x160(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1a0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1e0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x220(%0)	\n" "	cache %1, 0x240(%0); cache %1, 0x260(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2a0(%0)	\n" "	cache %1, 0x2c0(%0); cache %1, 0x2e0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x320(%0)	\n" "	cache %1, 0x340(%0); cache %1, 0x360(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3a0(%0)	\n" "	cache %1, 0x3c0(%0); cache %1, 0x3e0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x01));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_icache32(void)
{
        unsigned long start = 0xffffffff80000000;
        unsigned long end = start + cpu_data[0].icache.waysize;
        unsigned long ws_inc = 1UL << cpu_data[0].icache.waybit;
        unsigned long ws_end = cpu_data[0].icache.ways <<
                               cpu_data[0].icache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x400)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x020(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x060(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0a0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x120(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x160(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1a0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1e0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x220(%0)	\n" "	cache %1, 0x240(%0); cache %1, 0x260(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2a0(%0)	\n" "	cache %1, 0x2c0(%0); cache %1, 0x2e0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x320(%0)	\n" "	cache %1, 0x340(%0); cache %1, 0x360(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3a0(%0)	\n" "	cache %1, 0x3c0(%0); cache %1, 0x3e0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x00));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_icache32_page(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);

        do {
                __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x020(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x060(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0a0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x120(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x160(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1a0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1e0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x220(%0)	\n" "	cache %1, 0x240(%0); cache %1, 0x260(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2a0(%0)	\n" "	cache %1, 0x2c0(%0); cache %1, 0x2e0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x320(%0)	\n" "	cache %1, 0x340(%0); cache %1, 0x360(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3a0(%0)	\n" "	cache %1, 0x3c0(%0); cache %1, 0x3e0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (start), "i" (0x10));;
                start += 0x400;
        } while (start < end);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_icache32_page_indexed(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);
        unsigned long ws_inc = 1UL << cpu_data[0].icache.waybit;
        unsigned long ws_end = cpu_data[0].icache.ways <<
                               cpu_data[0].icache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x400)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x020(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x060(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0a0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x120(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x160(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1a0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1e0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x220(%0)	\n" "	cache %1, 0x240(%0); cache %1, 0x260(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2a0(%0)	\n" "	cache %1, 0x2c0(%0); cache %1, 0x2e0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x320(%0)	\n" "	cache %1, 0x340(%0); cache %1, 0x360(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3a0(%0)	\n" "	cache %1, 0x3c0(%0); cache %1, 0x3e0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x00));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache32(void)
{
        unsigned long start = 0xffffffff80000000;
        unsigned long end = start + cpu_data[0].scache.waysize;
        unsigned long ws_inc = 1UL << cpu_data[0].scache.waybit;
        unsigned long ws_end = cpu_data[0].scache.ways <<
                               cpu_data[0].scache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x400)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x020(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x060(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0a0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x120(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x160(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1a0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1e0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x220(%0)	\n" "	cache %1, 0x240(%0); cache %1, 0x260(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2a0(%0)	\n" "	cache %1, 0x2c0(%0); cache %1, 0x2e0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x320(%0)	\n" "	cache %1, 0x340(%0); cache %1, 0x360(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3a0(%0)	\n" "	cache %1, 0x3c0(%0); cache %1, 0x3e0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x03));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache32_page(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = page + (1UL << 14);

        do {
                __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x020(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x060(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0a0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x120(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x160(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1a0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1e0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x220(%0)	\n" "	cache %1, 0x240(%0); cache %1, 0x260(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2a0(%0)	\n" "	cache %1, 0x2c0(%0); cache %1, 0x2e0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x320(%0)	\n" "	cache %1, 0x340(%0); cache %1, 0x360(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3a0(%0)	\n" "	cache %1, 0x3c0(%0); cache %1, 0x3e0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (start), "i" (0x17));;
                start += 0x400;
        } while (start < end);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache32_page_indexed(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);
        unsigned long ws_inc = 1UL << cpu_data[0].scache.waybit;
        unsigned long ws_end = cpu_data[0].scache.ways <<
                               cpu_data[0].scache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x400)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x020(%0)	\n" "	cache %1, 0x040(%0); cache %1, 0x060(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0a0(%0)	\n" "	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x120(%0)	\n" "	cache %1, 0x140(%0); cache %1, 0x160(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1a0(%0)	\n" "	cache %1, 0x1c0(%0); cache %1, 0x1e0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x220(%0)	\n" "	cache %1, 0x240(%0); cache %1, 0x260(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2a0(%0)	\n" "	cache %1, 0x2c0(%0); cache %1, 0x2e0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x320(%0)	\n" "	cache %1, 0x340(%0); cache %1, 0x360(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3a0(%0)	\n" "	cache %1, 0x3c0(%0); cache %1, 0x3e0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x03));;
}
# 427 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/r4kcache.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_icache64(void)
{
        unsigned long start = 0xffffffff80000000;
        unsigned long end = start + cpu_data[0].icache.waysize;
        unsigned long ws_inc = 1UL << cpu_data[0].icache.waybit;
        unsigned long ws_end = cpu_data[0].icache.ways <<
                               cpu_data[0].icache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x800)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x040(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0c0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x140(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1c0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x240(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2c0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x340(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3c0(%0)	\n" "	cache %1, 0x400(%0); cache %1, 0x440(%0)	\n" "	cache %1, 0x480(%0); cache %1, 0x4c0(%0)	\n" "	cache %1, 0x500(%0); cache %1, 0x540(%0)	\n" "	cache %1, 0x580(%0); cache %1, 0x5c0(%0)	\n" "	cache %1, 0x600(%0); cache %1, 0x640(%0)	\n" "	cache %1, 0x680(%0); cache %1, 0x6c0(%0)	\n" "	cache %1, 0x700(%0); cache %1, 0x740(%0)	\n" "	cache %1, 0x780(%0); cache %1, 0x7c0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x00));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_icache64_page(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);

        do {
                __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x040(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0c0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x140(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1c0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x240(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2c0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x340(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3c0(%0)	\n" "	cache %1, 0x400(%0); cache %1, 0x440(%0)	\n" "	cache %1, 0x480(%0); cache %1, 0x4c0(%0)	\n" "	cache %1, 0x500(%0); cache %1, 0x540(%0)	\n" "	cache %1, 0x580(%0); cache %1, 0x5c0(%0)	\n" "	cache %1, 0x600(%0); cache %1, 0x640(%0)	\n" "	cache %1, 0x680(%0); cache %1, 0x6c0(%0)	\n" "	cache %1, 0x700(%0); cache %1, 0x740(%0)	\n" "	cache %1, 0x780(%0); cache %1, 0x7c0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (start), "i" (0x10));;
                start += 0x800;
        } while (start < end);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_icache64_page_indexed(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);
        unsigned long ws_inc = 1UL << cpu_data[0].icache.waybit;
        unsigned long ws_end = cpu_data[0].icache.ways <<
                               cpu_data[0].icache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x800)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x040(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0c0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x140(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1c0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x240(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2c0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x340(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3c0(%0)	\n" "	cache %1, 0x400(%0); cache %1, 0x440(%0)	\n" "	cache %1, 0x480(%0); cache %1, 0x4c0(%0)	\n" "	cache %1, 0x500(%0); cache %1, 0x540(%0)	\n" "	cache %1, 0x580(%0); cache %1, 0x5c0(%0)	\n" "	cache %1, 0x600(%0); cache %1, 0x640(%0)	\n" "	cache %1, 0x680(%0); cache %1, 0x6c0(%0)	\n" "	cache %1, 0x700(%0); cache %1, 0x740(%0)	\n" "	cache %1, 0x780(%0); cache %1, 0x7c0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x00));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache64(void)
{
        unsigned long start = 0xffffffff80000000;
        unsigned long end = start + cpu_data[0].scache.waysize;
        unsigned long ws_inc = 1UL << cpu_data[0].scache.waybit;
        unsigned long ws_end = cpu_data[0].scache.ways <<
                               cpu_data[0].scache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x800)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x040(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0c0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x140(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1c0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x240(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2c0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x340(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3c0(%0)	\n" "	cache %1, 0x400(%0); cache %1, 0x440(%0)	\n" "	cache %1, 0x480(%0); cache %1, 0x4c0(%0)	\n" "	cache %1, 0x500(%0); cache %1, 0x540(%0)	\n" "	cache %1, 0x580(%0); cache %1, 0x5c0(%0)	\n" "	cache %1, 0x600(%0); cache %1, 0x640(%0)	\n" "	cache %1, 0x680(%0); cache %1, 0x6c0(%0)	\n" "	cache %1, 0x700(%0); cache %1, 0x740(%0)	\n" "	cache %1, 0x780(%0); cache %1, 0x7c0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x03));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache64_page(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = page + (1UL << 14);

        do {
                __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x040(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0c0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x140(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1c0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x240(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2c0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x340(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3c0(%0)	\n" "	cache %1, 0x400(%0); cache %1, 0x440(%0)	\n" "	cache %1, 0x480(%0); cache %1, 0x4c0(%0)	\n" "	cache %1, 0x500(%0); cache %1, 0x540(%0)	\n" "	cache %1, 0x580(%0); cache %1, 0x5c0(%0)	\n" "	cache %1, 0x600(%0); cache %1, 0x640(%0)	\n" "	cache %1, 0x680(%0); cache %1, 0x6c0(%0)	\n" "	cache %1, 0x700(%0); cache %1, 0x740(%0)	\n" "	cache %1, 0x780(%0); cache %1, 0x7c0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (start), "i" (0x17));;
                start += 0x800;
        } while (start < end);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache64_page_indexed(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);
        unsigned long ws_inc = 1UL << cpu_data[0].scache.waybit;
        unsigned long ws_end = cpu_data[0].scache.ways <<
                               cpu_data[0].scache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x800)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x040(%0)	\n" "	cache %1, 0x080(%0); cache %1, 0x0c0(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x140(%0)	\n" "	cache %1, 0x180(%0); cache %1, 0x1c0(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x240(%0)	\n" "	cache %1, 0x280(%0); cache %1, 0x2c0(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x340(%0)	\n" "	cache %1, 0x380(%0); cache %1, 0x3c0(%0)	\n" "	cache %1, 0x400(%0); cache %1, 0x440(%0)	\n" "	cache %1, 0x480(%0); cache %1, 0x4c0(%0)	\n" "	cache %1, 0x500(%0); cache %1, 0x540(%0)	\n" "	cache %1, 0x580(%0); cache %1, 0x5c0(%0)	\n" "	cache %1, 0x600(%0); cache %1, 0x640(%0)	\n" "	cache %1, 0x680(%0); cache %1, 0x6c0(%0)	\n" "	cache %1, 0x700(%0); cache %1, 0x740(%0)	\n" "	cache %1, 0x780(%0); cache %1, 0x7c0(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x03));;
}
# 531 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/r4kcache.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache128(void)
{
        unsigned long start = 0xffffffff80000000;
        unsigned long end = start + cpu_data[0].scache.waysize;
        unsigned long ws_inc = 1UL << cpu_data[0].scache.waybit;
        unsigned long ws_end = cpu_data[0].scache.ways <<
                               cpu_data[0].scache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x1000)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x080(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x180(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x280(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x380(%0)	\n" "	cache %1, 0x400(%0); cache %1, 0x480(%0)	\n" "	cache %1, 0x500(%0); cache %1, 0x580(%0)	\n" "	cache %1, 0x600(%0); cache %1, 0x680(%0)	\n" "	cache %1, 0x700(%0); cache %1, 0x780(%0)	\n" "	cache %1, 0x800(%0); cache %1, 0x880(%0)	\n" "	cache %1, 0x900(%0); cache %1, 0x980(%0)	\n" "	cache %1, 0xa00(%0); cache %1, 0xa80(%0)	\n" "	cache %1, 0xb00(%0); cache %1, 0xb80(%0)	\n" "	cache %1, 0xc00(%0); cache %1, 0xc80(%0)	\n" "	cache %1, 0xd00(%0); cache %1, 0xd80(%0)	\n" "	cache %1, 0xe00(%0); cache %1, 0xe80(%0)	\n" "	cache %1, 0xf00(%0); cache %1, 0xf80(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x03));;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache128_page(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = page + (1UL << 14);

        do {
                __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x080(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x180(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x280(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x380(%0)	\n" "	cache %1, 0x400(%0); cache %1, 0x480(%0)	\n" "	cache %1, 0x500(%0); cache %1, 0x580(%0)	\n" "	cache %1, 0x600(%0); cache %1, 0x680(%0)	\n" "	cache %1, 0x700(%0); cache %1, 0x780(%0)	\n" "	cache %1, 0x800(%0); cache %1, 0x880(%0)	\n" "	cache %1, 0x900(%0); cache %1, 0x980(%0)	\n" "	cache %1, 0xa00(%0); cache %1, 0xa80(%0)	\n" "	cache %1, 0xb00(%0); cache %1, 0xb80(%0)	\n" "	cache %1, 0xc00(%0); cache %1, 0xc80(%0)	\n" "	cache %1, 0xd00(%0); cache %1, 0xd80(%0)	\n" "	cache %1, 0xe00(%0); cache %1, 0xe80(%0)	\n" "	cache %1, 0xf00(%0); cache %1, 0xf80(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (start), "i" (0x17));;
                start += 0x1000;
        } while (start < end);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blast_scache128_page_indexed(unsigned long page)
{
        unsigned long start = page;
        unsigned long end = start + (1UL << 14);
        unsigned long ws_inc = 1UL << cpu_data[0].scache.waybit;
        unsigned long ws_end = cpu_data[0].scache.ways <<
                               cpu_data[0].scache.waybit;
        unsigned long ws, addr;

        for (ws = 0; ws < ws_end; ws += ws_inc)
                for (addr = start; addr < end; addr += 0x1000)
                        __asm__ __volatile__( "	.set noreorder					\n" "	.set mips3					\n" "	cache %1, 0x000(%0); cache %1, 0x080(%0)	\n" "	cache %1, 0x100(%0); cache %1, 0x180(%0)	\n" "	cache %1, 0x200(%0); cache %1, 0x280(%0)	\n" "	cache %1, 0x300(%0); cache %1, 0x380(%0)	\n" "	cache %1, 0x400(%0); cache %1, 0x480(%0)	\n" "	cache %1, 0x500(%0); cache %1, 0x580(%0)	\n" "	cache %1, 0x600(%0); cache %1, 0x680(%0)	\n" "	cache %1, 0x700(%0); cache %1, 0x780(%0)	\n" "	cache %1, 0x800(%0); cache %1, 0x880(%0)	\n" "	cache %1, 0x900(%0); cache %1, 0x980(%0)	\n" "	cache %1, 0xa00(%0); cache %1, 0xa80(%0)	\n" "	cache %1, 0xb00(%0); cache %1, 0xb80(%0)	\n" "	cache %1, 0xc00(%0); cache %1, 0xc80(%0)	\n" "	cache %1, 0xd00(%0); cache %1, 0xd80(%0)	\n" "	cache %1, 0xe00(%0); cache %1, 0xe80(%0)	\n" "	cache %1, 0xf00(%0); cache %1, 0xf80(%0)	\n" "	.set mips0					\n" "	.set reorder					\n" : : "r" (addr|ws), "i" (0x03));;
}
# 4 "drivers/debug26/lib/regs.c" 2




static int cp0s_sel=0;
static int __cp0syscall1(int type,unsigned long long addr,union commondata *mydata)
{
long data8;
extern int mycp0ins();
unsigned int *p=(void *)mycp0ins;
if(type!=8)return -1;
memset(mydata->data8,0,8);
addr=addr&0x1f;

*p=((0x402<<20)|((2)<<16)|((addr)<<11)|cp0s_sel);



flush_dcache_line(((unsigned long)p)&~31UL);
flush_icache_line(((unsigned long)p)&~31UL);

 asm(".global mycp0ins;mycp0ins:mfc0 $2,$0;move %0,$2" :"=r"(data8)::"$2");

 *(long *)mydata->data8=data8;

return 0;
}

static int __cp0syscall2(int type,unsigned long long addr,union commondata *mydata)
{
extern int mycp0ins1();
unsigned int *p=(void *)mycp0ins1;
if(type!=8)return -1;
addr=addr&0x1f;

*p=((0x40a<<20)|((2)<<16)|((addr)<<11)|cp0s_sel);



flush_dcache_line(((unsigned long)p)&~31UL);
flush_icache_line(((unsigned long)p)&~31UL);

 asm(".global mycp0ins1;move $2,%0;mycp0ins1:mtc0 $2,$0;"::"r"(*(long *)mydata->data8):"$2");

return 0;
}

static int mycp0s(int argc,char **argv)
{
syscall1=__cp0syscall1;
syscall2=__cp0syscall2;
        syscall_addrtype=0x70;
if(argc>1)cp0s_sel=simple_strtol(argv[1],0,0);
else cp0s_sel=0;
return 0;
}
struct mycmd __mycmd_cp0s __attribute__ ((unused,__section__ (".mycmd"))) = {"cp0s",mycp0s,"[0|-1]","set m4,d4 to access cp0 regs"};;
# 25 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/myrequest_irq.c" 1
# 26 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/lib/dm642.c" 1
# 27 "drivers/debug26/debug.c" 2

# 1 "drivers/debug26/mips.bonito/debug.c" 1

# 1 "drivers/debug26/mips.bonito/pnp_82371.c" 1
# 3 "drivers/debug26/mips.bonito/debug.c" 2
# 1 "drivers/debug26/mips.bonito/pnp_686b.c" 1
# 4 "drivers/debug26/mips.bonito/debug.c" 2
# 1 "drivers/debug26/mips.bonito/test.c" 1
# 5 "drivers/debug26/mips.bonito/debug.c" 2
# 1 "drivers/debug26/mips.bonito/pmon.c" 1
# 6 "drivers/debug26/mips.bonito/debug.c" 2
# 1 "drivers/debug26/mips.bonito/cs5536_i2c.c" 1
# 7 "drivers/debug26/mips.bonito/debug.c" 2
# 1 "drivers/debug26/mips.bonito/cs5536_gpio.c" 1
# 8 "drivers/debug26/mips.bonito/debug.c" 2
# 29 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/mips.ev64420/debug.c" 1
# 30 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/mips.8172/debug.c" 1
# 31 "drivers/debug26/debug.c" 2
# 1 "drivers/debug26/i386/debug.c" 1
# 32 "drivers/debug26/debug.c" 2
