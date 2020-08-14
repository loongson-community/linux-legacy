/*
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
 * Machine dependent access functions for RTC registers.
 *
 * Copyright (C) 1996, 1997, 1998, 2000 Ralf Baechle
 * Copyright (C) 2002  Maciej W. Rozycki
 */
#ifndef _ASM_MC146818RTC_H
#define _ASM_MC146818RTC_H

#include <mc146818rtc.h>

#define lock_cmos_prefix(reg) do {} while (0)
#define lock_cmos_suffix(reg) do {} while (0)
#define lock_cmos(reg)
#define unlock_cmos()
#define do_i_have_lock_cmos() 0
#define current_lock_cmos_reg() 0


#endif /* _ASM_MC146818RTC_H */
