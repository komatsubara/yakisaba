#%matplot inline

str_num="1,000,000"
num=int(str_num.replace(",",""))
print(num)
print(str_num)

#%matplotlib inline
import matplotlib.pyplot as plt

str_speed="38 42 20 40 39"
str_armor="80 50 17 50 51"
speed=str_speed.split(" ")
armor=str_armor.split(" ")
markers=["o","v","^","<",">"]

for idx in range(len(speed)):
	x=int(speed[idx])
	y=int(armor[idx])
	plt.scatter(x,y,marker=markers[idx])
#plt.show()
#IV号戦車(o) LT-38(v) 八式中戦車(^) III号突撃砲(<) M3中戦車(>)


csep_speed=",".join(speed)
print(csep_speed)

raw=r"C:\path\to\file"
print(raw)
print("文字列で利用できるメゾッド")
print(str_speed.find("2"))
#print(speed.find("2")) splitはlistに分けるからfindが使えない
print(str_speed.endswith("9"))
print(csep_speed.find("2"))

print("文字列のフォーマット")
print("{} loves Python !".format('Guido'))

linkstr="<a href='{}'>{}</a>"
for i in ['http://python.org',
					'http://pypy.org',
					'http://cython.org',]:
		print(linkstr.format(i,i.replace('http://','')))

print("{0}+{1}={0}".format('Spam','Ham'))
print("{food1}*{food2}={food1}")
print("{food1}*{food2}={food1}".format(food1="Spam",food2="Ham"))

d={"name":"Guido","birthyear":1964}
print("{0[birthyear]} is {0[name]}'s birthyear.".format(d))

import sys
print("Python version: {0.version}".format(sys))

tmpl="{0:10} {1:>8}"
print(tmpl.format("Spam",300))
print(tmpl.format("Ham",200))
