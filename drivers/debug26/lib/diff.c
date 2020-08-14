#ifdef DEBUG26_DIFF
static int difffile(int argc,char **argv)
{
int fd0,fd1;
static unsigned char buf0[1024];
static unsigned char buf1[1024];
unsigned int size,size1,i,pos;

mm_segment_t old_fs;
	if(argc!=3)
	{return -1;}

old_fs=get_fs();
set_fs(KERNEL_DS);
fd0=open(argv[1],O_RDONLY,0);
fd1=open(argv[2],O_RDONLY,0);
pos=0;
while(1)
{
	size=read(fd0,buf0,1024);
	if(size<=0)break;
	size1=read(fd1,buf1,size);
	if(size!=size){nr_printf("file different!\n");break;}
	for(i=0;i<size;i++)
	{
		if(buf0[i]!=buf1[i])nr_printf("%08x:%02x %02x -  %c %c\n",pos,buf0[i],buf1[i],buf0[i],buf1[i]);
	}
	pos+=size;
}
close(fd0);
close(fd1);
set_fs(old_fs);
return 0;
}

mycmd_init(diff,difffile,"diff file1 file2","diff two files");
#endif
