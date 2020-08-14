#define RTC_TOYIM	0x00
#define	RTC_TOYWLO	0x04
#define	RTC_TOYWHI	0x08
#define RTC_TOYRLO	0x0c
#define RTC_TOYRHI	0x10
#define	RTC_TOYMH0	0x14
#define	RTC_TOYMH1	0x18
#define	RTC_TOYMH2	0x1c
#define	RTC_CNTL	0x20
#define	RTC_RTCIM	0x40
#define	RTC_WRITE0	0x44
#define	RTC_READ0	0x48
#define	RTC_RTCMH0	0x4c
#define	RTC_RTCMH1	0x50
#define	RTC_RTCMH2	0x54

#define SB2F_BOARD_RTC_BASE         0xb2e64020
#define REG(x) *(volatile int *)(SB2F_BOARD_RTC_BASE+x)

static spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;

static int sb2f_rtc_readtime(struct rtc_time *tm)
{
	unsigned long now, now1;

	now = REG(RTC_TOYRLO);

	tm->tm_sec = ((now >> 4) & 0x3f);
	tm->tm_min = ((now >> 10) & 0x3f);
	tm->tm_hour = ((now >> 16) & 0x1f);
	tm->tm_mday = ((now >> 21) & 0x1f);
	tm->tm_mon = ((now >> 26) & 0x3f) -1;
		
	now1 = REG(RTC_TOYRHI);

	tm->tm_year = (now1 -1900) ;

	return 0;
}

static int sb2f_rtc_settime(struct rtc_time *tm)
{
	unsigned long now;
	
	now = ((tm->tm_sec << 4) | (tm->tm_min << 10) | (tm->tm_hour << 16) | 
			(tm->tm_mday << 21) | (((tm->tm_mon+1)<< 26) ));
	spin_lock_irq(&rtc_lock);
	REG(RTC_TOYRLO) = now;
//set year 	
	REG(RTC_TOYRHI) = (tm->tm_year+1900);
	spin_unlock_irq(&rtc_lock);
	
	return 0;
}


static unsigned char CMOS_READ_TO_RTC_READ(unsigned char addr)
{
	struct rtc_time tm;
    	unsigned char val = 0;
	if(addr >= 0x0a)
		return 0;
	sb2f_rtc_readtime(&tm);
	switch(addr)
	{
	case RTC_SECONDS:
	val = tm.tm_sec;
	break;
	case RTC_SECONDS_ALARM:
	case RTC_MINUTES:
	val = tm.tm_min;
	break;
	case RTC_MINUTES_ALARM:
	case RTC_HOURS:
	val = tm.tm_hour;
	break;
	case RTC_HOURS_ALARM:
	case RTC_ALARM_DONT_CARE:
	case RTC_DAY_OF_WEEK:
	case RTC_DAY_OF_MONTH:
	val = tm.tm_mday;
	break;
	case RTC_MONTH:
	val = tm.tm_mon;
	break;
	case RTC_YEAR:
	val = tm.tm_year;
	break;
	}


        return val;
}

static void CMOS_WRITE_TO_RTC_WRITE(unsigned char val, unsigned char addr)
{

	struct rtc_time tm;

	if(addr >=0x0a)
		return ;

	sb2f_rtc_readtime(&tm);
	switch(addr)
	{
	case RTC_SECONDS:
	tm.tm_sec = val;
	break;
	case RTC_SECONDS_ALARM:
	case RTC_MINUTES:
	tm.tm_min = val;
	break;
	case RTC_MINUTES_ALARM:
	case RTC_HOURS:
	tm.tm_hour = val;
	break;
	case RTC_HOURS_ALARM:
	case RTC_ALARM_DONT_CARE:
	case RTC_DAY_OF_WEEK:
	case RTC_DAY_OF_MONTH:
	tm.tm_mday = val;
	break;
	case RTC_MONTH:
	tm.tm_mon = val;
	break;
	case RTC_YEAR:
	tm.tm_year = val;
	break;
	}
	sb2f_rtc_settime(&tm);

}

