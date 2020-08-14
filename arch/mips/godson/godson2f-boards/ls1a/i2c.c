#include "i2c.h"
#include <linux/init.h>
#include <linux/mm.h>
#define I2C_START 0x80
#define I2C_STOP 0x40
#define I2C_READ 0x20
#define I2C_WRITE 0x10
#define I2C_WACK 0x8
#define I2C_IACK 0x1
#define I2C_RUN 0x2
#define I2C_BUSY 0x40
#define I2C_RACK 0x80
#define GS_SOC_I2C_BASE  (int)0xb2e58000
#define LS1A_STEP 4
#define GS_SOC_I2C_PRER_LO (volatile unsigned char *)(GS_SOC_I2C_BASE + 0x0 *LS1A_STEP   )
#define GS_SOC_I2C_PRER_HI (volatile unsigned char *)(GS_SOC_I2C_BASE + 0x1 *LS1A_STEP   )
#define GS_SOC_I2C_CTR     (volatile unsigned char *)(GS_SOC_I2C_BASE + 0x2 *LS1A_STEP   )
#define GS_SOC_I2C_TXR     (volatile unsigned char *)(GS_SOC_I2C_BASE + 0x3 *LS1A_STEP   )
#define GS_SOC_I2C_RXR     (volatile unsigned char *)(GS_SOC_I2C_BASE + 0x3 *LS1A_STEP   )
#define GS_SOC_I2C_CR      (volatile unsigned char *)(GS_SOC_I2C_BASE + 0x4 *LS1A_STEP   )
#define GS_SOC_I2C_SR      (volatile unsigned char *)(GS_SOC_I2C_BASE + 0x4 *LS1A_STEP   )


#define SR_NOACK 0x80
#define CR_START 0x80
#define CR_WRITE 0x10
#define CR_READ  0x20
#define SR_BUSY  0x40 
#define SR_TIP   0x2
#define CR_STOP  0x40
#define LS232_I2C_BASE  (int)0xbf0040d0
#define LS232_I2C_PRER_LO ((volatile unsigned char *)(LS232_I2C_BASE + 0x0))
#define LS232_I2C_PRER_HI ((volatile unsigned char *)(LS232_I2C_BASE + 0x1))
#define LS232_I2C_CTR     ((volatile unsigned char *)(LS232_I2C_BASE + 0x2))
#define LS232_I2C_TXR     ((volatile unsigned char *)(LS232_I2C_BASE + 0x3))
#define LS232_I2C_RXR     ((volatile unsigned char *)(LS232_I2C_BASE + 0x3))
#define LS232_I2C_CR      ((volatile unsigned char *)(LS232_I2C_BASE + 0x4))
#define LS232_I2C_SR      ((volatile unsigned char *)(LS232_I2C_BASE + 0x4))

void i2c_stop()
{
  * GS_SOC_I2C_CR  = CR_STOP;
  * GS_SOC_I2C_SR;
  while(*GS_SOC_I2C_SR & SR_BUSY);
}




unsigned char i2c_rec_s(unsigned char *addr,int addrlen,unsigned char* buf ,int count)
{
int i;
int j;
	unsigned char value;
	for(i=0;i<count;i++)
	{
again:
		for(j=0;j<addrlen;j++)
		{
		/*write slave_addr*/
  * GS_SOC_I2C_TXR = addr[j];
  * GS_SOC_I2C_CR  = (j == 0)? (CR_START|CR_WRITE):CR_WRITE; /* start on first addr */
   while(*GS_SOC_I2C_SR & SR_TIP);

  if((* GS_SOC_I2C_SR) & SR_NOACK) { printk("read no ack %d\n",__LINE__); i2c_stop();goto again;}
		}

		/*write slave_addr*/
  * GS_SOC_I2C_TXR = addr[0]|1;
  * GS_SOC_I2C_CR  = CR_START|CR_WRITE; /* start on first addr */
   while(*GS_SOC_I2C_SR & SR_TIP);

  if((* GS_SOC_I2C_SR) & SR_NOACK) { printk("read no ack %d\n",__LINE__); i2c_stop();goto again;}

  * GS_SOC_I2C_CR  = CR_READ|I2C_WACK; /*last read not send ack*/
  while(*GS_SOC_I2C_SR & SR_TIP);

    buf[i] = * GS_SOC_I2C_TXR;
  * GS_SOC_I2C_CR  = CR_STOP;
  * GS_SOC_I2C_SR;
  while(*GS_SOC_I2C_SR & SR_BUSY);
 
	}

	return count;
}

unsigned char i2c_send_s(unsigned char *addr,int addrlen,unsigned char * buf ,int count)
{
int i;
int j;
	for(i=0;i<count;i++)
	{
again:
		for(j=0;j<addrlen;j++)
		{
		/*write slave_addr*/
  * GS_SOC_I2C_TXR = addr[j];
  * GS_SOC_I2C_CR  = j == 0? (CR_START|CR_WRITE):CR_WRITE; /* start on first addr */
   while(*GS_SOC_I2C_SR & SR_TIP);

  if((* GS_SOC_I2C_SR) & SR_NOACK) { printk("write no ack %d\n",__LINE__); i2c_stop();goto again;}
		}


  * GS_SOC_I2C_TXR = buf[i];
  * GS_SOC_I2C_CR = CR_WRITE|CR_STOP;
  while(*GS_SOC_I2C_SR & SR_TIP);

  if((* GS_SOC_I2C_SR) & SR_NOACK) { printk("write no ack %d\n",__LINE__); i2c_stop();goto again;}
	}
  while(*GS_SOC_I2C_SR & SR_BUSY);
	return count;
}


unsigned char i2c_rec_b(unsigned char *addr,int addrlen,unsigned char* buf ,int count)
{
    int i;
    int j;


    unsigned char value;

    for(j=0;j<addrlen-1;j++)
    {
        /*write slave_addr*/
        * GS_SOC_I2C_TXR = addr[j];
        * GS_SOC_I2C_CR  = j == 0? (CR_START|CR_WRITE):CR_WRITE; /* start on first addr */
        while(*GS_SOC_I2C_SR & SR_TIP);

        if((* GS_SOC_I2C_SR) & SR_NOACK) return i;
    }


    * GS_SOC_I2C_TXR = addr[0]|1;

    * GS_SOC_I2C_CR  = CR_START|CR_WRITE;
    while(*GS_SOC_I2C_SR & SR_TIP);
    if((* GS_SOC_I2C_SR) & SR_NOACK) return i;

    for(i=0;i<count;i++)
    {

        if(i==count-1){
            * GS_SOC_I2C_CR  = CR_READ|0x8; //yang23
        }else{
            * GS_SOC_I2C_CR  = CR_READ;
        }
#if 0
        * GS_SOC_I2C_CR  = CR_READ;
#endif
        while(*GS_SOC_I2C_SR & SR_TIP);

        buf[i] = * GS_SOC_I2C_TXR;
    }
    * GS_SOC_I2C_CR  = CR_STOP;
    while(*GS_SOC_I2C_SR & SR_BUSY );//yang23
    * GS_SOC_I2C_CR  = CR_STOP;

    return count;
}
unsigned char i2c_send_b(unsigned char *addr,int addrlen,unsigned char * buf ,int count)
{
int i;
int j;
		for(j=0;j<addrlen;j++)
		{
		/*write slave_addr*/
  * GS_SOC_I2C_TXR = addr[j];
  * GS_SOC_I2C_CR  = j == 0? (CR_START|CR_WRITE):CR_WRITE; /* start on first addr */
   while(*GS_SOC_I2C_SR & SR_TIP);

  if((* GS_SOC_I2C_SR) & SR_NOACK) return i;
		}


	for(i=0;i<count;i++)
	{	
  * GS_SOC_I2C_TXR = buf[i];
  * GS_SOC_I2C_CR = CR_WRITE;
  while(*GS_SOC_I2C_SR & SR_TIP);

  if((* GS_SOC_I2C_SR) & SR_NOACK) return i;

	}
  * GS_SOC_I2C_CR  = CR_STOP;
  while(*GS_SOC_I2C_SR & SR_BUSY);
	return count;
}

/*
 * 0 single: 每次读一个
 * 1 smb block
 */
int tgt_i2cread(int type,unsigned char *addr,int addrlen,unsigned char *buf,int count)
{
int i;
tgt_i2cinit();
memset(buf,-1,count);
switch(type)
{
case I2C_SINGLE:
return i2c_rec_s(addr,addrlen,buf,count);
break;
case I2C_BLOCK:
return i2c_rec_b(addr,addrlen,buf,count);
break;

default: return 0;break;
}
return 0;
}

int tgt_i2cwrite(int type,unsigned char *addr,int addrlen,unsigned char *buf,int count)
{
tgt_i2cinit();
switch(type&0xff)
{
case I2C_SINGLE:
i2c_send_s(addr,addrlen,buf,count);
break;
case I2C_BLOCK:
return i2c_send_b(addr,addrlen,buf,count);
break;
case I2C_SMB_BLOCK:
break;
default:return -1;break;
}
return -1;
}


int tgt_i2cinit()
{
static int inited=0;
if(inited)return 0;
inited=1;
 * GS_SOC_I2C_PRER_LO = 0x64;
 * GS_SOC_I2C_PRER_HI = 0;
 * GS_SOC_I2C_CTR = 0x80;
}

