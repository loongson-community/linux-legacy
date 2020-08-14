#ifdef DEBUG26_TEST_BONITO
#include <asm/io.h>
static float x=1.12;
static float y=1.34;
static float z;
double sin(double x);
static int test(int argc,char **argv)
{
int i;
static unsigned char *p=0;
char str[100];
unsigned char c;
{
	int x;
asm("cfc1 $2,$31;" \
"sw $2,(%0);" \
::"r"(&x)
:"$2","$3"
    );
nr_printf("fcr=0x%x\n",x);
}
z=sin(x);
nr_printf("sin(1.12)=%d\n",(int)(z*1000));
z=sin(x)*y;
nr_printf("sin(1.12)*1.34=%d\n",(int)(z*1000));
z=x*y;
nr_printf("1.12*1.34=%d\n",(int)(z*1000));
return 0;
}

mycmd_init(test,test,"test ...","test something");
#endif

