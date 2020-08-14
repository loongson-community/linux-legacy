#ifdef DEBUG26_CHROOT
static int mychroot(int argc,char **argv)
{
	if(argc!=2){return -1;}
	chroot(argv[1]);
	return 0;
}

mycmd_init(chroot,mychroot,"chroot dir","chroot dir");
#endif

