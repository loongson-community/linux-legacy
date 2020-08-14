#ifdef DEBUG26_EXEC
#define MAX_INIT_ARGS 8
#define MAX_INIT_ENVS 8
static char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };

static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
static inline pid_t wait(int * wait_stat)
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
old_fs=get_fs();
set_fs(KERNEL_DS);
execve(argv[0],argv,envp_init);
   while(1)
   {
	token = nr_strsep((char **)&path,":");
	if(!token||!*token)break;
	strcpy(newcmd,token);
	strcat(newcmd,oldcmd);
	argv[0]=newcmd;
	execve(argv[0],argv,envp_init);
   }
set_fs(old_fs);
nr_printf("Bad exe name\n");
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
	waitpid(id,NULL,__WCLONE);
	return 0;
}


static int exec(int argc,char **argv)
{
	int id;
	if(argc<2)return -1;
	argv[argc]=0;
	id=kernel_thread((void *)execcmd,&argv[1],0);
	waitpid(id,NULL,__WCLONE);
	return 0;
}

mycmd_init(exec,exec,"exec /sbin/ls -l /","execute a linux command");
mycmd_init(sh,sh,"sh pwd","execute a shell command");
#endif
