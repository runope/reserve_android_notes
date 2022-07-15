import keystone

import idc

arch = keystone.KS_ARCH_ARM
mode = keystone.KS_MODE_THUMB
ks = keystone.Ks(arch, mode)


def is_ldr(ea):
    ldr_addr = ea
    ldr_flags = idc.get_full_flags(ldr_addr)
    if not idc.is_code(ldr_flags):
        return False, None

    ldr_op = idc.print_insn_mnem(ldr_addr)
    if ldr_op != 'LDR':
        return False, None

    ldr_opt0 = idc.get_operand_type(ldr_addr, 0)
    ldr_op0 = idc.print_operand(ldr_addr, 0)
    if ldr_opt0 != idc.o_reg or ldr_op0 != 'R0':
        return False, None

    ldr_opt1 = idc.get_operand_type(ldr_addr, 1)
    if ldr_opt1 != idc.o_mem:
        return False, None

    ldr_opv1 = idc.get_operand_value(ldr_addr, 1)
    ldr_op1_flags = idc.get_full_flags(ldr_opv1)
    if not idc.is_dword(ldr_op1_flags):
        return False, None

    tb_index = idc.get_wide_dword(ldr_opv1)
    return True, tb_index


def is_bl(ea):
    bl_addr = ea
    bl_flags = idc.get_full_flags(bl_addr)
    if not idc.is_code(bl_flags):
        return False, None

    bl_op = idc.print_insn_mnem(bl_addr)
    if bl_op != 'BL':
        return False, None

    bl_opt0 = idc.get_operand_type(bl_addr, 0)
    if bl_opt0 != idc.o_near:
        return False, None

    blx_addr = idc.get_operand_value(bl_addr, 0)
    return True, blx_addr


def is_jump_table(ea):
    blx_addr = ea
    blx_flags = idc.get_full_flags(blx_addr)
    if not idc.is_code(blx_flags):
        return False, None

    blx_op = idc.print_insn_mnem(blx_addr)
    if blx_op != 'BLX':
        return False, None

    blx_opt0 = idc.get_operand_type(blx_addr, 0)
    if blx_opt0 != idc.o_near:
        return False, None

    route_addr = idc.get_operand_value(blx_addr, 0)
    return True, route_addr


def patch_jump_addr(ldr_addr, tb_addr, tb_index):
    patch_addr = idc.prev_head(ldr_addr)
    bl_addr = idc.next_head(ldr_addr)
    index_addr = tb_addr + tb_index * 4
    index_flags = idc.get_full_flags(index_addr)
    if not idc.is_dword(index_flags):
        idc.del_items(index_addr, 0, 4)
        idc.create_dword(index_addr)
    offset = idc.get_wide_dword(index_addr)
    jmp_addr = tb_addr + offset
    code = 'b ' + hex(jmp_addr)
    encoding, count = ks.asm(code, patch_addr)
    if not encoding:
        print 'asm error', hex(patch_addr)
        return

    old_bytes = []
    new_bytes = []
    for item in enumerate(encoding):
        old_bytes.append(hex(idc.get_wide_byte(patch_addr + item[0])))
        new_bytes.append(hex(item[1]))
        idc.patch_byte(patch_addr + item[0], item[1])
    idc.del_items(patch_addr)
    idc.del_items(ldr_addr)
    idc.del_items(bl_addr)
    idc.create_insn(patch_addr)
    # print 'patch', hex(patch_addr), old_bytes, '==>', new_bytes


def func_patch():
    time = 0
    count = -1
    while count != 0:
        time += 1
        count = 0
        print 'time:', time,
        idc.auto_wait()

        ins_addr = idc.next_head(0)
        while ins_addr != idc.BADADDR:
            succ, tb_index = is_ldr(ins_addr)
            if not succ:
                ins_addr = idc.next_head(ins_addr)
                continue

            ldr_addr = ins_addr
            ins_addr = idc.next_head(ldr_addr)
            succ, blx_addr = is_bl(ins_addr)
            if not succ:
                continue

            succ, route_addr = is_jump_table(blx_addr)
            if not succ or route_addr != 0x7584:
                continue

            tb_addr = blx_addr + 4
            patch_jump_addr(ldr_addr, tb_addr, tb_index)
            count += 1
        print 'count:', count


print 'start...'
func_patch()
print 'end...'
