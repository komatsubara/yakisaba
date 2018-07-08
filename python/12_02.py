import numpy as np
a=np.array([0,1,2,3,4,5,6])
print(a)

b=np.array([[0,0,0],[0,0,0],[0,0,0]])	#鉤括弧忘れ注意
print(b)

print(b.ndim)
print(b.shape)
print(b.size)
print(b.dtype)

f=open("12_02.txt","w")
for cnt in b:
		f.writelines(str(cnt)+"\n")
f.close()

b2=np.zeros(9).reshape(3,3)
print("\n b2 :\n",b2)
a2=np.arange(9).reshape(3,3)
print("\n a2 :\n",a2)

print("\n a2-T :\n",a2.T)

a3=np.arange(1,10)
print("\n a3 :\n",a3+1)
a4=np.arange(5,14)
print("\n a3+a4 :\n",a3+a4)

a5=np.ones(9).reshape(3,3)
a6=np.arange(1,4)
print(a5)
print("\n a5*a6 :\n",a5*a6)

a7=np.arange(9).reshape(3,3)
print("\n a7 : ",np.sum(a7),"\n",a7)
print("\n sum 列ごと",np.sum(a7,axis=0))

print(a5*a6@a7)
print(a7[1,2])
print(a7[1:,1:3])

d=np.arange(1,10)
print(d[[1,3,5,7]])		#インデックスにリストを渡す

e=np.arange(4).reshape(2,2)
f=np.arange(5,9).reshape(2,2)
print("\n",np.hstack((e,f)))
print("\n",np.vstack((e,f)))

g=np.zeros(4)
h=g
h += 1
print("\n",h)

i=g.copy()
i+=1
print("\n",i,"\n",g)
