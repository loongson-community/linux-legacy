# 1 "arch/mips/mm/init.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "arch/mips/mm/init.c"
# 12 "arch/mips/mm/init.c"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/config.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/autoconf.h" 1
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/config.h" 2
# 13 "arch/mips/mm/init.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/init.h" 1




# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/compiler.h" 1
# 6 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/init.h" 2
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
# 14 "arch/mips/mm/init.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/signal.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/signal.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/types.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/types.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/posix_types.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/stddef.h" 1
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/posix_types.h" 2
# 36 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/posix_types.h"
typedef struct {
        unsigned long fds_bits [(1024/(8 * sizeof(unsigned long)))];
} __kernel_fd_set;


typedef void (*__kernel_sighandler_t)(int);


typedef int __kernel_key_t;

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/posix_types.h" 1
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/posix_types.h"
typedef unsigned int __kernel_dev_t;
typedef unsigned long __kernel_ino_t;
typedef unsigned int __kernel_mode_t;
typedef unsigned long __kernel_nlink_t;
typedef long __kernel_off_t;
typedef int __kernel_pid_t;
typedef int __kernel_ipc_pid_t;
typedef int __kernel_uid_t;
typedef int __kernel_gid_t;
typedef unsigned int __kernel_size_t;
typedef int __kernel_ssize_t;
typedef int __kernel_ptrdiff_t;
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
        long val[2];
} __kernel_fsid_t;




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
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/types.h"
typedef unsigned short umode_t;






typedef __signed__ char __s8;
typedef unsigned char __u8;

typedef __signed__ short __s16;
typedef unsigned short __u16;

typedef __signed__ int __s32;
typedef unsigned int __u32;
# 38 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/types.h"
typedef __signed__ long long __s64;
typedef unsigned long long __u64;
# 49 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/types.h"
typedef __signed char s8;
typedef unsigned char u8;

typedef __signed short s16;
typedef unsigned short u16;

typedef __signed int s32;
typedef unsigned int u32;
# 66 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/types.h"
typedef __signed__ long long s64;
typedef unsigned long long u64;
# 77 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/types.h"
typedef u32 dma_addr_t;

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
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/signal.h" 2





typedef struct {
        unsigned long sig[(128 / 32)];
} sigset_t;

typedef unsigned long old_sigset_t;
# 123 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/signal.h"
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
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sigcontext.h"
struct sigcontext {
        unsigned int sc_regmask;
        unsigned int sc_status;
        unsigned long long sc_pc;
        unsigned long long sc_regs[32];
        unsigned long long sc_fpregs[32];
        unsigned int sc_ownedfp;
        unsigned int sc_fpc_csr;
        unsigned int sc_fpc_eir;
        unsigned int sc_used_math;
        unsigned int sc_ssflags;
        unsigned long long sc_mdhi;
        unsigned long long sc_mdlo;

        unsigned int sc_cause;
        unsigned int sc_badvaddr;

        unsigned long sc_sigset[4];
};
# 152 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/signal.h" 2
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
        int __pad0[128 / sizeof(int) - ((128/sizeof(int)) - 3) - 3];

        union {
                int _pad[((128/sizeof(int)) - 3)];


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





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h"
extern char * ___strtok;
extern char * strpbrk(const char *,const char *);
extern char * strtok(char *,const char *);
extern char * strsep(char **,const char *);
extern __kernel_size_t strspn(const char *,const char *);





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/string.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/string.h"
static __inline__ __attribute__((always_inline)) char *strcpy(char *__dest, __const__ char *__src)
{
  char *__xdest = __dest;

  __asm__ __volatile__(
        ".set\tnoreorder\n\t"
        ".set\tnoat\n"
        "1:\tlbu\t$1,(%1)\n\t"
        "addiu\t%1,1\n\t"
        "sb\t$1,(%0)\n\t"
        "bnez\t$1,1b\n\t"
        "addiu\t%0,1\n\t"
        ".set\tat\n\t"
        ".set\treorder"
        : "=r" (__dest), "=r" (__src)
        : "0" (__dest), "1" (__src)
        : "memory");

  return __xdest;
}


static __inline__ __attribute__((always_inline)) char *strncpy(char *__dest, __const__ char *__src, size_t __n)
{
  char *__xdest = __dest;

  if (__n == 0)
    return __xdest;

  __asm__ __volatile__(
        ".set\tnoreorder\n\t"
        ".set\tnoat\n"
        "1:\tlbu\t$1,(%1)\n\t"
        "subu\t%2,1\n\t"
        "sb\t$1,(%0)\n\t"
        "beqz\t$1,2f\n\t"
        "addiu\t%0,1\n\t"
        "bnez\t%2,1b\n\t"
        "addiu\t%1,1\n"
        "2:\n\t"
        ".set\tat\n\t"
        ".set\treorder"
        : "=r" (__dest), "=r" (__src), "=r" (__n)
        : "0" (__dest), "1" (__src), "2" (__n)
        : "memory");

  return __xdest;
}


static __inline__ __attribute__((always_inline)) int strcmp(__const__ char *__cs, __const__ char *__ct)
{
  int __res;

  __asm__ __volatile__(
        ".set\tnoreorder\n\t"
        ".set\tnoat\n\t"
        "lbu\t%2,(%0)\n"
        "1:\tlbu\t$1,(%1)\n\t"
        "addiu\t%0,1\n\t"
        "bne\t$1,%2,2f\n\t"
        "addiu\t%1,1\n\t"
        "bnez\t%2,1b\n\t"
        "lbu\t%2,(%0)\n\t"



        "move\t%2,$1\n"
        "2:\tsubu\t%2,$1\n"
        "3:\t.set\tat\n\t"
        ".set\treorder"
        : "=r" (__cs), "=r" (__ct), "=r" (__res)
        : "0" (__cs), "1" (__ct));

  return __res;
}


static __inline__ __attribute__((always_inline)) int
strncmp(__const__ char *__cs, __const__ char *__ct, size_t __count)
{
        int __res;

        __asm__ __volatile__(
        ".set\tnoreorder\n\t"
        ".set\tnoat\n"
        "1:\tlbu\t%3,(%0)\n\t"
        "beqz\t%2,2f\n\t"
        "lbu\t$1,(%1)\n\t"
        "subu\t%2,1\n\t"
        "bne\t$1,%3,3f\n\t"
        "addiu\t%0,1\n\t"
        "bnez\t%3,1b\n\t"
        "addiu\t%1,1\n"
        "2:\n\t"



        "move\t%3,$1\n"
        "3:\tsubu\t%3,$1\n\t"
        ".set\tat\n\t"
        ".set\treorder"
        : "=r" (__cs), "=r" (__ct), "=r" (__count), "=r" (__res)
        : "0" (__cs), "1" (__ct), "2" (__count));

        return __res;
}


extern void *memset(void *__s, int __c, size_t __count);


extern void *memcpy(void *__to, __const__ void *__from, size_t __n);


extern void *memmove(void *__dest, __const__ void *__src, size_t __n);





static __inline__ __attribute__((always_inline)) void *memscan(void *__addr, int __c, size_t __size)
{
        char *__end = (char *)__addr + __size;
        unsigned char __uc = (unsigned char) __c;

        __asm__(".set\tpush\n\t"
                ".set\tnoat\n\t"
                ".set\treorder\n\t"
                "1:\tbeq\t%0,%1,2f\n\t"
                "addiu\t%0,1\n\t"
                "lbu\t$1,-1(%0)\n\t"
                "bne\t$1,%z4,1b\n"
                "2:\t.set\tpop"
                : "=r" (__addr), "=r" (__end)
                : "0" (__addr), "1" (__end), "Jr" (__uc));

        return __addr;
}
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h" 2
# 35 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h"
extern char * strcat(char *, const char *);


extern char * strncat(char *, const char *, __kernel_size_t);
# 47 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h"
extern int strnicmp(const char *, const char *, __kernel_size_t);


extern char * strchr(const char *,int);


extern char * strrchr(const char *,int);


extern char * strstr(const char *,const char *);


extern __kernel_size_t strlen(const char *);


extern __kernel_size_t strnlen(const char *,__kernel_size_t);
# 78 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/string.h"
extern int memcmp(const void *,const void *,__kernel_size_t);


extern void * memchr(const void *,int,__kernel_size_t);
# 247 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/siginfo.h" 2

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






# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/byteorder.h" 1
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/byteorder.h"
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

        __u32 h = x >> 32;
        __u32 l = x & ((1ULL<<32)-1);
        return (((__u64)(__builtin_constant_p((__u32)(l)) ? ({ __u32 __x = ((l)); ((__u32)( (((__u32)(__x) & (__u32)0x000000ffUL) << 24) | (((__u32)(__x) & (__u32)0x0000ff00UL) << 8) | (((__u32)(__x) & (__u32)0x00ff0000UL) >> 8) | (((__u32)(__x) & (__u32)0xff000000UL) >> 24) )); }) : __fswab32((l)))) << 32) | ((__u64)((__builtin_constant_p((__u32)(h)) ? ({ __u32 __x = ((h)); ((__u32)( (((__u32)(__x) & (__u32)0x000000ffUL) << 24) | (((__u32)(__x) & (__u32)0x0000ff00UL) << 8) | (((__u32)(__x) & (__u32)0x00ff0000UL) >> 8) | (((__u32)(__x) & (__u32)0xff000000UL) >> 24) )); }) : __fswab32((h)))));



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
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/byteorder.h" 2
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h" 2
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sgidefs.h" 1
# 27 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h" 1
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h" 1
# 10 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h"
# 1 "/toolchain/lib/gcc-lib/mipsel-linux/3.2.3/include/stdarg.h" 1 3
# 43 "/toolchain/lib/gcc-lib/mipsel-linux/3.2.3/include/stdarg.h" 3
typedef __builtin_va_list __gnuc_va_list;
# 110 "/toolchain/lib/gcc-lib/mipsel-linux/3.2.3/include/stdarg.h" 3
typedef __gnuc_va_list va_list;
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/linkage.h" 1
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/kernel.h" 2
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
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/addrspace.h" 1
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ptrace.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ptrace.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/isadep.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ptrace.h" 2
# 31 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ptrace.h"
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
# 102 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ptrace.h"
extern void show_regs(struct pt_regs *);
# 29 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h" 2

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
# 71 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
__asm__ (

        ".macro\t__hard_cli\n\t"



        ".set\tpush\n\t"
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
# 163 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
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
# 235 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
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
# 301 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
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
   union { unsigned long long tsc; unsigned long hltsc[2]; } tsc;
   void (*linux_mips_timer_intr)(int irq, void *dev_id, struct pt_regs *regs);
   void (*linux_soft_mips_timer_intr)(int irq, void *dev_id, struct pt_regs *regs);
   unsigned long (*getflags_and_sti)(void);
   void (*soft_enint)(void);
};

extern struct rt_hal rthal;
# 420 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
extern void *resume(void *last, void *next);



struct task_struct;
# 435 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
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
# 465 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/system.h"
}




static __inline__ __attribute__((always_inline)) unsigned long
__xchg(unsigned long x, volatile void * ptr, int size)
{
        switch (size) {
                case 4:
                        return xchg_u32(ptr, x);
        }
        return x;
}

extern void *set_except_vector(int n, void *addr);
extern void per_cpu_trap_init(void);

extern void __die(const char *, struct pt_regs *, const char *file,
        const char *func, unsigned long line) __attribute__((noreturn));
extern void __die_if_kernel(const char *, struct pt_regs *, const char *file,
        const char *func, unsigned long line);
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h" 2
# 69 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) void set_bit(int nr, volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 5);
        unsigned long temp;

        __asm__ __volatile__(
                "1:\tll\t%0, %1\t\t# set_bit\n\t"
                "or\t%0, %2\n\t"
                "sc\t%0, %1\n\t"
                "beqz\t%0, 1b"
                : "=&r" (temp), "=m" (*m)
                : "ir" (1UL << (nr & 0x1f)), "m" (*m));
}
# 92 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) void __set_bit(int nr, volatile void * addr)
{
        unsigned long * m = ((unsigned long *) addr) + (nr >> 5);

        *m |= 1UL << (nr & 31);
}
# 109 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) void clear_bit(int nr, volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 5);
        unsigned long temp;

        __asm__ __volatile__(
                "1:\tll\t%0, %1\t\t# clear_bit\n\t"
                "and\t%0, %2\n\t"
                "sc\t%0, %1\n\t"
                "beqz\t%0, 1b\n\t"
                : "=&r" (temp), "=m" (*m)
                : "ir" (~(1UL << (nr & 0x1f))), "m" (*m));
}
# 132 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) void change_bit(int nr, volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 5);
        unsigned long temp;

        __asm__ __volatile__(
                "1:\tll\t%0, %1\t\t# change_bit\n\t"
                "xor\t%0, %2\n\t"
                "sc\t%0, %1\n\t"
                "beqz\t%0, 1b"
                : "=&r" (temp), "=m" (*m)
                : "ir" (1UL << (nr & 0x1f)), "m" (*m));
}
# 155 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) void __change_bit(int nr, volatile void * addr)
{
        unsigned long * m = ((unsigned long *) addr) + (nr >> 5);

        *m ^= 1UL << (nr & 31);
}
# 170 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) int test_and_set_bit(int nr, volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 5);
        unsigned long temp;
        int res;

        __asm__ __volatile__(
                ".set\tnoreorder\t\t# test_and_set_bit\n"
                "1:\tll\t%0, %1\n\t"
                "or\t%2, %0, %3\n\t"
                "sc\t%2, %1\n\t"
                "beqz\t%2, 1b\n\t"
                " and\t%2, %0, %3\n\t"



                ".set\treorder"
                : "=&r" (temp), "=m" (*m), "=&r" (res)
                : "r" (1UL << (nr & 0x1f)), "m" (*m)
                : "memory");

        return res != 0;
}
# 203 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) int __test_and_set_bit(int nr, volatile void * addr)
{
        volatile unsigned long *a = addr;
        unsigned long mask;
        int retval;

        a += nr >> 5;
        mask = 1 << (nr & 0x1f);
        retval = (mask & *a) != 0;
        *a |= mask;

        return retval;
}
# 225 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) int test_and_clear_bit(int nr, volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 5);
        unsigned long temp, res;

        __asm__ __volatile__(
                ".set\tnoreorder\t\t# test_and_clear_bit\n"
                "1:\tll\t%0, %1\n\t"
                "or\t%2, %0, %3\n\t"
                "xor\t%2, %3\n\t"
                "sc\t%2, %1\n\t"
                "beqz\t%2, 1b\n\t"
                " and\t%2, %0, %3\n\t"



                ".set\treorder"
                : "=&r" (temp), "=m" (*m), "=&r" (res)
                : "r" (1UL << (nr & 0x1f)), "m" (*m)
                : "memory");

        return res != 0;
}
# 258 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) int __test_and_clear_bit(int nr, volatile void * addr)
{
        volatile unsigned long *a = addr;
        unsigned long mask, retval;

        a += nr >> 5;
        mask = 1 << (nr & 0x1f);
        retval = (mask & *a) != 0;
        *a &= ~mask;

        return retval;
}
# 279 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) int test_and_change_bit(int nr, volatile void *addr)
{
        unsigned long *m = ((unsigned long *) addr) + (nr >> 5);
        unsigned long temp, res;

        __asm__ __volatile__(
                ".set\tnoreorder\t\t# test_and_change_bit\n"
                "1:\tll\t%0, %1\n\t"
                "xor\t%2, %0, %3\n\t"
                "sc\t%2, %1\n\t"
                "beqz\t%2, 1b\n\t"
                " and\t%2, %0, %3\n\t"



                ".set\treorder"
                : "=&r" (temp), "=m" (*m), "=&r" (res)
                : "r" (1UL << (nr & 0x1f)), "m" (*m)
                : "memory");

        return res != 0;
}
# 311 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) int __test_and_change_bit(int nr, volatile void * addr)
{
        volatile unsigned long *a = addr;
        unsigned long mask;
        int retval;

        a += nr >> 5;
        mask = 1 << (nr & 0x1f);
        retval = (mask & *a) != 0;
        *a ^= mask;

        return retval;
}
# 585 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int test_bit(int nr, volatile void *addr)
{
        return 1UL & (((const volatile unsigned long *) addr)[nr >> 5] >> (nr & 31UL));
}







static __inline__ __attribute__((always_inline)) unsigned long ffz(unsigned long word)
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
# 628 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) long find_next_zero_bit(void *addr, unsigned long size,
        unsigned long offset)
{
        unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
        unsigned long result = offset & ~31UL;
        unsigned long tmp;

        if (offset >= size)
                return size;
        size -= result;
        offset &= 31UL;
        if (offset) {
                tmp = *(p++);
                tmp |= ~0UL >> (32-offset);
                if (size < 32)
                        goto found_first;
                if (~tmp)
                        goto found_middle;
                size -= 32;
                result += 32;
        }
        while (size & ~31UL) {
                if (~(tmp = *(p++)))
                        goto found_middle;
                result += 32;
                size -= 32;
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
# 698 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bitops.h"
static __inline__ __attribute__((always_inline)) int __test_and_set_le_bit(int nr, void * addr)
{
        unsigned char *ADDR = (unsigned char *) addr;
        int mask, retval;

        ADDR += nr >> 3;
        mask = 1 << (nr & 0x07);
        retval = (mask & *ADDR) != 0;
        *ADDR |= mask;

        return retval;
}

static __inline__ __attribute__((always_inline)) int __test_and_clear_le_bit(int nr, void * addr)
{
        unsigned char *ADDR = (unsigned char *) addr;
        int mask, retval;

        ADDR += nr >> 3;
        mask = 1 << (nr & 0x07);
        retval = (mask & *ADDR) != 0;
        *ADDR &= ~mask;

        return retval;
}

static __inline__ __attribute__((always_inline)) int test_le_bit(int nr, const void * addr)
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
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h" 2



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigaddset(sigset_t *set, int _sig)
{
        unsigned long sig = _sig - 1;
        if ((128 / 32) == 1)
                set->sig[0] |= 1UL << sig;
        else
                set->sig[sig / 32] |= 1UL << (sig % 32);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigdelset(sigset_t *set, int _sig)
{
        unsigned long sig = _sig - 1;
        if ((128 / 32) == 1)
                set->sig[0] &= ~(1UL << sig);
        else
                set->sig[sig / 32] &= ~(1UL << (sig % 32));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int sigismember(sigset_t *set, int _sig)
{
        unsigned long sig = _sig - 1;
        if ((128 / 32) == 1)
                return 1 & (set->sig[0] >> sig);
        else
                return 1 & (set->sig[sig / 32] >> (sig % 32));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int sigfindinword(unsigned long word)
{
        return ffz(~word);
}
# 108 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigorsets(sigset_t *r, const sigset_t *a, const sigset_t *b) { unsigned long a0, a1, a2, a3, b0, b1, b2, b3; unsigned long i; for (i = 0; i < (128 / 32)/4; ++i) { a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; a3 = a->sig[4*i+3]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; b3 = b->sig[4*i+3]; r->sig[4*i+0] = ((a0) | (b0)); r->sig[4*i+1] = ((a1) | (b1)); r->sig[4*i+2] = ((a2) | (b2)); r->sig[4*i+3] = ((a3) | (b3)); } switch ((128 / 32) % 4) { case 3: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; r->sig[4*i+0] = ((a0) | (b0)); r->sig[4*i+1] = ((a1) | (b1)); r->sig[4*i+2] = ((a2) | (b2)); break; case 2: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; r->sig[4*i+0] = ((a0) | (b0)); r->sig[4*i+1] = ((a1) | (b1)); break; case 1: a0 = a->sig[4*i+0]; b0 = b->sig[4*i+0]; r->sig[4*i+0] = ((a0) | (b0)); break; } }


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigandsets(sigset_t *r, const sigset_t *a, const sigset_t *b) { unsigned long a0, a1, a2, a3, b0, b1, b2, b3; unsigned long i; for (i = 0; i < (128 / 32)/4; ++i) { a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; a3 = a->sig[4*i+3]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; b3 = b->sig[4*i+3]; r->sig[4*i+0] = ((a0) & (b0)); r->sig[4*i+1] = ((a1) & (b1)); r->sig[4*i+2] = ((a2) & (b2)); r->sig[4*i+3] = ((a3) & (b3)); } switch ((128 / 32) % 4) { case 3: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; r->sig[4*i+0] = ((a0) & (b0)); r->sig[4*i+1] = ((a1) & (b1)); r->sig[4*i+2] = ((a2) & (b2)); break; case 2: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; r->sig[4*i+0] = ((a0) & (b0)); r->sig[4*i+1] = ((a1) & (b1)); break; case 1: a0 = a->sig[4*i+0]; b0 = b->sig[4*i+0]; r->sig[4*i+0] = ((a0) & (b0)); break; } }


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void signandsets(sigset_t *r, const sigset_t *a, const sigset_t *b) { unsigned long a0, a1, a2, a3, b0, b1, b2, b3; unsigned long i; for (i = 0; i < (128 / 32)/4; ++i) { a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; a3 = a->sig[4*i+3]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; b3 = b->sig[4*i+3]; r->sig[4*i+0] = ((a0) & ~(b0)); r->sig[4*i+1] = ((a1) & ~(b1)); r->sig[4*i+2] = ((a2) & ~(b2)); r->sig[4*i+3] = ((a3) & ~(b3)); } switch ((128 / 32) % 4) { case 3: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; a2 = a->sig[4*i+2]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; b2 = b->sig[4*i+2]; r->sig[4*i+0] = ((a0) & ~(b0)); r->sig[4*i+1] = ((a1) & ~(b1)); r->sig[4*i+2] = ((a2) & ~(b2)); break; case 2: a0 = a->sig[4*i+0]; a1 = a->sig[4*i+1]; b0 = b->sig[4*i+0]; b1 = b->sig[4*i+1]; r->sig[4*i+0] = ((a0) & ~(b0)); r->sig[4*i+1] = ((a1) & ~(b1)); break; case 1: a0 = a->sig[4*i+0]; b0 = b->sig[4*i+0]; r->sig[4*i+0] = ((a0) & ~(b0)); break; } }
# 140 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/signal.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void signotset(sigset_t *set) { unsigned long i; for (i = 0; i < (128 / 32)/4; ++i) { set->sig[4*i+0] = (~(set->sig[4*i+0])); set->sig[4*i+1] = (~(set->sig[4*i+1])); set->sig[4*i+2] = (~(set->sig[4*i+2])); set->sig[4*i+3] = (~(set->sig[4*i+3])); } switch ((128 / 32) % 4) { case 3: set->sig[4*i+2] = (~(set->sig[4*i+2])); case 2: set->sig[4*i+1] = (~(set->sig[4*i+1])); case 1: set->sig[4*i+0] = (~(set->sig[4*i+0])); } }




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void sigemptyset(sigset_t *set)
{
        switch ((128 / 32)) {
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
        switch ((128 / 32)) {
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
        switch ((128 / 32)) {
        default:
                memset(&set->sig[1], 0, sizeof(long)*((128 / 32)-1));
                break;
        case 2: set->sig[1] = 0;
        case 1: ;
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void siginitsetinv(sigset_t *set, unsigned long mask)
{
        set->sig[0] = ~mask;
        switch ((128 / 32)) {
        default:
                memset(&set->sig[1], -1, sizeof(long)*((128 / 32)-1));
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
# 15 "arch/mips/mm/init.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/sched.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/param.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/param.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/compiler.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/param.h" 2
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
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/list.h" 1





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/prefetch.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/prefetch.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/cache.h" 1




# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cache.h" 1
# 6 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/cache.h" 2
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/isadep.h" 1
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2







# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/smp.h" 1
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/threads.h" 1
# 26 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cachectl.h" 1
# 28 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/cpu.h" 1
# 29 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h" 1
# 18 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/hazards.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h" 2
# 875 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h"
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
# 956 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mipsregs.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int set_c0_status(unsigned int set) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$12" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$12" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res |= set; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$12" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$12" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int clear_c0_status(unsigned int clear) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$12" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$12" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~clear; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$12" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$12" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int change_c0_status(unsigned int change, unsigned int new) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$12" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$12" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~change; res |= (new & change); do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$12" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$12" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int set_c0_cause(unsigned int set) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$13" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$13" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res |= set; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$13" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$13" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int clear_c0_cause(unsigned int clear) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$13" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$13" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~clear; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$13" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$13" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int change_c0_cause(unsigned int change, unsigned int new) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$13" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$13" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~change; res |= (new & change); do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$13" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$13" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int set_c0_config(unsigned int set) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$16" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$16" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res |= set; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$16" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$16" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int clear_c0_config(unsigned int clear) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$16" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$16" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~clear; do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$16" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$16" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int change_c0_config(unsigned int change, unsigned int new) { unsigned int res; res = ({ int __res; if (0 == 0) __asm__ __volatile__( "mfc0\t%0, " "$16" "\n\t" : "=r" (__res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mfc0\t%0, " "$16" ", " "0" "\n\t" ".set\tmips0\n\t" : "=r" (__res)); __res; }); res &= ~change; res |= (new & change); do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$16" "\n\t" : : "Jr" (res)); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$16" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (res)); } while (0); return res; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int set_c0_intcontrol(unsigned int set) { unsigned int res; res = ({ int __res; __asm__ __volatile__( "cfc0\t%0, " "$20" "\n\t" : "=r" (__res)); __res; }); res |= set; do { __asm__ __volatile__( "ctc0\t%z0, " "$20" "\n\t" : : "Jr" ((unsigned int)res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int clear_c0_intcontrol(unsigned int clear) { unsigned int res; res = ({ int __res; __asm__ __volatile__( "cfc0\t%0, " "$20" "\n\t" : "=r" (__res)); __res; }); res &= ~clear; do { __asm__ __volatile__( "ctc0\t%z0, " "$20" "\n\t" : : "Jr" ((unsigned int)res)); } while (0); return res; } static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int change_c0_intcontrol(unsigned int change, unsigned int new) { unsigned int res; res = ({ int __res; __asm__ __volatile__( "cfc0\t%0, " "$20" "\n\t" : "=r" (__res)); __res; }); res &= ~change; res |= (new & change); do { __asm__ __volatile__( "ctc0\t%z0, " "$20" "\n\t" : : "Jr" ((unsigned int)res)); } while (0); return res; }
# 30 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/reg.h" 1
# 31 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h" 2





struct cache_desc {
        unsigned short linesz;
        unsigned short ways;
        unsigned short sets;
        unsigned int waysize;
        unsigned int waybit;
        unsigned int flags;
};
# 53 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
struct cpuinfo_mips {
        unsigned long udelay_val;
        unsigned long *pgd_quick;
        unsigned long *pte_quick;
        unsigned long pgtable_cache_sz;
        unsigned long asid_cache;



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
# 108 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
extern struct cpuinfo_mips cpu_data[];


extern void cpu_probe(void);
extern void cpu_report(void);




extern void (*cpu_wait)(void);

extern unsigned int vced_count, vcei_count;
# 153 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
struct mips_fpu_hard_struct {
        double fp_regs[32];
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
# 246 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/processor.h"
extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);





struct mips_frame_info {
        int frame_offset;
        int pc_offset;
};
extern struct mips_frame_info schedule_frame;



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long thread_saved_pc(struct thread_struct *t)
{
        extern void ret_from_fork(void);


        if (t->reg31 == (unsigned long) ret_from_fork)
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
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/spinlock.h" 1
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
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/wait.h" 2


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/break.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h" 2
# 35 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h"
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
# 36 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h" 2
# 44 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h"
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
# 87 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h"
typedef struct { unsigned long pte_low; } pte_t;




typedef struct { unsigned long pmd; } pmd_t;
typedef struct { unsigned long pgd; } pgd_t;
typedef struct { unsigned long pgprot; } pgprot_t;
# 107 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/page.h"
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
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/statfs.h"
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
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/net.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h" 1
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/socket.h"
struct __kernel_sockaddr_storage {
        unsigned short ss_family;

        char __data[128 - sizeof(unsigned short)];


} __attribute__ ((aligned((__alignof__ (struct sockaddr *)))));



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/socket.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sockios.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sockios.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ioctl.h" 1
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/sockios.h" 2
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/socket.h" 2
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
# 23 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/net.h" 2


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





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/atomic.h" 1
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/atomic.h"
typedef struct { volatile int counter; } atomic_t;
# 127 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/atomic.h"
static __inline__ __attribute__((always_inline)) void atomic_add(int i, atomic_t * v)
{
        unsigned long temp;

        __asm__ __volatile__(
                "1:   ll      %0, %1      # atomic_add\n"
                "     addu    %0, %2                  \n"
                "     sc      %0, %1                  \n"
                "     beqz    %0, 1b                  \n"
                : "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter));
}
# 148 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/atomic.h"
static __inline__ __attribute__((always_inline)) void atomic_sub(int i, atomic_t * v)
{
        unsigned long temp;

        __asm__ __volatile__(
                "1:   ll      %0, %1      # atomic_sub\n"
                "     subu    %0, %2                  \n"
                "     sc      %0, %1                  \n"
                "     beqz    %0, 1b                  \n"
                : "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter));
}




static __inline__ __attribute__((always_inline)) int atomic_add_return(int i, atomic_t * v)
{
        unsigned long temp, result;

        __asm__ __volatile__(
                ".set push               # atomic_add_return\n"
                ".set noreorder                             \n"
                "1:   ll      %1, %2                        \n"
                "     addu    %0, %1, %3                    \n"
                "     sc      %0, %2                        \n"
                "     beqz    %0, 1b                        \n"
                "     addu    %0, %1, %3                    \n"
                "     sync                                  \n"
                ".set pop                                   \n"
                : "=&r" (result), "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter)
                : "memory");

        return result;
}

static __inline__ __attribute__((always_inline)) int atomic_sub_return(int i, atomic_t * v)
{
        unsigned long temp, result;

        __asm__ __volatile__(
                ".set push                                   \n"
                ".set noreorder           # atomic_sub_return\n"
                "1:   ll    %1, %2                           \n"
                "     subu  %0, %1, %3                       \n"
                "     sc    %0, %2                           \n"
                "     beqz  %0, 1b                           \n"
                "     subu  %0, %1, %3                       \n"
                "     sync                                   \n"
                ".set pop                                    \n"
                : "=&r" (result), "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter)
                : "memory");

        return result;
}
# 7 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/dcache.h" 2
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





struct stat {
        dev_t st_dev;
        long st_pad1[3];
        ino_t st_ino;
        mode_t st_mode;
        nlink_t st_nlink;
        uid_t st_uid;
        gid_t st_gid;
        dev_t st_rdev;
        long st_pad2[2];
        off_t st_size;
        long st_pad3;




        time_t st_atime;
        long reserved0;
        time_t st_mtime;
        long reserved1;
        time_t st_ctime;
        long reserved2;
        long st_blksize;
        long st_blocks;
        long st_pad4[14];
};







struct stat64 {
        unsigned long st_dev;
        unsigned long st_pad0[3];

        unsigned long long st_ino;

        mode_t st_mode;
        nlink_t st_nlink;

        uid_t st_uid;
        gid_t st_gid;

        unsigned long st_rdev;
        unsigned long st_pad1[3];

        long long st_size;





        time_t st_atime;
        unsigned long reserved0;

        time_t st_mtime;
        unsigned long reserved1;

        time_t st_ctime;
        unsigned long reserved2;

        unsigned long st_blksize;
        unsigned long st_pad2;

        long long st_blocks;
};
# 7 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/stat.h" 2
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2







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






extern spinlock_t semaphore_lock;


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
# 220 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int down_trylock(struct semaphore * sem)
{
        unsigned long flags;
        int count, waking;
        int ret = 0;





        do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&semaphore_lock); } while (0);
        count = ((&sem->count)->counter) - 1;
        ((&sem->count)->counter = (count));
        if (__builtin_expect((count < 0),0)) {
                waking = ((&sem->waking)->counter);
                if (waking <= 0) {
                        ((&sem->count)->counter = (count + 1));
                        ret = 1;
                } else {
                        ((&sem->waking)->counter = (waking - 1));
                        ret = 0;
                }
        }
        do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);

        return ret;
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void up(struct semaphore * sem)
{
        unsigned long flags;
        int count, waking;
# 266 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/semaphore.h"
        do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&semaphore_lock); } while (0);
        count = ((&sem->count)->counter) + 1;
        waking = ((&sem->waking)->counter);
        if (count <= 0)
                waking++;
        ((&sem->count)->counter = (count));
        ((&sem->waking)->counter = (waking));
        do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);

        if (__builtin_expect((count <= 0),0))
                __up_wakeup(sem);
}



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
# 84 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/fcntl.h"
typedef struct flock {
        short l_type;
        short l_whence;
        __kernel_off_t l_start;
        __kernel_off_t l_len;
        long l_sysid;
        __kernel_pid_t l_pid;
        long pad[4];
} flock_t;

typedef struct flock64 {
        short l_type;
        short l_whence;
        loff_t l_start;
        loff_t l_len;
        pid_t l_pid;
} flock64_t;
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fcntl.h" 2
# 659 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h" 2

extern int fcntl_getlk(unsigned int, struct flock *);
extern int fcntl_setlk(unsigned int, struct file *, unsigned int,
                        struct flock *);

extern int fcntl_getlk64(unsigned int, struct flock64 *);
extern int fcntl_setlk64(unsigned int, struct file *, unsigned int,
                        struct flock64 *);


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
# 1328 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
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
# 1359 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
# 1370 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
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
# 1612 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
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
# 1656 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/fs.h"
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
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termios.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termbits.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termbits.h"
typedef unsigned char cc_t;
typedef unsigned long speed_t;
typedef unsigned long tcflag_t;






struct termios {
        tcflag_t c_iflag;
        tcflag_t c_oflag;
        tcflag_t c_cflag;
        tcflag_t c_lflag;



        cc_t c_line;
        cc_t c_cc[23];
};
# 12 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termios.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/ioctls.h" 1
# 13 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/termios.h" 2

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
        struct file * fd_array[32];
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
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/current.h"
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

        switch ((128 / 32)) {
        default:
                for (i = (128 / 32), ready = 0; --i >= 0 ;)
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
# 16 "arch/mips/mm/init.c" 2




# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pagemap.h" 1
# 10 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pagemap.h"
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
                char reserved[(1L << 14) - 10];
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
# 21 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/fixmap.h" 1
# 49 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/fixmap.h"
enum fixed_addresses {




        __end_of_fixed_addresses
};

extern void __set_fixmap (enum fixed_addresses idx,
                                        unsigned long phys, pgprot_t flags);
# 80 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/fixmap.h"
extern void __this_fixmap_does_not_exist(void);






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long fix_to_virt(const unsigned int idx)
{
# 98 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/fixmap.h"
        if (idx >= __end_of_fixed_addresses)
                __this_fixmap_does_not_exist();

        return ((0xffffe000UL) - ((idx) << 14));
}
# 22 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h" 2
# 40 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
extern void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
                               unsigned long entryhi, unsigned long pagemask);
# 50 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
                               unsigned long entryhi, unsigned long pagemask);
# 88 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable-bits.h" 1
# 89 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h" 2
# 130 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable-32.h" 1
# 31 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable-32.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_none(pte_t pte) { return !(((pte).pte_low) & ~(1<<6)); }

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_wrprotect(pte_t pte)
{
        ((pte).pte_low) &= ~((1<<2) | (1<<8));
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_rdprotect(pte_t pte)
{
        ((pte).pte_low) &= ~((1<<1) | (1<<7));
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkclean(pte_t pte)
{
        ((pte).pte_low) &= ~((1<<4)|(1<<8));
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkold(pte_t pte)
{
        ((pte).pte_low) &= ~((1<<3)|(1<<7));
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkwrite(pte_t pte)
{
        ((pte).pte_low) |= (1<<2);
        if (((pte).pte_low) & (1<<4))
                ((pte).pte_low) |= (1<<8);
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkread(pte_t pte)
{
        ((pte).pte_low) |= (1<<1);
        if (((pte).pte_low) & (1<<3))
                ((pte).pte_low) |= (1<<7);
        return pte;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkdirty(pte_t pte)
{
        ((pte).pte_low) |= (1<<4);
        if (((pte).pte_low) & (1<<2))
                ((pte).pte_low) |= (1<<8);
        return pte;
}
# 89 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable-32.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pgprot_t pgprot_noncached(pgprot_t _prot)
{
        unsigned long prot = ((_prot).pgprot);

        prot = (prot & ~(7<<9)) | (2<<9);

        return ((pgprot_t) { (prot) } );
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_mkyoung(pte_t pte)
{
        ((pte).pte_low) |= (1<<3);
        if (((pte).pte_low) & (1<<1))
                ((pte).pte_low) |= (1<<7);
        return pte;
}
# 133 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable-32.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t mk_pte_phys(phys_t physpage, pgprot_t pgprot)
{



        return ((pte_t) { (physpage | ((pgprot).pgprot)) } );

}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t pte_modify(pte_t pte, pgprot_t newprot)
{
        return ((pte_t) { ((((pte).pte_low) & ((~((1L << 14)-1)) | (1<<3) | (1<<4) | (7<<9))) | ((newprot).pgprot)) } );
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void set_pte(pte_t *ptep, pte_t pteval)
{
        *ptep = pteval;

        if (((pteval).pte_low) & (1<<6)) {
                pte_t *buddy = ((pte_t *)((unsigned long)(ptep) ^ sizeof(pte_t)));




                if (pte_none(*buddy))
                        ((*buddy).pte_low) = ((*buddy).pte_low) | (1<<6);
        }

}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pte_clear(pte_t *ptep)
{


        if (((*((pte_t *)((unsigned long)(ptep) ^ sizeof(pte_t)))).pte_low) & (1<<6))
                set_pte(ptep, ((pte_t) { ((1<<6)) } ));
        else

                set_pte(ptep, ((pte_t) { (0) } ));
}
# 131 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h" 2




extern unsigned long empty_zero_page;
extern unsigned long zero_page_mask;




extern void load_pgd(unsigned long pg_dir);

extern pmd_t invalid_pte_table[(1L << 14)/sizeof(pmd_t)];





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long pmd_page(pmd_t pmd)
{
        return ((pmd).pmd);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pmd_set(pmd_t * pmdp, pte_t * ptep)
{
        ((*pmdp).pmd) = (((unsigned long) ptep) & (~((1L << 14)-1)));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_present(pte_t pte) { return ((pte).pte_low) & (1<<0); }
# 171 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pmd_none(pmd_t pmd)
{
        return ((pmd).pmd) == (unsigned long) invalid_pte_table;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pmd_bad(pmd_t pmd)
{
        return ((pmd_page(pmd) > (unsigned long) high_memory) ||
                (pmd_page(pmd) < 0x80000000UL));
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pmd_present(pmd_t pmd)
{
        return (((pmd).pmd) != (unsigned long) invalid_pte_table);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pmd_clear(pmd_t *pmdp)
{
        ((*pmdp).pmd) = ((unsigned long) invalid_pte_table);
}






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pgd_none(pgd_t pgd) { return 0; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pgd_bad(pgd_t pgd) { return 0; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pgd_present(pgd_t pgd) { return 1; }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void pgd_clear(pgd_t *pgdp) { }






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_read(pte_t pte) { return (pte).pte_low & (1<<1); }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_write(pte_t pte) { return (pte).pte_low & (1<<2); }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_dirty(pte_t pte) { return (pte).pte_low & (1<<4); }
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int pte_young(pte_t pte) { return (pte).pte_low & (1<<3); }
# 239 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pgd_t *pgd_offset(struct mm_struct *mm, unsigned long address)
{
        return mm->pgd + ((address) >> (2 * 14 - ffz(~sizeof(pte_t))));
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pmd_t *pmd_offset(pgd_t *dir, unsigned long address)
{
        return (pmd_t *) dir;
}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t *pte_offset(pmd_t * dir, unsigned long address)
{
        return (pte_t *) (pmd_page(*dir)) +
               ((address >> 14) & ((((1L << 14) << 0) / sizeof(pte_t)) - 1));
}

extern int do_check_pgt_cache(int, int);

extern pgd_t swapper_pg_dir[(((1L << 14) << 0) / sizeof(pgd_t))];
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
# 295 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h"
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
# 296 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgtable.h" 2
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
        return zone_table[page->flags >> (32 - 8)];
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void set_page_zone(struct page *page, unsigned long zone_num)
{
        page->flags &= ~(~0UL << (32 - 8));
        page->flags |= zone_num << (32 - 8);
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
        if ((offset + (((len) + (1L << 14) - 1) & (~((1L << 14)-1)))) < offset)
                goto out;
        if (!(offset & ~(~((1L << 14)-1))))
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






        address &= (~((1L << 14)-1));


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
# 11 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pagemap.h" 2





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/highmem.h" 1




# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgalloc.h" 1
# 25 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgalloc.h"
extern void local_flush_tlb_all(void);
extern void local_flush_tlb_mm(struct mm_struct *mm);
extern void local_flush_tlb_range(struct mm_struct *mm, unsigned long start,
                               unsigned long end);
extern void local_flush_tlb_page(struct vm_area_struct *vma,
                                 unsigned long page);
extern void local_flush_tlb_one(unsigned long page);
# 49 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgalloc.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void flush_tlb_pgtables(struct mm_struct *mm,
                                      unsigned long start, unsigned long end)
{

}
# 70 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgalloc.h"
extern void pgd_init(unsigned long page);

static __inline__ __attribute__((always_inline)) pgd_t *get_pgd_slow(void)
{
        pgd_t *ret = (pgd_t *)__get_free_pages((0x20 | 0x10 | 0x40 | 0x80 | 0x100), 0), *init;

        if (ret) {
                init = pgd_offset(&init_mm, 0);
                pgd_init((unsigned long)ret);
                memcpy (ret + (0x80000000UL/(1UL << (2 * 14 - ffz(~sizeof(pte_t))))), init + (0x80000000UL/(1UL << (2 * 14 - ffz(~sizeof(pte_t))))),
                        ((((1L << 14) << 0) / sizeof(pgd_t)) - (0x80000000UL/(1UL << (2 * 14 - ffz(~sizeof(pte_t)))))) * sizeof(pgd_t));
        }
        return ret;
}

static __inline__ __attribute__((always_inline)) pgd_t *get_pgd_fast(void)
{
        unsigned long *ret;

        if((ret = (cpu_data[0].pgd_quick)) != ((void *)0)) {
                (cpu_data[0].pgd_quick) = (unsigned long *)(*ret);
                ret[0] = ret[1];
                (cpu_data[0].pgtable_cache_sz)--;
        } else
                ret = (unsigned long *)get_pgd_slow();
        return (pgd_t *)ret;
}

static __inline__ __attribute__((always_inline)) void free_pgd_fast(pgd_t *pgd)
{
        *(unsigned long *)pgd = (unsigned long) (cpu_data[0].pgd_quick);
        (cpu_data[0].pgd_quick) = (unsigned long *) pgd;
        (cpu_data[0].pgtable_cache_sz)++;
}

static __inline__ __attribute__((always_inline)) void free_pgd_slow(pgd_t *pgd)
{
        free_pages((unsigned long)pgd, 0);
}

static __inline__ __attribute__((always_inline)) pte_t *get_pte_fast(void)
{
        unsigned long *ret;

        if((ret = (unsigned long *)(cpu_data[0].pte_quick)) != ((void *)0)) {
                (cpu_data[0].pte_quick) = (unsigned long *)(*ret);
                ret[0] = ret[1];
                (cpu_data[0].pgtable_cache_sz)--;
        }
        return (pte_t *)ret;
}

static __inline__ __attribute__((always_inline)) void free_pte_fast(pte_t *pte)
{
        *(unsigned long *)pte = (unsigned long) (cpu_data[0].pte_quick);
        (cpu_data[0].pte_quick) = (unsigned long *) pte;
        (cpu_data[0].pgtable_cache_sz)++;
}

static __inline__ __attribute__((always_inline)) void free_pte_slow(pte_t *pte)
{
        free_pages(((unsigned long)pte),0);
}


static __inline__ __attribute__((always_inline)) pmd_t *get_pmd_fast(void)
{
        return (pmd_t *)0;
}

static __inline__ __attribute__((always_inline)) void free_pmd_fast(pmd_t *pmd)
{
}

static __inline__ __attribute__((always_inline)) void free_pmd_slow(pmd_t *pmd)
{
}

extern void __bad_pte(pmd_t *pmd);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) pte_t *pte_alloc_one(struct mm_struct *mm, unsigned long address)
{
        pte_t *pte;

        pte = (pte_t *) __get_free_pages(((0x20 | 0x10 | 0x40 | 0x80 | 0x100)),0);
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

static __inline__ __attribute__((always_inline)) void pte_free_fast(pte_t *pte)
{
        *(unsigned long *)pte = (unsigned long) (cpu_data[0].pte_quick);
        (cpu_data[0].pte_quick) = (unsigned long *) pte;
        (cpu_data[0].pgtable_cache_sz)++;
}

static __inline__ __attribute__((always_inline)) void pte_free_slow(pte_t *pte)
{
        free_pages(((unsigned long)pte),0);
}
# 197 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/pgalloc.h"
extern int do_check_pgt_cache(int, int);
# 6 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/highmem.h" 2
# 66 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/highmem.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int nr_free_highpages(void) { return 0; }

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void *kmap(struct page *page) { return ((void *)((unsigned long) ((((page) - page_zone(page)->zone_mem_map) << 14) + page_zone(page)->zone_start_paddr) + 0x80000000UL)); }
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

        if (offset + size > (1L << 14))
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
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pagemap.h" 2
# 34 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pagemap.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct page *page_cache_alloc(struct address_space *x)
{
        return alloc_pages(x->gfp_mask, 0);
}






extern unsigned int page_hash_bits;



extern unsigned long page_cache_size;
extern struct page **page_hash_table;

extern void page_cache_init(unsigned long);
# 62 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/pagemap.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long _page_hashfn(struct address_space * mapping, unsigned long index)
{


        return (((((unsigned long) mapping)/(sizeof(struct inode) & ~ (sizeof(struct inode) - 1)))+index)+(((((unsigned long) mapping)/(sizeof(struct inode) & ~ (sizeof(struct inode) - 1)))+index)>>(page_hash_bits))) & ((1 << (page_hash_bits))-1);


}



extern struct page * __find_get_page(struct address_space *mapping,
                                unsigned long index, struct page **hash);


extern struct page * __find_lock_page (struct address_space * mapping,
                                unsigned long index, struct page **hash);
extern struct page * find_or_create_page(struct address_space *mapping,
                                unsigned long index, unsigned int gfp_mask);

extern void lock_page(struct page *page);
extern void unlock_page(struct page *page);


extern struct page *find_trylock_page(struct address_space *, unsigned long);

extern void add_to_page_cache(struct page * page, struct address_space *mapping, unsigned long index);
extern void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index);
extern int add_to_page_cache_unique(struct page * page, struct address_space *mapping, unsigned long index, struct page **hash);

extern void ___wait_on_page(struct page *);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void wait_on_page(struct page * page)
{
        if (test_bit(0, &(page)->flags))
                ___wait_on_page(page);
}

extern void wakeup_page_waiters(struct page * page);




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) struct page *grab_cache_page(struct address_space *mapping, unsigned long index)
{
        return find_or_create_page(mapping, index, mapping->gfp_mask);
}


extern struct page * grab_cache_page_nowait (struct address_space *, unsigned long);

typedef int filler_t(void *, struct page*);

extern struct page *read_cache_page(struct address_space *, unsigned long,
                                filler_t *, void *);
# 21 "arch/mips/mm/init.c" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mman.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mman.h" 1
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/mman.h" 2
# 23 "arch/mips/mm/init.c" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/bootmem.h" 1







# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/dma.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/dma.h"
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h" 1
# 108 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
extern void * __ioremap(phys_t offset, phys_t size, unsigned long flags);
# 151 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
extern void iounmap(void *addr);
# 186 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
extern unsigned long isa_slot_offset;
# 225 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
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
# 254 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
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
# 283 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long virt_to_phys(volatile void * address)
{
        return (unsigned long)address - 0x80000000UL;
}
# 301 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void * phys_to_virt(unsigned long address)
{
        return (void *)(address + 0x80000000UL);
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long virt_to_bus(volatile void * address)
{
        return (unsigned long)address - 0x80000000UL;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void * bus_to_virt(unsigned long address)
{
        return (void *)(address + 0x80000000UL);
}
# 330 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
extern const unsigned long mips_io_port_base;
# 385 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/io.h"
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
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/dma.h" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/delay.h" 1
# 10 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/delay.h"
extern unsigned long loops_per_jiffy;



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/delay.h" 1
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/delay.h"
extern unsigned long loops_per_jiffy;

static __inline__ __attribute__((always_inline)) void __delay(unsigned long loops)
{
        __asm__ __volatile__ (
                ".set\tnoreorder\n"
                "1:\tbnez\t%0,1b\n\t"
                "subu\t%0,1\n\t"
                ".set\treorder"
                :"=r" (loops)
                :"0" (loops));
}
# 40 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/delay.h"
static __inline__ __attribute__((always_inline)) void __udelay(unsigned long usecs, unsigned long lpj)
{
        unsigned long lo;




        usecs *= (unsigned long) (((0x8000000000000000ULL / (500000 / 100)) +
                                   0x80000000ULL) >> 32);
        __asm__("multu\t%2,%3"
                : "=h" (usecs), "=l" (lo)
                : "r" (usecs), "r" (lpj)
                : "accum");
        __delay(usecs);
}

static __inline__ __attribute__((always_inline)) void __ndelay(unsigned long nsecs, unsigned long lpj)
{
        unsigned long lo;




        nsecs *= (unsigned long) (((0x8000000000000000ULL / (500000000 / 100)) +
                                   0x80000000ULL) >> 32);
        __asm__("multu\t%2,%3"
                : "=h" (nsecs), "=l" (lo)
                : "r" (nsecs), "r" (lpj)
                : "accum");
        __delay(nsecs);
}
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/delay.h" 2
# 40 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/delay.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int jiffies_to_msecs(const unsigned long j)
{

        return (1000 / 100) * j;





}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int jiffies_to_usecs(const unsigned long j)
{

        return (1000000 / 100) * j;





}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long msecs_to_jiffies(const unsigned int m)
{
        if (((~0UL) - (1000 / 100) + 1) < (~0U) && m > (unsigned int)((~0UL) - (1000 / 100) + 1))
                return ((~0UL >> 1)-1);

        return ((unsigned long)m + (1000 / 100) - 1) / (1000 / 100);





}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void msleep(unsigned long msecs)
{
        do { current->state = (2); __asm__ __volatile__( ".set	push\n\t" ".set	noreorder\n\t" ".set	mips2\n\t" "sync\n\t" ".set	pop" : : : "memory"); } while (0);
        schedule_timeout(msecs_to_jiffies(msecs) + 1);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void ssleep(unsigned long secs)
{
        do { current->state = (2); __asm__ __volatile__( ".set	push\n\t" ".set	noreorder\n\t" ".set	mips2\n\t" "sync\n\t" ".set	pop" : : : "memory"); } while (0);
        schedule_timeout((100 * secs) + 1);
}
# 19 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/dma.h" 2
# 155 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/dma.h"
extern spinlock_t dma_spin_lock;

static __inline__ __attribute__((always_inline)) unsigned long claim_dma_lock(void)
{
        unsigned long flags;
        do { do { flags = rthal.getflags_and_cli(); } while(0);; (void)(&dma_spin_lock); } while (0);
        return flags;
}

static __inline__ __attribute__((always_inline)) void release_dma_lock(unsigned long flags)
{
        do { do { } while(0); do { rthal.setflags(flags); } while(0);; } while (0);
}


static __inline__ __attribute__((always_inline)) void enable_dma(unsigned int dmanr)
{
        if (dmanr<=3)
                do { *(volatile u8 *)(mips_io_port_base + (0x0A)) = (dmanr); } while(0);
        else
                do { *(volatile u8 *)(mips_io_port_base + (0xD4)) = (dmanr & 3); } while(0);
}

static __inline__ __attribute__((always_inline)) void disable_dma(unsigned int dmanr)
{
        if (dmanr<=3)
                do { *(volatile u8 *)(mips_io_port_base + (0x0A)) = (dmanr | 4); } while(0);
        else
                do { *(volatile u8 *)(mips_io_port_base + (0xD4)) = ((dmanr & 3) | 4); } while(0);
}
# 193 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/dma.h"
static __inline__ __attribute__((always_inline)) void clear_dma_ff(unsigned int dmanr)
{
        if (dmanr<=3)
                do { *(volatile u8 *)(mips_io_port_base + (0x0C)) = (0); } while(0);
        else
                do { *(volatile u8 *)(mips_io_port_base + (0xD8)) = (0); } while(0);
}


static __inline__ __attribute__((always_inline)) void set_dma_mode(unsigned int dmanr, char mode)
{
        if (dmanr<=3)
                do { *(volatile u8 *)(mips_io_port_base + (0x0B)) = (mode | dmanr); } while(0);
        else
                do { *(volatile u8 *)(mips_io_port_base + (0xD6)) = (mode | (dmanr&3)); } while(0);
}






static __inline__ __attribute__((always_inline)) void set_dma_page(unsigned int dmanr, char pagenr)
{
        switch(dmanr) {
                case 0:
                        do { *(volatile u8 *)(mips_io_port_base + (0x87)) = (pagenr); } while(0);
                        break;
                case 1:
                        do { *(volatile u8 *)(mips_io_port_base + (0x83)) = (pagenr); } while(0);
                        break;
                case 2:
                        do { *(volatile u8 *)(mips_io_port_base + (0x81)) = (pagenr); } while(0);
                        break;
                case 3:
                        do { *(volatile u8 *)(mips_io_port_base + (0x82)) = (pagenr); } while(0);
                        break;
                case 5:
                        do { *(volatile u8 *)(mips_io_port_base + (0x8B)) = (pagenr & 0xfe); } while(0);
                        break;
                case 6:
                        do { *(volatile u8 *)(mips_io_port_base + (0x89)) = (pagenr & 0xfe); } while(0);
                        break;
                case 7:
                        do { *(volatile u8 *)(mips_io_port_base + (0x8A)) = (pagenr & 0xfe); } while(0);
                        break;
        }
}





static __inline__ __attribute__((always_inline)) void set_dma_addr(unsigned int dmanr, unsigned int a)
{
        set_dma_page(dmanr, a>>16);
        if (dmanr <= 3) {
            do { *(volatile u8 *)(mips_io_port_base + (((dmanr&3)<<1) + 0x00)) = (a & 0xff); } while(0);
            do { *(volatile u8 *)(mips_io_port_base + (((dmanr&3)<<1) + 0x00)) = ((a>>8) & 0xff); } while(0);
        } else {
            do { *(volatile u8 *)(mips_io_port_base + (((dmanr&3)<<2) + 0xC0)) = ((a>>1) & 0xff); } while(0);
            do { *(volatile u8 *)(mips_io_port_base + (((dmanr&3)<<2) + 0xC0)) = ((a>>9) & 0xff); } while(0);
        }
}
# 267 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/dma.h"
static __inline__ __attribute__((always_inline)) void set_dma_count(unsigned int dmanr, unsigned int count)
{
        count--;
        if (dmanr <= 3) {
            do { *(volatile u8 *)(mips_io_port_base + (((dmanr&3)<<1) + 1 + 0x00)) = (count & 0xff); } while(0);
            do { *(volatile u8 *)(mips_io_port_base + (((dmanr&3)<<1) + 1 + 0x00)) = ((count>>8) & 0xff); } while(0);
        } else {
            do { *(volatile u8 *)(mips_io_port_base + (((dmanr&3)<<2) + 2 + 0xC0)) = ((count>>1) & 0xff); } while(0);
            do { *(volatile u8 *)(mips_io_port_base + (((dmanr&3)<<2) + 2 + 0xC0)) = ((count>>9) & 0xff); } while(0);
        }
}
# 288 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/dma.h"
static __inline__ __attribute__((always_inline)) int get_dma_residue(unsigned int dmanr)
{
        unsigned int io_port = (dmanr<=3)? ((dmanr&3)<<1) + 1 + 0x00
                                         : ((dmanr&3)<<2) + 2 + 0xC0;


        unsigned short count;

        count = 1 + inb(io_port);
        count += inb(io_port) << 8;

        return (dmanr<=3)? count : (count<<1);
}



extern int request_dma(unsigned int dmanr, const char * device_id);
extern void free_dma(unsigned int dmanr);


extern int isa_dma_bridge_buggy;
# 9 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/bootmem.h" 2
# 17 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/bootmem.h"
extern unsigned long max_low_pfn;
extern unsigned long min_low_pfn;
extern unsigned long max_pfn;





typedef struct bootmem_data {
        unsigned long node_boot_start;
        unsigned long node_low_pfn;
        void *node_bootmem_map;
        unsigned long last_offset;
        unsigned long last_pos;
} bootmem_data_t;

extern unsigned long __attribute__ ((__section__ (".text.init"))) bootmem_bootmap_pages (unsigned long);
extern unsigned long __attribute__ ((__section__ (".text.init"))) init_bootmem (unsigned long addr, unsigned long memend);
extern void __attribute__ ((__section__ (".text.init"))) reserve_bootmem (unsigned long addr, unsigned long size);
extern void __attribute__ ((__section__ (".text.init"))) free_bootmem (unsigned long addr, unsigned long size);
extern void * __attribute__ ((__section__ (".text.init"))) __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
# 46 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/bootmem.h"
extern unsigned long __attribute__ ((__section__ (".text.init"))) free_all_bootmem (void);

extern unsigned long __attribute__ ((__section__ (".text.init"))) init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
extern void __attribute__ ((__section__ (".text.init"))) reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
extern void __attribute__ ((__section__ (".text.init"))) free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
extern unsigned long __attribute__ ((__section__ (".text.init"))) free_all_bootmem_node (pg_data_t *pgdat);
extern void * __attribute__ ((__section__ (".text.init"))) __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
# 25 "arch/mips/mm/init.c" 2


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/swapctl.h" 1



typedef struct pager_daemon_v1
{
        unsigned int tries_base;
        unsigned int tries_min;
        unsigned int swap_cluster;
} pager_daemon_v1;
typedef pager_daemon_v1 pager_daemon_t;
extern pager_daemon_t pager_daemon;
# 28 "arch/mips/mm/init.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blk.h" 1



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blkdev.h" 1





# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/genhd.h" 1
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/genhd.h"
enum {


        DOS_EXTENDED_PARTITION = 5,
        LINUX_EXTENDED_PARTITION = 0x85,
        WIN98_EXTENDED_PARTITION = 0x0f,

        LINUX_SWAP_PARTITION = 0x82,
        LINUX_RAID_PARTITION = 0xfd,

        SOLARIS_X86_PARTITION = LINUX_SWAP_PARTITION,

        DM6_PARTITION = 0x54,
        EZD_PARTITION = 0x55,
        DM6_AUX1PARTITION = 0x51,
        DM6_AUX3PARTITION = 0x53,

        FREEBSD_PARTITION = 0xa5,
        OPENBSD_PARTITION = 0xa6,
        NETBSD_PARTITION = 0xa9,
        BSDI_PARTITION = 0xb7,

        BSD_PARTITION = FREEBSD_PARTITION,
        MINIX_PARTITION = 0x81,
        PLAN9_PARTITION = 0x39,
        UNIXWARE_PARTITION = 0x63,

};

struct partition {
        unsigned char boot_ind;
        unsigned char head;
        unsigned char sector;
        unsigned char cyl;
        unsigned char sys_ind;
        unsigned char end_head;
        unsigned char end_sector;
        unsigned char end_cyl;
        unsigned int start_sect;
        unsigned int nr_sects;
} __attribute__((packed));


# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/devfs_fs_kernel.h" 1
# 47 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/devfs_fs_kernel.h"
typedef struct devfs_entry * devfs_handle_t;
# 122 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/devfs_fs_kernel.h"
struct unique_numspace
{
    char dummy;
};



static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void devfs_put (devfs_handle_t de)
{
    return;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) devfs_handle_t devfs_register (devfs_handle_t dir,
                                             const char *name,
                                             unsigned int flags,
                                             unsigned int major,
                                             unsigned int minor,
                                             umode_t mode,
                                             void *ops, void *info)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void devfs_unregister (devfs_handle_t de)
{
    return;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_mk_symlink (devfs_handle_t dir, const char *name,
                                    unsigned int flags, const char *link,
                                    devfs_handle_t *handle, void *info)
{
    return 0;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) devfs_handle_t devfs_mk_dir (devfs_handle_t dir,
                                           const char *name, void *info)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) devfs_handle_t devfs_get_handle (devfs_handle_t dir,
                                               const char *name,
                                               unsigned int major,
                                               unsigned int minor,
                                               char type,
                                               int traverse_symlinks)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) devfs_handle_t devfs_find_handle (devfs_handle_t dir,
                                                const char *name,
                                                unsigned int major,
                                                unsigned int minor,
                                                char type,
                                                int traverse_symlinks)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_get_flags (devfs_handle_t de, unsigned int *flags)
{
    return 0;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_set_flags (devfs_handle_t de, unsigned int flags)
{
    return 0;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_get_maj_min (devfs_handle_t de,
                                     unsigned int *major, unsigned int *minor)
{
    return 0;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) devfs_handle_t devfs_get_handle_from_inode (struct inode *inode)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_generate_path (devfs_handle_t de, char *path,
                                       int buflen)
{
    return -89;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void *devfs_get_ops (devfs_handle_t de)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void devfs_put_ops (devfs_handle_t de)
{
    return;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_set_file_size (devfs_handle_t de, unsigned long size)
{
    return -89;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void *devfs_get_info (devfs_handle_t de)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_set_info (devfs_handle_t de, void *info)
{
    return 0;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) devfs_handle_t devfs_get_parent (devfs_handle_t de)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) devfs_handle_t devfs_get_first_child (devfs_handle_t de)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) devfs_handle_t devfs_get_next_sibling (devfs_handle_t de)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void devfs_auto_unregister (devfs_handle_t master,
                                          devfs_handle_t slave)
{
    return;
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) devfs_handle_t devfs_get_unregister_slave (devfs_handle_t master)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) const char *devfs_get_name (devfs_handle_t de,
                                          unsigned int *namelen)
{
    return ((void *)0);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_register_chrdev (unsigned int major, const char *name,
                                         struct file_operations *fops)
{
    return register_chrdev (major, name, fops);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_register_blkdev (unsigned int major, const char *name,
                                         struct block_device_operations *bdops)
{
    return register_blkdev (major, name, bdops);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_unregister_chrdev (unsigned int major,const char *name)
{
    return unregister_chrdev (major, name);
}
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_unregister_blkdev (unsigned int major,const char *name)
{
    return unregister_blkdev (major, name);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void devfs_register_tape (devfs_handle_t de)
{
    return;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void devfs_register_series (devfs_handle_t dir,
                                          const char *format,
                                          unsigned int num_entries,
                                          unsigned int flags,
                                          unsigned int major,
                                          unsigned int minor_start,
                                          umode_t mode, void *ops, void *info)
{
    return;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_alloc_major (char type)
{
    return -1;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void devfs_dealloc_major (char type, int major)
{
    return;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) kdev_t devfs_alloc_devnum (char type)
{
    return 0;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void devfs_dealloc_devnum (char type, kdev_t devnum)
{
    return;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int devfs_alloc_unique_number (struct unique_numspace *space)
{
    return -1;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void devfs_dealloc_unique_number (struct unique_numspace *space,
                                                int number)
{
    return;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void mount_devfs_fs (void)
{
    return;
}
# 60 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/genhd.h" 2

struct hd_struct {
        unsigned long start_sect;
        unsigned long nr_sects;
        devfs_handle_t de;





        unsigned int ios_in_flight;
        unsigned int io_ticks;
        unsigned int last_idle_time;
        unsigned int last_queue_change;
        unsigned int aveq;

        unsigned int rd_ios;
        unsigned int rd_merges;
        unsigned int rd_ticks;
        unsigned int rd_sectors;
        unsigned int wr_ios;
        unsigned int wr_merges;
        unsigned int wr_ticks;
        unsigned int wr_sectors;

};



struct gendisk {
        int major;
        const char *major_name;
        int minor_shift;

        int max_p;

        struct hd_struct *part;
        int *sizes;
        int nr_real;

        void *real_devices;
        struct gendisk *next;
        struct block_device_operations *fops;

        devfs_handle_t *de_arr;
        char *flags;
};


extern struct gendisk *gendisk_head;

extern void add_gendisk(struct gendisk *gp);
extern void del_gendisk(struct gendisk *gp);
extern struct gendisk *get_gendisk(kdev_t dev);
extern int walk_gendisk(int (*walk)(struct gendisk *, void *), void *);
# 263 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/genhd.h"
char *disk_name (struct gendisk *hd, int minor, char *buf);





struct request;


extern void disk_round_stats(struct hd_struct *hd);
extern void req_new_io(struct request *req, int merge, int sectors);
extern void req_merged_io(struct request *req);
extern void req_finished_io(struct request *req);






extern void devfs_register_partitions (struct gendisk *dev, int minor,
                                       int unregister);






static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int disk_index (kdev_t dev)
{
        int major = ((unsigned int) ((dev) >> 8));
        int minor = ((unsigned int) ((dev) & ((1U << 8) - 1)));
        unsigned int index;

        switch (major) {
                case 48 +0:
                        index = (minor & 0x00f8) >> 3;
                        break;
                case 8:
                        index = (minor & 0x00f0) >> 4;
                        break;
                case 3:
                case 13:
                        index = (minor & 0x0040) >> 6;
                        break;
                case 22:
                        index = ((minor & 0x0040) >> 6) + 2;
                        break;
                default:
                        return 0;
        }
        return index;
}
# 7 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blkdev.h" 2






struct request_queue;
typedef struct request_queue request_queue_t;
struct elevator_s;
typedef struct elevator_s elevator_t;





struct request {
        struct list_head queue;
        int elevator_sequence;

        volatile int rq_status;






        kdev_t rq_dev;
        int cmd;
        int errors;
        unsigned long start_time;
        unsigned long sector;
        unsigned long nr_sectors;
        unsigned long hard_sector, hard_nr_sectors;
        unsigned int nr_segments;
        unsigned int nr_hw_segments;
        unsigned long current_nr_sectors, hard_cur_sectors;
        void * special;
        char * buffer;
        struct completion * waiting;
        struct buffer_head * bh;
        struct buffer_head * bhtail;
        request_queue_t *q;
        char io_account;
};

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/elevator.h" 1



typedef void (elevator_fn) (struct request *, elevator_t *,
                            struct list_head *,
                            struct list_head *, int);

typedef int (elevator_merge_fn) (request_queue_t *, struct request **, struct list_head *,
                                 struct buffer_head *, int, int);

typedef void (elevator_merge_cleanup_fn) (request_queue_t *, struct request *, int);

typedef void (elevator_merge_req_fn) (struct request *, struct request *);

struct elevator_s
{
        int read_latency;
        int write_latency;

        elevator_merge_fn *elevator_merge_fn;
        elevator_merge_req_fn *elevator_merge_req_fn;

        unsigned int queue_ID;
};

int elevator_noop_merge(request_queue_t *, struct request **, struct list_head *, struct buffer_head *, int, int);
void elevator_noop_merge_cleanup(request_queue_t *, struct request *, int);
void elevator_noop_merge_req(struct request *, struct request *);

int elevator_linus_merge(request_queue_t *, struct request **, struct list_head *, struct buffer_head *, int, int);
void elevator_linus_merge_cleanup(request_queue_t *, struct request *, int);
void elevator_linus_merge_req(struct request *, struct request *);

typedef struct blkelv_ioctl_arg_s {
        int queue_ID;
        int read_latency;
        int write_latency;
        int max_bomb_segments;
} blkelv_ioctl_arg_t;




extern int blkelvget_ioctl(elevator_t *, blkelv_ioctl_arg_t *);
extern int blkelvset_ioctl(elevator_t *, const blkelv_ioctl_arg_t *);

extern void elevator_init(elevator_t *, elevator_t);
# 72 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/elevator.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int elevator_request_latency(elevator_t * elevator, int rw)
{
        int latency;

        latency = elevator->read_latency;
        if (rw != 0)
                latency = elevator->write_latency;

        return latency;
}
# 53 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blkdev.h" 2

typedef int (merge_request_fn) (request_queue_t *q,
                                struct request *req,
                                struct buffer_head *bh,
                                int);
typedef int (merge_requests_fn) (request_queue_t *q,
                                 struct request *req,
                                 struct request *req2,
                                 int);
typedef void (request_fn_proc) (request_queue_t *q);
typedef request_queue_t * (queue_proc) (kdev_t dev);
typedef int (make_request_fn) (request_queue_t *q, int rw, struct buffer_head *bh);
typedef void (plug_device_fn) (request_queue_t *q, kdev_t device);
typedef void (unplug_device_fn) (void *q);

struct request_list {
        unsigned int count;
        unsigned int pending[2];
        struct list_head free;
};

struct request_queue
{



        struct request_list rq;




        int nr_requests;




        int batch_requests;




        atomic_t nr_sectors;




        int batch_sectors;




        int max_queue_sectors;




        struct list_head queue_head;
        elevator_t elevator;

        request_fn_proc * request_fn;
        merge_request_fn * back_merge_fn;
        merge_request_fn * front_merge_fn;
        merge_requests_fn * merge_requests_fn;
        make_request_fn * make_request_fn;
        plug_device_fn * plug_device_fn;




        void * queuedata;




        struct tq_struct plug_tq;




        int plugged:1;





        int head_active:1;







        int can_throttle:1;

        unsigned long bounce_pfn;





        spinlock_t queue_lock;




        wait_queue_head_t wait_for_requests;
};





extern __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int rq_data_dir(struct request *rq)
{
        if (rq->cmd == 0)
                return 0;
        else if (rq->cmd == 1)
                return 1;
        else {
                do { __asm__ __volatile__("break %0" : : "i" (512)); } while (0);
                return -1;
        }
}

extern unsigned long blk_max_low_pfn, blk_max_pfn;




extern void blk_queue_bounce_limit(request_queue_t *, u64);
# 210 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blkdev.h"
struct blk_dev_struct {



        request_queue_t request_queue;
        queue_proc *queue;
        void *data;
};

struct sec_size {
        unsigned block_size;
        unsigned block_size_bits;
};
# 232 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blkdev.h"
extern struct sec_size * blk_sec[255];
extern struct blk_dev_struct blk_dev[255];
extern void grok_partitions(struct gendisk *dev, int drive, unsigned minors, long size);
extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, long size);
extern void generic_make_request(int rw, struct buffer_head * bh);
extern request_queue_t *blk_get_queue(kdev_t dev);
extern void blkdev_release_request(struct request *);




extern int blk_grow_request_list(request_queue_t *q, int nr_requests, int max_queue_sectors);
extern void blk_init_queue(request_queue_t *, request_fn_proc *);
extern void blk_cleanup_queue(request_queue_t *);
extern void blk_queue_headactive(request_queue_t *, int);
extern void blk_queue_throttle_sectors(request_queue_t *, int);
extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
extern void generic_unplug_device(void *);
extern int blk_seg_merge_ok(struct buffer_head *, struct buffer_head *);

extern int * blk_size[255];

extern int * blksize_size[255];

extern int * hardsect_size[255];

extern int * max_readahead[255];

extern int * max_sectors[255];

extern int * max_segments[255];
# 277 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blkdev.h"
extern void drive_stat_acct (kdev_t dev, int rw,
                                        unsigned long nr_sectors, int new_io);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int get_hardsect_size(kdev_t dev)
{
        int retval = 512;
        int major = ((unsigned int) ((dev) >> 8));

        if (hardsect_size[major]) {
                int minor = ((unsigned int) ((dev) & ((1U << 8) - 1)));
                if (hardsect_size[major][minor])
                        retval = hardsect_size[major][minor];
        }
        return retval;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int blk_oversized_queue(request_queue_t * q)
{
        if (q->can_throttle)
                return ((&q->nr_sectors)->counter) > q->max_queue_sectors;
        return q->rq.count == 0;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int blk_oversized_queue_reads(request_queue_t * q)
{
        if (q->can_throttle)
                return ((&q->nr_sectors)->counter) > q->max_queue_sectors + q->batch_sectors;
        return q->rq.count == 0;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int blk_oversized_queue_batch(request_queue_t * q)
{
        return ((&q->nr_sectors)->counter) > q->max_queue_sectors - q->batch_sectors;
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blk_started_sectors(struct request *rq, int count)
{
        request_queue_t *q = rq->q;
        if (q && q->can_throttle) {
                atomic_add(count, &q->nr_sectors);
                if (((&q->nr_sectors)->counter) < 0) {
                        printk("nr_sectors is %d\n", ((&q->nr_sectors)->counter));
                        do { __asm__ __volatile__("break %0" : : "i" (512)); } while (0);
                }
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blk_finished_sectors(struct request *rq, int count)
{
        request_queue_t *q = rq->q;
        if (q && q->can_throttle) {
                atomic_sub(count, &q->nr_sectors);

                __asm__ __volatile__("": : :"memory");
                if (q->rq.count >= q->batch_requests && !blk_oversized_queue_batch(q)) {
                        if (waitqueue_active(&q->wait_for_requests))
                                __wake_up((&q->wait_for_requests),2 | 1, 1);
                }
                if (((&q->nr_sectors)->counter) < 0) {
                        printk("nr_sectors is %d\n", ((&q->nr_sectors)->counter));
                        do { __asm__ __volatile__("break %0" : : "i" (512)); } while (0);
                }
        }
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int blksize_bits(unsigned int size)
{
        unsigned int bits = 8;
        do {
                bits++;
                size >>= 1;
        } while (size > 256);
        return bits;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned int block_size(kdev_t dev)
{
        int retval = (1<<10);
        int major = ((unsigned int) ((dev) >> 8));

        if (blksize_size[major]) {
                int minor = ((unsigned int) ((dev) & ((1U << 8) - 1)));
                if (blksize_size[major][minor])
                        retval = blksize_size[major][minor];
        }
        return retval;
}
# 5 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blk.h" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/locks.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/locks.h"
extern void __wait_on_buffer(struct buffer_head *);

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void wait_on_buffer(struct buffer_head * bh)
{
        if (test_bit(BH_Lock, &bh->b_state))
                __wait_on_buffer(bh);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void lock_buffer(struct buffer_head * bh)
{
        while (test_and_set_bit(BH_Lock, &bh->b_state))
                __wait_on_buffer(bh);
}

extern void unlock_buffer(struct buffer_head *bh);







static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void lock_super(struct super_block * sb)
{
        down(&sb->s_lock);
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void unlock_super(struct super_block * sb)
{
        up(&sb->s_lock);
}
# 6 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blk.h" 2
# 14 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blk.h"
extern spinlock_t io_request_lock;




extern int isp16_init(void);
extern int cdu31a_init(void);
extern int acsi_init(void);
extern int mcd_init(void);
extern int mcdx_init(void);
extern int sbpcd_init(void);
extern int aztcd_init(void);
extern int sony535_init(void);
extern int gscd_init(void);
extern int cm206_init(void);
extern int optcd_init(void);
extern int sjcd_init(void);
extern int cdi_init(void);
extern int hd_init(void);
extern int ide_init(void);
extern int xd_init(void);
extern int mfm_init(void);
extern int loop_init(void);
extern int md_init(void);
extern int ap_init(void);
extern int ddv_init(void);
extern int z2_init(void);
extern int swim3_init(void);
extern int swimiop_init(void);
extern int amiga_floppy_init(void);
extern int atari_floppy_init(void);
extern int ez_init(void);
extern int bpcd_init(void);
extern int ps2esdi_init(void);
extern int jsfd_init(void);
extern int viodasd_init(void);
extern int viocd_init(void);







extern void set_device_ro(kdev_t dev,int flag);
void add_blkdev_randomness(int major);

extern int floppy_init(void);
extern int rd_doload;
extern int rd_prompt;
extern int rd_image_start;
# 87 "/work/work/loongson/sict_cpci/linux-2.4-new/include/linux/blk.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void blkdev_dequeue_request(struct request * req)
{
        list_del(&req->queue);
}

int end_that_request_first(struct request *req, int uptodate, char *name);
void end_that_request_last(struct request *req);
# 29 "arch/mips/mm/init.c" 2

# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bootinfo.h" 1
# 219 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bootinfo.h"
const char *get_system_type(void);

extern unsigned long mips_machtype;
extern unsigned long mips_machgroup;
# 233 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/bootinfo.h"
struct boot_mem_map {
        int nr_map;
        struct {
                phys_t addr;
                phys_t size;
                long type;
        } map[32];
};

extern struct boot_mem_map boot_mem_map;

extern void add_memory_region(phys_t start, phys_t size, long type);
# 31 "arch/mips/mm/init.c" 2



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/jazzdma.h" 1
# 10 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/jazzdma.h"
extern void vdma_init(void);
extern unsigned long vdma_alloc(unsigned long paddr, unsigned long size);
extern int vdma_free(unsigned long laddr);
extern int vdma_remap(unsigned long laddr, unsigned long paddr,
                      unsigned long size);
extern unsigned long vdma_phys2log(unsigned long paddr);
extern unsigned long vdma_log2phys(unsigned long laddr);
extern void vdma_stats(void);

extern void vdma_enable(int channel);
extern void vdma_disable(int channel);
extern void vdma_set_mode(int channel, int mode);
extern void vdma_set_addr(int channel, long addr);
extern void vdma_set_count(int channel, int count);
extern int vdma_get_residue(int channel);
extern int vdma_get_enable(int channel);
# 51 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/jazzdma.h"
typedef volatile struct VDMA_PGTBL_ENTRY {
        unsigned int frame;
        unsigned int owner;
} VDMA_PGTBL_ENTRY;
# 35 "arch/mips/mm/init.c" 2



# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mmu_context.h" 1
# 15 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mmu_context.h"
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
# 16 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mmu_context.h" 2
# 33 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mmu_context.h"
extern unsigned long pgd_current[];
# 56 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mmu_context.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
{
}
# 67 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/mmu_context.h"
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void
get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
{
        unsigned long asid = (cpu_data[cpu].asid_cache);

        if (! ((asid += 0x1) & 0xff) ) {
                do { } while(0);
                local_flush_tlb_all();
                if (!asid)
                        asid = ((unsigned long)(~((unsigned long)~(0xff|(0xff -1)))) + 1);
        }
        ((mm)->context[cpu]) = (cpu_data[cpu].asid_cache) = asid;
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int
init_new_context(struct task_struct *tsk, struct mm_struct *mm)
{
        int i;

        for (i = 0; i < 1; i++)
                ((mm)->context[i]) = 0;
        return 0;
}

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void switch_mm(struct mm_struct *prev, struct mm_struct *next,
                             struct task_struct *tsk, unsigned cpu)
{
        unsigned long flags;

        do { flags = rthal.getflags_and_cli(); } while(0);;

        if ((((next)->context[cpu]) ^ (cpu_data[cpu].asid_cache)) & ((unsigned long)~(0xff|(0xff -1))))
                get_new_mmu_context(next, cpu);

        do { if (sizeof(unsigned long) == 4) do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$10" "\n\t" : : "Jr" (((next)->context[cpu]))); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$10" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (((next)->context[cpu]))); } while (0); else do { if (0 == 0) __asm__ __volatile__( ".set\tmips3\n\t" "dmtc0\t%z0, " "$10" "\n\t" ".set\tmips0" : : "Jr" (((next)->context[cpu]))); else __asm__ __volatile__( ".set\tmips64\n\t" "dmtc0\t%z0, " "$10" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (((next)->context[cpu]))); } while (0); } while (0);
        pgd_current[0] = (unsigned long)(next->pgd);





        clear_bit(cpu, &prev->cpu_vm_mask);
        set_bit(cpu, &next->cpu_vm_mask);
        do { rthal.setflags(flags); } while(0);;
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void destroy_context(struct mm_struct *mm)
{
}





static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void
activate_mm(struct mm_struct *prev, struct mm_struct *next)
{
        unsigned long flags;
        int cpu = 0;

   do { flags = rthal.getflags_and_cli(); } while(0);;


        get_new_mmu_context(next, cpu);

        do { if (sizeof(unsigned long) == 4) do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$10" "\n\t" : : "Jr" (((next)->context[cpu]))); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$10" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (((next)->context[cpu]))); } while (0); else do { if (0 == 0) __asm__ __volatile__( ".set\tmips3\n\t" "dmtc0\t%z0, " "$10" "\n\t" ".set\tmips0" : : "Jr" (((next)->context[cpu]))); else __asm__ __volatile__( ".set\tmips64\n\t" "dmtc0\t%z0, " "$10" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (((next)->context[cpu]))); } while (0); } while (0);
        pgd_current[0] = (unsigned long)(next->pgd);


        clear_bit(cpu, &prev->cpu_vm_mask);
        set_bit(cpu, &next->cpu_vm_mask);

   do { rthal.setflags(flags); } while(0);;
}







static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void ___drop_mmu_context(struct mm_struct *mm, unsigned cpu)
{
   if (test_bit(cpu, &mm->cpu_vm_mask))
     {
        get_new_mmu_context(mm, cpu);
        do { if (sizeof(unsigned long) == 4) do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$10" "\n\t" : : "Jr" (((((mm))->context[(cpu)]) & 0xff))); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$10" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (((((mm))->context[(cpu)]) & 0xff))); } while (0); else do { if (0 == 0) __asm__ __volatile__( ".set\tmips3\n\t" "dmtc0\t%z0, " "$10" "\n\t" ".set\tmips0" : : "Jr" (((((mm))->context[(cpu)]) & 0xff))); else __asm__ __volatile__( ".set\tmips64\n\t" "dmtc0\t%z0, " "$10" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (((((mm))->context[(cpu)]) & 0xff))); } while (0); } while (0);
     }
   else
     {
        ((mm)->context[cpu]) = 0;
     }

}


static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) void
drop_mmu_context(struct mm_struct *mm, unsigned cpu)
{
        unsigned long flags;




   do { __hard_save_flags_and_cli(&(flags)); } while(0);


        if (test_bit(cpu, &mm->cpu_vm_mask)) {
                get_new_mmu_context(mm, cpu);
                do { if (sizeof(unsigned long) == 4) do { if (0 == 0) __asm__ __volatile__( "mtc0\t%z0, " "$10" "\n\t" : : "Jr" (((((mm))->context[(cpu)]) & 0xff))); else __asm__ __volatile__( ".set\tmips32\n\t" "mtc0\t%z0, " "$10" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (((((mm))->context[(cpu)]) & 0xff))); } while (0); else do { if (0 == 0) __asm__ __volatile__( ".set\tmips3\n\t" "dmtc0\t%z0, " "$10" "\n\t" ".set\tmips0" : : "Jr" (((((mm))->context[(cpu)]) & 0xff))); else __asm__ __volatile__( ".set\tmips64\n\t" "dmtc0\t%z0, " "$10" ", " "0" "\n\t" ".set\tmips0" : : "Jr" (((((mm))->context[(cpu)]) & 0xff))); } while (0); } while (0);
        } else {

                ((mm)->context[cpu]) = 0;
        }




   do { unsigned long __tmp1; __asm__ __volatile__( "__hard_restore_flags\t%0" : "=r" (__tmp1) : "0" (flags) : "memory"); } while(0);

}
# 39 "arch/mips/mm/init.c" 2
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/tlb.h" 1
# 1 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm-generic/tlb.h" 1
# 100 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm-generic/tlb.h"
typedef struct mm_struct mmu_gather_t;
# 2 "/work/work/loongson/sict_cpci/linux-2.4-new/include/asm/tlb.h" 2
# 40 "arch/mips/mm/init.c" 2

mmu_gather_t mmu_gathers[1];
unsigned long highstart_pfn, highend_pfn;
static unsigned long totalram_pages;
static unsigned long totalhigh_pages;

void pgd_init(unsigned long page)
{
        unsigned long *p = (unsigned long *) page;
        int i;

        for (i = 0; i < (0x80000000UL/(1UL << (2 * 14 - ffz(~sizeof(pte_t))))); i+=8) {
                p[i + 0] = (unsigned long) invalid_pte_table;
                p[i + 1] = (unsigned long) invalid_pte_table;
                p[i + 2] = (unsigned long) invalid_pte_table;
                p[i + 3] = (unsigned long) invalid_pte_table;
                p[i + 4] = (unsigned long) invalid_pte_table;
                p[i + 5] = (unsigned long) invalid_pte_table;
                p[i + 6] = (unsigned long) invalid_pte_table;
                p[i + 7] = (unsigned long) invalid_pte_table;
        }
}
# 70 "arch/mips/mm/init.c"
unsigned long empty_zero_page, zero_page_mask;

static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) unsigned long setup_zero_pages(void)
{
        unsigned long order, size;
        struct page *page;

        if ((cpu_data[0].options & 0x00000400))
                order = 3;
        else
                order = 0;

        empty_zero_page = __get_free_pages((0x20 | 0x10 | 0x40 | 0x80 | 0x100), order);
        if (!empty_zero_page)
                panic("Oh boy, that early out of memory?");

        page = (mem_map + (((unsigned long) (empty_zero_page) - 0x80000000UL) >> 14));
        while (page < (mem_map + (((unsigned long) (empty_zero_page + ((1L << 14) << order)) - 0x80000000UL) >> 14))) {
                set_bit(14, &page->flags);
                ((&(page)->count)->counter = (0));
                page++;
        }

        size = (1L << 14) << order;
        zero_page_mask = (size - 1) & (~((1L << 14)-1));
        memset((void *)empty_zero_page, 0, size);

        return 1UL << order;
}

int do_check_pgt_cache(int low, int high)
{
        int freed = 0;

        if ((cpu_data[0].pgtable_cache_sz) > high) {
                do {
                        if ((cpu_data[0].pgd_quick))
                                free_pgd_slow(get_pgd_fast()), freed++;
                        if (((unsigned long *)0))
                                free_pmd_slow(get_pmd_fast()), freed++;
                        if ((cpu_data[0].pte_quick))
                                free_pte_slow(get_pte_fast()), freed++;
                } while ((cpu_data[0].pgtable_cache_sz) > low);
        }
        return freed;
}
# 137 "arch/mips/mm/init.c"
void show_mem(void)
{
        int i, free = 0, total = 0, reserved = 0;
        int shared = 0, cached = 0;

        printk("Mem-info:\n");
        show_free_areas();
        printk("Free swap:       %6dkB\n", nr_swap_pages<<(14 -10));
        i = max_mapnr;
        while (i-- > 0) {
                total++;
                if (test_bit(14, &(mem_map+i)->flags))
                        reserved++;
                else if (((mem_map+i)->mapping == &swapper_space))
                        cached++;
                else if (!((&(mem_map + i)->count)->counter))
                        free++;
                else
                        shared += ((&(mem_map + i)->count)->counter) - 1;
        }
        printk("%d pages of RAM\n", total);
        printk("%d reserved pages\n", reserved);
        printk("%d pages shared\n", shared);
        printk("%d pages swap cached\n",cached);
        printk("%ld pages in page table cache\n",(cpu_data[0].pgtable_cache_sz));
        printk("%d free pages\n", free);
        show_buffers();
}



extern char _ftext, _etext, _fdata, _edata;
extern char __init_begin, __init_end;
# 202 "arch/mips/mm/init.c"
void __attribute__ ((__section__ (".text.init"))) pagetable_init(void)
{
# 212 "arch/mips/mm/init.c"
        pgd_init((unsigned long)swapper_pg_dir);
        pgd_init((unsigned long)swapper_pg_dir +
                 sizeof(pgd_t ) * (0x80000000UL/(1UL << (2 * 14 - ffz(~sizeof(pte_t))))));
# 236 "arch/mips/mm/init.c"
}

void __attribute__ ((__section__ (".text.init"))) paging_init(void)
{
        unsigned long zones_size[3] = {0, 0, 0};
        unsigned long max_dma, high, low;

        pagetable_init();





        max_dma = virt_to_phys((char *)(0x80000000UL + 0x01000000)) >> 14;
        low = max_low_pfn;
        high = highend_pfn;
# 264 "arch/mips/mm/init.c"
        zones_size[0] = low;
# 276 "arch/mips/mm/init.c"
        free_area_init(zones_size);
}




static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) int page_is_ram(unsigned long pagenr)
{
        int i;

        for (i = 0; i < boot_mem_map.nr_map; i++) {
                unsigned long addr, end;

                if (boot_mem_map.map[i].type != 1)

                        continue;

                addr = (((boot_mem_map.map[i].addr) + (1L << 14) - 1) >> 14);
                end = ((boot_mem_map.map[i].addr + boot_mem_map.map[i].size) >> 14);


                if (pagenr >= addr && pagenr < end)
                        return 1;
        }

        return 0;
}

void __attribute__ ((__section__ (".text.init"))) mem_init(void)
{
        unsigned long codesize, reservedpages, datasize, initsize;
        unsigned long tmp, ram;
# 319 "arch/mips/mm/init.c"
        max_mapnr = num_mappedpages = num_physpages = max_low_pfn;

        high_memory = (void *) ((void *)((unsigned long) (max_low_pfn * (1L << 14)) + 0x80000000UL));

        totalram_pages += free_all_bootmem();
        totalram_pages -= setup_zero_pages();

        reservedpages = ram = 0;
        for (tmp = 0; tmp < max_low_pfn; tmp++)
                if (page_is_ram(tmp)) {
                        ram++;
                        if (test_bit(14, &(mem_map+tmp)->flags))
                                reservedpages++;
                }
# 351 "arch/mips/mm/init.c"
        codesize = (unsigned long) &_etext - (unsigned long) &_ftext;
        datasize = (unsigned long) &_edata - (unsigned long) &_fdata;
        initsize = (unsigned long) &__init_end - (unsigned long) &__init_begin;

        printk("<6>" "Memory: %luk/%luk available (%ldk kernel code, "
               "%ldk reserved, %ldk data, %ldk init, %ldk highmem)\n",
               (unsigned long) nr_free_pages() << (14 -10),
               ram << (14 -10),
               codesize >> 10,
               reservedpages << (14 -10),
               datasize >> 10,
               initsize >> 10,
               (unsigned long) (totalhigh_pages << (14 -10)));
}
# 382 "arch/mips/mm/init.c"
extern char __init_begin, __init_end;
extern void prom_free_prom_memory(void) __attribute__ ((__section__ (".text.init")));

void free_initmem(void)
{
        unsigned long addr;

        prom_free_prom_memory ();

        addr = (unsigned long) &__init_begin;
        while (addr < (unsigned long) &__init_end) {
                clear_bit(14, &((mem_map + (((unsigned long) (addr) - 0x80000000UL) >> 14)))->flags);
                ((&((mem_map + (((unsigned long) (addr) - 0x80000000UL) >> 14)))->count)->counter = (1));
                free_pages((addr),0);
                totalram_pages++;
                addr += (1L << 14);
        }
        printk("<6>" "Freeing unused kernel memory: %dk freed\n",
               (&__init_end - &__init_begin) >> 10);
}

void si_meminfo(struct sysinfo *val)
{
        val->totalram = totalram_pages;
        val->sharedram = 0;
        val->freeram = nr_free_pages();
        val->bufferram = ((&buffermem_pages)->counter);
        val->totalhigh = totalhigh_pages;
        val->freehigh = nr_free_highpages();
        val->mem_unit = (1L << 14);

        return;
}
