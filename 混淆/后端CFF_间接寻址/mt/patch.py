import keystone
from capstone import *
import idc
import ida_bytes
import subprocess
 
arch = keystone.KS_ARCH_ARM
mode = keystone.KS_MODE_THUMB
ks = keystone.Ks(arch, mode)
md = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
 
def is_BLX_sub407C(ea):
    ldr_addr = ea
    ldr_flags = idc.get_full_flags(ldr_addr)
    if not idc.is_code(ldr_flags):
        return False
 
    if idc.print_insn_mnem(ldr_addr) != 'BLX':
        return False
 
    if idc.print_operand(ldr_addr, 0) != 'sub_407C':
        return False
 
    return True
 
def is_BLX_sub4094(ea):
    ldr_addr = ea
    ldr_flags = idc.get_full_flags(ldr_addr)
    if not idc.is_code(ldr_flags):
        return False
 
    if idc.print_insn_mnem(ldr_addr) != 'BLX':
        return False
 
    if idc.print_operand(ldr_addr, 0) != 'sub_4094':
        return False
 
    if idc.print_insn_mnem(ldr_addr - 2) != 'PUSH':
        return False
 
    if idc.print_insn_mnem(ldr_addr + 8) != 'POP':
        return False
 
    return True
 
def func_patch():
 
    ins_addr = idc.next_head(0)
    while ins_addr != idc.BADADDR:
 
         if is_BLX_sub407C(ins_addr):
            for i in CodeRefsTo(ins_addr, False):
                if idc.get_wide_word(i + 4) == 18112:
                    index = idc.get_wide_word(i + 6)
                    patch_qword(i + 6, 0x46C046C0)
                    idc.create_insn(i + 6)
                else:
                    index = idc.get_wide_word(i + 4)
                    patch_qword(i + 4, 0x46C046C0)
                    idc.create_insn(i + 4)
                print("i:" + hex(i))
                index = index * 4 + ins_addr + 4
                offset = ida_bytes.get_dword(index)
                target = ins_addr + 0x4 + offset
                command = "BL " + hex(target)
                print("command:" + command)
                # encoding, _ = ks.asm(command, target)
                pi = subprocess.Popen(['E:\\reserve\\keystone-0.9.2-win64\\kstool.exe', 'thumb', command, \
                hex(i)], shell=True, stdout=subprocess.PIPE)
                output = pi.stdout.read()
                ins = str(output[-15:-4])[2:-1]
                ins = ins.split(" ")

                # for idx, c in enumerate(encoding):
                #     if isinstance(c, str):
                #         c = ord(c)
                #     patch_byte(target + idx, c)
                ins = "0x" + ins[3] + ins[2] + ins[1] + ins[0]
                print("ins:" + ins)
                patch_dword(i, int(ins, 16))
 
         if is_BLX_sub4094(ins_addr):
            patch_dword(ins_addr - 2, 0xbf00)
            patch_dword(ins_addr, 0xbf00)
            patch_dword(ins_addr + 2, 0xbf00)
            patch_dword(ins_addr + 4, 0xbf00)
            patch_dword(ins_addr + 6, 0xbf00)
            patch_dword(ins_addr + 8, 0xbf00)
 
         ins_addr = idc.next_head(ins_addr)
 
func_patch()