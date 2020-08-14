char debug26_array[0x100];
static int dset(int argc,char **argv)
{
int i;
if(argc==1)
{
 for(i=0;i<0x100;i++)
  {
   if(i%16==0)nr_printf("%02x:",i);
   nr_printf("%02x ",debug26_array[i]);
   if(i%16==15)nr_printf("\n");
  }
}
else if(argc==2)
{
 i=nr_strtol(argv[1],0,0);
 nr_printf("%02x:%02x\n",i,debug26_array[i]);
}
else if(argc==3)
{
 i=nr_strtol(argv[1],0,0);
 debug26_array[i]= nr_strtol(argv[2],0,0);
}
else return -1;
return 0;
}

mycmd_init(dset,dset,"dset [name] [value] ","set debug env var");
