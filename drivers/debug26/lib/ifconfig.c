#ifdef DEBUG26_IFCONFIG
#include <linux/inet.h>
#include <net/ip.h>
#include <net/sock.h>
#include <net/tcp.h>
#include <net/udp.h>

#ifdef __NR_socket
static inline _syscall3(long,socket,int, family, int, type, int, protocol);
#else
static inline _syscall2(long,socketcall,int, call, unsigned long *, args);
#endif
static int ifconfig(int argc,char **argv)
{
int sockfd;
struct ifreq ifr;
struct sockaddr_in *sin=(void *)&ifr.ifr_addr;
short port=0;
int ret;
        mm_segment_t    oldfs;
        oldfs=get_fs();
        set_fs(KERNEL_DS);
if(argc<3){nr_printf("usage:ifconfig eth0 202.38.78.252\n");ret=-1;goto error;}

strncpy(ifr.ifr_name,argv[1], IFNAMSIZ);
sin->sin_family=AF_INET; 
sin->sin_port=htons(port); 
sin->sin_addr.s_addr=in_aton(argv[2]);
#ifdef __NR_socket
        sockfd=socket(AF_INET,SOCK_DGRAM,0); 
#else
        sockfd=socketcall(SYS_SOCKET,&(long [3]){AF_INET,SOCK_DGRAM,0}); 
#endif
        if(sockfd<0) 
        { 
                nr_printf("Socket  Error %d\n",sockfd); 
                ret=-1;
                goto error;
        }  
        ret=ioctl(sockfd,SIOCSIFADDR ,(int)&ifr);
ifr.ifr_flags=IFF_UP;        
ret=ioctl(sockfd,SIOCSIFFLAGS,(int)&ifr);
   close(sockfd);
error:
set_fs(oldfs);
    return ret;    
}

mycmd_init(ifconfig,ifconfig,"eth0 10.0.0.12","ifconfig");
#endif

