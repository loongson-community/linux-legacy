#include "argvize.c"
#define LINESZ	200		/* max command line length */

static char *expand (char *);
static char *expand1 (char *);
static char  *getenv(char *name);

static int help(int argc,char **argv);

static int quitnow=0;
static int showcmd=0;
static int quit(int argc,char **argv)
{
quitnow=1;
return 0;
}

#include "cmdparser.h"
extern struct myinit  __myinit_begin_begin;
extern struct myinit  __myinit_begin_end;
extern struct myinit  __myinit_end_begin;
extern struct myinit  __myinit_end_end;

static void do_initbegin_calls(void)
{
struct myinit *p;

for(p=&__myinit_begin_begin+1;p!=&__myinit_begin_end;p++)
p->func();
}

static void do_initend_calls(void)
{
struct myinit *p;

for(p=&__myinit_begin_begin+1;p!=&__myinit_begin_end;p++)
{p->func();}
}

extern struct mycmd __mycmd_begin;
extern struct mycmd __mycmd_end;
static int help(int argc,char **argv)
{
struct mycmd *pcmd;
char str[20];
int i;
if(argc==1)
{
   for(pcmd=&__mycmd_begin+1,i=0;pcmd!=&__mycmd_end;pcmd++,i++)
	{
	nr_printf("%-10s:%-30s:%s\n",pcmd->name,pcmd->usage,pcmd->note);
	if(i%16==15){nr_printf("press enter to continue...\n");nr_gets(str,20);}
	}
}
else if(argc==2)
{
 for(pcmd=&__mycmd_begin+1;pcmd!=&__mycmd_end;pcmd++)
	if(!strcmp(pcmd->name,argv[1]))
    {
	nr_printf("%-10s:%-30s:%s\n",pcmd->name,pcmd->usage,pcmd->note);
	break;
	}
 if(pcmd==&__mycmd_end)nr_printf("can not find cmd %s\n",argv[1]);
}
else return -1;

return 0;
}

/*
 *  Execute command
 *  ---------------
 *
 *  Execute the comman string given. If the command string given is
 *  empty, check the 'rptcmd' environment var and repeat the last
 *  command accordingly. If value is 'off' no repeat takes place. If
 *  the value is 'on' all commands repeatable can be repeated. If
 *  value is 'trace' only the 't' and 'to' commands will be repeated.
 */
char *_do_cmd(char *p_in,int need_end);

void do_cmd(char *p)
{
_do_cmd(p,0);
}

char *_do_cmd(char *p_in,int need_end)
{
	char	*av[MAX_AC];	/* argument holder */
	int32_t	ac;		/* # of arguments */
	int	 nc, j, c;
	struct mycmd *pcmd;
	char *p,*p_cmd;

cmd_loop:
	p_cmd=p_in;
	for (; *p_in;) {
		c = *p_in;
		if(c == '\'' || c == '"') {
			p_in++;
			while (*p_in && *p_in != c) {
				++p_in;
			}
			if(*p_in) {
				p_in++;
			}
			else {
				nr_printf("unbalanced %c\n", c);
				return p;
			}
		}
		else if((c == ';')||(c == '\n')) {
			*p_in++ = 0;
			goto run_a_cmd;
		}
		else {
			p_in++;
		}
	}
	if(need_end)return p_cmd;
run_a_cmd:

	/* Expand command substituting $vars. Breakup into separate cmds */

	if(!(p = expand (p_cmd))) {
		return p_cmd;
	}

	if(!(p = expand1 (p))) {
		return p_cmd;
	}

	nc = 0;

	/*
	 *  Lookup command in command list and dispatch.
	 */
	do{
		int stat = -1;
		if(showcmd)nr_printf("#%s\n",p);
		ac = argvize (av, p);
		if(ac == 0) {
			break;
		}


   for(pcmd=&__mycmd_begin+1;pcmd!=&__mycmd_end;pcmd++)
   if(!strcmp(av[0],pcmd->name))break;
   if(pcmd!=&__mycmd_end)
	stat = pcmd->func(ac, av);
   else 
   {nr_printf("syntax error");stat=0;}

		if(stat < 0) {
		nr_printf("usage:%-10s:%-30s:%s\n",pcmd->name,pcmd->usage,pcmd->note);
		}

		if(stat != 0) {
			return p_in;	/* skip commands after ';' */
		}
	}while(0);

if(*p_in)goto cmd_loop;
return p_in;
}

/*
 * expand(cmdline) - expand environment variables
 * entry:
 *	char *cmdline pointer to input command line
 * returns:
 *	pointer to static buffer containing expanded line.
 */
static char *
expand(cmdline)
	char *cmdline;
{
	char *ip, *op, *v;
	char var[256];
	static char expline[LINESZ + 8];

	if(!strchr (cmdline, '$')) {
		return cmdline;
	}

	ip = cmdline;
	op = expline;
	while (*ip) {
		if(op >= &expline[sizeof(expline) - 1]) {
			nr_printf ("Line too long after expansion\n");
			return (0);
		}

		if(*ip != '$') {
			*op++ = *ip++;
			continue;
		}

		ip++;
		if(*ip == '$') {
			*op++ = '$';
			ip++;
			continue;
		}

		/* get variable name */
		v = var;
		if(*ip == '{') {
			/* allow ${xxx} */
			ip++;
			while (*ip && *ip != '}') {
				*v++ = *ip++;
			}
			if(*ip && *ip != '}') {
				nr_printf ("Variable syntax\n");
				return (0);
			}
			ip++;
		} else {
			/* look for $[A-Za-z0-9]* */
			while (isalpha(*ip) || isdigit(*ip)) {
				*v++ = *ip++;
			}
		}

		*v = 0;
		if(!(v = getenv (var))) {
			nr_printf ("'%s': undefined\n", var);
			return (0);
		}

		if(op + strlen(v) >= &expline[sizeof(expline) - 1]) {
			nr_printf ("Line expansion ovf.\n");
			return (0);
		}

		while (*v) {
			*op++ = *v++;
		}
	}
	*op = '\0';
	return (expline);
}

static char *expr(char *cmd)
{
char *token;
unsigned int op='+';
unsigned long result=0;
static char cmd1[0x100];
char *inp=cmd;
char *outp=cmd1;
unsigned long data;
char c=0x20;
int deep;
const char *fmt="+-*/\\%|&^hpod";

while(*inp)
{
	if(strchr(fmt,*inp)){
	if(c!=0x20){*outp++=0x20;}
	*outp++=*inp++;*outp++=0x20;c=0x20;
	continue;
	}
	if(*inp==0x20||*inp=='\t'){inp++;continue;}
	*outp++=c=*inp++;
}

*outp=0;
inp=cmd1;

   while(*inp)
   {
	 while(*inp==' '||*inp=='\t')inp++;

	 if(*inp=='('){
		 token=++inp;
		 deep=1;
		 while(1)
		 {
			 if(deep<1 || !*inp){nr_printf("error synax");return 0;}
			 if(*inp==')' && deep==1){*inp=0;inp++;break;}
		 	 if(*inp=='('){inp++;deep++;continue;}
		 	 if(*inp==')'){inp++;deep--;continue;}
			 ++inp;
		 }
		 token=expr(token);
	 }
	 else {
	 token=inp;
	 while(*inp!=' ' && *inp!='\t' && *inp!=0)inp++;
	 if(*inp){*inp=0;inp++;}
	 }

	if(!token||!*token)break;
	if(token[1]==0 && strchr(fmt,*token)){op=*token;continue;}
	data=nr_strtol(token,0,0);
	switch(op)
	{
		case '+':result=result+data;break;
		case '-':result=result-data;break;
		case '*':result=result*data;break;
		case '/':result=result/data;break;
		case '\\':result=data/result;break;
		case '%':result=result%data;break;
		case '|':result=result|data;break;
		case '&':result=result&data;break;
		case '^':result=result^data;break;
		case '~':result=~result;break;
	}

   }
   switch(op)
   {
	   case 'd':sprintf(cmd1,"%ld",result);break;
	   case 'p':sprintf(cmd1,"%p",(void *)result);break;
	   case 'o':sprintf(cmd1,"0%lo",result);break;
	   default:sprintf(cmd1,"0x%lx",result);break;
   }
   return cmd1;
}

static char *expand1(char *cmdline)
{
	char *ip, *op, *v;
	char var[256];
	static char expline[LINESZ + 8];

	if(!strchr (cmdline, '`')) {
		return cmdline;
	}

	ip = cmdline;
	op = expline;
	while (*ip) {
		if(op >= &expline[sizeof(expline) - 1]) {
			nr_printf ("Line too long after expansion\n");
			return (0);
		}

		if(*ip != '`') {
			*op++ = *ip++;
			continue;
		}

		ip++;
		if(*ip == '`') {
			*op++ = '`';
			ip++;
			continue;
		}

		/* get variable name */
		v = var;
			while (*ip && *ip != '`') {
				*v++ = *ip++;
			}
			if(*ip && *ip != '`') {
				nr_printf ("Variable syntax\n");
				return (0);
			}
			ip++;

		*v = 0;
		if(!(v = expr (var))) {
			nr_printf ("'%s': undefined\n", var);
			return (0);
		}

		if(op + strlen(v) >= &expline[sizeof(expline) - 1]) {
			nr_printf ("Line expansion ovf.\n");
			return (0);
		}

		while (*v) {
			*op++ = *v++;
		}
	}
	*op = '\0';
	return (expline);
}

int cmd_expr(int argc,char **argv)
{
	if(argc!=2)return -1;
	nr_printf("%s\n",expr(argv[1]));
	return 0;
}

mycmd_init(h,help,"h","show this help");
mycmd_init(q,quit,"q","quit this shell");
mycmd_init(expr,cmd_expr,"expr","expr");
