from idautils import *
from idaapi import *
from idc import *
import keystone


ARCH = keystone.KS_ARCH_ARM64
MODE = keystone.KS_MODE_LITTLE_ENDIAN
ks = keystone.Ks(ARCH, MODE)

ADRP_X8_inst_list = [
    "ADRP            X8, #dword_C0144@PAGE", \
    "ADRP            X8, #dword_C0140@PAGE", \
    "ADRP            X8, #dword_C013C@PAGE", \
    "ADRP            X8, #dword_C0138@PAGE", \
    "ADRP            X8, #dword_C0134@PAGE", \
    "ADRP            X8, #dword_C0130@PAGE", \
    "ADRP            X8, #dword_C012C@PAGE", \
    "ADRP            X8, #dword_C0128@PAGE", \
    "ADRP            X8, #dword_C0124@PAGE", \
    "ADRP            X8, #dword_C0120@PAGE", \
    "ADRP            X8, #dword_C011C@PAGE", \
    "ADRP            X8, #dword_C0118@PAGE"
]

ADRP_X9_inst_list = [
    "ADRP            X9, #dword_C0140@PAGE", \
    "ADRP            X9, #dword_C013C@PAGE", \
    "ADRP            X9, #dword_C0138@PAGE", \
    "ADRP            X9, #dword_C0134@PAGE", \
    "ADRP            X9, #dword_C0130@PAGE", \
    "ADRP            X9, #dword_C012C@PAGE", \
    "ADRP            X9, #dword_C0128@PAGE", \
    "ADRP            X9, #dword_C0124@PAGE", \
    "ADRP            X9, #dword_C0120@PAGE", \
    "ADRP            X9, #dword_C011C@PAGE", \
    "ADRP            X9, #dword_C0118@PAGE"
]

ADRP_X10_inst_list = [
    "ADRP            X10, #dword_C0140@PAGE", \
    "ADRP            X10, #dword_C013C@PAGE", \
    "ADRP            X10, #dword_C0138@PAGE", \
    "ADRP            X10, #dword_C0134@PAGE", \
    "ADRP            X10, #dword_C0130@PAGE", \
    "ADRP            X10, #dword_C012C@PAGE", \
    "ADRP            X10, #dword_C0128@PAGE", \
    "ADRP            X10, #dword_C0124@PAGE", \
    "ADRP            X10, #dword_C0120@PAGE", \
    "ADRP            X10, #dword_C011C@PAGE", \
    "ADRP            X10, #dword_C0118@PAGE"
]

def fill_ops(ea, codes):
    ''' fill ea with codes '''
    for idx, c in enumerate(codes):
        if isinstance(c, str):
            c = ord(c)
        patch_byte(ea + idx, c)

for seg in Segments():
    for func in Functions(seg, get_segm_end(seg)):
        for (startEa, endEa) in Chunks(func):
            for line in Heads(startEa, endEa):
                if idc.GetDisasm(line) in ADRP_X8_inst_list:
                    encoding, _ = ks.asm('ADRP X8, 0xA0000')
                    fill_ops(line, encoding)
                    print("patch %x -> %s" % (line, encoding))
                elif idc.GetDisasm(line) in ADRP_X9_inst_list:
                    encoding, _ = ks.asm('ADRP X9, 0xA0000')
                    fill_ops(line, encoding)
                    print("patch %x -> %s" % (line, encoding))
                elif idc.GetDisasm(line) in ADRP_X10_inst_list:
                    encoding, _ = ks.asm('ADRP X10, 0xA0000')
                    fill_ops(line, encoding)
                    print("patch %x -> %s" % (line, encoding))