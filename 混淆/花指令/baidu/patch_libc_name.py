from idautils import *
from idc import *

flag = 0
pass_line = 75
for line in open("E:\\reserve\\idapython\\baidu\\sub_B3B4.c", 'r', encoding='utf-8'):
    if pass_line > 0:
        pass_line -= 1
        continue
    if flag == 0:
        try:
            line_split = line.split("\"")
            funcname = line_split[-2]
            funcname += "_libc"
            flag = 1
        except:
            pass
        continue
    if flag == 1:
        addrname = line[8:13]
        addrname = int(addrname, 16)
        set_name(addrname, funcname, SN_CHECK)
        flag = 0
