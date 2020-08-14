
static int console_open(struct inode *inode, struct file *filp)
{
return 0;
}

char buf[1024];
char *head;
char *tail;

inline char *pnext(char *ptr)
{
	return (ptr==&buf[1023])?buf:(ptr+1);
}

inline int bufempty()
{
	return (head==tail)?1:0;
}

inline int buffull()
{
	return (pnext(head)==tail)?1:0;
}

inline int buflen()
{
	int len;
	if(head<tail)len=tail-head;
	else if(head>tail)len=tail-head+1024;
	else len=0;
	return len;
}

inline int buflen1()
{
	int len;
	if(head<tail)len=tail-head;
	else if(head>tail)len=buf+1024-head;
	else len=0;
	return len;
}

inline void bufeat(int count)
{
	int len;
	if(head<tail)head=head+count;
	else if(head>tail)head=head+count-1024;
}


ssize_t console_write (struct file *filp, const char *buf,
                size_t count, loff_t *f_pos)
{
    int retval = count;
	unsigned char *ptr;
    unsigned char *kbuf=kmalloc(count+1, GFP_KERNEL);
    if (!kbuf) return -ENOMEM;
    if (copy_from_user(kbuf, buf, count))
	return -EFAULT;
    ptr=kbuf;
	ptr[count]=0;
	prom_printf("%s",ptr);
    kfree(kbuf);
    return retval;
}

DECLARE_WAIT_QUEUE_HEAD(myqueue);

ssize_t console_read (struct file *filp, char *buf,
                size_t count, loff_t *f_pos)
{
    int retval,len1,once,real;
    unsigned char *ptr;
	real=min(buflen(),count);
	if(!real){
	interruptible_sleep_on(&myqueue);
    real=min(buflen(),count);
	}
	retval=real;

	while(real)
	{
	len1==buflen1();
	once=min(real,len1);
	copy_to_user(buf,head,once);
	buf=buf+once;
	real-=once;
	bufeat(once);
	}

    return retval;
}

static int console_close(struct inode * inode, struct file * file)
{
  /* do nothing for now */
  return 0;
}




struct file_operations console_fops =
{
  .read    = console_read,
  .write   = console_write,
  .open    = console_open,
  .release = console_close
};


static void qch_init_int_timer();

static struct timer_list qch_int_timer;


#if 0
static void qch_int_timer_do (unsigned long ptr)
{
	static char c=0;
	while(c||mpsc_test_char_debug())
	{
	  wake_up(&myqueue);
	 if(buffull())break;
	 if(!c)
	{
	  c=mpsc_getchar_debug();
	  if(c=='\r')c='\n';
	  if(c=='\r'){
	  *tail='\r';
	  tail=pnext(tail);
	  c='\n';
	  if(buffull())break;
	  }

	 }
	 *tail=c;
	 tail=pnext(tail);
	 c=0;
	}
		
    qch_init_int_timer ();
}
#endif
static void qch_int_timer_do (unsigned long ptr)
{
	char c;
	int wake=0;
	while(mpsc_test_char_debug())
	{
	 if(buffull())break;
	 wake=1;
	  c=mpsc_getchar_debug();
	  if(c=='\r')c='\n';
	 *tail=c;
	 tail=pnext(tail);
	}
	 if(wake)wake_up(&myqueue);
		
    qch_init_int_timer ();
}

static void qch_init_int_timer()
{
    init_timer (&qch_int_timer);
    qch_int_timer.function = (void *)qch_int_timer_do;
    qch_int_timer.data = 0;
    mod_timer(&qch_int_timer,jiffies + 1);
}

static int consoledev=0;
static void console_init()
{
head=buf;
tail=buf;
consoledev=register_chrdev(DEBUG_MAJOR+1, "console", &console_fops);
if(consoledev<0)
	printk("<0>register_chrdev DEBUGMAJOR 63 fail\n");
else 	{
	printk("<0>register_chrdev DEBUGMAJOR 63 succeed\n");
	qch_init_int_timer();
	}

}

static void console_exit()
{
if(consoledev>=0)unregister_chrdev(DEBUG_MAJOR+1, "console");
}
