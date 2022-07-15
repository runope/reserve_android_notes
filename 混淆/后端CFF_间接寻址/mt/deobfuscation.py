import keystone
import idc
from ida_bytes import *
import idautils
from idaapi import *

ARCH = keystone.KS_ARCH_ARM
MODE = keystone.KS_MODE_THUMB
ks = keystone.Ks(ARCH, MODE)


def is_br_inst(insn):
    return insn.itype in [ARM_bl, ARM_b, ARM_bx]

def get_ldr_value(insn):
    assert insn.itype == ARM_ldr
    assert insn.Op2.type == o_mem
    value = get_dword(insn.Op2.addr)
    return value

def get_bl_addr(insn):
    assert insn.itype == ARM_bl
    assert insn.Op1.type == o_near
    value = insn.Op1.addr
    return value

def is_code_addr(ea):
    addr_flags = idc.get_full_flags(ea)
    return idc.is_code(addr_flags)

def is_obfuscated_0x407c(ea):
    insn = idautils.DecodeInstruction(ea)

    # 1. ldr r0, @32[mem]
    if (not hasattr(insn, "itype"))  or insn.itype != ARM_ldr or insn.Op1.type != idc.o_reg or insn.Op1.reg != 0x0 or insn.Op2.type != o_mem:
        return (False, None, None)
    ldr_value = get_ldr_value(insn)

    # 2. BL loc_688C
    insn_addr = idc.next_head(ea)
    if not is_code_addr(ea): 
        return (False, None, None)
    insn = idautils.DecodeInstruction(insn_addr)
    if insn == None or insn.itype != ARM_bl or insn.Op1.type != idc.o_near:
        return (False, None, None)
    bl_addr = get_bl_addr(insn)

    # 3. blx sub_7584
    blx_addr = bl_addr
    if not is_code_addr(ea): 
        return (False, None, None)
    insn = idautils.DecodeInstruction(blx_addr)
    # if insn.itype != 0x2e or insn.Op1.type != idc.o_near or insn.Op1.addr != 0x7584:
    if insn == None or insn.itype != 0x2e or insn.Op1.type != idc.o_near or insn.Op1.addr != 0x407c:
        return (False, None, None)

    return (True, ldr_value, blx_addr)
    print(hex(insn_addr))

def is_obfuscated_0x4094(ea):
    insn = idautils.DecodeInstruction(ea)
    if insn!= None and insn.itype == ARM_blx1 and insn.Op1.type == idc.o_near and insn.Op1.addr == 0x4094:
        return True

def rel(addr, base_addr):
    return hex(addr - base_addr).rstrip('L')

def make_thumb_code(head):
    idc.split_sreg_range(head, "T", 1, SR_user)
    del_items(head, 1)
    create_insn(head)

def fill_ops(ea, codes):
    ''' fill ea with codes '''
    for idx, c in enumerate(codes):
        if isinstance(c, str):
            c = ord(c)
        patch_byte(ea + idx, c)
    make_thumb_code(ea)

def fill_nop(ea, length):
    ''' fill ea with nops '''
    codes, count = ks.asm("nop")
    c = 0
    assert (len(codes) == 2)
    while c < length:
        patch_byte(ea + c, codes[0])
        patch_byte(ea + c + 1, codes[1])
        c += 2
    make_thumb_code(ea)

def patch_obfuscated(push_addr, ldr_value, blx_addr):
    LR_INIT = blx_addr + 4
    if LR_INIT & 0b11:
        print("LR_INIT is not align: ", LR_INIT, )
        LR_INIT &= 0xfffffffc
        print(" -> align: ", LR_INIT)

    patch_addr = push_addr
    jmp_addr = LR_INIT + get_wide_dword(LR_INIT + int(ldr_value << 2))

    # code_asm = "b.w #%s" % (rel(jmp_addr, patch_addr))
    # ks.asm(asm, patch_addr)会用patch_addr的地址去求相对偏移，不用自己算
    code_asm = "bl #%s" % jmp_addr
    encoding, _ = ks.asm(code_asm, patch_addr)

    # for item in enumerate(encoding):
    #     idc.patch_byte(patch_addr + item[0], item[1])


    fill_ops(patch_addr, encoding)
    fill_beg = patch_addr + len(encoding)
    fill_end = patch_addr + 8
    fill_nop(fill_beg, fill_end - fill_beg)


    check_code_items(jmp_addr, idc.get_sreg(patch_addr, 'T'))
    pass

def check_code_items(ea, t_flag):
    addr = ea
    flags = idc.get_full_flags(ea)
    if not idc.is_head(flags):
        idc.del_items(idc.get_item_head(ea))
        addr = idc.next_head(ea)
    
    while addr != idc.BADADDR:
        flags = idc.get_full_flags(addr)
        if not idc.is_code(flags) or idc.get_sreg(addr, "T") != t_flag:
            idc.del_items(addr)
            addr = idc.next_head(addr)
        else: 
            break

    if idc.get_sreg(ea, 'T') != t_flag:
        idc.split_sreg_range(ea, 'T', t_flag)

def patch_so():
    ins_addr = idc.next_head(0)
    count = -1
    time = 0

    # addr = idc.next_head(0)
    # while addr < 0x8B000:
    #     insn = idautils.DecodeInstruction(addr)
    #     if insn != None:
    #         # make_thumb_code(addr)
    #         if insn.itype == 0x2e and insn.Op1.type and idc.o_near and insn.Op1.addr == 0x407c:
    #             make_thumb_code(addr)
    #             print('[*] blx 407c, make_thumb_code: %x' %addr)
    #     addr = addr + 2

    # idc.auto_wait()

    while count != 0:
        ins_addr = idc.next_head(0)
        count = 0
        time += 1
        while ins_addr != idc.BADADDR:          
            if not is_code_addr(ins_addr):
                ins_addr = idc.next_head(ins_addr)
                continue
            (flags, ldr_value, blx_addr) = is_obfuscated_0x407c(ins_addr) # 或者直接用一个CodeRefsTo(ins_addr, False)找交叉引用
            if flags:
                patch_obfuscated(ins_addr - 2, ldr_value, blx_addr)
                print(hex(ins_addr - 2), hex(ldr_value), hex(blx_addr))
                print("-------------------------")
                count += 1
                idc.auto_wait()

            if is_obfuscated_0x4094(ins_addr):
                fill_nop(ins_addr - 2, 12)

            ins_addr = idc.next_head(ins_addr)
        print("====> ", time, count)

patch_so()
# encoding, _ = ks.asm("b.w #0x3c", 0x10000)
# for item in enumerate(encoding):
#     print(0 + item[0], hex(item[1]))