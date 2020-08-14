#ifdef DEBUG26_MYREQUEST_IRQ
struct myirqlist{
		struct myirqlist *next;
		void (*handler)(int, void *, struct pt_regs *);
		void *dev_id;
		int irq;
} *head=0;

static int run=0;
static int stop=0;

static int mythread(void *unused)
{

	struct myirqlist *q;
run=1;
strcpy(current->comm,"irqthread");
while(1)
{
if(stop){run=0;exit(0);}
schedule();
	for(q=head;q;q=q->next)
	{
	 q->handler(0,q->dev_id,0);
	}
}
return 0;
}
int myrequest_irq(unsigned int irq,
		void (*handler)(int, void *, struct pt_regs *),
		unsigned long irqflags,
		const char * devname,
		void *dev_id)
{
	struct myirqlist **p,*q;
	q=(void *)kmalloc(sizeof(struct myirqlist), GFP_KERNEL);
	if(!q)return -1;
	q->irq=irq;
	q->handler=handler;
	q->dev_id=dev_id;
	q->next=0;
	for(p=&head;*p;p=&(*p)->next);
	*p=q;
	if(!run){run=1;kernel_thread(mythread,0,CLONE_FS | CLONE_FILES );}
	return 0;
}

void myfree_irq(unsigned int irq, void *dev_id)
{
	struct myirqlist **p,*q;
	for(p=&head;*p;p=&(*p)->next)
	{
		if(((*p)->irq == irq) && ((*p)->dev_id == dev_id))
		{
			q=*p;
			*p=(*p)->next;
			kfree(q);
		if(!*p)break;
		}
	}
}

static struct mytimerlist{
		struct mytimerlist *next;
		void (*handler)(int, void *, struct pt_regs *);
		void *dev_id;
		struct timer_list timer;		/* Media monitoring timer. */
		int irq;
}*timerhead=0;

static void netdev_timer(unsigned long data)
{
	struct mytimerlist *np = (struct net_device *)data;
	np->handler(0,np->dev_id,0);
	np->timer.expires = jiffies + 1;
	add_timer(&np->timer);
}

int myrequest_irq1(unsigned int irq,
		void (*handler)(int, void *, struct pt_regs *),
		unsigned long irqflags,
		const char * devname,
		void *dev_id)
{
	struct mytimerlist **p,*q;
	q=(void *)kmalloc(sizeof(struct mytimerlist), GFP_KERNEL);
	if(!q)return -1;
	memset(q,0,sizeof(*q));
	q->irq=irq;
	q->handler=handler;
	q->dev_id=dev_id;
	init_timer(&q->timer);
	q->timer.expires = jiffies + 1;
	q->timer.data = (unsigned long)q;
	q->timer.function = &netdev_timer;				/* timer handler */
	for(p=&timerhead;*p;p=&(*p)->next);
	*p=q;
	add_timer(&q->timer);

	return 0;
}

void myfree_irq1(unsigned int irq, void *dev_id)
{
	struct myirqlist **p,*q;
	for(p=&timerhead;*p;p=&(*p)->next)
	{
		if(((*p)->irq == irq) && ((*p)->dev_id == dev_id))
		{
			q=*p;
			*p=(*p)->next;
			kfree(q);
		if(!*p)break;
		}
	}
}

int thread_cmd(int argc,char **argv)
{
if(argc!=2)return -1;
if(!strcmp(argv[1],"start"))
{
	if(run){nr_printf("thread is running\n");return -1;}
	kernel_thread(mythread,0,CLONE_FS | CLONE_FILES );
	return 0;
}
if(!run){nr_printf("thread is already stoped now\n");return -1;}
stop=1;
while(run)
	schedule();
stop=0;

return 0;
}


mycmd_init(thread,thread_cmd,"thread [start|stop]","poll thread");
#endif
