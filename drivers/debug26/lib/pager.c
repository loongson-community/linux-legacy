#ifdef DEBUG26_PAGER
static inline _syscall1(int,pipe,unsigned long *, fildes)

static long pg_fd[2]={0,0};
static long pg_con[2]={0,0};
int printthread(void *unused)
{
	char buf[100];
	close(pg_fd[0]);
	while(1)
	{
		read(pg_fd[1],buf,100);
		write(pg_con[0],buf,100);
	}
return 0;	
}

int pager(int argc,char **argv)
{
	chfs(1);
	pipe(pg_fd);
	chfs(0);
	pg_con[0]=dup(1);
	pg_con[1]=dup(2);
	close(1);
	close(2);
	dup(pg_fd[0]);
	dup(pg_fd[0]);
	
kernel_thread(printthread,0,0);
close(pg_fd[1]);
	return 0;
}

mycmd_init(pager,pager,"pager [1|0]","pager");
#endif
