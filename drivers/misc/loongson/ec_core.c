/******************************************************************
 * 	EC chip common operations:  
 *	ec_read(), ec_write(), ec_query_seq(), sci_get_event_num()	
 *	Copy from the ec_misc.c and ec_sci.c
 ******************************************************************/

#include <linux/module.h>
#include <linux/delay.h>

#include "ec.h"
#include "ec_rom.h"
/*******************************************************************/

/* this spinlock is dedicated for ec_read & ec_write function */
DEFINE_SPINLOCK(index_access_lock);
/* this spinlock is dedicated for 62&66 ports access */
DEFINE_SPINLOCK(port_access_lock);

/*******************************************************************/

/* read a byte from EC registers throught index-io */
unsigned char ec_read(unsigned short addr)
{
	unsigned char value;
	unsigned long flags;

	spin_lock_irqsave(&index_access_lock, flags);
	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
	outb((addr & 0x00ff), EC_IO_PORT_LOW);
	value = inb(EC_IO_PORT_DATA);
	spin_unlock_irqrestore(&index_access_lock, flags);

	return value;
}
EXPORT_SYMBOL_GPL(ec_read);

/* write a byte to EC registers throught index-io */
void ec_write(unsigned short addr, unsigned char val)
{
	unsigned long flags;

	spin_lock_irqsave(&index_access_lock, flags);
	outb( (addr & 0xff00) >> 8, EC_IO_PORT_HIGH );
	outb( (addr & 0x00ff), EC_IO_PORT_LOW );
	outb( val, EC_IO_PORT_DATA );
	inb( EC_IO_PORT_DATA );	// flush the write action
	spin_unlock_irqrestore(&index_access_lock, flags);

	return;
}
EXPORT_SYMBOL_GPL(ec_write);

/*
 * ec_query_seq
 * this function is used for ec command writing and the corresponding status query 
 */
int ec_query_seq(unsigned char cmd)
{
	int timeout;
	unsigned char status;
	unsigned long flags;
	int ret = 0;

	spin_lock_irqsave(&port_access_lock, flags);

	/* make chip goto reset mode */
	udelay(EC_REG_DELAY);
	outb(cmd, EC_CMD_PORT);
	udelay(EC_REG_DELAY);

	/* check if the command is received by ec */
	timeout = EC_CMD_TIMEOUT;
	status = inb(EC_STS_PORT);
	while(timeout--){
		if(status & (1 << 1)){
			status = inb(EC_STS_PORT);
			udelay(EC_REG_DELAY);
			continue;
		}
		break;
	}
	
	if(timeout <= 0){
		printk(KERN_ERR "EC QUERY SEQ : deadable error : timeout...\n");
		ret = -EINVAL;
	}else{
		PRINTK_DBG(KERN_INFO "(%x/%d)ec issued command %x status : 0x%x\n", timeout, EC_CMD_TIMEOUT - timeout, cmd, status);
	}

	spin_unlock_irqrestore(&port_access_lock, flags);

	return ret;
}

EXPORT_SYMBOL_GPL(ec_query_seq);


/*
 * sci_get_event_num :
 *	get sci event number from ec
 *	NOTE : this routine must follow the sci_query_event_num 
 *	function in the interrupt
 */
int sci_get_event_num(void)
{
	int timeout = 100;
	unsigned char value;
	unsigned char status;
	
	udelay(EC_REG_DELAY);
	status = inb(EC_STS_PORT);
	udelay(EC_REG_DELAY);
	while(timeout--){
		if(!(status & (1 << 0))){
			status = inb(EC_STS_PORT);
			udelay(EC_REG_DELAY);
			continue;
		}
		break;
	}
	if(timeout <= 0){
		PRINTK_DBG("fixup sci : get event number timeout.\n");
		return -EINVAL;
	}
	value = inb(EC_DAT_PORT);
	udelay(EC_REG_DELAY);

	return value;
}

EXPORT_SYMBOL(sci_get_event_num);
