from idautils import *
from idaapi import *
from idc import *
f = open("./func.txt",'w')
for func_addr in Functions(0,0x5B18BC):
    func_name = get_func_name(func_addr)
    print(func_addr , func_name)
    f.write(str(func_addr) + "," + func_name + "\n")
    # f.writelines()


f.close()