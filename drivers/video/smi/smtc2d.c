/*
 *  linux/drivers/video/smtc2d.c -- Silicon Motion SM501 and SM7xx 2D drawing engine functions.
 *
 *      Copyright (C) 2006 Silicon Motion Technology Corp.
 *      Boyod boyod.yang@siliconmotion.com.cn
 *
 *  This file is subject to the terms and conditions of the GNU General Public
 *  License version 2 or later as published by the Free Software Foundation. 
 *
 *
 * Version 0.10.26192.21.01
    - Add PowerPC support
	- Add 2D support for Lynx
    - Verified on 2.6.19.2                          Boyod.yang  <boyod.yang@siliconmotion.com.cn>
*/

unsigned char smtc_de_busy = 0;
void SMTC_write2Dreg(unsigned long nOffset, unsigned long nData)
{
    writel(nData, smtc_2DBaseAddress+nOffset) ;
}

unsigned long SMTC_read2Dreg(unsigned long nOffset)
{
    readl(smtc_2DBaseAddress+nOffset) ;
}


void SMTC_write2Ddataport(unsigned long nOffset, unsigned long nData)
{
    writel(nData, smtc_2Ddataport+nOffset);
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
	unsigned char gate, clock;
	clock = smtc_seqr(0x21);
	// Enable 2D Drawing Engine
	smtc_seqw(0x21,clock& 0xF8);
	
	SMTC_write2Dreg(DE_CLIP_TL,
		FIELD_VALUE(0, DE_CLIP_TL, TOP,     0)       |
		FIELD_SET  (0, DE_CLIP_TL, STATUS,  DISABLE) |
		FIELD_SET  (0, DE_CLIP_TL, INHIBIT, OUTSIDE) |
		FIELD_VALUE(0, DE_CLIP_TL, LEFT,    0));

	if (bpp>=24){
	    SMTC_write2Dreg(DE_PITCH,
			FIELD_VALUE(0, DE_PITCH, DESTINATION, nModeWidth*3) |
			FIELD_VALUE(0, DE_PITCH, SOURCE,      nModeWidth*3));
	}else{
	    SMTC_write2Dreg(DE_PITCH,
			FIELD_VALUE(0, DE_PITCH, DESTINATION, nModeWidth) |
			FIELD_VALUE(0, DE_PITCH, SOURCE,      nModeWidth));
	}
	
    SMTC_write2Dreg(DE_WINDOW_WIDTH,
		FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, nModeWidth) |
		FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      nModeWidth));

    switch (bpp)
    {
    case 8:
        SMTC_write2Dreg(DE_STRETCH_FORMAT,
            FIELD_SET  (0, DE_STRETCH_FORMAT, PATTERN_XY,    NORMAL) |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_Y,     0)      |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,     0)      |
            FIELD_SET  (0, DE_STRETCH_FORMAT, PIXEL_FORMAT,  8)      |
            FIELD_SET  (0, DE_STRETCH_FORMAT, ADDRESSING,	 XY)     |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, SOURCE_HEIGHT, 3));
        break;
    case 24:
        SMTC_write2Dreg(DE_STRETCH_FORMAT,
            FIELD_SET  (0, DE_STRETCH_FORMAT, PATTERN_XY,    NORMAL) |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_Y,     0)      |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,     0)      |
            FIELD_SET  (0, DE_STRETCH_FORMAT, PIXEL_FORMAT,  24)     |
            FIELD_SET  (0, DE_STRETCH_FORMAT, ADDRESSING,	 XY)     |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, SOURCE_HEIGHT, 3));
        break;
    case 16:
    default:
        SMTC_write2Dreg(DE_STRETCH_FORMAT,
            FIELD_SET  (0, DE_STRETCH_FORMAT, PATTERN_XY,    NORMAL) |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_Y,     0)      |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, PATTERN_X,     0)      |
            FIELD_SET  (0, DE_STRETCH_FORMAT, PIXEL_FORMAT,  16)     |
            FIELD_SET  (0, DE_STRETCH_FORMAT, ADDRESSING,	 XY)     |
            FIELD_VALUE(0, DE_STRETCH_FORMAT, SOURCE_HEIGHT, 3));
        break;
    }

	SMTC_write2Dreg(DE_MASKS,
		FIELD_VALUE(0, DE_MASKS, BYTE_MASK, 0xFFFF) |
		FIELD_VALUE(0, DE_MASKS, BIT_MASK,  0xFFFF));
	SMTC_write2Dreg(DE_COLOR_COMPARE_MASK,
		FIELD_VALUE(0, DE_COLOR_COMPARE_MASK, MASKS, 0xFFFFFF));
	SMTC_write2Dreg(DE_COLOR_COMPARE,
		FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR, 0xFFFFFF));
}


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
    
    SMTC_write2Dreg(DE_CLIP_TL,
        FIELD_VALUE(0, DE_CLIP_TL, TOP,     top) |
        FIELD_SET  (0, DE_CLIP_TL, STATUS,  ENABLE)         |
        FIELD_SET  (0, DE_CLIP_TL, INHIBIT, OUTSIDE)        |
        FIELD_VALUE(0, DE_CLIP_TL, LEFT,    left));
    SMTC_write2Dreg(DE_CLIP_BR,
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
    deWaitForNotBusy();

    SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));

	SMTC_write2Dreg(DE_PITCH,
		FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
		FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
    
	SMTC_write2Dreg(DE_WINDOW_WIDTH,
		FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
		FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));

    SMTC_write2Dreg(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));

    SMTC_write2Dreg(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    nX)      |
        FIELD_VALUE(0, DE_DESTINATION, Y,    nY));

    SMTC_write2Dreg(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    1) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));

    SMTC_write2Dreg(DE_CONTROL,
        FIELD_SET  (0, DE_CONTROL, STATUS,     START)         |
        FIELD_SET  (0, DE_CONTROL, DIRECTION,  LEFT_TO_RIGHT) |
        FIELD_SET  (0, DE_CONTROL, MAJOR,      Y)             |
        FIELD_SET  (0, DE_CONTROL, STEP_X,     NEGATIVE)      |
        FIELD_SET  (0, DE_CONTROL, STEP_Y,     POSITIVE)      |
        FIELD_SET  (0, DE_CONTROL, LAST_PIXEL, OFF)           |
        FIELD_SET  (0, DE_CONTROL, COMMAND,    SHORT_STROKE)  |
        FIELD_SET  (0, DE_CONTROL, ROP_SELECT, ROP2)          |
        FIELD_VALUE(0, DE_CONTROL, ROP,        0x0C));
    
    smtc_de_busy = 1;
}

void deHorizontalLine(unsigned long dst_base,
                      unsigned long dst_pitch, 
                      unsigned long nX, 
                      unsigned long nY, 
                      unsigned long dst_width, 
                      unsigned long nColor)
{
    deWaitForNotBusy();
    
    SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
    
    SMTC_write2Dreg(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
    
    SMTC_write2Dreg(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));
    SMTC_write2Dreg(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
    SMTC_write2Dreg(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    nX)      |
        FIELD_VALUE(0, DE_DESTINATION, Y,    nY));
    SMTC_write2Dreg(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, 1));
    SMTC_write2Dreg(DE_CONTROL,
        FIELD_SET  (0, DE_CONTROL, STATUS,     START)         |
        FIELD_SET  (0, DE_CONTROL, DIRECTION,  RIGHT_TO_LEFT) |
        FIELD_SET  (0, DE_CONTROL, MAJOR,      X)             |
        FIELD_SET  (0, DE_CONTROL, STEP_X,     POSITIVE)      |
        FIELD_SET  (0, DE_CONTROL, STEP_Y,     NEGATIVE)      |
        FIELD_SET  (0, DE_CONTROL, LAST_PIXEL, OFF)           |
        FIELD_SET  (0, DE_CONTROL, COMMAND,    SHORT_STROKE)  |
        FIELD_SET  (0, DE_CONTROL, ROP_SELECT, ROP2)          |
        FIELD_VALUE(0, DE_CONTROL, ROP,        0x0C));

    smtc_de_busy = 1;
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
        deWaitForNotBusy();
        
        SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
        
        SMTC_write2Dreg(DE_PITCH,
            FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
        
        SMTC_write2Dreg(DE_WINDOW_WIDTH,
            FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));
        
        SMTC_write2Dreg(DE_FOREGROUND,
            FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
        
        SMTC_write2Dreg(DE_DESTINATION,
            FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_DESTINATION, X,    1)       |
            FIELD_VALUE(0, DE_DESTINATION, Y,    nY1));
        
        SMTC_write2Dreg(DE_DIMENSION,
            FIELD_VALUE(0, DE_DIMENSION, X,    1) |
            FIELD_VALUE(0, DE_DIMENSION, Y_ET, DeltaX));
        
        SMTC_write2Dreg(DE_CONTROL,
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
        
        deWaitForNotBusy();
        
        SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
        
        SMTC_write2Dreg(DE_PITCH,
            FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
        
        SMTC_write2Dreg(DE_WINDOW_WIDTH,
            FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));
        
        SMTC_write2Dreg(DE_FOREGROUND,
            FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));
        
        SMTC_write2Dreg(DE_SOURCE,
            FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_SOURCE, X_K1, k1)      |
            FIELD_VALUE(0, DE_SOURCE, Y_K2, k2));
        
        SMTC_write2Dreg(DE_DESTINATION,
            FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_DESTINATION, X,    nX1)     |
            FIELD_VALUE(0, DE_DESTINATION, Y,    nY1));
        
        SMTC_write2Dreg(DE_DIMENSION,
            FIELD_VALUE(0, DE_DIMENSION, X,    w) |
            FIELD_VALUE(0, DE_DIMENSION, Y_ET, et));
        
        SMTC_write2Dreg(DE_CONTROL,
            FIELD_SET(nCommand, DE_CONTROL, COMMAND, LINE_DRAW));
    }

    smtc_de_busy = 1;
}


void deFillRect(unsigned long dst_base,
                unsigned long dst_pitch,  
                unsigned long dst_X, 
                unsigned long dst_Y, 
                unsigned long dst_width, 
                unsigned long dst_height, 
                unsigned long nColor)
{
    deWaitForNotBusy();

    SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
    
    if (dst_pitch)
    {
        SMTC_write2Dreg(DE_PITCH,
            FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
        
        SMTC_write2Dreg(DE_WINDOW_WIDTH,
            FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));
    }

    SMTC_write2Dreg(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, nColor));

    SMTC_write2Dreg(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)     |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));

    SMTC_write2Dreg(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));

    SMTC_write2Dreg(DE_CONTROL,
        FIELD_SET  (0, DE_CONTROL, STATUS,     START)          |
        FIELD_SET  (0, DE_CONTROL, DIRECTION,  LEFT_TO_RIGHT)  |
        FIELD_SET  (0, DE_CONTROL, LAST_PIXEL, OFF)            |
        FIELD_SET  (0, DE_CONTROL, COMMAND,    RECTANGLE_FILL) |
        FIELD_SET  (0, DE_CONTROL, ROP_SELECT, ROP2)           |
        FIELD_VALUE(0, DE_CONTROL, ROP,        0x0C));

    smtc_de_busy = 1;
}


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
        deWaitForNotBusy();
        
        /* Load pattern from local video memory into pattern array */
        pattern_read_addr = pattern_src_addr;
        
        for (i = 0; i < (pattern_BPP * 2); i++)
        {
//            pattern[i] = memRead32(pattern_read_addr);       removed by boyod
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
    deWaitForNotBusy();
    
    SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
    
    SMTC_write2Dreg(DE_PITCH, FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |  FIELD_VALUE(0, DE_PITCH, SOURCE, dst_pitch));
    
    SMTC_write2Dreg(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));

    SMTC_write2Dreg(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, pattern_FGcolor));

    SMTC_write2Dreg(DE_BACKGROUND,
        FIELD_VALUE(0, DE_BACKGROUND, COLOR, pattern_BGcolor));

    SMTC_write2Dreg(DE_MONO_PATTERN_LOW,
        FIELD_VALUE(0, DE_MONO_PATTERN_LOW, PATTERN, pattern_low));

    SMTC_write2Dreg(DE_MONO_PATTERN_HIGH,
        FIELD_VALUE(0, DE_MONO_PATTERN_HIGH, PATTERN, pattern_high));
    
    SMTC_write2Dreg(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dstX)      |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dstY));

    SMTC_write2Dreg(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
    
    SMTC_write2Dreg(DE_CONTROL, 
        FIELD_VALUE(0, DE_CONTROL, ROP, 0xF0) |
        FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
        FIELD_SET(0, DE_CONTROL, PATTERN, MONO)  |
        FIELD_SET(0, DE_CONTROL, STATUS, START));

    smtc_de_busy = 1;
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
    
    deWaitForNotBusy();
    
    de_ctrl = FIELD_SET(0, DE_CONTROL, PATTERN, COLOR);
    
    SMTC_write2Dreg(DE_CONTROL, de_ctrl);
    
    /* Rotate pattern if necessary */
    deRotatePattern(ajPattern, pattern_src_addr, dst_BPP, pattern_stride, PatternOriginX, PatternOriginY);
    
    /* Load pattern to 2D Engine Data Port */
    de_data_port_write_addr = 0;
    
    for (i = 0; i < (dst_BPP * 2); i++)
    {
        SMTC_write2Ddataport(de_data_port_write_addr, ((unsigned long *)ajPattern)[i]);
        de_data_port_write_addr += 4;
    }
    
    deWaitForNotBusy();

    SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
 
    SMTC_write2Dreg(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));

    SMTC_write2Dreg(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));

    SMTC_write2Dreg(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)      |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));

    SMTC_write2Dreg(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
    
    SMTC_write2Dreg(DE_CONTROL, 
        FIELD_VALUE(0, DE_CONTROL, ROP, 0xF0) |
        FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
        FIELD_SET(0, DE_CONTROL, PATTERN, COLOR) |
        FIELD_SET(0, DE_CONTROL, STATUS, START));

    smtc_de_busy = 1;
} /* deColorPatternFill() */


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
    
    deWaitForNotBusy();


    SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));

    SMTC_write2Dreg(DE_WINDOW_SOURCE_BASE, FIELD_VALUE(0, DE_WINDOW_SOURCE_BASE, ADDRESS, src_base));

    if (dst_pitch && src_pitch)
    {
        SMTC_write2Dreg(DE_PITCH,
            FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_PITCH, SOURCE,      src_pitch));
        
        SMTC_write2Dreg(DE_WINDOW_WIDTH,
            FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
            FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      src_pitch));
    }
    
    /* Set transparent bits if necessary */
    if (pTransp != NULL)
    {
        nTransparent = pTransp->match | pTransp->select | pTransp->control;
        
        /* Set color compare register */
        SMTC_write2Dreg(DE_COLOR_COMPARE,
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


    if (dst_BPP>=24){
            src_X*=3;
            src_Y*=3;
            dst_X*=3;
	     dst_Y*=3;
            dst_width*=3;
	    if ((nDirection == BOTTOM_TO_TOP) || (nDirection == RIGHT_TO_LEFT))
		    {
		        src_X += 2;
		        dst_X += 2;
		    }
    	}
		
    /* Workaround for 192 byte hw bug */
    if ((nROP2 != 0x0C) && ((dst_width * (dst_BPP / 8)) >= 192))
    {
        /* Perform the ROP2 operation in chunks of (xWidth * dst_height) */
        while (1)
        {
            deWaitForNotBusy();
            SMTC_write2Dreg(DE_SOURCE,
                FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
                FIELD_VALUE(0, DE_SOURCE, X_K1, src_X)   |
                FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
            SMTC_write2Dreg(DE_DESTINATION,
                FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
                FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)  |
                FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));
            SMTC_write2Dreg(DE_DIMENSION,
                FIELD_VALUE(0, DE_DIMENSION, X,    xWidth) |
                FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
            de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, nROP2) |
                nTransparent |
                FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
                FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
                ((nDirection == 1) ? FIELD_SET(0, DE_CONTROL, DIRECTION, RIGHT_TO_LEFT)
                : FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT)) |
                FIELD_SET(0, DE_CONTROL, STATUS, START);
            SMTC_write2Dreg(DE_CONTROL, de_ctrl);
            
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
        deWaitForNotBusy();
        SMTC_write2Dreg(DE_SOURCE,
            FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_SOURCE, X_K1, src_X)   |
            FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
        SMTC_write2Dreg(DE_DESTINATION,
            FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
            FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)  |
            FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));
        SMTC_write2Dreg(DE_DIMENSION,
            FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
            FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
        de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, nROP2) |
            nTransparent |
            FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
            FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
            ((nDirection == 1) ? FIELD_SET(0, DE_CONTROL, DIRECTION, RIGHT_TO_LEFT)
            : FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT)) |
            FIELD_SET(0, DE_CONTROL, STATUS, START);
        SMTC_write2Dreg(DE_CONTROL, de_ctrl);
    }

    smtc_de_busy = 1;
}


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
    deWaitForNotBusy();

    /* Set transparent bits if necessary */
    if (pTransp != NULL)
    {
        nTransparent = pTransp->match | pTransp->select | pTransp->control;
        
        /* Set color compare register */
        SMTC_write2Dreg(DE_COLOR_COMPARE,
            FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR, pTransp->color));
    }
    
    SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));
    
    SMTC_write2Dreg(DE_WINDOW_SOURCE_BASE, FIELD_VALUE(0, DE_WINDOW_SOURCE_BASE, ADDRESS, 0));
    
    SMTC_write2Dreg(DE_SOURCE,
        FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_SOURCE, X_K1, 0)       |
        FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));
    SMTC_write2Dreg(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)  |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));
    SMTC_write2Dreg(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));
    SMTC_write2Dreg(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_width) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_width));
    SMTC_write2Dreg(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_width) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_width));
    de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, nROP2) |
        nTransparent |
        FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
        FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) |
        FIELD_SET(0, DE_CONTROL, STATUS, START);
    SMTC_write2Dreg(DE_CONTROL, de_ctrl);
    
    /* Write bitmap/image data (line by line) to 2D Engine data port */
    de_data_port_write_addr = 0;
    
    for (i = 1; i < dst_height; i++)
    {
        for (j = 0; j < (nBytes8_per_scan / 4); j++)
        {
            memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
            SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
        }
        
        pSrcBuffer += src_stride;
    }
    
    /* Special handling for last line of bitmap */
    if (nLong)
    {
        for (j = 0; j < (nLong / 4); j++)
        {
            memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
            SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
        }
    }
    
    if (nBytes_remain)
    {
        memcpy(abyRemain, (pSrcBuffer + nLong), nBytes_remain);
        SMTC_write2Ddataport(de_data_port_write_addr, *(unsigned long*)abyRemain);
        SMTC_write2Ddataport(de_data_port_write_addr, *(unsigned long*)(abyRemain + 4));
    }

    smtc_de_busy = 1;
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

    deWaitForNotBusy();
    
    /* Set transparent bits if necessary */
    if (pTransp != NULL)
    {
        nTransparent = pTransp->match | pTransp->select | pTransp->control;
        
        /* Set color compare register */
        SMTC_write2Dreg(DE_COLOR_COMPARE,
            FIELD_VALUE(0, DE_COLOR_COMPARE, COLOR, pTransp->color));
    }
    
    /* Program 2D Drawing Engine */

    SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, FIELD_VALUE(0, DE_WINDOW_DESTINATION_BASE, ADDRESS, dst_base));

    SMTC_write2Dreg(DE_WINDOW_SOURCE_BASE, FIELD_VALUE(0, DE_WINDOW_SOURCE_BASE, ADDRESS, 0));

    SMTC_write2Dreg(DE_PITCH,
        FIELD_VALUE(0, DE_PITCH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_PITCH, SOURCE,      dst_pitch));
    
    SMTC_write2Dreg(DE_WINDOW_WIDTH,
        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, dst_pitch) |
        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      dst_pitch));

    SMTC_write2Dreg(DE_SOURCE,
        FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE)        |
        FIELD_VALUE(0, DE_SOURCE, X_K1, nLeft_bits_off) |
        FIELD_VALUE(0, DE_SOURCE, Y_K2, src_Y));

    SMTC_write2Dreg(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dst_X)  |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dst_Y));

    SMTC_write2Dreg(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    dst_width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, dst_height));

    SMTC_write2Dreg(DE_FOREGROUND,
        FIELD_VALUE(0, DE_FOREGROUND, COLOR, nFgColor));

    SMTC_write2Dreg(DE_BACKGROUND,
        FIELD_VALUE(0, DE_BACKGROUND, COLOR, nBgColor));
    
    de_ctrl = 0x0000000C |
        FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
        FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) |
        FIELD_SET(0, DE_CONTROL, HOST, MONO) |
        nTransparent |
        FIELD_SET(0, DE_CONTROL, STATUS, START);
    SMTC_write2Dreg(DE_CONTROL, de_ctrl);
    
    /* Write bitmap/image data (line by line) to 2D Engine data port */
    de_data_port_write_addr = 0;
    
    for (i = 1; i < dst_height; i++)
    {
        for (j = 0; j < (nBytes4_per_scan / 4); j++)
        {
            memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
            SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
        }
        
        pSrcBuffer += src_stride;
    }
    
    /* Special handling for last line of bitmap */
    if (nLong)
    {
        for (j = 0; j < (nLong / 4); j++)
        {
            memcpy(&ulSrc, (pSrcBuffer + (j * 4)), 4);
            SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
        }
    }
    
    if (nBytes_remain)
    {
        memcpy(&ulSrc, (pSrcBuffer + nLong), nBytes_remain);
        SMTC_write2Ddataport(de_data_port_write_addr, ulSrc);
    }

    smtc_de_busy = 1;
}

/*
 * This function sets the pixel format that will apply to the 2D Engine.
 */
void deSetPixelFormat(
    unsigned long bpp
)
{
    unsigned long de_format;
    
    de_format = SMTC_read2Dreg(DE_STRETCH_FORMAT);
    
    switch (bpp)
    {
        case 8:
            de_format = FIELD_SET(de_format, DE_STRETCH_FORMAT, PIXEL_FORMAT, 8);
            break;
        default:
        case 16:
            de_format = FIELD_SET(de_format, DE_STRETCH_FORMAT, PIXEL_FORMAT, 16);
            break;
        case 32:
            de_format = FIELD_SET(de_format, DE_STRETCH_FORMAT, PIXEL_FORMAT, 32);
            break;
    }
    
    SMTC_write2Dreg(DE_STRETCH_FORMAT, de_format);
}



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

 	if (smtc_de_busy)
       	deWaitForNotBusy();

    /* 2D Source Base.
       Use 0 for HOST Blt.
    */
    SMTC_write2Dreg(DE_WINDOW_SOURCE_BASE, 0);

    /* 2D Destination Base.
       It is an address offset (128 bit aligned) from the beginning of frame buffer.
    */
    SMTC_write2Dreg(DE_WINDOW_DESTINATION_BASE, dBase);


    if (dPitch)
    	{
	    /* Program pitch (distance between the 1st points of two adjacent lines).
	       Note that input pitch is BYTE value, but the 2D Pitch register uses
	       pixel values. Need Byte to pixel convertion.
	    */
	    SMTC_write2Dreg(DE_PITCH,
	        FIELD_VALUE(0, DE_PITCH, DESTINATION, dPitch/bytePerPixel) |
	        FIELD_VALUE(0, DE_PITCH, SOURCE,      dPitch/bytePerPixel));

	    /* Screen Window width in Pixels.
	       2D engine uses this value to calculate the linear address in frame buffer for a given point.
	    */
	    SMTC_write2Dreg(DE_WINDOW_WIDTH,
	        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/bytePerPixel)) |
	        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (dPitch/bytePerPixel)));
    	}
    /* Note: For 2D Source in Host Write, only X_K1 field is needed, and Y_K2 field is not used.
             For mono bitmap, use startBit for X_K1. */
    SMTC_write2Dreg(DE_SOURCE,
        FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE)  |
        FIELD_VALUE(0, DE_SOURCE, X_K1, startBit) |
        FIELD_VALUE(0, DE_SOURCE, Y_K2, 0));

    SMTC_write2Dreg(DE_DESTINATION,
        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
        FIELD_VALUE(0, DE_DESTINATION, X,    dx)    |
        FIELD_VALUE(0, DE_DESTINATION, Y,    dy));

    SMTC_write2Dreg(DE_DIMENSION,
        FIELD_VALUE(0, DE_DIMENSION, X,    width) |
        FIELD_VALUE(0, DE_DIMENSION, Y_ET, height));

    SMTC_write2Dreg(DE_FOREGROUND, fColor);
    SMTC_write2Dreg(DE_BACKGROUND, bColor);

    if (bpp)
	    deSetPixelFormat(bpp);
    /* Set the pixel format of the destination */


    de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, rop2)         |
              FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2)    |
              FIELD_SET(0, DE_CONTROL, COMMAND, HOST_WRITE) |
              FIELD_SET(0, DE_CONTROL, HOST, MONO)          |
              FIELD_SET(0, DE_CONTROL, STATUS, START);

    SMTC_write2Dreg(DE_CONTROL, de_ctrl | deGetTransparency());

    /* Write MONO data (line by line) to 2D Engine data port */
    for (i=0; i<height; i++)
    {
        /* For each line, send the data in chunks of 4 bytes */
        for (j=0; j<(ul4BytesPerScan/4); j++)
        {
            SMTC_write2Ddataport( 0, *(unsigned long *)(pSrcbuf + (j * 4)));
        }

        if (ulBytesRemain)
        {
            memcpy(ajRemain, pSrcbuf+ul4BytesPerScan, ulBytesRemain);
            SMTC_write2Ddataport(0,*(unsigned long *)ajRemain);
        }

        pSrcbuf += srcDelta;
    }
    smtc_de_busy = 1;
	
    return 0;
}


/*
 * This function gets the transparency status from DE_CONTROL register.
 * It returns a double word with the transparent fields properly set,
 * while other fields are 0.
 */
unsigned long deGetTransparency()
{
    unsigned long de_ctrl;

    de_ctrl = SMTC_read2Dreg(DE_CONTROL);

    de_ctrl &= 
        FIELD_MASK(DE_CONTROL_TRANSPARENCY_MATCH) | 
        FIELD_MASK(DE_CONTROL_TRANSPARENCY_SELECT)| 
        FIELD_MASK(DE_CONTROL_TRANSPARENCY);

    return de_ctrl;
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
//        memWrite32(write_addr, *(unsigned long*)(&pattern[i]));     removed by boyod
        write_addr += 4;
    }
}
