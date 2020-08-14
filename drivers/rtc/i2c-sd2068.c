/*
 *This file is from pmon ^)^
 */

#include <linux/i2c.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <asm/delay.h>

#include <i2c_oprate.h> 

#define GPIO_DIR_LOW 		(volatile unsigned int *)(mmio + 0x10008)
#define GPIO_DATA_LOW		(volatile unsigned int *)(mmio + 0x10000)

#define G_OUTPUT		1
#define G_INPUT			0
#define	DAT_PIN			21
#define	CLK_PIN			20

#define REG_MAX		0x10
#define SLAVE_ADDR	0x64 /* i2c slave device addr */

#define SM_VENDOR   0x126f
#define SM_DEVICE   0x0501

extern volatile char *mmio;

DEFINE_SPINLOCK(my_rtc_lock);
static void i2c_sleep(int ntime)
{
	udelay(ntime); /* 100KHz	(10us) ??? */
//	udelay(10); /* 100KHz	(10us) ??? */
}

static void sda_dir(int ivalue)
{
	u32 tmp;
	tmp = *GPIO_DIR_LOW;
	if(ivalue == 1)
		*GPIO_DIR_LOW = tmp|(0x1<<DAT_PIN);
	else
		*GPIO_DIR_LOW = tmp&(~(0x1<<DAT_PIN));
}

static void scl_dir(int ivalue)
{
	u32 tmp;
	tmp = *GPIO_DIR_LOW;
	if(ivalue == 1)
		*GPIO_DIR_LOW = tmp|(0x1<<CLK_PIN);
	else
		*GPIO_DIR_LOW = tmp&(~(0x1<<CLK_PIN));
}

static void sda_bit(int ivalue)
{
	u32 tmp;

	tmp = *GPIO_DATA_LOW;
	if(ivalue == 1)
		*GPIO_DATA_LOW = tmp|(0x1<<DAT_PIN);
	else
		*GPIO_DATA_LOW = tmp&(~(0x1<<DAT_PIN));
}

static void scl_bit(int ivalue)
{
	u32 tmp;

	tmp = *GPIO_DATA_LOW;
	if(ivalue == 1)
		*GPIO_DATA_LOW = tmp|(0x1<<CLK_PIN);
	else
		*GPIO_DATA_LOW = tmp&(~(0x1<<CLK_PIN));
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
	tmp = ((*GPIO_DATA_LOW)&(1 << DAT_PIN) );

	/* wait for a ack signal from slave */
	while(tmp){
   		i2c_sleep(1);
   		num--;
   		if(!num){
		res = 0;
		break;
   		}
   		tmp = ((*GPIO_DATA_LOW)&(1 << DAT_PIN));
    }
	scl_bit(0);
	i2c_sleep(3);
	return res;
}

static unsigned char i2c_rec(void)
{
	int i;
	u32 tmp;
	u8 or_char, value = 0x00;

	sda_dir(G_INPUT);
	for(i=7;i>=0;i--){
		i2c_sleep(5);
		scl_bit(1);
		i2c_sleep(3);
		tmp = ((*GPIO_DATA_LOW)&(1 << DAT_PIN));
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
		i2c_sleep(5);
		scl_bit(0);
		i2c_sleep(1);
	}
	sda_bit(1);	

	return 1;
}

static int i2c_write_2(u8 slave_addr,u8 index_addr, u8 value)
{
	int ret = 0;

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

out :
    if(ret)
        printk("slave_addr : 0x%x, index_addr : 0x%x, value 0x%x, error = %d\n", 
					slave_addr, index_addr, value, ret);
	return 0;
}

static u8 i2c_read_2(u8 slave_addr, u8 index_addr)
{
	int ret = 0;
	u8 value = 0;

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
	i2c_send_ack(1);/***add in***/
	i2c_stop();

	return value;
out :
    if(ret)
        printk("slave_addr : 0x%x, index_addr : 0x%x, value 0x%x, error = %d\n", 
						slave_addr, index_addr, value, ret);
	
	return 0;
}

int i2c_rtc_write(void* value)
{
	int ret = 0; 
	unsigned long flag;
    struct pci_dev *dev;
	u8	slave_addr = SLAVE_ADDR, index_addr = 0, tmp_reg = 0;

    /* Get mmio_base_addr used by i2c */
    dev = pci_get_device(SM_VENDOR, SM_DEVICE, NULL);
    if(!dev){
        printk("Can't find sm502, error\n");
        return -ENODEV;
    }
    mmio = ioremap(pci_resource_start(dev, 1), pci_resource_len(dev, 1));

	spin_lock_irqsave(&my_rtc_lock, flag);

	/* write enable */
	tmp_reg = i2c_read_2(SLAVE_ADDR, REG_CRT2);
	tmp_reg |= 1<<WRTC1_BIT;
	i2c_write_2(SLAVE_ADDR, REG_CRT2, tmp_reg);
	tmp_reg = i2c_read_2(SLAVE_ADDR, REG_CRT1);
	tmp_reg |= (1<<WRTC2_BIT)|(1<<WRTC3_BIT);
	i2c_write_2(SLAVE_ADDR, REG_CRT1, tmp_reg);

	i2c_start();
    /* write slave_addr */
    i2c_send(slave_addr);
    if(!i2c_rec_ack()){
		ret = 1;
		goto out;
	}
	/* write sub_addr */
	i2c_send(0);
	if(!i2c_rec_ack()){
		ret = 2;
		goto out;
	}
	/* write data */
	for(index_addr = REG_SEC; index_addr <= (REG_SEC + REG_YEAR); index_addr++){
			i2c_send(*(u8*)(value + index_addr));
			if(!i2c_rec_ack()){
				ret = 3;
				goto out;
			}
	}
	/* stop */
	i2c_stop();
	
	/* disalbe write */
	tmp_reg = i2c_read_2(SLAVE_ADDR, REG_CRT1);
	tmp_reg &= ~((1<<WRTC2_BIT)|(1<<WRTC3_BIT));
	i2c_write_2(SLAVE_ADDR, REG_CRT1, tmp_reg);
	tmp_reg = i2c_read_2(SLAVE_ADDR, REG_CRT2);
	tmp_reg &= ~(1<<WRTC1_BIT);
	i2c_write_2(SLAVE_ADDR, REG_CRT2, tmp_reg);

	spin_unlock_irqrestore(&my_rtc_lock, flag);

out :
    if(ret)
        printk("slave_addr : 0x%x, index_addr : 0x%x, value 0x%x, error = %d\n", 
					slave_addr, index_addr, *(u8*)value, ret);
	return ret;
}
EXPORT_SYMBOL(i2c_rtc_write);

u8 i2c_rtc_read(void *value)
{
	int ret = 0; 
	unsigned long flag;
    struct pci_dev *dev;
	u8 slave_addr = SLAVE_ADDR, index_addr = 0;

    /* Get mmio_base_addr used by i2c */
    dev = pci_get_device(SM_VENDOR, SM_DEVICE, NULL);
    if(!dev){
        printk("Can't find sm502, error\n");
        return -ENODEV;
    }
    mmio = ioremap(pci_resource_start(dev, 1), pci_resource_len(dev, 1));

	spin_lock_irqsave(&my_rtc_lock, flag);
    /* start signal */
    i2c_start();
	/* write slave_addr+1 */
	i2c_send(slave_addr+0x1);
	if(!i2c_rec_ack()){
		ret = 3;
		goto out;
	}
	/* read data */
	for(index_addr = 0; index_addr <= 6; index_addr++){
			*(u8*)(value + index_addr) = i2c_rec();
			if(index_addr != 6)
				i2c_send_ack(0);/***add in***/
	}
	i2c_stop();

	spin_unlock_irqrestore(&my_rtc_lock, flag);
out :
    if(ret)
        printk("slave_addr : 0x%x, index_addr : 0x%x, value 0x%x, error = %d\n", 
						slave_addr, index_addr, *(u8*)value, ret);
	
	return ret;
}
EXPORT_SYMBOL(i2c_rtc_read);
