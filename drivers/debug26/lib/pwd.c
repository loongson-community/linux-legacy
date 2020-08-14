
static inline _syscall2(long,getcwd,char *,buf,unsigned long,size)
static int pwd(int argc,char **argv)
{
	char buf[200];
	chfs(1);
    getcwd(buf,200);
	chfs(0);
	nr_printf("%s\n",buf);
	return 0;
}

mycmd_init(pwd,pwd,"pwd","pwd");
