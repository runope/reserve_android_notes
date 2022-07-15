from idautils import *
from idaapi import *
from idc import *

import string

rodata_start_addr = 0x959b0
rodata_end_addr = 0x9af68

def get_string(addr):
    out = ""
    while True:
        if get_byte(addr) != 0:
            out += chr(get_byte(addr))
        else:
            break
        addr += 1
    return out

addr = rodata_start_addr
index = 0

while addr < rodata_end_addr:
    str_encode = get_string(addr)
    str_len = len(str_encode) + 1
    if all(c in string.hexdigits for c in str_encode) and str_len > 8:
        xref_addrs = XrefsTo(addr, flags=0)
        for xref_addr in xref_addrs:
            call_addr = xref_addr.frm
            while print_insn_mnem(call_addr) != "BL":
                call_addr = next_head(call_addr)
        decode_func_addr = print_operand(call_addr, 0)
        print("\"" + decode_func_addr + "---" + str_encode +"\",")
    
    addr += str_len