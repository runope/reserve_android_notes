
from idautils import *
from idaapi import *
from idc import *


f = open(r"CryptoTest_32\CryptoTest\lib\func.txt",'r')
func_info = {}
while True:
    info = f.readline().strip('\n')
    if not info:
        break
    addr, func_name = info.split(',')
    # print(addr + func_name)
    func_info[int(addr,10)] = func_name
# print(func_info)
f.close()


textStart = 0xA2984
textEnd = 0xC2000
# textStart = 0xA2DE0
# textEnd = 0xA2E04
libc_dump_base = 0xe494b000
for i in range(textStart,textEnd,4):
    dword_ = get_dword(i)
    if dword_ > libc_dump_base:
        libc_func = dword_ - libc_dump_base
        # print(dword_,libc_func)
        func_name = func_info.get(libc_func)
        if not func_name:
            func_name = func_info.get(libc_func-1)  #thumb
        if not func_name:
            continue
        raw_name_off = get_name(i)
        patch_name_off = func_name + "_ptr_" + raw_name_off
        set_name(i,patch_name_off)
        xrefaddrs = XrefsTo(i, flags=0)
        for xrefaddr in xrefaddrs:
            raw_name = get_func_name(xrefaddr.frm)          #拿到函数原名称
            patch_fun_addr = get_name_ea_simple(raw_name)   #拿到函数地址
            # print(get_func_name(xrefaddr.frm))
            if raw_name and patch_fun_addr:
                break
        if raw_name and patch_fun_addr:
            patch_name = func_name + "_" + raw_name
            print("patch_name : ",patch_name)
            set_name(patch_fun_addr,patch_name)
        print(dword_,func_name)
