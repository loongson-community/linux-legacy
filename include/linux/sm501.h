/* include/linux/sm501.h
 *
 * Copyright (C) 2010 SiliconMotion Inc.
 * Copyright (c) 2006 Simtec Electronics
 *
 *	Ben Dooks <ben@simtec.co.uk>
 *	Vincent Sanders <vince@simtec.co.uk>
  *	Boyod Yang <boyoddev@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/
#ifndef _LINUX_SM501_CORE
#define _LINUX_SM501_CORE

//#define USE_SYSTEM_MEMORY
//#define B_DEBUG
//#define SMI_DEBUG


#include <linux/fb.h>
#include <linux/module.h>

#ifdef B_DEBUG
#define b_dbg printk
#else
#define b_dbg(format, arg...) do {} while (0)
#endif
#ifdef SMI_DEBUG
#define smi_dbg printk
#else
#define smi_dbg(format, arg...) do {} while (0)
#endif

#ifndef CONFIG_SMIVGX_UART_OUTPUT_BUF_SIZE
#define CONFIG_SMIVGX_UART_OUTPUT_BUF_SIZE 1024
#endif

#ifdef CONFIG_SM501_USE_EXTERNAL_MEMORY
#define USB_DMA_BUFFER_SIZE 0x80000
#else
#define USB_DMA_BUFFER_SIZE 0x80000
#endif

extern resource_size_t sm50x_mem_size;
extern unsigned long SmRead8(unsigned long nOffset);
extern unsigned long SmRead16(unsigned long nOffset);
extern unsigned long SmRead32(unsigned long nOffset);
extern unsigned char __iomem *  SmIoAddress(void);


extern void SmWrite8(unsigned long nOffset, unsigned long nData);
extern void SmWrite16(unsigned long nOffset, unsigned long nData);
extern void SmWrite32(unsigned long nOffset, unsigned long nData);

extern void SmMemset(unsigned long nOffset, unsigned char val, int count);

extern unsigned long sm501_find_clock(int clksrc, unsigned long req_freq);
extern unsigned long sm501_set_clock(struct device *dev, int clksrc, unsigned long req_freq);
extern void sm501_set_gate( unsigned long gate);



#define MHZ (1000 * 1000)

/* Platform data definitions */

#define SM501FB_FLAG_USE_INIT_MODE	(1<<0)
#define SM501FB_FLAG_DISABLE_AT_EXIT	(1<<1)
#define SM501FB_FLAG_USE_HWCURSOR	(1<<2)
#define SM501FB_FLAG_USE_HWACCEL	(1<<3)


typedef enum _panel_state_t
{
	PANEL_OFF,
	PANEL_ON,
}
panel_state_t;

struct sm501_platdata_fbsub {
	struct fb_videomode	*def_mode;
	unsigned int		 def_bpp;
	unsigned long		 max_mem;
	unsigned int		 flags;
};

/* sm501_platdata_fb flag field bit definitions */

#define SM501_FBPD_SWAP_FB_ENDIAN	(1<<0)	/* need to endian swap */


enum sm501_fb_routing {
	SM501_FB_OWN		= 0,	/* CRT=>CRT, Panel=>Panel */
	SM501_FB_CRT_PANEL	= 1,	/* Panel=>CRT, Panel=>Panel */
};

/* sm501_platdata_fb
 *
 * configuration data for the framebuffer driver
*/

struct sm501_platdata_fb {
	enum sm501_fb_routing		 fb_route;
	unsigned int			 flags;   /*For big endian or other. ...*/
	struct sm501_platdata_fbsub	*fb_crt;
	struct sm501_platdata_fbsub	*fb_pnl;
};


#define SM501_USE_USB_HOST	(1<<0)
#define SM501_USE_FB		(1<<1)
#define SM501_USE_SSP0		(1<<2)
#define SM501_USE_SSP1		(1<<3)
#define SM501_USE_UART0		(1<<4)
#define SM501_USE_UART1		(1<<5)
#define SM501_USE_FBACCEL	(1<<6)
#define SM501_USE_AC97		(1<<7)
#define SM501_USE_I2S		(1<<8)
#define SM501_USE_I2C		(1<<9)

#define SM501_USE_ALL		(0xFFFFFFFF)

/* panel clock */
#define SM501_CLOCK_P2XCLK		(24)
/* crt clock */
#define SM501_CLOCK_V2XCLK		(16)
/* main clock */
#define SM501_CLOCK_MCLK		(8)
/* SDRAM controller clock */
#define SM501_CLOCK_M1XCLK		(0)

struct sm501_initdata {
	unsigned int		flags;     /*For big endian or other. ...*/
	unsigned int		devices;
	unsigned long		mclk;		/* non-zero to modify */
	unsigned long		m1xclk;		/* non-zero to modify */
};


/* sm501_platdata
 *
 * This is passed with the platform device to allow the board
 * to control the behaviour of the SM501 driver(s) which attach
 * to the device.
 *
*/

struct sm501_platdata {
	struct sm501_initdata		*init;
	struct sm501_platdata_fb	*fb;
};


#endif
