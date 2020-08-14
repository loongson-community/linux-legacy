/*
 *	This file is from pmon ^)^
 *	used by spd, poweroff and reset
 */

#include <linux/i2c.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <asm/delay.h>
#include <i2c_oprate.h>

extern volatile char *mmio;

#define GPIO_DIR_HIGH 		(volatile unsigned int *)(mmio + 0x1000c)
#define GPIO_DATA_HIGH		(volatile unsigned int *)(mmio + 0x10004)

#define G_OUTPUT		1
#define G_INPUT			0
#define	DAT_PIN			47
#define	CLK_PIN			46

extern volatile char *mmio;

DEFINE_SPINLOCK(my_i2c_lock);
static void i2c_sleep(int ntime)
{
	udelay(ntime*16); // (25/4)KHz	(10us)
}

static void sda_dir(int ivalue)
{
	u32 tmp;

	tmp = *GPIO_DIR_HIGH;
	if(ivalue == 1)
		*GPIO_DIR_HIGH = tmp|(0x1<<15);
	else
		*GPIO_DIR_HIGH = tmp&(~(0x1<<15));
}

static void scl_dir(int ivalue)
{
	u32 tmp;

	tmp = *GPIO_DIR_HIGH;
	if(ivalue == 1)
		*GPIO_DIR_HIGH = tmp|(0x1<<14);
	else
		*GPIO_DIR_HIGH = tmp&(~(0x1<<14));
}

static void sda_bit(int ivalue)
{
	u32 tmp;

	tmp = *GPIO_DATA_HIGH;
	if(ivalue == 1)
		*GPIO_DATA_HIGH = tmp|(0x1<<15);
	else
		*GPIO_DATA_HIGH = tmp&(~(0x1<<15));
}

static void scl_bit(int ivalue)
{
	u32 tmp;

	tmp = *GPIO_DATA_HIGH;
	if(ivalue == 1)
		*GPIO_DATA_HIGH = tmp|(0x1<<14);
	else
		*GPIO_DATA_HIGH = tmp&(~(0x1<<14));
}

static void i2c_start(void)
{
	sda_dir(G_OUTPUT);
	scl_dir(G_OUTPUT);
	scl_bit(0);
	i2c_sleep(1);
	sda_bit(1);
	i2c_sleep(1);
	scl_bit(1);
	i2c_sleep(5);
	sda_bit(0);
	i2c_sleep(5);
	scl_bit(0);
	i2c_sleep(2);
	
}
static void i2c_stop(void)
{
	sda_dir(G_OUTPUT);
	scl_dir(G_OUTPUT);
	scl_bit(0);
	i2c_sleep(1);
	sda_bit(0);
	i2c_sleep(1);
	scl_bit(1);
	i2c_sleep(5);
	sda_bit(1);
	i2c_sleep(5);
	scl_bit(0);
	i2c_sleep(2);
}

static void i2c_send_ack(int ack)
{
	sda_dir(G_OUTPUT);
	sda_bit(ack);
	i2c_sleep(3);
	scl_bit(1);
	i2c_sleep(5);
	scl_bit(0);
	i2c_sleep(2);
}

static char i2c_rec_ack(void)
{
    char res = 1;
    int num=10;
	u32 tmp;

    sda_dir(G_INPUT);
    i2c_sleep(3);
    scl_bit(1);
    i2c_sleep(5);
	tmp = ((*GPIO_DATA_HIGH)&0x8000);

    /* wait for a ack signal from slave */
    while(tmp){
    	i2c_sleep(1);
        num--;
        if(!num){
        	res = 0;
            break;
        }
		tmp = ((*GPIO_DATA_HIGH)&0x8000);
   }
   scl_bit(0);
   i2c_sleep(3);

   return res;
}

static unsigned char i2c_rec(void)
{
	int i;
	u8 or_char, value = 0x00;
	u32 tmp;

	sda_dir(G_INPUT);
	for(i=7;i>=0;i--){
		i2c_sleep(5);
		scl_bit(1);
		i2c_sleep(3);
		tmp = ((*GPIO_DATA_HIGH)&0x8000);

		if(tmp)
			or_char=0x1;
		else
			or_char=0x0;
		or_char<<=i;
		value|=or_char;
		i2c_sleep(3);
		scl_bit(0);
	}
	return value;
}

static unsigned char i2c_send(unsigned char value)
{
	/* we assume that now scl is 0 */
	int i;
	u8 and_char;

	sda_dir(G_OUTPUT);
	for(i=7;i>=0;i--){
		and_char = value;
		and_char>>=i;
		and_char&=0x1;
		if(and_char)
			sda_bit(1);
		else
			sda_bit(0);
		i2c_sleep(1);
		scl_bit(1);
		i2c_sleep(2);
		scl_bit(0);
		i2c_sleep(4);
	}
	sda_bit(1);	

	return 1;
}

int i2c_write(u8 slave_addr,u8 index_addr, u8 value)
{
	int ret = 0, flag;

	spin_lock_irqsave(&my_i2c_lock, flag);

	sda_dir(G_OUTPUT);
	scl_dir(G_OUTPUT);
	sda_bit(1);
	scl_bit(1);
	i2c_sleep(1000);

    /* start signal */
    i2c_start();
    /* write slave_addr */
    i2c_send(slave_addr);
    if(!i2c_rec_ack()){
		ret = 1;
		goto out;
	}       
	/* write sub_addr */
	i2c_send(index_addr);
	if(!i2c_rec_ack()){
	    ret = 2;
	    goto out;
	}
	/* write data */	
	i2c_send(value);
	if(!i2c_rec_ack()){
		ret = 3;
		goto out;
	}
	/* stop */
	i2c_stop();

	spin_unlock_irqrestore(&my_i2c_lock, flag);

out :
    if(ret)
        printk("slave_addr : 0x%x, index_addr : 0x%x, value 0x%x, error = %d\n", 
						slave_addr, index_addr, value, ret);
	
	return 0;
}
EXPORT_SYMBOL(i2c_write);

u8 i2c_read(u8 slave_addr, u8 index_addr)
{
	int ret = 0, flag;
	u8 value = 0;

	spin_lock_irqsave(&my_i2c_lock, flag);
    /* start signal */
    i2c_start();
    /* write slave_addr */ 
    i2c_send(slave_addr);
    if(!i2c_rec_ack()){
		ret = 1;
		goto out;
	}
	/* write sub_addr */
	i2c_send(index_addr);
	if(!i2c_rec_ack()){
	    ret = 2;
	    goto out;
	}
	/* repeat start */
	i2c_start();
	/* write slave_addr+1 */
	i2c_send(slave_addr+0x1);
	if(!i2c_rec_ack()){
		ret = 3;
		goto out;
	}
	/* read data */
	value = i2c_rec();
	i2c_send_ack(1);//***add in***//
	i2c_stop();
	spin_unlock_irqrestore(&my_i2c_lock, flag);
	return value;
out :
    if(ret)
        printk("slave_addr : 0x%x, index_addr : 0x%x, value 0x%x, error = %d\n", 
						slave_addr, index_addr, value, ret);
	
	return 0;
}
EXPORT_SYMBOL(i2c_read);
