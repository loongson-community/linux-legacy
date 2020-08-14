#ifndef __CMDPARSER_H 
#define __CMDPARSER_H
struct mycmd{
char *name;
int (*func)(int argc,char **argv);
char *usage;
char *note;
};

struct myinit{
int (*func)(void);
};
#define mycmd_init(name,func,usage,note)                              \
	    struct mycmd  __mycmd_##name __attribute__ ((unused,__section__ (".mycmd"))) = {#name,func,usage,note};

#define myinit_begin(func)                              \
	    struct myinit  __myinit_begin_##func  __attribute__ ((unused,__section__ (".myinit.begin"))) ={func};

#define myinit_end(func)                              \
	    struct myinit  __myinit_end_##func __attribute__ ((unused,__section__ (".myinit.end"))) = {func};
#endif
