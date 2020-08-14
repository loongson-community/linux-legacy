/*
 *  linux/drivers/video/ls2f1afb.c -- Simple frame buffer device
 *
 *	 Based on virtual frame buffer by Geert Uytterhoeven
 *
 *  This is a simple no-frills frame buffer driver for devices that don't
 *  (yet) have hardware-specific drivers written.  It is very limited in that
 *  it does no hardware-specific operations, so hardware initialization must
 *  be done prior to boot, no mode changes are allowed, and the palette cannot
 *  be changed.  It also requires a fixed, known virtual address for the base
 *  of video ram.  For these reasons, it is mostly for test and development
 *  purposes.
 *
 *  NOTE:  No hardware-specific code should go in this file.  Instead, once
 *  a device needs specific code, it should be split off into its own frame
 *  buffer device.  On the other hand, feel free to add more general
 *  capabilities to the frame buffer parameters below.
 *
 *  This file is subject to the terms and conditions of the GNU General Public
 *  License. See the file COPYING in the main directory of this archive for
 *  more details.
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/tty.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <asm/uaccess.h>
#include <linux/fb.h>
#include <linux/init.h>

#include <video/fbcon.h>
#include <video/fbcon-mfb.h>
#include <video/fbcon-cfb2.h>
#include <video/fbcon-cfb4.h>
#include <video/fbcon-cfb8.h>
#include <video/fbcon-cfb16.h>
#include <video/fbcon-cfb24.h>
#include <video/fbcon-cfb32.h>

static unsigned long videomemory = (int)0xb8000000;
static unsigned long videomemorysize;

static int currcon = 0;
static struct display disp;
static struct fb_info fb_info;
static struct { u_char red, green, blue, pad; } palette[256];

static union {
#if defined(FBCON_HAS_CFB8)
    u8 cfb8[16];
#endif
#ifdef FBCON_HAS_CFB16
    u16 cfb16[16];
#endif
#ifdef FBCON_HAS_CFB24
    u32 cfb24[16];
#endif
#ifdef FBCON_HAS_CFB32
    u32 cfb32[16];
#endif
} fbcon_cmap;

static char ls2f1afb_name[16] = "Simple FB";
static char *mode_option __initdata = 0;
static int inverse = 0;
static int grayscale = 0;

static struct fb_var_screeninfo ls2f1afb_default = {
    800, 600, 800, 600, 0, 0, 16, 0,
    {11, 5, 0}, {5, 6, 0}, {0, 5, 0}, {0, 0, 0},
    0, FB_ACTIVATE_NOW, -1, -1, 0, 20000, 64, 64, 32, 32, 64, 2,
    0, FB_VMODE_NONINTERLACED, {0,0,0,0,0,0}
};


    /*
     *  Interface used by the world
     */

int ls2f1afb_setup(char*);

static int ls2f1afb_get_fix(struct fb_fix_screeninfo *fix, int con,
		       struct fb_info *info);
static int ls2f1afb_get_var(struct fb_var_screeninfo *var, int con,
		       struct fb_info *info);
static int ls2f1afb_set_var(struct fb_var_screeninfo *var, int con,
		       struct fb_info *info);
static int ls2f1afb_pan_display(struct fb_var_screeninfo *var, int con,
			   struct fb_info *info);
static int ls2f1afb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
			struct fb_info *info);
static int ls2f1afb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
			struct fb_info *info);


    /*
     *  Interface to the low level console driver
     */

int ls2f1afb_init(void);
static int ls2f1afbcon_switch(int con, struct fb_info *info);
static int ls2f1afbcon_updatevar(int con, struct fb_info *info);
static void ls2f1afbcon_blank(int blank, struct fb_info *info);


    /*
     *  Internal routines
     */

static u_long get_line_length(int xres_virtual, int bpp);
static void ls2f1afb_encode_fix(struct fb_fix_screeninfo *fix,
			   struct fb_var_screeninfo *var);
static void set_color_bitfields(struct fb_var_screeninfo *var);
static int ls2f1afb_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
                         u_int *transp, struct fb_info *info);
static int ls2f1afb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                         u_int transp, struct fb_info *info);
static void do_install_cmap(int con, struct fb_info *info);


static struct fb_ops ls2f1afb_ops = {
    owner:          THIS_MODULE,
    fb_get_fix:     ls2f1afb_get_fix,
    fb_get_var:     ls2f1afb_get_var,
    fb_set_var:     ls2f1afb_set_var,
    fb_get_cmap:    ls2f1afb_get_cmap,
    fb_set_cmap:    ls2f1afb_set_cmap,
    fb_pan_display: ls2f1afb_pan_display,
};

    /*
     *  Get the Fixed Part of the Display
     */

static int ls2f1afb_get_fix(struct fb_fix_screeninfo *fix, int con,
		       struct fb_info *info)
{
    struct fb_var_screeninfo *var;

    if (con == -1)
	var = &ls2f1afb_default;
    else
	var = &fb_display[con].var;
    ls2f1afb_encode_fix(fix, var);
    return 0;
}


    /*
     *  Get the User Defined Part of the Display
     */

static int ls2f1afb_get_var(struct fb_var_screeninfo *var, int con,
		       struct fb_info *info)
{
    if (con == -1)
	*var = ls2f1afb_default;
    else
	*var = fb_display[con].var;
    set_color_bitfields(var);
    return 0;
}


    /*
     *  Set the User Defined Part of the Display
     */

static int ls2f1afb_set_var(struct fb_var_screeninfo *var, int con,
		       struct fb_info *info)
{
    int err, activate = var->activate;
    int oldxres, oldyres, oldvxres, oldvyres, oldbpp;
    u_long line_length;
    struct display *display;

    if (con >= 0)
	display = &fb_display[con];
    else
	display = &disp;	/* used during initialization */

    /*
     *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
     *  as FB_VMODE_SMOOTH_XPAN is only used internally
     */

    if (var->vmode & FB_VMODE_CONUPDATE) {
	var->vmode |= FB_VMODE_YWRAP;
	var->xoffset = display->var.xoffset;
	var->yoffset = display->var.yoffset;
    }

    /*
     *  Some very basic checks
     */
    if (!var->xres)
	var->xres = 1;
    if (!var->yres)
	var->yres = 1;
    if (var->xres > var->xres_virtual)
	var->xres_virtual = var->xres;
    if (var->yres > var->yres_virtual)
	var->yres_virtual = var->yres;
    if (var->bits_per_pixel <= 1)
	var->bits_per_pixel = 1;
    else if (var->bits_per_pixel <= 2)
	var->bits_per_pixel = 2;
    else if (var->bits_per_pixel <= 4)
	var->bits_per_pixel = 4;
    else if (var->bits_per_pixel <= 8)
	var->bits_per_pixel = 8;
    else if (var->bits_per_pixel <= 16)
	var->bits_per_pixel = 16;
    /* fbcon doesn't support this (yet) */
    else if (var->bits_per_pixel <= 24)
	var->bits_per_pixel = 24;
    else if (var->bits_per_pixel <= 32)
	var->bits_per_pixel = 32;
    else
	return -EINVAL;

    /*
     *  Memory limit
     */
    line_length = get_line_length(var->xres_virtual, var->bits_per_pixel);
    if (line_length*var->yres_virtual > videomemorysize)
	return -ENOMEM;

    set_color_bitfields(var);

    if ((activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
	oldxres = display->var.xres;
	oldyres = display->var.yres;
	oldvxres = display->var.xres_virtual;
	oldvyres = display->var.yres_virtual;
	oldbpp = display->var.bits_per_pixel;
	display->var = *var;
	info->var=*var;
	if (oldxres != var->xres || oldyres != var->yres ||
	    oldvxres != var->xres_virtual || oldvyres != var->yres_virtual ||
	    oldbpp != var->bits_per_pixel) {
	    struct fb_fix_screeninfo fix;

	    ls2f1afb_encode_fix(&fix, var);
	    display->screen_base = (char *)videomemory;
	    display->visual = fix.visual;
	    display->type = fix.type;
	    display->type_aux = fix.type_aux;
	    display->ypanstep = fix.ypanstep;
	    display->ywrapstep = fix.ywrapstep;
	    display->line_length = fix.line_length;
	    display->can_soft_blank = 1;
	    display->inverse = inverse;
	    display->scrollmode = SCROLL_YREDRAW;
	    switch (var->bits_per_pixel) {
#ifdef FBCON_HAS_MFB
		case 1:
		    display->dispsw = &fbcon_mfb;
		    break;
#endif
#ifdef FBCON_HAS_CFB2
		case 2:
		    display->dispsw = &fbcon_cfb2;
		    break;
#endif
#ifdef FBCON_HAS_CFB4
		case 4:
		    display->dispsw = &fbcon_cfb4;
		    break;
#endif
#ifdef FBCON_HAS_CFB8
		case 8:
		    display->dispsw = &fbcon_cfb8;
#if FB_IS_TRUECOLOR
		    display->dispsw_data = fbcon_cmap.cfb8;
#endif
		    break;
#endif
#ifdef FBCON_HAS_CFB16
		case 16:
		    display->dispsw = &fbcon_cfb16;
		    display->dispsw_data = fbcon_cmap.cfb16;
		    break;
#endif
#ifdef FBCON_HAS_CFB24
		case 24:
		    display->dispsw = &fbcon_cfb24;
		    display->dispsw_data = fbcon_cmap.cfb24;
		    break;
#endif
#ifdef FBCON_HAS_CFB32
		case 32:
		    display->dispsw = &fbcon_cfb32;
		    display->dispsw_data = fbcon_cmap.cfb32;
		    break;
#endif
		default:
		    display->dispsw = &fbcon_dummy;
		    break;
	    }
	    if (fb_info.changevar)
		(*fb_info.changevar)(con);
	}
	if (oldbpp != var->bits_per_pixel) {
	    if ((err = fb_alloc_cmap(&display->cmap, 0, 0)))
		return err;
	    do_install_cmap(con, info);
	}
    }
    return 0;
}


    /*
     *  Pan or Wrap the Display
     *
     *  This call looks only at xoffset, yoffset and the FB_VMODE_YWRAP flag
     */

static int ls2f1afb_pan_display(struct fb_var_screeninfo *var, int con,
			   struct fb_info *info)
{
#if 1
    return -EINVAL;
#else
    if (var->vmode & FB_VMODE_YWRAP) {
	if (var->yoffset < 0 ||
	    var->yoffset >= fb_display[con].var.yres_virtual ||
	    var->xoffset)
	    return -EINVAL;
    } else {
	if (var->xoffset+fb_display[con].var.xres >
	    fb_display[con].var.xres_virtual ||
	    var->yoffset+fb_display[con].var.yres >
	    fb_display[con].var.yres_virtual)
	    return -EINVAL;
    }
    fb_display[con].var.xoffset = var->xoffset;
    fb_display[con].var.yoffset = var->yoffset;
    if (var->vmode & FB_VMODE_YWRAP)
	fb_display[con].var.vmode |= FB_VMODE_YWRAP;
    else
	fb_display[con].var.vmode &= ~FB_VMODE_YWRAP;
    return 0;
#endif
}

    /*
     *  Get the Colormap
     */

static int ls2f1afb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
			struct fb_info *info)
{
    if (con == currcon) /* current console? */
	return fb_get_cmap(cmap, kspc, ls2f1afb_getcolreg, info);
    else if (fb_display[con].cmap.len) /* non default colormap? */
	fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
    else
	fb_copy_cmap(fb_default_cmap(1<<fb_display[con].var.bits_per_pixel),
		     cmap, kspc ? 0 : 2);
    return 0;
}

    /*
     *  Set the Colormap
     */

static int ls2f1afb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
			struct fb_info *info)
{
    int err;

    if (!fb_display[con].cmap.len) {	/* no colormap allocated? */
	if ((err = fb_alloc_cmap(&fb_display[con].cmap,
			      1<<fb_display[con].var.bits_per_pixel, 0)))
	    return err;
    }
    if (con == currcon)			/* current console? */
	return fb_set_cmap(cmap, kspc, ls2f1afb_setcolreg, info);
    else
	fb_copy_cmap(cmap, &fb_display[con].cmap, kspc ? 0 : 1);
    return 0;
}

int __init ls2f1afb_setup(char *options)
{
    char *this_opt;

    fb_info.fontname[0] = '\0';

    if (!options || !*options)
	return 0;

    while ((this_opt = strsep(&options, ",")) != NULL) {
    	if (!*this_opt)
	    continue;
	if (!strncmp(this_opt, "inverse", 7)) {
	    inverse = 1;
	    fb_invert_cmaps();
	} else if (!strncmp(this_opt, "grayscale", 9)) {
	    grayscale = 1;
	} else if (!strncmp(this_opt, "font:", 5)) {
	    strcpy(fb_info.fontname, this_opt+5);
	} else {
	    mode_option = this_opt;
	}
    }

    return 0;
}


    /*
     *  Initialisation
     */

int __init ls2f1afb_init(void)
{
    struct fb_var_screeninfo var;

    strcpy(fb_info.modename, ls2f1afb_name);
    fb_info.changevar = NULL;
    fb_info.node = -1;
    fb_info.fbops = &ls2f1afb_ops;
    fb_info.disp = &disp;
    fb_info.switch_con = &ls2f1afbcon_switch;
    fb_info.updatevar = &ls2f1afbcon_updatevar;
    fb_info.blank = &ls2f1afbcon_blank;
    fb_info.flags = FBINFO_FLAG_DEFAULT;

    memset(&var, 0, sizeof(var));

    if (!mode_option || !fb_find_mode(&var, &fb_info,
    				mode_option, NULL, 0, NULL, 8))
	var = ls2f1afb_default;

    /*
     * Calculate a sane default size if none is specified.
     */
    if (!videomemorysize) {
    	videomemorysize = var.xres_virtual *
			  var.yres_virtual *
			  var.bits_per_pixel / 8;
    }

    ls2f1afb_set_var(&var, -1, &fb_info);

    if (register_framebuffer(&fb_info) < 0)
	return -EINVAL;

    printk(KERN_INFO "fb%d: Simple frame buffer device, using %ldK of video memory\n",
	   GET_FB_IDX(fb_info.node), videomemorysize>>10);
    return 0;
}

static void __exit ls2f1afb_exit(void)
{
	unregister_framebuffer(&fb_info);
}

module_init(ls2f1afb_init);
module_exit(ls2f1afb_exit);

MODULE_LICENSE("GPL");

static int ls2f1afbcon_switch(int con, struct fb_info *info)
{
    /* Do we have to save the colormap? */
    if (fb_display[currcon].cmap.len)
	fb_get_cmap(&fb_display[currcon].cmap, 1, ls2f1afb_getcolreg, info);

    currcon = con;
    /* Install new colormap */
    do_install_cmap(con, info);
    return 0;
}

    /*
     *  Update the `var' structure (called by fbcon.c)
     */

static int ls2f1afbcon_updatevar(int con, struct fb_info *info)
{
    /* Nothing */
    return 0;
}

    /*
     *  Blank the display.
     */

static void ls2f1afbcon_blank(int blank, struct fb_info *info)
{
    /* Nothing */
}

static u_long get_line_length(int xres_virtual, int bpp)
{
    u_long length;
    
    length = (xres_virtual * bpp + 7) >> 3;
    return(length);
}

static void ls2f1afb_encode_fix(struct fb_fix_screeninfo *fix,
			   struct fb_var_screeninfo *var)
{
    memset(fix, 0, sizeof(struct fb_fix_screeninfo));
    strcpy(fix->id, ls2f1afb_name);
    fix->smem_start = videomemory&0x1fffffff;
    fix->smem_len = videomemorysize;
    fix->type = FB_TYPE_PACKED_PIXELS;
    fix->type_aux = 0;
    switch (var->bits_per_pixel) {
	case 1:
	    fix->visual = FB_VISUAL_MONO01;
	    break;
	case 2:
	case 4:
#ifndef FB_IS_TRUECOLOR
	case 8:
#endif
	    fix->visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
	    break;
#ifdef FB_IS_TRUECOLOR
	case 8:
#endif
	case 16:
	case 24:
	case 32:
	    fix->visual = FB_VISUAL_TRUECOLOR;
	    break;
    }
    fix->ywrapstep = 1;
    fix->xpanstep = 1;
    fix->ypanstep = 1;
    fix->line_length = get_line_length(var->xres_virtual, var->bits_per_pixel);
}

static void set_color_bitfields(struct fb_var_screeninfo *var)
{
    switch (var->bits_per_pixel) {
	case 1:
	case 2:
	case 4:
	case 8:
#if FB_IS_TRUECOLOR
	    var->red.offset = 5;
	    var->red.length = 3;
	    var->green.offset = 2;
	    var->green.length = 3;
	    var->blue.offset = 0;
	    var->blue.length = 2;
#else
	    var->red.offset = 0;
	    var->red.length = var->bits_per_pixel;
	    var->green.offset = 0;
	    var->green.length = var->bits_per_pixel;
	    var->blue.offset = 0;
	    var->blue.length = var->bits_per_pixel;
#endif
	    var->transp.offset = 0;
	    var->transp.length = 0;
	    break;
	case 16:  // RGB 565
	    var->red.offset = 11;
	    var->red.length = 5;
	    var->green.offset = 5;
	    var->green.length = 6;
	    var->blue.offset = 0;
	    var->blue.length = 5;
	    var->transp.offset = 0;
	    var->transp.length = 0;
	    break;

	case 24: // RGB 888
	    var->red.offset = 16;
	    var->red.length = 8;
	    var->green.offset = 8;
	    var->green.length = 8;
	    var->blue.offset = 0;
	    var->blue.length = 8;
	    var->transp.offset = 0;
	    var->transp.length = 0;
	    break;
	case 32:	/* RGBA 8888 */
	    var->red.offset = 16;
	    var->red.length = 8;
	    var->green.offset = 8;
	    var->green.length = 8;
	    var->blue.offset = 0;
	    var->blue.length = 8;
	    var->transp.offset = 24;
	    var->transp.length = 8;
	    break;
    }
    var->red.msb_right = 0;
    var->green.msb_right = 0;
    var->blue.msb_right = 0;
    var->transp.msb_right = 0;
}

    /*
     *  Read a single color register and split it into
     *  colors/transparent. Return != 0 for invalid regno.
     *
     *  For palette or greyscale mode, returns what the hardware will
     *  actually do for that index (as far as we know), instead of the
     *  value set by setcolreg, since the hardware palette cannot be
     *  changed by this driver.  For palette mode, we rely on whatever
     *  is set by FB_PALETTE, if not defined, then we just return 0s...
     */

#define MAX_REGNO 255
static int ls2f1afb_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
                         u_int *transp, struct fb_info *info)
{
    if (regno > 255)
	return 1;

    if (grayscale) {
	u_int grey;

	grey = regno * 255 / MAX_REGNO;

	if (inverse)
	    grey ^= 255;

	grey |= grey << 8;
	*red = grey;
	*green = grey;
	*blue = grey;
    } else {
    	*red = (palette[regno].red << 8) | palette[regno].red;
    	*green = (palette[regno].green << 8) | palette[regno].green;
    	*blue = (palette[regno].blue << 8) | palette[regno].blue;
    }

    *transp = 0;

    return 0;
}


    /*
     *  Set a single color register. The values supplied are already
     *  rounded down to the hardware's capabilities (according to the
     *  entries in the var structure). Return != 0 for invalid regno.
     *
     *  For paletted and greyscale modes, this just ignores the value
     *  being set in the color register.
     */

static int ls2f1afb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                         u_int transp, struct fb_info *info)
{
    if (regno > 255)
	return 1;

    red >>= 8;
    green >>= 8;
    blue >>= 8;

    /*
     *  Round color down to what the video mode can actually do, so if the
     *  palette is read back, the actual hardware value is returned.  Also, 
     *  maintain index to RGB map for fbcon (accessed through dispsw_data)
     */
    switch (info->var.bits_per_pixel) {
#if defined(FBCON_HAS_CFB8)
	case 8:
    	    red   &= 0xe0;
	    green &= 0xe0;
    	    blue  &= 0xc0;
	    if(regno < 16)
    	    fbcon_cmap.cfb8[regno] = red | (green >> 3) | (blue >> 6);

	    break;
#endif 
#if defined(FBCON_HAS_CFB16)
	case 16:
    	    red   &= 0xF8;
    	    green &= 0xFC;
    	    blue  &= 0xF8;
	    if(regno < 16)
    	    fbcon_cmap.cfb16[regno] = (red << 8) | (green << 3) | (blue >> 3);
	    
	    break;
#endif 
#if defined(FBCON_HAS_CFB24)
	case 24:
	    if(regno < 16)
    	    fbcon_cmap.cfb24[regno] = (red << 16) | (green << 8) | blue;

	    break;
#endif
#if defined(FBCON_HAS_CFB32)
	case 32:
	    if(regno < 16)
    	    fbcon_cmap.cfb32[regno] = (red << 16) | (green << 8) | blue;
	    
	    break;
#endif
	default:
	    break;
    }

    palette[regno].red = red;
    palette[regno].green = green;
    palette[regno].blue = blue;

    return 0;
}


static void do_install_cmap(int con, struct fb_info *info)
{
    if (con != currcon)
	return;
    if (fb_display[con].cmap.len)
	fb_set_cmap(&fb_display[con].cmap, 1, ls2f1afb_setcolreg, info);
    else
	fb_set_cmap(fb_default_cmap(1<<fb_display[con].var.bits_per_pixel), 1,
		    ls2f1afb_setcolreg, info);
}

