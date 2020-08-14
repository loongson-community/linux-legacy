#ifdef DEBUG26_PNP_BONITO_82371
// MB PnP configuration register
#define PNP_KEY_ADDR    0x3f0
#define PNP_DATA_ADDR   0x3f1

// Device LDN
#define LDN_SERIAL1     0x01
#define LDN_SERIAL2     0x02
#define LDN_PARALLEL    0x03
#define LDN_KEYBOARD    0x05
#define LDN_MOUSE       0x06



static void PNPSetConfig(char LdnNumber, char Index, char data);
static char PNPGetConfig(char LdnNumber, char Index);



static void EnterMBPnP(void)
{

                outb(0x87,PNP_KEY_ADDR);
                outb(0x87,PNP_KEY_ADDR);

}

static void ExitMBPnP(void)
{
        outb(0xaa,PNP_KEY_ADDR);
}

static void PNPSetConfig(char LdnNumber, char Index, char data)
{
        EnterMBPnP();                                // Enter IT8712 MB PnP mode
        outb(0x07,PNP_KEY_ADDR);
        outb(LdnNumber,PNP_DATA_ADDR);
        outb(Index,PNP_KEY_ADDR);
        outb(data,PNP_DATA_ADDR);
        ExitMBPnP();
}

static char PNPGetConfig(char LdnNumber, char Index)
{
        char rtn;

        EnterMBPnP();                                // Enter IT8712 MB PnP mode
        outb(0x07,PNP_KEY_ADDR);
        outb(LdnNumber,PNP_DATA_ADDR);
        outb(Index,PNP_KEY_ADDR);
        rtn = inb(PNP_DATA_ADDR);
        ExitMBPnP();
        return rtn;
}


static int PnpRead(int argc,char **argv)
{
	unsigned char LdnNumber,Index,data;
		if(argc!=3){nr_printf("pnpr LdnNumber Index\n");return -1;}
		
		LdnNumber=nr_strtol(argv[1],0,0);
		Index=nr_strtol(argv[2],0,0);
data=PNPGetConfig(LdnNumber,Index);
nr_printf("pnpread logic device %d ,index=0x%02x,value=0x%02x\n",LdnNumber,Index,data);
return 0;
}

static int PnpWrite(int argc,char **argv)
{
        unsigned char LdnNumber,Index,data;
                if(argc!=4){nr_printf("pnpw LdnNumber Index data\n");return -1;}
		LdnNumber=nr_strtol(argv[1],0,0);
		Index=nr_strtol(argv[2],0,0);
		data=nr_strtol(argv[3],0,0);

PNPSetConfig(LdnNumber,Index,data);
nr_printf("pnpwrite logic device %d ,index=0x%02x,value=0x%02x,",LdnNumber,Index,data);
data=PNPGetConfig(LdnNumber,Index);
nr_printf("result=0x%02x\n",data);
return 0;
}


mycmd_init(pnpr,PnpRead,"LDN index","pnpr LDN(logic device NO) index");
mycmd_init(pnpw,PnpWrite,"LDN index value","pnpw LDN(logic device NO) index value");
#endif
