/*
 *  linux/drivers/video/smtc2d.c -- Silicon Motion SM501 and SM7xx 2D drawing engine functions.
 *
 *      Copyright (C) 2010 Silicon Motion Technology Corp.
 *      Ge Wang, gewang@siliconmotion.com
 *      Boyod.yang,  <boyod.yang@siliconmotion.com.cn>
 *      Teddy.wang  <teddy.wang@siliconmotion.com.cn>
 *
 *  This file is subject to the terms and conditions of the GNU General Public
 *  License version 2 or later as published by the Free Software Foundation.  
 */

 
#include <linux/kernel.h>
#include <linux/errno.h>

#define RGB(r, g, b) ((unsigned long)(((r) << 16) | ((g) << 8) | (b)))

// Transparent info definition
typedef struct
{
    unsigned long match;    // Matching pixel is OPAQUE/TRANSPARENT
	unsigned long select;   // Transparency controlled by SOURCE/DESTINATION
	unsigned long control;  // ENABLE/DISABLE transparency
	unsigned long color;    // Transparent color
} Transparent, *pTransparent;

#define PIXEL_DEPTH_1_BP		0		// 1 bit per pixel
#define PIXEL_DEPTH_8_BPP		1		// 8 bits per pixel
#define PIXEL_DEPTH_16_BPP		2		// 16 bits per pixel
#define PIXEL_DEPTH_32_BPP		3		// 32 bits per pixel
#define PIXEL_DEPTH_YUV422		8		// 16 bits per pixel YUV422
#define PIXEL_DEPTH_YUV420		9		// 16 bits per pixel YUV420

#define PATTERN_WIDTH           8
#define PATTERN_HEIGHT          8

#define	TOP_TO_BOTTOM			0
#define	BOTTOM_TO_TOP			1
#define RIGHT_TO_LEFT			BOTTOM_TO_TOP
#define LEFT_TO_RIGHT			TOP_TO_BOTTOM

// Constants used in Transparent structure
#define MATCH_OPAQUE            0x00000000
#define MATCH_TRANSPARENT       0x00000400
#define SOURCE                  0x00000000
#define DESTINATION             0x00000200

#define DE_DATA_PORT_501                                0x110000
#define DE_DATA_PORT_712                                0x400000
#define DE_DATA_PORT_722                                0x6000

unsigned char sm_accel_busy = 0;

void SmWrite2D(unsigned long nOffset, unsigned long nData)
{
    SmWrite32(DE_BASE_ADDRESS+nOffset, nData);
}

ulong SmRead2D(ulong offset)
{
	return SmRead32(DE_BASE_ADDRESS+offset);
}


void SmWrite2D_DataPort(unsigned long nOffset, unsigned long nData)
{
    SmWrite32(DE_DATA_PORT+nOffset, nData);
}

/* sm501fb_Wait_IDLE()
 *
 * This call is mainly for wait 2D idle.
*/
void sm501fb_Wait_Idle(void)
{
	unsigned long i = 0x1000000;
	unsigned long dwVal =0;
	smdbg("In W_Idle\n");
	while (i--)
	{
        dwVal = SmRead32(SYS_CTRL);
        if ((FIELD_GET(dwVal, SYS_CTRL, 2D_ENGINE_STATUS)      == SYS_CTRL_2D_ENGINE_STATUS_IDLE) &&
            (FIELD_GET(dwVal, SYS_CTRL, 2D_FIFO)        == SYS_CTRL_2D_FIFO_EMPTY) &&
            (FIELD_GET(dwVal, SYS_CTRL, CSC_STATUS)     == SYS_CTRL_CSC_STATUS_IDLE) &&
            (FIELD_GET(dwVal, SYS_CTRL, 2D_MEMORY_FIFO) == SYS_CTRL_2D_MEMORY_FIFO_EMPTY))
            break;
	}
    	//sm_accel_busy = 0;
}

/*
 * This function gets the transparency status from DE_CONTROL register.
 * It returns a double word with the transparent fields properly set,
 * while other fields are 0.
 */
unsigned long deGetTransparency()
{
    unsigned long de_ctrl;

    de_ctrl = SmRead2D(DE_CONTROL);

    de_ctrl &= 
        FIELD_MASK(DE_CONTROL_TRANSPARENCY_MATCH) | 
        FIELD_MASK(DE_CONTROL_TRANSPARENCY_SELECT)| 
        FIELD_MASK(DE_CONTROL_TRANSPARENCY);

    return de_ctrl;
}

long deSetTransparency(
unsigned long enable,     /* 0 = disable, 1 = enable transparency feature */
unsigned long tSelect,    /* 0 = compare source, 1 = compare destination */
unsigned long tMatch,     /* 0 = Opaque mode, 1 = transparent mode */
unsigned long ulColor)    /* Color to compare. */
{
    unsigned long de_ctrl;

    
    /* Set mask */
    if (enable)
    {
        SmWrite2D(DE_COLOR_COMPARE_MASK, 0x00ffffff);

        /* Set compare color */
        SmWrite2D(DE_COLOR_COMPARE, ulColor);
    }
    else
    {
        SmWrite2D(DE_COLOR_COMPARE_MASK, 0x0);
        SmWrite2D(DE_COLOR_COMPARE, 0x0);
    }

    /* Set up transparency control, without affecting other bits
       Note: There are two operatiing modes: Transparent and Opague.
       We only use transparent mode because Opaque mode may have bug.
    */
    de_ctrl = SmRead2D(DE_CONTROL)
              & FIELD_CLEAR(DE_CONTROL, TRANSPARENCY)
              & FIELD_CLEAR(DE_CONTROL, TRANSPARENCY_MATCH)
              & FIELD_CLEAR(DE_CONTROL, TRANSPARENCY_SELECT);

    /* For DE_CONTROL_TRANSPARENCY_MATCH bit, always set it
       to TRANSPARENT mode, OPAQUE mode don't seem working.
    */
    de_ctrl |=
    ((enable)?
      FIELD_SET(0, DE_CONTROL, TRANSPARENCY, ENABLE)
    : FIELD_SET(0, DE_CONTROL, TRANSPARENCY, DISABLE))        |
    ((tMatch)?
      FIELD_SET(0, DE_CONTROL, TRANSPARENCY_MATCH, TRANSPARENT)
    : FIELD_SET(0, DE_CONTROL, TRANSPARENCY_MATCH, OPAQUE)) |
    ((tSelect)?
      FIELD_SET(0, DE_CONTROL, TRANSPARENCY_SELECT, DESTINATION)
    : FIELD_SET(0, DE_CONTROL, TRANSPARENCY_SELECT, SOURCE));

    SmWrite2D(DE_CONTROL, de_ctrl);

    return 0;
}


/**********************************************************************
 *
 * deInit
 *
 * Purpose
 *    Drawing engine initialization.
 *
 **********************************************************************/
 void deInit(unsigned int nModeWidth, unsigned int nModeHeight, unsigned int bpp)
{
	// Get current power configuration.
	unsigned int gate, clock;

	gate  = SmRead32(CURRENT_GATE);

	// Enable 2D Drawing Engine
	gate = FIELD_SET(gate, CURRENT_GATE, 2D, ENABLE);
	sm501_set_gate(gate);
	
	SmWrite2D(DE_CLIP_TL,
		FIELD_VALUE(0, DE_CLIP_TL, TOP,     0)       |
		FIELD_SET  (0, DE_CLIP_TL, STATUS,  DISABLE) |
		FIELD_SET  (0, DE_CLIP_TL, INHIBIT, OUTSIDE) |
		FIELD_VALUE(0, DE_CLIP_TL, LEFT,    0));
/*
    SmWrite2D(DE_PITCH,
		FIELD_VALUE(0, DE_PITCH, DESTINATION, nModeWidth) |
		FIELD_VALUE(0, DE_PITCH, SOURCE,      nModeWidth));

    SmWrite2D(DE_WINDOW_WIDTH,
		FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, nModeWidth) |
		FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      nModeWidth));
*/

   if ((bpp>=24)&&(bpp<=32))
   	bpp = 32;
   
    switch (bpp)
    {
    case 8:
        SmWrite2D(DE_STRETCH_FORMAT,
            FIELD_SET  (0, DE_STRETCH_FORMAT, PATTERN_XY,    NORMAL) |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_Y,     0)      |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,     0)      |
            FIELD_SET  (0, DE_STRETCH_FORMAT, PIXEL_FORMAT,  8)      |
            FIELD_SET  (0, DE_STRETCH_FORMAT, ADDRESSING,	 XY)     |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, SOURCE_HEIGHT, 3));
        break;
    case 16:
        SmWrite2D(DE_STRETCH_FORMAT,
            FIELD_SET  (0, DE_STRETCH_FORMAT, PATTERN_XY,    NORMAL) |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_Y,     0)      |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,     0)      |
            FIELD_SET  (0, DE_STRETCH_FORMAT, PIXEL_FORMAT,  16)     |
            FIELD_SET  (0, DE_STRETCH_FORMAT, ADDRESSING,	 XY)     |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, SOURCE_HEIGHT, 3));
        break;
    case 32:
        SmWrite2D(DE_STRETCH_FORMAT,
            FIELD_SET  (0, DE_STRETCH_FORMAT, PATTERN_XY,    NORMAL) |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_Y,     0)      |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,     0)      |
            FIELD_SET  (0, DE_STRETCH_FORMAT, PIXEL_FORMAT,  32)     |
            FIELD_SET  (0, DE_STRETCH_FORMAT, ADDRESSING,	 XY)     |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, SOURCE_HEIGHT, 3));
       break;
   default:
		BUG();

    }

	SmWrite2D(DE_MASKS,
		FIELD_VALUE(0, DE_MASKS, BYTE_MASK, 0xFFFF) |
		FIELD_VALUE(0, DE_MASKS, BIT_MASK,  0xFFFF));
	SmWrite2D(DE_COLOR_COMPARE_MASK,
		FIELD_VALUE(0, DE_COLOR_COMPARE_MASK, MASKS, 0xFFFFFF));
	SmWrite2D(DE_COLOR_COMPARE,
		FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR, 0xFFFFFF));

	/* disable transparency first */
	deSetTransparency(0,0,0,0);
}


#if 0
/**********************************************************************
 *
 * deSetClipRectangle
 *
 * Purpose
 *    Set drawing engine clip rectangle.
 *
 * Remarks
 *       Caller need to pass in valid rectangle parameter in device coordinate.
 **********************************************************************/
void deSetClipRectangle(int left, int top, int right, int bottom)
{
    /* Top left of clipping rectangle cannot be negative */
    if (top < 0)
    {
        top = 0;
    }
    
    if (left < 0)
    {
        left = 0;
    }
    
    SmWrite2D(DE_CLIP_TL,
        FIELD_VALUE(0, DE_CLIP_TL, TOP,     top) |
        FIELD_SET  (0, DE_CLIP_TL, STATUS,  ENABLE)         |
        FIELD_SET  (0, DE_CLIP_TL, INHIBIT, OUTSIDE)        |
        FIELD_VALUE(0, DE_CLIP_TL, LEFT,    left));
    SmWrite2D(DE_CLIP_BR,
        FIELD_VALUE(0, DE_CLIP_BR, BOTTOM, bottom) |
        FIELD_VALUE(0, DE_CLIP_BR, RIGHT,  right));
}


void deVerticalLine(unsigned long dst_base,
                    unsigned long dst_pitch, 
                    unsigned long nX, 
                    unsigned long nY, 
                    unsigned long dst_height, 
                    unsigned long nColor)
{
    sm501fb_Wait_Idle();

    SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));

	SmWrite2D(DE_PITCH,
		FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
		FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
    
	SmWrite2D(DE_WINDOW_WIDTH,
		FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
		FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));

    SmWrite2D(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));

    SmWrite2D(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    nX)      |
        FIELD_VALUE(0, DE_DESTINATION, Y,    nY));

    SmWrite2D(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    1) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));

    SmWrite2D(DE_CONTROL,
        FIELD_SET  (0, DE_CONTROL, STATUS,     START)         |
        FIELD_SET  (0, DE_CONTROL, DIRECTION,  LEFT_TO_RIGHT) |
        FIELD_SET  (0, DE_CONTROL, MAJOR,      Y)             |
        FIELD_SET  (0, DE_CONTROL, STEP_X,     NEGATIVE)      |
        FIELD_SET  (0, DE_CONTROL, STEP_Y,     POSITIVE)      |
        FIELD_SET  (0, DE_CONTROL, LAST_PIXEL, OFF)           |
        FIELD_SET  (0, DE_CONTROL, COMMAND,    SHORT_STROKE)  |
        FIELD_SET  (0, DE_CONTROL, ROP_SELECT, ROP2)          |
        FIELD_VALUE(0, DE_CONTROL, ROP,        0x0C));
    
    sm_accel_busy = 1;
}

void deHorizontalLine(unsigned long dst_base,
                      unsigned long dst_pitch, 
                      unsigned long nX, 
                      unsigned long nY, 
                      unsigned long dst_width, 
                      unsigned long nColor)
{
    sm501fb_Wait_Idle();
    
    SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
    
    SmWrite2D(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
    
    SmWrite2D(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));
    SmWrite2D(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
    SmWrite2D(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    nX)      |
        FIELD_VALUE(0, DE_DESTINATION, Y,    nY));
    SmWrite2D(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, 1));
    SmWrite2D(DE_CONTROL,
        FIELD_SET  (0, DE_CONTROL, STATUS,     START)         |
        FIELD_SET  (0, DE_CONTROL, DIRECTION,  RIGHT_TO_LEFT) |
        FIELD_SET  (0, DE_CONTROL, MAJOR,      X)             |
        FIELD_SET  (0, DE_CONTROL, STEP_X,     POSITIVE)      |
        FIELD_SET  (0, DE_CONTROL, STEP_Y,     NEGATIVE)      |
        FIELD_SET  (0, DE_CONTROL, LAST_PIXEL, OFF)           |
        FIELD_SET  (0, DE_CONTROL, COMMAND,    SHORT_STROKE)  |
        FIELD_SET  (0, DE_CONTROL, ROP_SELECT, ROP2)          |
        FIELD_VALUE(0, DE_CONTROL, ROP,        0x0C));

    sm_accel_busy = 1;
}


void deLine(unsigned long dst_base,
            unsigned long dst_pitch,  
            unsigned long nX1, 
            unsigned long nY1, 
            unsigned long nX2, 
            unsigned long nY2, 
            unsigned long nColor)
{
    unsigned long nCommand =
        FIELD_SET  (0, DE_CONTROL, STATUS,     START)         |
        FIELD_SET  (0, DE_CONTROL, DIRECTION,  LEFT_TO_RIGHT) |
        FIELD_SET  (0, DE_CONTROL, MAJOR,      X)             |
        FIELD_SET  (0, DE_CONTROL, STEP_X,     POSITIVE)      |
        FIELD_SET  (0, DE_CONTROL, STEP_Y,     POSITIVE)      |
        FIELD_SET  (0, DE_CONTROL, LAST_PIXEL, OFF)           |
        FIELD_SET  (0, DE_CONTROL, ROP_SELECT, ROP2)          |
        FIELD_VALUE(0, DE_CONTROL, ROP,        0x0C);
    unsigned long DeltaX;
    unsigned long DeltaY;
    
    /* Calculate delta X */
    if (nX1 <= nX2)
    {
        DeltaX = nX2 - nX1;
    }
    else
    {
        DeltaX = nX1 - nX2;
        nCommand = FIELD_SET(nCommand, DE_CONTROL, STEP_X, NEGATIVE);
    }
    
    /* Calculate delta Y */
    if (nY1 <= nY2)
    {
        DeltaY = nY2 - nY1;
    }
    else
    {
        DeltaY = nY1 - nY2;
        nCommand = FIELD_SET(nCommand, DE_CONTROL, STEP_Y, NEGATIVE);
    }
    
    /* Determine the major axis */
    if (DeltaX < DeltaY)
    {
        nCommand = FIELD_SET(nCommand, DE_CONTROL, MAJOR, Y);
    }
    
    /* Vertical line? */
    if (nX1 == nX2)
        deVerticalLine(dst_base, dst_pitch, nX1, nY1, DeltaY, nColor);
    
    /* Horizontal line? */
    else if (nY1 == nY2)
        deHorizontalLine(dst_base, dst_pitch, nX1, nY1, DeltaX, nColor);
    
    /* Diagonal line? */
    else if (DeltaX == DeltaY)
    {
        sm501fb_Wait_Idle();
        
        SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
        
        SmWrite2D(DE_PITCH,
            FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
        
        SmWrite2D(DE_WINDOW_WIDTH,
            FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));
        
        SmWrite2D(DE_FOREGROUND,
            FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
        
        SmWrite2D(DE_DESTINATION,
            FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_DESTINATION, X,    1)       |
            FIELD_VALUE(0, DE_DESTINATION, Y,    nY1));
        
        SmWrite2D(DE_DIMENSION,
            FIELD_VALUE(0, DE_DIMENSION, X,    1) |
            FIELD_VALUE(0, DE_DIMENSION, Y_ET, DeltaX));
        
        SmWrite2D(DE_CONTROL,
            FIELD_SET(nCommand, DE_CONTROL, COMMAND, SHORT_STROKE));
    }
    
    /* Generic line */
    else
    {
        unsigned int k1, k2, et, w;
        if (DeltaX < DeltaY)
        {
            k1 = 2 * DeltaX;
            et = k1 - DeltaY;
            k2 = et - DeltaY;
            w  = DeltaY + 1;
        } 
        else 
        {
            k1 = 2 * DeltaY;
            et = k1 - DeltaX;
            k2 = et - DeltaX;
            w  = DeltaX + 1;
        }
        
        sm501fb_Wait_Idle();
        
        SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
        
        SmWrite2D(DE_PITCH,
            FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
        
        SmWrite2D(DE_WINDOW_WIDTH,
            FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));
        
        SmWrite2D(DE_FOREGROUND,
            FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
        
        SmWrite2D(DE_SOURCE,
            FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_SOURCE, X_K1, k1)      |
            FIELD_VALUE(0, DE_SOURCE, Y_K2, k2));
        
        SmWrite2D(DE_DESTINATION,
            FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_DESTINATION, X,    nX1)     |
            FIELD_VALUE(0, DE_DESTINATION, Y,    nY1));
        
        SmWrite2D(DE_DIMENSION,
            FIELD_VALUE(0, DE_DIMENSION, X,    w) |
            FIELD_VALUE(0, DE_DIMENSION, Y_ET, et));
        
        SmWrite2D(DE_CONTROL,
            FIELD_SET(nCommand, DE_CONTROL, COMMAND, LINE_DRAW));
    }

    sm_accel_busy = 1;
}
#endif



#if 1
/*
 * This function uses 2D engine to fill a rectangular area with a specific color.
 * The filled area includes the starting points.
 */
long deRectFill( /*resolution_t resolution, point_t p0, point_t p1, unsigned long color, unsigned long rop2)*/
unsigned long dBase,  /* Base address of destination surface counted from beginning of video frame buffer */
unsigned long dPtich, /* Pitch value of destination surface in BYTES */
unsigned long bpp,    /* Color depth of destination surface: 8, 16 or 32 */
unsigned long x,
unsigned long y,      /* Upper left corner (X, Y) of rectangle in pixel value */
unsigned long width, 
unsigned long height, /* width and height of rectange in pixel value */
unsigned long color,  /* Color to be filled */
unsigned long rop2)   /* ROP value */
{
	unsigned long de_ctrl, bytePerPixel;

    	bytePerPixel = bpp/8;
    
	sm501fb_Wait_Idle();

	ulong regvalue=SmRead2D(DE_STRETCH_FORMAT);
	switch(bpp)
	{
		case 8:
			FIELD_SET(regvalue,DE_STRETCH_FORMAT,PIXEL_FORMAT,8);
			break;
		case 16:
			FIELD_SET(regvalue,DE_STRETCH_FORMAT,PIXEL_FORMAT,16);
			break;
		case 32:	
			FIELD_SET(regvalue,DE_STRETCH_FORMAT,PIXEL_FORMAT,32);
			break;
	}
	SmWrite2D(DE_STRETCH_FORMAT, regvalue);


    /* 2D Destination Base.
       It is an address offset (128 bit aligned) from the beginning of frame buffer.
    */
    SmWrite2D(DE_WINDOW_DESTINATION_BASE, dBase);

    /* Program pitch (distance between the 1st points of two adjacent lines).
       Note that input pitch is BYTE value, but the 2D Pitch register uses
       pixel values. Need Byte to pixel convertion.
    */
    SmWrite2D(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, (dPtich/bytePerPixel)) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      (dPtich/bytePerPixel)));

    /* Screen Window width in Pixels.
       2D engine uses this value to calculate the linear address in frame buffer for a given point.
    */
    SmWrite2D(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPtich/bytePerPixel)) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (dPtich/bytePerPixel)));

    SmWrite2D(DE_FOREGROUND, color);

    SmWrite2D(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    x)       |
        FIELD_VALUE(0, DE_DESTINATION, Y,    y));

    SmWrite2D(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, height));

	/*
		because bpp had been set by deInit routine, we do not need reset again
		but,if dual mode need support ,  bpp should by set each time cuz CRT may 
		get a different bpp to PANEL and deInit may only set 2d engine bpp filed to
		be the same as PANEL layer
	*/
	

    de_ctrl = 
        FIELD_SET  (0, DE_CONTROL,  STATUS,     START)          |
        FIELD_SET  (0, DE_CONTROL,  DIRECTION,  LEFT_TO_RIGHT)  |
        FIELD_SET  (0, DE_CONTROL,LAST_PIXEL, ON)            |
        FIELD_SET  (0, DE_CONTROL,  COMMAND,    RECTANGLE_FILL) |
        FIELD_SET  (0, DE_CONTROL,  ROP_SELECT, ROP2)           |
        FIELD_VALUE(0, DE_CONTROL,  ROP,        rop2);
	
	sm501fb_Wait_Idle();

#if 0
    POKE_32(DE_CONTROL, de_ctrl | deGetTransparency());
#else	
	SmWrite2D(DE_CONTROL,de_ctrl);
#endif

    return 0;
}
#else
void deFillRect(unsigned long dst_base,
                unsigned long dst_pitch,  
                unsigned long dst_X, 
                unsigned long dst_Y, 
                unsigned long dst_width, 
                unsigned long dst_height, 
                unsigned long nColor)
{
    sm501fb_Wait_Idle();

    SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
    
    if (dst_pitch)
    {
        SmWrite2D(DE_PITCH,
            FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
        
        SmWrite2D(DE_WINDOW_WIDTH,
            FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));
    }

    SmWrite2D(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));

    SmWrite2D(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)     |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));

    SmWrite2D(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));

    SmWrite2D(DE_CONTROL,
        FIELD_SET  (0, DE_CONTROL, STATUS,     START)          |
        FIELD_SET  (0, DE_CONTROL, DIRECTION,  LEFT_TO_RIGHT)  |
        FIELD_SET  (0, DE_CONTROL, LAST_PIXEL, OFF)            |
        FIELD_SET  (0, DE_CONTROL, COMMAND,    RECTANGLE_FILL) |
        FIELD_SET  (0, DE_CONTROL, ROP_SELECT, ROP2)           |
        FIELD_VALUE(0, DE_CONTROL, ROP,        0x0C));

    //sm_accel_busy = 1;
}
#endif
#if 0
/**********************************************************************
 *
 * deRotatePattern
 *
 * Purpose
 *    Rotate the given pattern if necessary
 *
 * Parameters
 *    [in]
 *        pPattern  - Pointer to DE_SURFACE structure containing
 *                    pattern attributes
 *        patternX  - X position (0-7) of pattern origin
 *        patternY  - Y position (0-7) of pattern origin
 *
 *    [out]
 *        pattern_dstaddr - Pointer to pre-allocated buffer containing rotated pattern
 *
 *
 **********************************************************************/
void deRotatePattern(unsigned char* pattern_dstaddr,
                     unsigned long pattern_src_addr,
                     unsigned long pattern_BPP,
                     unsigned long pattern_stride,
                     int patternX,
                     int patternY)
{
    unsigned int i;
    unsigned long pattern_read_addr;
    unsigned long pattern[PATTERN_WIDTH * PATTERN_HEIGHT];
    unsigned int x, y;
	unsigned char* pjPatByte;

    if (pattern_dstaddr != NULL)
    {
        sm501fb_Wait_Idle();
        
        /* Load pattern from local video memory into pattern array */
        pattern_read_addr = pattern_src_addr;
        
        for (i = 0; i < (pattern_BPP * 2); i++)
        {
//            pattern[i] = SmRead32m(pattern_read_addr);          bug
            pattern_read_addr += 4;
        }
        
        if (patternX || patternY)
        {
            /* Rotate pattern */
            pjPatByte = (unsigned char*)pattern;
            
            switch (pattern_BPP)
            {
            case 8:
                {
                    for (y = 0; y < 8; y++)
                    {
                        unsigned char* pjBuffer = pattern_dstaddr + ((patternY + y) & 7) * 8;
                        for (x = 0; x < 8; x++)
                        {
                            pjBuffer[(patternX + x) & 7] = pjPatByte[x];
                        }
                        pjPatByte += pattern_stride;
                    }
                    break;
                }
                
            case 16:
                {
                    for (y = 0; y < 8; y++)
                    {
                        unsigned short* pjBuffer = (unsigned short*) pattern_dstaddr + ((patternY + y) & 7) * 8;
                        for (x = 0; x < 8; x++)
                        {
                            pjBuffer[(patternX + x) & 7] = ((unsigned short*) pjPatByte)[x];
                        }
                        pjPatByte += pattern_stride;
                    }
                    break;
                }
                
            case 32:
                {
                    for (y = 0; y < 8; y++)
                    {
                        unsigned long* pjBuffer = (unsigned long*) pattern_dstaddr + ((patternY + y) & 7) * 8;
                        for (x = 0; x < 8; x++)
                        {
                            pjBuffer[(patternX + x) & 7] = ((unsigned long*) pjPatByte)[x];
                        }
                        pjPatByte += pattern_stride;
                    }
                    break;
                }
            }
        }
        else
        {
            /* Don't rotate, just copy pattern into pattern_dstaddr */
            for (i = 0; i < (pattern_BPP * 2); i++)
            {
                ((unsigned long *)pattern_dstaddr)[i] = pattern[i];
            }
        }
        
    }
}


/**********************************************************************
 *
 * deMonoPatternFill
 *
 * Purpose
 *    Copy the specified monochrome pattern into the destination surface
 *
 * Remarks
 *       Pattern size must be 8x8 pixel. 
 *       Pattern color depth must be same as destination bitmap or monochrome.
**********************************************************************/
void deMonoPatternFill(unsigned long dst_base,
                       unsigned long dst_pitch,  
                       unsigned long dst_BPP,
                       unsigned long dstX, 
                       unsigned long dstY,
                       unsigned long dst_width,
                       unsigned long dst_height,
                       unsigned long pattern_FGcolor,
                       unsigned long pattern_BGcolor,
                       unsigned long pattern_low, 
                       unsigned long pattern_high)
{
    sm501fb_Wait_Idle();
    
    SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
    
    SmWrite2D(DE_PITCH, FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |  FIELD_VALUE(0, DE_PITCH, SOURCE, dst_pitch));
    
    SmWrite2D(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));

    SmWrite2D(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, pattern_FGcolor));

    SmWrite2D(DE_BACKGROUND,
        FIELD_VALUE(0, DE_BACKGROUND, COLOR, pattern_BGcolor));

    SmWrite2D(DE_MONO_PATTERN_LOW,
        FIELD_VALUE(0, DE_MONO_PATTERN_LOW, PATTERN, pattern_low));

    SmWrite2D(DE_MONO_PATTERN_HIGH,
        FIELD_VALUE(0, DE_MONO_PATTERN_HIGH, PATTERN, pattern_high));
    
    SmWrite2D(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dstX)      |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dstY));

    SmWrite2D(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
    
    SmWrite2D(DE_CONTROL, 
        FIELD_VALUE(0, DE_CONTROL, ROP, 0xF0) |
        FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
        FIELD_SET(0, DE_CONTROL, PATTERN, MONO)  |
        FIELD_SET(0, DE_CONTROL, STATUS, START));

    sm_accel_busy = 1;
} /* deMonoPatternFill() */

/**********************************************************************
 *
 * deColorPatternFill
 *
 * Purpose
 *    Copy the specified pattern into the destination surface
 *
 * Parameters
 *    [in]
 *        pDestSurface   - Pointer to DE_SURFACE structure containing
 *                         destination surface attributes
 *        nX             - X coordinate of destination surface to be filled
 *        nY             - Y coordinate of destination surface to be filled
 *        dst_width         - Width (in pixels) of area to be filled
 *        dst_height        - Height (in lines) of area to be filled
 *        pPattern       - Pointer to DE_SURFACE structure containing
 *                         pattern attributes
 *        pPatternOrigin - Pointer to Point structure containing pattern origin
 *        pMonoInfo      - Pointer to mono_pattern_info structure
 *        pClipRect      - Pointer to Rect structure describing clipping
 *                         rectangle; NULL if no clipping required
 *
 *    [out]
 *        None
 *
 * Remarks
 *       Pattern size must be 8x8 pixel. 
 *       Pattern color depth must be same as destination bitmap.
**********************************************************************/
void deColorPatternFill(unsigned long dst_base,
                        unsigned long dst_pitch,  
                        unsigned long dst_BPP,  
                        unsigned long dst_X, 
                        unsigned long dst_Y, 
                        unsigned long dst_width,
                        unsigned long dst_height,
                        unsigned long pattern_src_addr,
                        unsigned long pattern_stride,
                        int PatternOriginX,
                        int PatternOriginY)
{
    unsigned int i;
    unsigned long de_data_port_write_addr;
    unsigned char ajPattern[PATTERN_WIDTH * PATTERN_HEIGHT * 4];
    unsigned long de_ctrl = 0;
    
    sm501fb_Wait_Idle();
    
    de_ctrl = FIELD_SET(0, DE_CONTROL, PATTERN, COLOR);
    
    SmWrite2D(DE_CONTROL, de_ctrl);
    
    /* Rotate pattern if necessary */
    deRotatePattern(ajPattern, pattern_src_addr, dst_BPP, pattern_stride, PatternOriginX, PatternOriginY);
    
    /* Load pattern to 2D Engine Data Port */
    de_data_port_write_addr = 0;
    
    for (i = 0; i < (dst_BPP * 2); i++)
    {
        SmWrite2D_DataPort(de_data_port_write_addr, ((unsigned long *)ajPattern)[i]);
        de_data_port_write_addr += 4;
    }
    
    sm501fb_Wait_Idle();

    SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
 
    SmWrite2D(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));

    SmWrite2D(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));

    SmWrite2D(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)      |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));

    SmWrite2D(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
    
    SmWrite2D(DE_CONTROL, 
        FIELD_VALUE(0, DE_CONTROL, ROP, 0xF0) |
        FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
        FIELD_SET(0, DE_CONTROL, PATTERN, COLOR) |
        FIELD_SET(0, DE_CONTROL, STATUS, START));

    sm_accel_busy = 1;
} /* deColorPatternFill() */
#endif

#if 0
/**********************************************************************
 *
 * deCopy
 *
 * Purpose
 *    Copy a rectangular area of the source surface to a destination surface
 *
 * Remarks
 *       Source bitmap must have the same color depth (BPP) as the destination bitmap.
 *
**********************************************************************/
void deCopy(unsigned long dst_base,
            unsigned long dst_pitch,  
            unsigned long dst_BPP,  
            unsigned long dst_X, 
            unsigned long dst_Y, 
            unsigned long dst_width,
            unsigned long dst_height,
            unsigned long src_base, 
            unsigned long src_pitch,  
            unsigned long src_X, 
            unsigned long src_Y, 
            pTransparent pTransp,
            unsigned char nROP2)
{
    unsigned long nDirection = 0;
    unsigned long nTransparent = 0;
    unsigned long opSign = 1;    // Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left
    unsigned long xWidth = 192 / (dst_BPP / 8); // xWidth is in pixels
    unsigned long de_ctrl = 0;
    
    sm501fb_Wait_Idle();

    SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));

    SmWrite2D(DE_WINDOW_SOURCE_BASE, FIELD_VALUE(0, DE_WINDOW_SOURCE_BASE, ADDRESS, src_base));

    if (dst_pitch && src_pitch)
    {
        SmWrite2D(DE_PITCH,
            FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_PITCH, SOURCE,      src_pitch));
        
        SmWrite2D(DE_WINDOW_WIDTH,
            FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      src_pitch));
    }
    
    /* Set transparent bits if necessary */
    if (pTransp != NULL)
    {
        nTransparent = pTransp->match | pTransp->select | pTransp->control;
        
        /* Set color compare register */
        SmWrite2D(DE_COLOR_COMPARE,
            FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR, pTransp->color));
    }
    
    /* Determine direction of operation */
    if (src_Y < dst_Y)
    {
    /* +----------+
    |S         |
    |   +----------+
    |   |      |   |
    |   |      |   |
    +---|------+   |
    |         D|
        +----------+ */
        
        nDirection = BOTTOM_TO_TOP;
    }
    else if (src_Y > dst_Y)
    {
    /* +----------+
    |D         |
    |   +----------+
    |   |      |   |
    |   |      |   |
    +---|------+   |
    |         S|
        +----------+ */
        
        nDirection = TOP_TO_BOTTOM;
    }
    else
    {
        /* src_Y == dst_Y */
        
        if (src_X <= dst_X)
        {
        /* +------+---+------+
        |S     |   |     D|
        |      |   |      |
        |      |   |      |
        |      |   |      |
            +------+---+------+ */
            
            nDirection = RIGHT_TO_LEFT;
        }
        else
        {
            /* src_X > dst_X */
            
            /* +------+---+------+
            |D     |   |     S|
            |      |   |      |
            |      |   |      |
            |      |   |      |
            +------+---+------+ */
            
            nDirection = LEFT_TO_RIGHT;
        }
    }
    
    if ((nDirection == BOTTOM_TO_TOP) || (nDirection == RIGHT_TO_LEFT))
    {
        src_X += dst_width - 1;
        src_Y += dst_height - 1;
        dst_X += dst_width - 1;
        dst_Y += dst_height - 1;
        opSign = (-1);
    }
    
    /* Workaround for 192 byte hw bug */
    if ((nROP2 != 0x0C) && ((dst_width * (dst_BPP / 8)) >= 192))
    {
        /* Perform the ROP2 operation in chunks of (xWidth * dst_height) */
        while (1)
        {
            sm501fb_Wait_Idle();
            SmWrite2D(DE_SOURCE,
                FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
                FIELD_VALUE(0, DE_SOURCE, X_K1, src_X)   |
                FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
            SmWrite2D(DE_DESTINATION,
                FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
                FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)  |
                FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));
            SmWrite2D(DE_DIMENSION,
                FIELD_VALUE(0, DE_DIMENSION, X,    xWidth) |
                FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
            de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, nROP2) |
                nTransparent |
                FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
                FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
                ((nDirection == 1) ? FIELD_SET(0, DE_CONTROL, DIRECTION, RIGHT_TO_LEFT)
                : FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT)) |
                FIELD_SET(0, DE_CONTROL, STATUS, START);
            SmWrite2D(DE_CONTROL, de_ctrl);
            
            src_X += (opSign * xWidth);
            dst_X += (opSign * xWidth);
            dst_width -= xWidth;
            
            if (dst_width <= 0)
            {
                /* ROP2 operation is complete */
                break;
            }
            
            if (xWidth > dst_width)
            {
                xWidth = dst_width;
            }
        }
    }
    else
    {
        sm501fb_Wait_Idle();
        SmWrite2D(DE_SOURCE,
            FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_SOURCE, X_K1, src_X)   |
            FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
        SmWrite2D(DE_DESTINATION,
            FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)  |
            FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));
        SmWrite2D(DE_DIMENSION,
            FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
            FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
        de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, nROP2) |
            nTransparent |
            FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
            FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
            ((nDirection == 1) ? FIELD_SET(0, DE_CONTROL, DIRECTION, RIGHT_TO_LEFT)
            : FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT)) |
            FIELD_SET(0, DE_CONTROL, STATUS, START);
        SmWrite2D(DE_CONTROL, de_ctrl);
    }

    sm_accel_busy = 1;
}
#endif
#if 0
/**********************************************************************
 *
 * deSrcCopyHost
 *
 * Purpose
 *    Copy a rectangular area of the source surface in system memory to
 *    a destination surface in video memory
 *
 * Remarks
 *       Source bitmap must have the same color depth (BPP) as the destination bitmap.
 *
**********************************************************************/
void deSrcCopyHost(unsigned long dst_base, 
                   unsigned long dst_pitch,  
                   unsigned long dst_BPP,  
                   unsigned long dst_X, 
                   unsigned long dst_Y,
                   unsigned long dst_width, 
                   unsigned long dst_height, 
                   unsigned long src_base, 
                   unsigned long src_stride,  
                   unsigned long src_X, 
                   unsigned long src_Y,
                   pTransparent pTransp,
                   unsigned char nROP2)
{
    int nBytes_per_scan;
    int nBytes8_per_scan;
    int nBytes_remain;
    int nLong;
    unsigned long nTransparent = 0;
    unsigned long de_ctrl = 0;
    unsigned long i;
    int j;
    unsigned long ulSrc;
    unsigned long de_data_port_write_addr;
    unsigned char abyRemain[8] = {0, 0, 0, 0, 0, 0, 0, 0};
    unsigned char *pSrcBuffer;
    
    pSrcBuffer = (unsigned char*)(src_base + src_Y * src_stride + src_X * (dst_BPP / 8));

    nBytes_per_scan = dst_width * (dst_BPP / 8);
    nBytes8_per_scan = (nBytes_per_scan + 7) & ~7;
    nBytes_remain = nBytes_per_scan & 7;
    nLong = nBytes_per_scan & ~7;
    
    /* Program 2D Drawing Engine */
    sm501fb_Wait_Idle();

    /* Set transparent bits if necessary */
    if (pTransp != NULL)
    {
        nTransparent = pTransp->match | pTransp->select | pTransp->control;
        
        /* Set color compare register */
        SmWrite2D(DE_COLOR_COMPARE,
            FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR, pTransp->color));
    }
    
    SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
    
    SmWrite2D(DE_WINDOW_SOURCE_BASE, FIELD_VALUE(0, DE_WINDOW_SOURCE_BASE, ADDRESS, 0));
    
    SmWrite2D(DE_SOURCE,
        FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_SOURCE, X_K1, 0)       |
        FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
    SmWrite2D(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)  |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));
    SmWrite2D(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
    SmWrite2D(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_width) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_width));
    SmWrite2D(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_width) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_width));
    de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, nROP2) |
        nTransparent |
        FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
        FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) |
        FIELD_SET(0, DE_CONTROL, STATUS, START);
    SmWrite2D(DE_CONTROL, de_ctrl);
    
    /* Write bitmap/image data (line by line) to 2D Engine data port */
    de_data_port_write_addr = 0;
    
    for (i = 1; i < dst_height; i++)
    {
        for (j = 0; j < (nBytes8_per_scan / 4); j++)
        {
            memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
            SmWrite2D_DataPort(de_data_port_write_addr, ulSrc);
        }
        
        pSrcBuffer += src_stride;
    }
    
    /* Special handling for last line of bitmap */
    if (nLong)
    {
        for (j = 0; j < (nLong / 4); j++)
        {
            memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
            SmWrite2D_DataPort(de_data_port_write_addr, ulSrc);
        }
    }
    
    if (nBytes_remain)
    {
        memcpy(abyRemain, (pSrcBuffer + nLong), nBytes_remain);
        SmWrite2D_DataPort(de_data_port_write_addr, *(unsigned long*)abyRemain);
        SmWrite2D_DataPort(de_data_port_write_addr, *(unsigned long*)(abyRemain + 4));
    }

    sm_accel_busy = 1;
}


/**********************************************************************
 *
 * deMonoSrcCopyHost
 *
 * Purpose
 *    Copy a rectangular area of the monochrome source surface in 
 *    system memory to a destination surface in video memory
 *
 * Parameters
 *    [in]
 *        pSrcSurface  - Pointer to DE_SURFACE structure containing
 *                       source surface attributes
 *        pSrcBuffer   - Pointer to source buffer (system memory)
 *                       containing monochrome image
 *        src_X        - X coordinate of source surface
 *        src_Y        - Y coordinate of source surface
 *        pDestSurface - Pointer to DE_SURFACE structure containing
 *                       destination surface attributes
 *        dst_X       - X coordinate of destination surface
 *        dst_Y       - Y coordinate of destination surface
 *        dst_width       - Width (in pixels) of the area to be copied
 *        dst_height      - Height (in lines) of the area to be copied
 *        nFgColor     - Foreground color
 *        nBgColor     - Background color
 *        pClipRect    - Pointer to Rect structure describing clipping
 *                       rectangle; NULL if no clipping required
 *        pTransp      - Pointer to Transparent structure containing
 *                       transparency settings; NULL if no transparency
 *                       required
 *
 *    [out]
 *        None
 *
 * Returns
 *    DDK_OK                      - function is successful
 *    DDK_ERROR_NULL_PSRCSURFACE  - pSrcSurface is NULL
 *    DDK_ERROR_NULL_PDESTSURFACE - pDestSurface is NULL
 *
**********************************************************************/
void deMonoSrcCopyHost(unsigned long dst_base, 
                      unsigned long dst_pitch,  
                      unsigned long dst_BPP,  
                      unsigned long dst_X, 
                      unsigned long dst_Y,
                      unsigned long dst_width, 
                      unsigned long dst_height, 
                      unsigned long src_base, 
                      unsigned long src_stride,  
                      unsigned long src_X, 
                      unsigned long src_Y,
                      unsigned long nFgColor, 
                      unsigned long nBgColor,
                      pTransparent pTransp)
{
    int nLeft_bits_off;
    int nBytes_per_scan;
    int nBytes4_per_scan;
    int nBytes_remain;
    int nLong;
    unsigned long nTransparent = 0;
    unsigned long de_ctrl = 0;
    unsigned long de_data_port_write_addr;
    unsigned long i;
    int j;
	unsigned long ulSrc;
    unsigned char * pSrcBuffer;

    pSrcBuffer = (unsigned char *)src_base+(src_Y * src_stride) + (src_X / 8);
    nLeft_bits_off = (src_X & 0x07);
    nBytes_per_scan = (dst_width + nLeft_bits_off + 7) / 8;
    nBytes4_per_scan = (nBytes_per_scan + 3) & ~3;
    nBytes_remain = nBytes_per_scan & 3;
    nLong = nBytes_per_scan & ~3;

    sm501fb_Wait_Idle();
    
    /* Set transparent bits if necessary */
    if (pTransp != NULL)
    {
        nTransparent = pTransp->match | pTransp->select | pTransp->control;
        
        /* Set color compare register */
        SmWrite2D(DE_COLOR_COMPARE,
            FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR, pTransp->color));
    }
    
    /* Program 2D Drawing Engine */

    SmWrite2D(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));

    SmWrite2D(DE_WINDOW_SOURCE_BASE, FIELD_VALUE(0, DE_WINDOW_SOURCE_BASE, ADDRESS, 0));

    SmWrite2D(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
    
    SmWrite2D(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));

    SmWrite2D(DE_SOURCE,
        FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE)        |
        FIELD_VALUE(0, DE_SOURCE, X_K1, nLeft_bits_off) |
        FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));

    SmWrite2D(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)  |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));

    SmWrite2D(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));

    SmWrite2D(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, nFgColor));

    SmWrite2D(DE_BACKGROUND,
        FIELD_VALUE(0, DE_BACKGROUND, COLOR, nBgColor));
    
    de_ctrl = 0x0000000C |
        FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
        FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) |
        FIELD_SET(0, DE_CONTROL, HOST, MONO) |
        nTransparent |
        FIELD_SET(0, DE_CONTROL, STATUS, START);
    SmWrite2D(DE_CONTROL, de_ctrl);
    
    /* Write bitmap/image data (line by line) to 2D Engine data port */
    de_data_port_write_addr = 0;
    
    for (i = 1; i < dst_height; i++)
    {
        for (j = 0; j < (nBytes4_per_scan / 4); j++)
        {
            memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
            SmWrite2D_DataPort(de_data_port_write_addr, ulSrc);
        }
        
        pSrcBuffer += src_stride;
    }
    
    /* Special handling for last line of bitmap */
    if (nLong)
    {
        for (j = 0; j < (nLong / 4); j++)
        {
            memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
            SmWrite2D_DataPort(de_data_port_write_addr, ulSrc);
        }
    }
    
    if (nBytes_remain)
    {
        memcpy(&ulSrc, (pSrcBuffer + nLong), nBytes_remain);
        SmWrite2D_DataPort(de_data_port_write_addr, ulSrc);
    }

    sm_accel_busy = 1;
}
/**********************************************************************
*
 * Misc. functions
 *
 **********************************************************************/
// Load 8x8 pattern into local video memory
void deLoadPattern(unsigned char* pattern, unsigned long write_addr)
{
    int i;

    for (i = 0; i < (8 * 8 * 2); i += 4)
    {
//        SmWrite32m(write_addr, *(unsigned long*)(&pattern[i]));    bug
        write_addr += 4;
    }
}
#endif

/*
 * System memory to Video memory monochrome expansion.
 * Source is monochrome image in system memory.
 * This function expands the monochrome data to color image in video memory.
 */
long deSystemMem2VideoMemMonoBlt(
unsigned char *pSrcbuf, /* pointer to start of source buffer in system memory */
long srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
unsigned long startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
unsigned long dBase,    /* Address of destination: offset in frame buffer */
unsigned long dPitch,   /* Pitch value of destination surface in BYTE */
unsigned long bpp,      /* Color depth of destination surface */
unsigned long dx,
unsigned long dy,       /* Starting coordinate of destination surface */
unsigned long width, 
unsigned long height,   /* width and height of rectange in pixel value */
unsigned long fColor,   /* Foreground color (corresponding to a 1 in the monochrome data */
unsigned long bColor,   /* Background color (corresponding to a 0 in the monochrome data */
unsigned long rop2)     /* ROP value */
{
    unsigned long bytePerPixel;
    unsigned long ulBytesPerScan;
    unsigned long ul4BytesPerScan;
    unsigned long ulBytesRemain;
    unsigned long de_ctrl = 0;
    unsigned char ajRemain[4];
    long i, j;

    bytePerPixel = bpp/8;

    startBit &= 7; /* Just make sure the start bit is within legal range */
    ulBytesPerScan = (width + startBit + 7) / 8;
    ul4BytesPerScan = ulBytesPerScan & ~3;
    ulBytesRemain = ulBytesPerScan & 3;


	sm501fb_Wait_Idle();
    
    /* 2D Source Base.
       Use 0 for HOST Blt.
    */
    SmWrite2D(DE_WINDOW_SOURCE_BASE, 0);

    /* 2D Destination Base.
       It is an address offset (128 bit aligned) from the beginning of frame buffer.
    */
    SmWrite2D(DE_WINDOW_DESTINATION_BASE, dBase);

    /* Program pitch (distance between the 1st points of two adjacent lines).
       Note that input pitch is BYTE value, but the 2D Pitch register uses
       pixel values. Need Byte to pixel convertion.
    */

#if 1
    	SmWrite2D(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dPitch/bytePerPixel) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dPitch/bytePerPixel));
#else
    	SmWrite2D(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, width*bpp/8) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,     width/8));
#endif
    /* Screen Window width in Pixels.
       2D engine uses this value to calculate the linear address in frame buffer for a given point.
    */
    SmWrite2D(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/bytePerPixel)) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (dPitch/bytePerPixel)));

    /* Note: For 2D Source in Host Write, only X_K1 field is needed, and Y_K2 field is not used.
             For mono bitmap, use startBit for X_K1. */
    SmWrite2D(DE_SOURCE,
        FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE)  |
        FIELD_VALUE(0, DE_SOURCE, X_K1, startBit) |
        FIELD_VALUE(0, DE_SOURCE, Y_K2, 0));

    SmWrite2D(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dx)    |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dy));

    SmWrite2D(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, height));

    SmWrite2D(DE_FOREGROUND, fColor);
    SmWrite2D(DE_BACKGROUND, bColor);
    

	
    de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, rop2)         |
              FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2)    |
              FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) |
              FIELD_SET(0, DE_CONTROL, HOST, MONO)          |
              FIELD_SET(0, DE_CONTROL, STATUS, START);

    SmWrite2D(DE_CONTROL, de_ctrl);

    /* Write MONO data (line by line) to 2D Engine data port */
    for (i=0; i<height; i++)
    {
        /* For each line, send the data in chunks of 4 bytes */
        for (j=0; j<(ul4BytesPerScan/4); j++)
        {
            SmWrite32(DE_DATA_PORT, *(unsigned long *)(pSrcbuf + (j * 4)));
        }

        if (ulBytesRemain)
        {
            memcpy(ajRemain, pSrcbuf+ul4BytesPerScan, ulBytesRemain);
            SmWrite32(DE_DATA_PORT, *(unsigned long *)ajRemain);
        }

        pSrcbuf += srcDelta;
    }
	
    	return 0;
}

/* 
 * System memory to Video memory data transfer
 * Note: 
 *         We also call it HOST Blt.
 *        This function is a one to one transfer without stretching or 
 *        mono expansion.
 */
 #if 0
long deSystemMem2VideoMemBlt(
unsigned char *pSrcbuf, /* pointer to source data in system memory */
long srcDelta,          /* width (in Bytes) of the source data, +ive means top down and -ive mean button up */
unsigned long dBase,    /* Address of destination: offset in frame buffer */
unsigned long dPitch,   /* Pitch value of destination surface in BYTE */
unsigned long bpp,      /* Color depth of destination surface */
unsigned long dx,
unsigned long dy,       /* Starting coordinate of destination surface */
unsigned long width, 
unsigned long height,   /* width and height of rectange in pixel value */
unsigned long rop2)     /* ROP value */
{
    unsigned long bytePerPixel;
    unsigned long ulBytesPerScan;
    unsigned long ul8BytesPerScan;
    unsigned long ulBytesRemain;
    unsigned long de_ctrl = 0;
    unsigned char ajRemain[8];
    long i, j;

    bytePerPixel = bpp/8;

    /* HOST blt data port must take multiple of 8 bytes as input.
       If the source width does not match that requirement,
       we need to split it into two portions. The first portion
       is 8 byte multiple. The 2nd portion is the remaining bytes.
       The remaining bytes will be buffered to an 8 byte array and
       and send it to the host blt data port.
    */
    ulBytesPerScan = width * bpp / 8;
    ul8BytesPerScan = ulBytesPerScan & ~7;
    ulBytesRemain = ulBytesPerScan & 7;

    /* Program 2D Drawing Engine */
    if (deWaitForNotBusy() != 0)
    {
        /* The 2D engine is always busy for some unknown reason.
           Application can choose to return ERROR, or reset it and
           continue the operation.
        */

        return -1;

        /* or */
        /* deReset(); */
    }

    /* 2D Source Base.
       Use 0 for HOST Blt.
    */
    POKE_32(DE_WINDOW_SOURCE_BASE, 0);

    /* 2D Destination Base.
       It is an address offset (128 bit aligned) from the beginning of frame buffer.
    */
    POKE_32(DE_WINDOW_DESTINATION_BASE, dBase);

    /* Program pitch (distance between the 1st points of two adjacent lines).
       Note that input pitch is BYTE value, but the 2D Pitch register uses
       pixel values. Need Byte to pixel convertion.
    */
    POKE_32(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dPitch/bytePerPixel) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dPitch/bytePerPixel));

    /* Screen Window width in Pixels.
       2D engine uses this value to calculate the linear address in frame buffer for a given point.
    */
    POKE_32(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/bytePerPixel)) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (dPitch/bytePerPixel)));

    /* Note: For 2D Source in Host Write, only X_K1 field is needed, and Y_K2 field is not used.
             For 1 to 1 bitmap transfer, use 0 for X_K1 means source alignment from byte 0. */
    POKE_32(DE_SOURCE,
        FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_SOURCE, X_K1, 0)       |
        FIELD_VALUE(0, DE_SOURCE, Y_K2, 0));

    POKE_32(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dx)    |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dy));

    POKE_32(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, height));
        
    /* Set the pixel format of the destination */
    deSetPixelFormat(bpp);

   
        FIELD_VALUE(0, DE_CONTROL, ROP, rop2)         |
        FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2)    |
        FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) |
        FIELD_SET(0, DE_CONTROL, HOST, COLOR)         |
        FIELD_SET(0, DE_CONTROL, STATUS, START);

    POKE_32(DE_CONTROL, de_ctrl | deGetTransparency());

    /* Write bitmap/image data (line by line) to 2D Engine data port */
    for (i = 0; i < height; i++)
    {
        /* For each line, send the data in chunks of 4 bytes. */
        for (j=0; j < (ul8BytesPerScan/4);  j++)
            POKE_32(DE_DATA_PORT, *(unsigned long *)(pSrcbuf + (j * 4)));

        if (ulBytesRemain)
        {
            memcpy(ajRemain, pSrcbuf+ul8BytesPerScan, ulBytesRemain);
            POKE_32(DE_DATA_PORT, *(unsigned long *)ajRemain);
            POKE_32(DE_DATA_PORT, *(unsigned long *)(ajRemain+4));
        }

        pSrcbuf += srcDelta;
    }

    return 0;
}
#endif

#if 0
void sm_imageblt(struct fb_info *info, const struct fb_image *image)
{
	ulong fgcolor,bgcolor;
	struct sm501fb_par *p = (struct sm501fb_par*)info->par;

	//if (info->state != FBINFO_STATE_RUNNING)
	//	return;
	
	//if (info->fbops->fb_sync)
	//	info->fbops->fb_sync(info);

	sm501fb_Wait_Idle();
	

	if(image->depth==1)
	{
		if (info->fix.visual == FB_VISUAL_TRUECOLOR ||info->fix.visual == FB_VISUAL_DIRECTCOLOR) 
		{
			fgcolor = ((u32*)(info->pseudo_palette))[image->fg_color];
			bgcolor = ((u32*)(info->pseudo_palette))[image->bg_color];
		} 
		else
		{
			fgcolor = image->fg_color;
			bgcolor = image->bg_color;
		}	
		 deSystemMem2VideoMemMonoBlt(	
		 	image->data,                                                 /* pointer to start of source buffer in system memory */
		 	image->width/8,                                            /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
		 	0,                                                                     /* Mono data can start at any bit in a byte, this value should be 0 to 7 */				
		 	p->screen.sm_addr,                                       /* Address of destination: offset in frame buffer */			 	
		 	info->fix.line_length,                                   /* Pitch value of destination surface in BYTE */
		 	info->var.bits_per_pixel,                                /* Color depth of destination surface */				
		 	image->dx,		                                        /* Starting coordinate of destination surface */
		 	image->dy,                   				
		 	image->width, 	                                        /* width and height of rectange in pixel value */		
		 	image->height,             				
		 	fgcolor,                                                              /* Foreground color (corresponding to a 1 in the monochrome data */				
		 	bgcolor,                                                             /* Background color (corresponding to a 0 in the monochrome data */				
		 	0x0C		 	
		 	);		 
	}
	else
	{
		cfb_imageblit(info,image);
	}
	sm_accel_busy = 1;	
}
#endif


/*
 * Video Memory to Video Memory data transfer.
 * Note: 
 *        It works whether the Video Memroy is off-screeen or on-screen.
 *        This function is a one to one transfer without stretching or 
 *        mono expansion.
 */
long deVideoMem2VideoMemBlt(
unsigned long sBase,  /* Address of source: offset in frame buffer */
unsigned long sPitch, /* Pitch value of source surface in BYTE */
unsigned long sx,
unsigned long sy,     /* Starting coordinate of source surface */
unsigned long dBase,  /* Address of destination: offset in frame buffer */
unsigned long dPitch, /* Pitch value of destination surface in BYTE */
unsigned long bpp,    /* Color depth of destination surface */
unsigned long dx,
unsigned long dy,     /* Starting coordinate of destination surface */
unsigned long width, 
unsigned long height, /* width and height of rectangle in pixel value */
unsigned long rop2)   /* ROP value */
{
    unsigned long nDirection, de_ctrl, bytePerPixel;
    long opSign;


    nDirection = LEFT_TO_RIGHT;
    opSign = 1;    /* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
    bytePerPixel = bpp/8;
    de_ctrl = 0;

    /* If source and destination are the same surface, need to check for overlay cases */
    if (sBase == dBase && sPitch == dPitch)
    {
        /* Determine direction of operation */
        if (sy < dy)
        {
            /* +----------+
               |S         |
               |   +----------+
               |   |      |   |
               |   |      |   |
               +---|------+   |
                   |         D|
                   +----------+ */
    
            nDirection = BOTTOM_TO_TOP;
        }
        else if (sy > dy)
        {
            /* +----------+
               |D         |
               |   +----------+
               |   |      |   |
               |   |      |   |
               +---|------+   |
                   |         S|
                   +----------+ */
    
            nDirection = TOP_TO_BOTTOM;
        }
        else
        {
            /* sy == dy */
    
            if (sx <= dx)
            {
                /* +------+---+------+
                   |S     |   |     D|
                   |      |   |      |
                   |      |   |      |
                   |      |   |      |
                   +------+---+------+ */
    
                nDirection = RIGHT_TO_LEFT;
            }
            else
            {
                /* sx > dx */
    
                /* +------+---+------+
                   |D     |   |     S|
                   |      |   |      |
                   |      |   |      |
                   |      |   |      |
                   +------+---+------+ */
    
                nDirection = LEFT_TO_RIGHT;
            }
        }
    }

    if ((nDirection == BOTTOM_TO_TOP) || (nDirection == RIGHT_TO_LEFT))
    {
        sx += width - 1;
        sy += height - 1;
        dx += width - 1;
        dy += height - 1;
        opSign = (-1);
    }

    /* Note:
       DE_FOREGROUND are DE_BACKGROUND are don't care.
       DE_COLOR_COMPARE and DE_COLOR_COMPARE_MAKS are set by set deSetTransparency().
    */

    /* 2D Source Base.
       It is an address offset (128 bit aligned) from the beginning of frame buffer.
    */
    SmWrite2D(DE_WINDOW_SOURCE_BASE, sBase);

    /* 2D Destination Base.
       It is an address offset (128 bit aligned) from the beginning of frame buffer.
    */
    SmWrite2D(DE_WINDOW_DESTINATION_BASE, dBase);

    /* Program pitch (distance between the 1st points of two adjacent lines).
       Note that input pitch is BYTE value, but the 2D Pitch register uses
       pixel values. Need Byte to pixel convertion.
    */
    SmWrite2D(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, (dPitch/bytePerPixel)) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      (sPitch/bytePerPixel)));

    /* Screen Window width in Pixels.
       2D engine uses this value to calculate the linear address in frame buffer for a given point.
    */
    SmWrite2D(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/bytePerPixel)) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (sPitch/bytePerPixel)));

	sm501fb_Wait_Idle();

        SmWrite2D(DE_SOURCE,
            FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_SOURCE, X_K1, sx)   |
            FIELD_VALUE(0, DE_SOURCE, Y_K2, sy));
        SmWrite2D(DE_DESTINATION,
            FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_DESTINATION, X,    dx)  |
            FIELD_VALUE(0, DE_DESTINATION, Y,    dy));
        SmWrite2D(DE_DIMENSION,
            FIELD_VALUE(0, DE_DIMENSION, X,    width) |
            FIELD_VALUE(0, DE_DIMENSION, Y_ET, height));

        de_ctrl = 
            FIELD_VALUE(0, DE_CONTROL, ROP, rop2) |
            FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
            FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
            ((nDirection == RIGHT_TO_LEFT) ? 
            FIELD_SET(0, DE_CONTROL, DIRECTION, RIGHT_TO_LEFT)
            : FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT)) |
            FIELD_SET(0, DE_CONTROL, STATUS, START);
		
		SmWrite2D(DE_CONTROL,de_ctrl);

    	return 0;
}


