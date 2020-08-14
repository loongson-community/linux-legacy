static int echo(int argc,char **argv)
{
	int i;
if(!strcmp(argv[0],"echo_on")){showcmd=1;return 0;}
else if(!strcmp(argv[0],"echo_off")){showcmd=0;return 0;}

	for(i=1;i<argc;i++)
	nr_printf("%s ",argv[i]);
	nr_printf("\n");
return 0;	
}

mycmd_init(echo,echo,"cmds","echo");
mycmd_init(echo_on,echo,"","echo on");
mycmd_init(echo_off,echo,"","echo off");
