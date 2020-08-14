/* vi: set sw=4 ts=4: */
/*
 * Utility routines.
 *
 * Copyright (C) tons of folks.  Tracking down who wrote what
 * isn't something I'm going to worry about...  If you wrote something
 * here, please feel free to acknowledge your work.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 * Based in part on code from sash, Copyright (c) 1999 by David I. Bell 
 * Permission has been granted to redistribute this code under the GPL.
 *
 */

//#include <stdio.h>
//#include "libbb.h"
//

#ifdef __KERNEL__
#define printf nr_printf 
#else
#define BB_FEATURE_LS_TIMESTAMPS
#define chfs(...)
#define MAJOR(dev)	((dev)>>8)
#define MINOR(dev)	((dev) & 0xff)
#endif

static const int TIME_MOD = 0;
static const int TIME_CHANGE = 1;
static const int TIME_ACCESS = 2;

#define TYPEINDEX(mode) (((mode) >> 12) & 0x0f)
#define TYPECHAR(mode)  ("0pcCd?bB-?l?s???" [TYPEINDEX(mode)])

/* The special bits. If set, display SMODE0/1 instead of MODE0/1 */
static const mode_t SBIT[] = {
	0, 0, S_ISUID,
	0, 0, S_ISGID,
	0, 0, S_ISVTX
};

/* The 9 mode bits to test */
static const mode_t MBIT[] = {
	S_IRUSR, S_IWUSR, S_IXUSR,
	S_IRGRP, S_IWGRP, S_IXGRP,
	S_IROTH, S_IWOTH, S_IXOTH
};

static const char MODE1[]  = "rwxrwxrwx";
static const char MODE0[]  = "---------";
static const char SMODE1[] = "..s..s..t";
static const char SMODE0[] = "..S..S..T";

/*
 * Return the standard ls-like mode string from a file mode.
 * This is static and so is overwritten on each call.
 */
const char *mode_string(int mode)
{
	static char buf[12];

	int i;

	buf[0] = TYPECHAR(mode);
	for (i = 0; i < 9; i++) {
		if (mode & SBIT[i])
			buf[i + 1] = (mode & MBIT[i]) ? SMODE1[i] : SMODE0[i];
		else
			buf[i + 1] = (mode & MBIT[i]) ? MODE1[i] : MODE0[i];
	}
	return buf;
}

#define LIST_INO		(1<<0)
#define LIST_BLOCKS		(1<<1)
#define LIST_MODEBITS	(1<<2)
#define LIST_NLINKS		(1<<3)
#define LIST_ID_NAME	(1<<4)
#define LIST_ID_NUMERIC	(1<<5)
#define LIST_SIZE		(1<<6)
#define LIST_DEV		(1<<7)
#define LIST_DATE_TIME	(1<<8)
#define LIST_FULLTIME	(1<<9)
#define LIST_FILENAME	(1<<10)
#define LIST_SYMLINK	(1<<11)
#define LIST_FILETYPE	(1<<12)
#define LIST_EXEC		(1<<13)

extern char *xreadlink(const char *path)
{

    static char buf[101];
    int bufsize = 100, readsize = 0;
chfs(1);
        readsize = readlink(path, buf, bufsize); /* 1st try */
chfs(0);
        if (readsize == -1) {
            return NULL;
        }

    buf[readsize] = '\0';

    return buf;
}

static unsigned int time_fmt=-1;
static unsigned int list_fmt=LIST_MODEBITS|LIST_NLINKS|LIST_ID_NUMERIC|LIST_SIZE|LIST_DATE_TIME|LIST_FILENAME|LIST_SYMLINK|LIST_FILETYPE;
static unsigned short column = 0;

struct dnode {				/* the basic node */
    char *name;				/* the dir entry name */
    char *fullname;			/* the dir entry name */
    struct stat dstat;		/* the file stat info */
    struct dnode *next;		/* point at the next node */
};

#define TYPEINDEX(mode) (((mode) >> 12) & 0x0f)
#define APPCHAR(mode)   ("\0|\0\0/\0\0\0\0\0@\0=\0\0\0" [TYPEINDEX(mode)])
static char append_char(mode_t mode)
{
	if ( !(list_fmt & LIST_FILETYPE))
		return '\0';
	if ((list_fmt & LIST_EXEC) && S_ISREG(mode)
	    && (mode & (S_IXUSR | S_IXGRP | S_IXOTH))) return '*';
		return APPCHAR(mode);
}
#define BUFSIZ 200
static int list_single(struct dnode *dn)
{
	int i;
	time_t ttime;
	char append;

	if (dn==NULL || dn->fullname==NULL) return(0);

	ttime= dn->dstat.st_mtime;      /* the default time */
	if (time_fmt & TIME_ACCESS) ttime= dn->dstat.st_atime;
	if (time_fmt & TIME_CHANGE) ttime= dn->dstat.st_ctime;

#ifndef __KERNEL__
	filetime= ctime(&ttime);
#endif
	append = append_char(dn->dstat.st_mode);
	
	for (i=0; i<=31; i++) {
		switch (list_fmt & (1<<i)) {
			case LIST_INO:
				printf("%7ld ", (long int)dn->dstat.st_ino);
				column += 8;
				break;
			case LIST_BLOCKS:
#ifdef BB_FEATURE_HUMAN_READABLE
				printf("%6s ", make_human_readable_str(dn->dstat.st_blocks>>1, 
							KILOBYTE, (ls_disp_hr==TRUE)? 0: KILOBYTE));
#else
#if defined(FILE_OFFSET_BITS) && (_FILE_OFFSET_BITS == 64)
				printf("%4lld ", dn->dstat.st_blocks>>1);
#else
				printf("%4ld ", dn->dstat.st_blocks>>1);
#endif
#endif
				column += 5;
				break;
			case LIST_MODEBITS:
				printf("%-10s ", (char *)mode_string(dn->dstat.st_mode));
				column += 10;
				break;
			case LIST_NLINKS:
				printf("%4ld ", (long)dn->dstat.st_nlink);
				column += 10;
				break;
			case LIST_ID_NAME:
#ifdef BB_FEATURE_LS_USERNAME
				my_getpwuid(scratch, dn->dstat.st_uid);
				printf("%-8.8s ", scratch);
				my_getgrgid(scratch, dn->dstat.st_gid);
				printf("%-8.8s", scratch);
				column += 17;
				break;
#endif
			case LIST_ID_NUMERIC:
				printf("%-8d %-8d", dn->dstat.st_uid, dn->dstat.st_gid);
				column += 17;
				break;
			case LIST_SIZE:
			case LIST_DEV:
				if (S_ISBLK(dn->dstat.st_mode) || S_ISCHR(dn->dstat.st_mode)) {
					printf("%4d, %3d ", (int)MAJOR(dn->dstat.st_rdev), (int)MINOR(dn->dstat.st_rdev));
				} else {
#ifdef BB_FEATURE_HUMAN_READABLE
					if (ls_disp_hr==TRUE) {
						printf("%8s ", make_human_readable_str(dn->dstat.st_size, 1, 0));
					} else 
#endif	
					{
#if defined(_FILE_OFFSET_BITS) && (_FILE_OFFSET_BITS == 64)
						printf("%9lld ", (long long)dn->dstat.st_size);
#else
						printf("%9ld ", dn->dstat.st_size);
#endif
					}
				}
				column += 10;
				break;
#ifdef BB_FEATURE_LS_TIMESTAMPS
			case LIST_FULLTIME:
			case LIST_DATE_TIME:
				if (list_fmt & LIST_FULLTIME) {
					printf("%24.24s ", filetime);
					column += 25;
					break;
				}
				age = time(NULL) - ttime;
				printf("%6.6s ", filetime+4);
				if (age < 3600L * 24 * 365 / 2 && age > -15 * 60) {
					/* hh:mm if less than 6 months old */
					printf("%5.5s ", filetime+11);
				} else {
					printf(" %4.4s ", filetime+20);
				}
				column += 13;
				break;
#endif
			case LIST_FILENAME:
				printf("%s", dn->name);
				column += strlen(dn->name);
				break;
			case LIST_SYMLINK:
				if (S_ISLNK(dn->dstat.st_mode)) {
					char *lpath = xreadlink(dn->fullname);
					if (lpath) {
						printf(" -> %s", lpath);
#ifdef BB_FEATURE_LS_FILETYPES
						if (!stat(dn->fullname, &info)) {
							append = append_char(info.st_mode);
						}
#endif
						column += strlen(lpath) + 4;
					}
				}
				break;

#ifdef BB_FEATURE_LS_FILETYPES
			case LIST_FILETYPE:
				if (append != '\0') {
					printf("%1c", append);
					column++;
				}
				break;
#endif
		}
	}

	return(0);
}
/* END CODE */
/*
Local Variables:
c-file-style: "linux"
c-basic-offset: 4
tab-width: 4
End:
*/
