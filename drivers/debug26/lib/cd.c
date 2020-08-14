
static inline _syscall1(long,chdir,char *,filename)
static int mychdir(int argc,char **argv)
{
	if(argc!=2){return -1;}
	chfs(1);
	chdir(argv[1]);
	chfs(0);
	return 0;
}

mycmd_init(cd,mychdir,"cd dir","cd dir");
