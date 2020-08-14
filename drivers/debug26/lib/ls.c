#ifdef DEBUG26_LS
#include <linux/stat.h>
#include <asm/stat.h>
#define __NR_newlstat 107



#define S_IFMT  00170000
#define S_IFSOCK 0140000
#define S_IFLNK  0120000
#define S_IFREG  0100000
#define S_IFBLK  0060000
#define S_IFDIR  0040000
#define S_IFCHR  0020000
#define S_IFIFO  0010000
#define S_ISUID  0004000
#define S_ISGID  0002000
#define S_ISVTX  0001000

#define S_ISLNK(m)  (((m) & S_IFMT) == S_IFLNK)
#define S_ISREG(m)  (((m) & S_IFMT) == S_IFREG)
#define S_ISDIR(m)  (((m) & S_IFMT) == S_IFDIR)
#define S_ISCHR(m)  (((m) & S_IFMT) == S_IFCHR)
#define S_ISBLK(m)  (((m) & S_IFMT) == S_IFBLK)
#define S_ISFIFO(m) (((m) & S_IFMT) == S_IFIFO)
#define S_ISSOCK(m) (((m) & S_IFMT) == S_IFSOCK)

struct old_linux_dirent {
    unsigned long   d_ino;
    unsigned long   d_offset;
    unsigned short  d_namlen;
    char        d_name[100];
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
        return -EINVAL;
    buf->count++;
    dirent = buf->dirent;
	dirent->d_ino=ino;
	dirent->d_offset=offset;
	dirent->d_namlen=namlen;

    memcpy(dirent->d_name, name, namlen);
    dirent->d_name[namlen]=0;
    return 0;
}


static inline _syscall2(long,newlstat,char *,filename,struct stat *,statbuf)
static inline _syscall1(long,time,int *, tloc)
static inline _syscall3(long,readlink,const char *, path, char *, buf, int, bufsiz)
#include "mode_string.c"
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

  if(IS_ERR(f)){ nr_printf("error open file\n");return -1;}
	
	nr_printf("%-40s\toffset\tino\ttype\n","name");
	while(1)
	{
    buf.count = 0;
    buf.dirent = &d;
    error = vfs_readdir(f, fillonedir, &buf);

	if(IS_ERR(f)){nr_printf("error:%d\n",error);goto done;}
	
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
	nr_printf("\n");
	}
done:	
	filp_close(f,current->files);
	return 0;
}

mycmd_init(ls,ls,"ls dir","ls dir");
#endif
