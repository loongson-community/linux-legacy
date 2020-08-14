/*-
 * Finger Sensing Pad PS/2 mouse driver.
 *
 * Copyright (C) 2005-2007 Asia Vital Components Co., Ltd.
 * Copyright (C) 2005-2008 Tai-hwa Liang, Sentelic Corporation.
 *
 *   This program is free software; you can redistribute it and/or
 *   modify it under the terms of the GNU General Public License
 *   as published by the Free Software Foundation; either version 2
 *   of the License, or (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 * $Id: sentelic.h 28700 2008-10-16 07:23:43Z avatar $
 */

#ifndef	__SENTELIC_H__
#define	__SENTELIC_H__

#if	defined(__KERNEL__)
extern int fsp_detect(struct psmouse *psmouse, int set_properties);
extern int fsp_init(struct psmouse *psmouse);
extern int fsp_reset(struct psmouse *psmouse);
#endif

/* Finger-sensing Pad information registers */
#define	FSP_REG_DEVICE_ID	0x00
#define	FSP_REG_VERSION		0x01
#define	FSP_REG_REVISION	0x04
#define	FSP_REG_TMOD_STATUS1	0x0B
#define	FSP_BIT_NO_ROTATION	BIT(3)
#define	FSP_REG_PAGE_CTRL	0x0F

/* Finger-sensing Pad control registers */
#define	FSP_REG_SYSCTL1		0x10
#define	FSP_BIT_EN_REG_CLK	BIT(5)
#define	FSP_REG_OPC_QDOWN	0x31
#define	FSP_BIT_EN_OPC_TAG	BIT(7)
#define	FSP_REG_OPTZ_XLO	0x34
#define	FSP_REG_OPTZ_XHI	0x35
#define	FSP_REG_OPTZ_YLO	0x36
#define	FSP_REG_OPTZ_YHI	0x37
#define	FSP_REG_SYSCTL5		0x40
#define	FSP_BIT_90_DEGREE	BIT(0)
#define	FSP_BIT_EN_MSID6	BIT(1)
#define	FSP_BIT_EN_MSID7	BIT(2)
#define	FSP_BIT_EN_MSID8	BIT(3)
#define	FSP_BIT_EN_AUTO_MSID8	BIT(5)
#define	FSP_BIT_EN_PKT_G0	BIT(6)

#define	FSP_REG_ONPAD_CTL	0x43
#define	FSP_BIT_ONPAD_ENABLE	BIT(0)
#define	FSP_BIT_ONPAD_FBBB	BIT(1)
#define	FSP_BIT_FIX_VSCR	BIT(3)
#define	FSP_BIT_FIX_HSCR	BIT(5)
#define	FSP_BIT_DRAG_LOCK	BIT(6)

/* Finger-sensing Pad packet formating related definitions */

/* absolute packet type */
#define	FSP_PKT_TYPE_NORMAL	(0x00)
#define	FSP_PKT_TYPE_ABS	(0x01)
#define	FSP_PKT_TYPE_NOTIFY	(0x02)
#define	FSP_PKT_TYPE_NORMAL_OPC	(0x03)
#define	FSP_PKT_TYPE_SHIFT	(6)

struct fsp_hw_state
{
	unsigned char	onpad_vscroll:1,/* On-pad vertical scroll zone */
			onpad_hscroll:1,/* On-pad horizontal scroll zone */
			onpad_icon:1,	/* On-pad icons */
			btn_fbbb:1,	/* Forward/backward button */
			btn_slsr:1,	/* Scroll left/right button */
			abs_pkt:1,	/* absolute packet mode */
			pkt_fmt:2;	/* packet format */
	unsigned int	reg_val;	/* used by reg_write sysctl */
};

struct fsp_data
{
	unsigned int		flags;
#define FSPDRV_FLAG_CMD		(0x010)	/* The command bit of flags indicates the special FSP PS/2 command is sent. */
#define FSPDRV_FLAG_RESP	(0x020)	/* The response bit of flags indicates the special FSP PS/2 comamnd is sent and response is received. */
#define FSPDRV_FLAG_OPICON_BTN	(0x040)	/* Output on-pad icons as BTN events */
#define FSPDRV_FLAG_OPICON_KEY	(0x080)	/* Output on-pad icons as KEY events */
#define	FSPDRV_FLAG_REVERSE_X	(0x100)	/* reverse X direction */
#define	FSPDRV_FLAG_REVERSE_Y	(0x200)	/* reverse Y direction */
#define	FSPDRV_FLAG_AUTO_SWITCH	(0x400)	/* software on-pad icon auto switch */
#define	FSPDRV_FLAG_EN_OPC	(0x800)	/* enable on-pad clicking */
#define FSP_RESP_PKT_MAXLEN	(8)	/* The max response packet size. */
	unsigned char 		cmd;	/* The buffer used to store the sending PS/2 command */
	unsigned char 		resp[FSP_RESP_PKT_MAXLEN]; /* The buffer used to store the response of PS/2 command */
	int			resp_cnt;	/* The command count in resp buffer */
	unsigned char		buttons;	/* Number of buttons */
	unsigned char		ver;		/* hardware version */
	unsigned char		rev;		/* hardware revison */
	unsigned int		mode;		/* device mode */
#define	FSPDRV_MODE_BTN_RIGHT	BIT(0)
#define	FSPDRV_MODE_BTN_MIDDLE	BIT(1)
#define	FSPDRV_MODE_BTN_LEFT	BIT(2)
#define	FSPDRV_MODE_BTN_SCRD	BIT(3)
#define	FSPDRV_MODE_BTN_SCRU	BIT(4)
#define	FSPDRV_MODE_BTN_SCRL	BIT(5)
#define	FSPDRV_MODE_BTN_SCRR	BIT(6)
#define	FSPDRV_MODE_BTN_FB	BIT(7)
#define	FSPDRV_MODE_BTN_BB	BIT(8)
	unsigned char		button_status;
	unsigned int		last_reg_val;

/** default acceleration numerator */
#define	DEFAULT_ACCEL_NUM	(2)
	/** numerator for the acceleration multiplier */
	int			accel_num;
/** default acceleration denominator */
#define	DEFAULT_ACCEL_DENOM	(1)
	/** denominator for the acceleration multiplier */
	int			accel_denom;
/** default acceleration threshold */
#define	DEFAULT_ACCEL_THRESHOLD	(4)

	/** acceleration threshold */
	int			accel_threshold;
#define	FSPDRV_SET_REG_BUF_LEN	(256)
	unsigned char		init_params[FSPDRV_SET_REG_BUF_LEN];
	size_t			init_params_len;
	struct fsp_hw_state	hw_state;
};

#endif	/* !__SENTELIC_H__ */
