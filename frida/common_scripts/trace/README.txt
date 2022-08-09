# 0x01 Trace Instructions
# 0x02 Record memory change
1. 解析load/store相关指令，根据CPU上下文，计算访问内存地址和大小
2. 解析plt等引用libc函数，方便解析memset,memcpy等内存变化. 方便监控bl等相对寻址到libc函数

## 0x0201 method
1. use keystone, transfer to assembly, and frida malloc memory to 
2. use vixl, simulate assembly to gain address