static unsigned char CMOS_READ_TO_RTC_READ(unsigned char addr)
{
    unsigned char val;
	unsigned char value;
	char i2caddr[]={(unsigned char)0x64, 0};
	if(addr >= 0x0a)
		return 0;
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
		
	}
	
	i2caddr[1] = 0xe<<4;
	tgt_i2cread(I2C_SINGLE,i2caddr,2,&value,1);
	value = value|0x20;

	i2caddr[1] = 0xe<<4;
	tgt_i2cwrite(I2C_SINGLE,i2caddr,2,&value,1);

	i2caddr[1] = addr<<4;
	tgt_i2cread(I2C_SINGLE,i2caddr,2,&val,1);


        return val;
}

static void CMOS_WRITE_TO_RTC_WRITE(unsigned char val, unsigned char addr)
{

	unsigned char value;
	char i2caddr[]={(unsigned char)0x64, 0};

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
		
	}
	
	i2caddr[1] = 0xe<<4;
	tgt_i2cread(I2C_SINGLE,i2caddr,2,&value,1);
	value = value|0x20;
	i2caddr[1] = 0xe<<4;
	tgt_i2cwrite(I2C_SINGLE,i2caddr,2,&value,1);
	i2caddr[1] = addr<<4;
	tgt_i2cwrite(I2C_SINGLE,i2caddr,2,&val,1);

}

