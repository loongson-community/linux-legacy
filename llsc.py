import sys;
import os;
import re;

f={}
o=os.popen('mipsel-linux-objdump --prefix-addresses -d vmlinux');

line=o.readline()
while line:
    m=re.match('^([\da-f]{8})\s.*\sll\s',line)
    if m:
        s=os.popen ('addr2line ' + m.groups()[0] + ' -e vmlinux').read().split(':')
	f[s[0]]=m.groups()[0]
    
    line=o.readline()

for i in f.keys():
 print i,f[i]

