#ifdef DEBUG26_8172_PNP
#define LPC_BASE_ADDR   0x14000000

// MB PnP configuration register
#define LPC_KEY_ADDR    0x1400002E
#define LPC_DATA_ADDR   0x1400002F

// Device LDN
#define LDN_SERIAL1     0x01
#define LDN_SERIAL2     0x02
#define LDN_PARALLEL    0x03
#define LDN_KEYBOARD    0x05
#define LDN_MOUSE       0x06

#define IT8712_UART1_PORT      0x3F8
#define IT8712_UART2_PORT      0x2F8



void LPCSetConfig(char LdnNumber, char Index, char data);
char LPCGetConfig(char LdnNumber, char Index);

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#define outb(val,port)  *(volatile unsigned char *)(0xa0000000+port)=val
#define inb(port)   *(volatile unsigned char *)(0xa0000000+port) 

void LPCEnterMBPnP(void)
{
        int i;
        unsigned char key[4] = {0x87, 0x01, 0x55, 0x55};

        for (i = 0; i<4; i++)
                outb(key[i], LPC_KEY_ADDR);

}

void LPCExitMBPnP(void)
{
        outb(0x02, LPC_KEY_ADDR);
        outb(0x02, LPC_DATA_ADDR);
}

void LPCSetConfig(char LdnNumber, char Index, char data)
{
        LPCEnterMBPnP();                                // Enter IT8712 MB PnP mode
        outb(0x07, LPC_KEY_ADDR);
        outb(LdnNumber, LPC_DATA_ADDR);
        outb(Index, LPC_KEY_ADDR);
        outb(data, LPC_DATA_ADDR);
        LPCExitMBPnP();
}

char LPCGetConfig(char LdnNumber, char Index)
{
        char rtn;

        LPCEnterMBPnP();                                // Enter IT8712 MB PnP mode
        outb(0x07, LPC_KEY_ADDR);
        outb(LdnNumber, LPC_DATA_ADDR);
        outb(Index, LPC_KEY_ADDR);
        rtn = inb(LPC_DATA_ADDR);
        LPCExitMBPnP();
        return rtn;
}
#endif
