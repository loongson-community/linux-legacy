/*******************************
 * RTC SD2068 regsiter define
 * *****************************/

/* rtc time regs */
#define REG_SEC		0
#define REG_MIN 	1
#define REG_HOUR 	2
#define REG_WDAY	3
#define REG_DAY 	4
#define REG_MON		5
#define	REG_YEAR	6

/* alarm time regs */

/* control regs */
#define REG_CRT1	0xf
#define REG_CRT2	0x10
#define REG_CRT3	0x11
#define REG_Time_Adjust	0x12
#define REG_TIMER	0x13

#define	WRTC1_BIT	7	/* belongs to REG_CRT2 */
#define WRTC2_BIT   2   /* belongs to REG_CRT1 */
#define WRTC3_BIT	7   /* belongs to REG_CRT1 */

/* general ram */
/*	0x14-0x1F 12bytes*/

extern volatile char *mmio;

extern u8 i2c_read(u8, u8);
extern int i2c_write(u8, u8, u8);

extern u8 i2c_rtc_read(void*);
extern int i2c_rtc_write(void*);
extern unsigned long sd2068_get_time(void);
