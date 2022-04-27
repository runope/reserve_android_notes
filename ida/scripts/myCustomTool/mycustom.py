import idaapi
import idc
import idautils


def InitFunctions_6_BreakPoint():
    # _get_modules是idc提供的接口，如其名
    for module in idc._get_modules():
        # 遍历所有module，找到linker
        module_name = module.name
        if 'linker' in module_name:
            print('linker call_function address is ' + str(hex(module.base + 0x2434)))
            print('linker call_array address is ' + str(hex(module.base + 0x24A8)))

            # 在init_array上下个断点
            idc.add_bpt(module.base + 0x2434, 1)
            idc.add_bpt(module.base + 0x24A8, 1)
            # jumpto可以直接跳转到目标地址
            idc.jumpto(module.base + 0x2434)
            # makecode更不用说了，相当于C
            idaapi.auto_make_code(module.base + 0x2434)
            idaapi.auto_make_code(module.base + 0x24A8)

def JNIOnload_6_BreakPoint():
    for module in idc._get_modules():
        # 遍历所有module，找到linker
        module_name = module.name
        if 'libart.so' in module_name:
            print('linker JNI_Onload address is ' + str(hex(module.base + 0x25B386)))

            # 在init_array上下个断点
            idc.add_bpt(module.base + 0x25B386, 1)
            # jumpto可以直接跳转到目标地址
            idc.jumpto(module.base + 0x25B386)
            # makecode更不用说了，相当于C
            idaapi.auto_make_code(module.base + 0x25B386)

def InitFunctions_8_BreakPoint():
    # _get_modules是idc提供的接口，如其名
    for module in idc._get_modules():
        # 遍历所有module，找到linker
        module_name = module.name
        if 'linker' in module_name:
            print('linker call_function address is ' + str(hex(module.base + 0x13548)))
            print('linker call_array address is ' + str(hex(module.base + 0x13264)))

            # 在init_array上下个断点
            idc.add_bpt(module.base + 0x13548, 1)
            idc.add_bpt(module.base + 0x13264, 1)
            # jumpto可以直接跳转到目标地址
            idc.jumpto(module.base + 0x13548)
            # makecode更不用说了，相当于C
            idaapi.auto_make_code(module.base + 0x13548)
            idaapi.auto_make_code(module.base + 0x13264)

def JNIOnload_8_BreakPoint():
    for module in idc._get_modules():
        # 遍历所有module，找到linker
        module_name = module.name
        if 'libart.so' in module_name:
            print('linker JNI_Onload address is ' + str(hex(module.base + 0x24F890)))

            # 在init_array上下个断点
            idc.add_bpt(module.base + 0x24F890, 1)
            # jumpto可以直接跳转到目标地址
            idc.jumpto(module.base + 0x24F890)
            # makecode更不用说了，相当于C
            idaapi.auto_make_code(module.base + 0x24F890)

