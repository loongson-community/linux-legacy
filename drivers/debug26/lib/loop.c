static int loop(int argc,char **argv)
{
	int count;
	int len;
	static char buf[1024];
	if(argc!=3)return -1;
	count=nr_strtol(argv[1],0,0);
	len=strlen(argv[2]);
	if(len>1024)len=1024;
	while(count--)
	{   strncpy(buf,argv[2],len);
		do_cmd(buf);
	}
return 0;	
}

mycmd_init(loop,loop,"count cmds","run cmds for count times");
