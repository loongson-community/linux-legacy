#define NENVS 100
struct __myenv_s{
char *name;
char *value;
char *msg;
};

static char env_buf[0x100];
static char *env_head=env_buf;

static struct __myenv_s  __myenv_items[NENVS];

static struct __myenv_s *getenvp(char *name,int create)
{
struct  __myenv_s *p;
 for(p=__myenv_items;p<&__myenv_items[NENVS];p++)
 if(p->name && !strcmp(p->name,name)) return p;

 if(!create)return 0;
 for(p=__myenv_items;p<&__myenv_items[NENVS];p++)
 if(!p->name){p->value=0;p->msg=0;return p;}

return 0;
}


static int setenv(char *name,char *value,char *msg)
{
struct  __myenv_s *p;
char *s;

if(!strcmp(name,"iomap"))
{
	syscall_addrtype=nr_strtol(value,0,0);
}

p=getenvp(name,1);
if(!p){nr_printf("env array full\n");return -1;}
if(!p->name)
          {
		   s=nr_malloc(strlen(name)+1);
		   if(!s)return -1;
		   strcpy(s,name);
		   p->name=s;
		  }
if(value)
{
		   s=nr_malloc(strlen(value)+1);
		   if(!s)goto error;
		   strcpy(s,value);
		   if(p->value)nr_free(p->value);
		   p->value=s;
}

if(msg)
{
		   s=nr_malloc(strlen(msg)+1);
		   if(!s)goto error;
		   strcpy(s,msg);
		   if(p->msg)nr_free(p->msg);
		   p->msg=s;
}

   return 0;
error:
if(p->name){nr_free(p->name);p->name=0;}
if(p->value){nr_free(p->value);p->value=0;}
if(p->msg){nr_free(p->msg);p->msg=0;}
return -1;
}

static char  *getenv(char *name)
{
 struct __myenv_s *p;
 static char val[20];
if(!strcmp(name,"iomap"))
{
	sprintf(val,"0x%x",syscall_addrtype);
	return val;
}

p=getenvp(name,0);
	return p?p->value:0;
}

char  *debug26_getenv(char *name)
{
return getenv(name);
}

int debug26_setenv(char *name,char *value,char *msg)
{
setenv(name,value,msg);
return 0;
}

static int set(int argc,char **argv)
{
struct  __myenv_s *p;
if(argc>4){nr_printf("usage:set [name] [value] [msg]\n");return -1;}
if(argc==1)
{
for(p=__myenv_items;p<&__myenv_items[100];p++)
{
if(!p->name)continue;
 nr_printf("%-20s%-18s%-40s\n",p->name,p->value,p->msg);
}
return 0;
}

if(argc==2){
char *s;
p=getenvp(argv[1],0);
if(p && p->name)
	nr_printf("%-20s%-18s%-40s\n",p->name,getenv(p->name),p->msg);
else
 {
	nr_printf("can not found env var %s\n",argv[1]);return -1;
  }
return 0;
}

setenv(argv[1],argv[2],(argc==3)?0:argv[3]);
return 0;
}


static int unset(int argc,char **argv)
{
struct  __myenv_s *p;
if(argc!=2){nr_printf("usage:unset name\n");return -1;}

p=getenvp(argv[1],0);
        if(!p) return 0;
if(p->name){nr_free(p->name);p->name=0;}
if(p->value){nr_free(p->value);p->value=0;}
if(p->msg){nr_free(p->msg);p->msg=0;}
return 0;
}

char *use_env(char *name)
{
struct  __myenv_s *p;
char *psign,sign,*ret;
int env_v=0;
int env_l;
psign=strchr(name,'+');
if(!psign)psign=strchr(name,'-');
if(!psign)sign=0;
else if(*psign=='+')sign=1;
else sign=-1;
if(psign){
	env_v=nr_strtol(psign+1,0,0);*psign=0;
	env_v=sign*env_v;
}
p=getenvp(name,0);
if(!p)return 0;
if(psign){
	env_l=nr_strtol(p->value,0,0);
	env_v+=env_l;
ret=env_head;
env_head+=sprintf(env_head,"0x%x",env_v)+1;
}
else ret=p->value;
return ret;
}

static int envinit(void)
{
setenv("iomap","-1","iomap address,64 bit cpu address,64 bit cached phyiscal address,64 bit uncached phyiscal address");
setenv("x","d4 0x14000000 100",0);
setenv("y","wf 1.dat 0xffffffffb6000000 ",0);
return 0;
}

myinit_begin(envinit);
mycmd_init(set,set,"set [name] [value] [msg]","set env var");
mycmd_init(unset,unset,"unset name","unset envvar");
