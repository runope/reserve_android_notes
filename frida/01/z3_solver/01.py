from z3 import *

# 解一个三元一次方程组
x, y, z = Ints('x y z')
s = Solver()
s.add(2*x + 3 * y + z ==6)
s.add(x - y + 2 * z == -1)
s.add(x + 2 * y - z == 5)
print(s.check())
print(s.model())