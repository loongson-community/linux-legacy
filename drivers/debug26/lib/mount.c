#ifdef DEBUG26_LSMOUNT
#include <linux/dcache.h>
#include <linux/mount.h>

static void nr_set_fs_root(struct fs_struct *fs, struct vfsmount *mnt,
		 struct dentry *dentry)
{
	struct dentry *old_root;
	struct vfsmount *old_rootmnt;
	write_lock(&fs->lock);
	old_root = fs->root;
	old_rootmnt = fs->rootmnt;
	fs->rootmnt = mntget(mnt);
	fs->root = dget(dentry);
	write_unlock(&fs->lock);
	if (old_root) {
		dput(old_root);
		mntput(old_rootmnt);
	}
}

static void nr_set_fs_pwd(struct fs_struct *fs, struct vfsmount *mnt,
		struct dentry *dentry)
{
	struct dentry *old_pwd;
	struct vfsmount *old_pwdmnt;

	write_lock(&fs->lock);
	old_pwd = fs->pwd;
	old_pwdmnt = fs->pwdmnt;
	fs->pwdmnt = mntget(mnt);
	fs->pwd = dget(dentry);
	write_unlock(&fs->lock);

	if (old_pwd) {
		dput(old_pwd);
		mntput(old_pwdmnt);
	}
}

char * dentry_path(struct dentry *dentry,struct vfsmount *vfsmnt,
        char *buffer, int buflen)
{
    char * end = buffer+buflen;
    char * retval;
    int namelen;

    *--end = '\0';
    buflen--;
    if (!IS_ROOT(dentry) && list_empty(&dentry->d_hash)) {
        buflen -= 10;
        end -= 10;
        memcpy(end, " (deleted)", 10);
    }

    /* Get '/' right */
    retval = end-1;
    *retval = '/';

    for (;;) {
        struct dentry * parent;

        if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
            /* Global root? */
            if (vfsmnt->mnt_parent == vfsmnt)
                goto global_root;
            dentry = vfsmnt->mnt_mountpoint;
            vfsmnt = vfsmnt->mnt_parent;
            continue;
        }
        parent = dentry->d_parent;
        namelen = dentry->d_name.len;
        buflen -= namelen + 1;
        if (buflen < 0)
            return ERR_PTR(-ENAMETOOLONG);
        end -= namelen;
        memcpy(end, dentry->d_name.name, namelen);
        *--end = '/';
        retval = end;
        dentry = parent;
    }

    return retval;
global_root:
    namelen = dentry->d_name.len;
    buflen -= namelen;
    if (buflen >= 0) {
        retval -= namelen-1;    /* hit the slash */
        memcpy(retval, dentry->d_name.name, namelen);
    } else
        retval = ERR_PTR(-ENAMETOOLONG);
    return retval;
}


static int lsmount(int argc,char **argv)
{
	char buf[400],*p;
	struct vfsmount *vfsmnt;
	struct file *f;

	if(argc<2)
	  {err: return -1;}

        f = filp_open(argv[1], 0,0);
	if(IS_ERR(f))goto err;
if(argc==2)
{
	p=dentry_path(f->f_dentry,f->f_vfsmnt,buf,400);
	nr_printf("path:%s\n",p);
	p=dentry_path(current->fs->root,current->fs->rootmnt,buf,400);
	nr_printf("root:%s\n",p);
}
else if(argc==3 && strlen(argv[2])==2 && argv[2][0]=='-'&& argv[2][1]=='t')
{
	int count=0;
	vfsmnt=f->f_vfsmnt;
	while(1){
	p=dentry_path(vfsmnt->mnt_root,vfsmnt,buf,400);
	nr_printf("%d:%s,%d:%d,%p,%p\n",count,p,MAJOR(vfsmnt->mnt_sb->s_dev),MINOR(vfsmnt->mnt_sb->s_dev),vfsmnt->mnt_mountpoint,vfsmnt->mnt_root);
	if(vfsmnt->mnt_parent == vfsmnt)break;
	vfsmnt=vfsmnt->mnt_parent;
	count++;	
	}
		
}
	filp_close(f,current->files);
	return 0;
}


static int schroot(int argc,char **argv)
{
	char buf[400],*p;
	struct vfsmount *vfsmnt;
	int num,count=0;
	struct file *f;

	if(argc<2){return -1;}
	if(argc==2)num=0;
	else num=simple_strtol(argv[2],0,0);

       	f = filp_open(argv[1], 0,0);
	vfsmnt=f->f_vfsmnt;
	while(1){
	p=dentry_path(vfsmnt->mnt_root,vfsmnt,buf,400);
	if(!strcmp(argv[1],p) && (count==num))break;
		
	if(vfsmnt->mnt_parent == vfsmnt)break;
	vfsmnt=vfsmnt->mnt_parent;
	count++;
	}
		
	filp_close(f,current->files);
	nr_set_fs_root(current->fs, vfsmnt,vfsmnt->mnt_root);
	nr_set_fs_pwd(current->fs, vfsmnt,vfsmnt->mnt_root);
//	set_fs_altroot();
	return 0;
}

mycmd_init(lsmount,lsmount,"lsmount file [-t]","lsmount command");
mycmd_init(schroot,schroot,"schroot dir","super chroot");
#endif
