#define I2C_SINGLE 0 
#define I2C_BLOCK 1
#define I2C_SMB_BLOCK 2
#define I2C_START_STOP 3

int tgt_i2cread(int type,unsigned char *addr,int addrlen,unsigned char *buf,int count);

int tgt_i2cwrite(int type,unsigned char *addr,int addrlen,unsigned char *buf,int count);

int tgt_i2cinit();
