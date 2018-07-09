#10進数浮動小数点
from decimal import Decimal
d=Decimal(10)
print(d)
print(d+20)

print(0.1*3==0.3)
print(Decimal("0.1")*3==Decimal("0.3"))
print(d.sqrt())

