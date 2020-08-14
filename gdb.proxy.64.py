#!/usr/bin/python
import re
import os
from socket import socket,TCP_NODELAY
import select
from signal import signal,SIGINT,SIG_IGN
import select

def csum(s):
 sum=0
 for i in xrange(len(s)):
  sum += ord(s[i])
 return sum&0xff


def send_to_qemu(s,b):
 c=csum(b)
 s.sendall("+\$" + b + "#%02x"%(c))
 while 1:
  if s.recv(ack) : break
 return ack
   

def recv_from_qemu(s,l):
    a='';
    while 1:
       b = s.recv(s, 2048)
       a += b
       if re.findall('#\w{2}',a):
          break
    s.send ('+',0)
    return a

def read_addr(s,b):
    send_to_qemu(s,b)
    b=recv_from_qemu(s,100)
    #return re.sub('(\w{2})',lambda x: chr(int(x.group(),16)),b)
    return b.decode('hex')

def read_addr8(s,d):
    send_to_qemu(s,"m%#016x,8" %(d))
    b=recv_from_qemu(s,100)
    return struct.unpack('Q',b.decode('hex'))[0]

def read_addr4(s,d):
    send_to_qemu(s,"m%#016x,4" %(d))
    b=recv_from_qemu(s,100)
    return struct.unpack('I',b.decode('hex'))[0]

def getpgd(addr):
    if (addr&0xf0000000) == 0xc0000000:
        curpgd = sym['swapper_pg_dir']
    elif (addr&0xc0000000) == 0xc0000000:
        curpgd = sym['swapper_pg_dir']
    elif debugpgd:
        curpgd = debugpgd
    else :
        curpgd=read_addr8(socket, sym['pgd_current'])
    return curpgd

def accesshelper(head,addr,tail,pgd):

        mask = ((1<<pageshift)-8);
        mask1 = ((1<<pageshift)-16);
        #printf("read 0x%x\n", $addr);
#right shift(14+1), left shit log2(2item) : 11 = (14+1-4) (pageshift+1-log2(2item)) 
# 11 = (14-3)
# 12-2
        pmd=read_addr8(sock,((addr>>((pageshift-3)*3))&mask) + pgd);
        pud=read_addr8(sock,((addr>>((pageshift-3)*2))&mask) + pmd);
        pte=read_addr8(sock,((addr>>(pageshift-3)) & mask1) + pud);
        pte1=read_addr8(sock,((addr>>($pageshift-3)) & mask1) + 8 + pud);
        #printf("pud=%x pte=%x pte1=%x\n", $pud, $pte, $pte1);


        if addr&(1<<pageshift):
            if pte1&(2<<$pteshift):
                addr1 = 0x9800000000000000 + ((pte1>>(pteshift+6))<<12) + (addr&((1<<pageshift)-1));
            else :
            return None;
        else :
            if pte&(2<<pteshift) :
                addr1 = 0x9800000000000000 + ((pte>>(pteshift+6))<<12)  + (addr&((1<<pageshift)-1));
            else :
             return None;

        newbuf = (head +"%016x" + tail) % (addr1);
        buf='$' + newbuf + ('#%02x' % (csum(newbuf)));
        return buf;


def probepte():
    my ($ins, $i);
    for i in range(0x30,0x50;4):
        ins = read_addr4(sock,0xffffffff80000080+i);
        #srl
        if ((ins & 0xffe0003f) == 2):
            pteshift = ((ins>>6)&0x1f);
        #mtc0
        if ((ins & 0xffe00000) == 0x40800000):
            break;

    if debuginfo: print 'g: pteshift:'+'pteshift\n'



pageshift = 14;
pteshift = 5;
debugpgd = 0;
enablesb = 'ENV_memsize' in os.environ.keys();
debuginfo = 0;
fg = 0
func={}

if 'FG' not in os.environ.keys():
    signal(SIGINT,SIG_IGN)
    fg = 0


if  len(sys.argv)>=2:
    f = os.popen('nm ' + sys.argv[1]);
    map(lambda x: func[x] = 1, ('swapper_pg_dir', 'pgd_current', 'module_kallsyms_lookup_name'))

    l=f.readline()
    while l:
        a=re.split(r'\s',s)
        if a[2] in func:
            sym[a[2]] = int(a[0],16)
    f.close()

if 'swapper_pg_dir' in sym:
    print 'swapper_pg_dir %#x\n' % (sym['swapper_pg_dir'])

if not fg and fork(): exit(0)


sock=socket.socket()
peeraddr = ('',50010)
if len(sys.argv)>1:
    peeraddr = re.match(r'(.*):(\d+)',sys.argv[1]).groups()
    perraddr = (addr[0],int(addr[1]))

sock.connect(peeraddr)

server = socket.socket()

server.listen(5)
server.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
server.bind(('',9000))

client = server.accept()


sock.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1);
client.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1);

ready = select.select([sock,client],[],[])


for fh in ready:
        if (fh == sock): 
            $ret = recv($sock, $buf, 4096, MSG_DONTWAIT);

            if(defined($ret))
            {
                last TOP if !length($buf);
                print $client "$buf";
                #print qq(q: $buf\n);
            }
        }
        else {
            $ret = recv($client, $buf, 4096, MSG_DONTWAIT);
            if(defined($ret))
            {

                last TOP if !length($buf);
               if(defined($sym{q(swapper_pg_dir)}))
               {
                if($buf=~/\$m(\w+)(,\w+)#/)
                {
                    $addr=Math::BigInt->new("0x" . $1);
                    $tail=$2;
                    if((($addr>>32)&0xf0000000)==0xc0000000)
                    {
                        my $pgd=$sym{q(swapper_pg_dir)};
                        $buf = accesshelper("m",$addr - Math::BigInt->new(q(0xc000000000000000)), $tail,$pgd);
                    }
                    elsif($addr<0x80000000)
                    {

                        $buf = accesshelper("m", $addr, $tail, getpgd($addr));
                    }
                    elsif(($addr>>32)==0xffffffff && ($addr&0xc0000000)==0xc0000000)
                    {
                        my $pgd=$sym{q(swapper_pg_dir)};
                        $buf = accesshelper("m", $addr, $tail, $pgd);
                    }
                }
                elsif($enablesb && $buf=~/\$z0,(\w+)(,\w+)#/)
                {
                    $addr=Math::BigInt->new("0x" . $1);
                    $tail=$2;
                    $buf = accesshelper("z0,",$addr, $tail, getpgd($addr)) if((($addr)&0xf0000000)==0xc0000000);
                }
                elsif($enablesb && $buf=~/\$Z0,(\w+)(,\w+)#/)
                {
                    $addr=Math::BigInt->new("0x" . $1);
                    $tail=$2;
                    $buf = accesshelper("Z0,",$addr, $tail, getpgd($addr)) if((($addr)&0xf0000000)==0xc0000000);
                }
              }

                if($buf=~/\$qRcmd,(\w+)#/)
                {
                 my $cmd=pack("H*",qq($1));
                 if($cmd=~/setpgd\s+(\w+)/)
                 {
                 print qq(cmd $cmd $1\n);
                 $debugpgd=Math::BigInt->new($1);
                 print $client q(+$OK#9a);
                 next;
                 }
                 elsif($cmd=~/setpgsize\s+(\w+)/)
                 {
                 print qq(cmd $cmd $1\n);
                 my $pagesize=Math::BigInt->new($1);
                 for($i=12;$i<25;$i++)
                 {
                   last if((1<<$i) == $pagesize);
                 }
                 $pageshift = $i;
                 probepte();
                 print $client q(+$OK#9a);
                 next;
                 }
                 elsif($cmd=~/kernel\s+kallsyms/)
                 {
                     if(defined($sym{q(module_kallsyms_lookup_name)}))
                     {
                        my $t = unpack("H*","set \$mykallsyms=1\n");
                         printf $client q(+$%s#%02x),$t,csum($t);
                     }
                     else
                     {
                        my $t = unpack("H*","set \$mykallsyms=0\n");
                         printf $client q(+$%s#%02x),$t,csum($t);
                     }
                 next;
                 }
                 elsif($cmd=~/enablesb\s+(\d)/)
                 {
                 $enablesb = $1;
                 print $client q(+$OK#9a);
                 next;
                 }
                 elsif($cmd=~/debug\s+(\d)/)
                 {
                 $debuginfo = $1;
                 print $client q(+$OK#9a);
                 next;
                 }
                 elsif($cmd=~/perl\s+/)
                 {
                  eval substr($cmd,4);    
                 print $client q(+$OK#9a);
                 next;
                 }
                }

                if(!defined($buf))
                {
                    printf $client q(+$E14#aa);
                    next;
                }
                print $sock $buf;
                print qq(g: $buf\n) if $debuginfo;
            }
        }
    }
}



close($sock);
close($client);
close($server);

