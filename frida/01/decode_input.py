from z3 import *

result = "EoPAoY62@ElRD"
key    = "W3_arE_whO_we_ARE"
k = 2016
# BitVec定义位向量，每个是8位就是BitVec("x", 8)， 然后我们要多个就如下创建：
x = [BitVec("x%s" % i, 8) for i in range(len(result))]

s = Solver()

for i in range(len(result)):
    if(i % 3 == 1):
        k = (k + 5) % 16
        tmp = key[k + 1]
    elif(i % 3 == 2):
        k = (k + 7) % 15
        tmp = key[k + 2]
    else:
        k = (k + 3) % 13
        tmp = key[k + 3]
    s.add(x[i] == ord(result[i]) ^ ord(tmp))

if s.check() == sat:
    m = s.model()
    print("".join([chr(m[x[i]].as_long()) for i in range(len(result))]))
