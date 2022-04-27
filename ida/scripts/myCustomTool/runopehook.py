import sys
import os
# 引入ida提供给我们的api
import idaapi
# 引入pyqt，编写交互界面
import idautils

from PyQt5 import QtWidgets



# 这里一定要继承ida提供的插件的base类
import idc


class RunopeHook(idaapi.plugin_t):
    flags = idaapi.PLUGIN_KEEP
    comment = "runopehook a ida pro plugin"
    help = ""
    # ida插件的名字
    wanted_name = "runopeHook"
    # ida插件的快捷键
    wanted_hotkey = "Alt+F6"
    windows = None

    def __init__(self):
        super(RunopeHook, self).__init__()
        flags = idaapi.PLUGIN_KEEP
        pass

    # 脚本初始化的时候调用
    def init(self):
        return idaapi.PLUGIN_OK

    # 初始化后开始运行的时候调用
    def run(self, arg):
        # idaapi.require('view')
        # idaapi.require('view.main_view')
        # main_window = view.main_view.MainView()
        # if self.windows is None or not self.windows.isVisible():
        #     self.windows = QtWidgets.QMainWindow()
        #     main_window.setupUi(self.windows)
        #     self.windows.showNormal()
        self.break_Init_InitArray_JNIOnlad()
        pass

    def break_Init_InitArray_JNIOnlad(self):
        # _get_modules是idc提供的接口，如其名
        for module in idc._get_modules():
            # 遍历所有module，找到linker
            module_name = module.name
            if 'linker' in module_name:
                module_size = module.size
                module_base = module.base
                print('[*]found linker base=>0x%08X, Size=0x%08X' % (module.module_base, module_size))
                print("\t[-]begin to search DT_INIT And DT_INIT_ARRAY")
                init_func_ea = 0
                init_array_ea = 0
                for ea_offset in range(module_base, module_base + module_size):
                    # i don't want to write a huge single line like 'if x and x and x and...', so many ifs apear
                    if 0x4620 == idaapi.get_word(ea_offset):
                        if 0x20F0F8D4 == idaapi.get_long(ea_offset + 2):
                            if 0x4479 == idaapi.get_word(ea_offset + 6):
                                if 0xFEA9F7FF == idaapi.get_word(ea_offset + 8):
                                    if 0x490D == idaapi.get_word(ea_offset + 12):
                                        if 0x2200 == idaapi.get_long(ea_offset + 14):
                                            if 0x9200 == idaapi.get_word(ea_offset + 16):
                                                init_func_ea = ea_offset + 8
                                                init_array_ea = ea_offset + 30
                                                break

                print("\t[-]found INIT=>0x%08X INIT_ARRAY=>0x%08X" % (init_func_ea, init_array_ea))
                print("\t[-]try set breakpoint there")
                idc.add_bpt(init_func_ea)
                idc.add_bpt(init_array_ea)
                idaapi.auto_make_code(init_func_ea)
                idaapi.auto_make_code(init_array_ea)

                print("[*]script by freakish, enjoy~~")
                print("[*]script finish")
                # print('linker address is ' + str(hex(module.base + 0x2464)))
                # # 0x2464是Android某个版本的init_array的偏移地址,
                # # jumpto可以直接跳转到目标地址
                # idc.jumpto(module.base + 0x2464)
                # # 在init_array上下个断点
                # idc.add_bpt(module.base + 0x2464, 1)
                # # makecode更不用说了，相当于C
                # idaapi.auto_make_code(module.base + 0x2464)
                # print("hello world")

    # 脚本结束的时候调用
    def term(self):
        return idaapi.PLUGIN_OK