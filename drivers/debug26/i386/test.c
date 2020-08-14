#ifdef DEBUG26_I386_TEST
static int test(int argc,char **argv)
{
if(argc!=2){nr_printf("usage:test num\n");return 0;}
getdata(argv[1]);
nr_printf("%08x,%08x\n",mydata.data8[0],mydata.data8[1]);
return 0;
}

mycmd_init(test,test,"test num","test getdata");
#endif
