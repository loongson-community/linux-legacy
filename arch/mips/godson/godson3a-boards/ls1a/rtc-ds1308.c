#include "i2c.h"
static unsigned char CMOS_READ_TO_RTC_READ(unsigned char addr)
{
	unsigned char value;
	char i2caddr[]={(unsigned char)0xd0, 0};

	switch(addr)
	{
		case 0:
			break;
		case 2:
			addr = 1;
			break;
		case 4:
			addr = 2;
			break;
		case 6:
			addr = 3;
			break;
		case 7:
			addr = 4;
			break;
		case 8:
			addr = 5;
			break;
		case 9:
			addr = 6;
			break;
		case 11:
			return RTC_DM_BINARY;
			break;
		default: 
			return 0;
		
	}
		
	i2caddr[1] = addr;
	tgt_i2cread(I2C_SINGLE,i2caddr,2,&value,1);
	value = BCD_TO_BIN(value);

        return value;
}

static void CMOS_WRITE_TO_RTC_WRITE(unsigned char val, unsigned char addr)
{

	char i2caddr[]={(unsigned char)0xd0, 0};

	if(addr >=0x0a)
		return ;
	switch(addr)
	{
		case 0:
			break;
		case 2:
			addr = 1;
			break;
		case 4:
			addr = 2;
			break;
		case 6:
			addr = 3;
			break;
		case 7:
			addr = 4;
			break;
		case 8:
			addr = 5;
			break;
		case 9:
			addr = 6;
			break;
		default:
			return;
			break;
	}


	val = BIN_TO_BCD(val);
	
	i2caddr[1] = addr;
	tgt_i2cwrite(I2C_SINGLE,i2caddr,2,&val,1);
}

