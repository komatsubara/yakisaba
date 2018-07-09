import numpy as np
p_male=np.loadtxt("male_1944_2014.csv",delimiter=",",skiprows=1,usecols=range(1,22))
p_female=np.loadtxt("female_1944_2014.csv",delimiter=",",skiprows=1,usecols=range(1,22))

p_total=p_male +p_female
p_yearly=p_total.sum(axis=1)

import matplotlib.pyplot as plt
"""fig,(t,tt)=plt.subplots(ncols=2,figsize=(10,4))

t=plt.plot(range(1944,2015),p_yearly)
plt.ylim((0,130000))
plt.grid(True)
plt.show()

tfr=np.loadtxt("total_fertility_rate.csv",delimiter=",",skiprows=1)
tt=plt.plot(range(1960,2015),tfr,ls=":")
tt=plt.plot([1960,2015],[2.07,2.07])
plt.show()
fig.show()
"""
"""
fig,(t,tt)=plt.subplots(ncols=2,figsize=(10,4))

t.plot(range(1944,2015),p_yearly)
#t.ylim((0,130000))
t.grid(True)
#plt.show()

tfr=np.loadtxt("total_fertility_rate.csv",delimiter=",",skiprows=1)
tt.plot(range(1960,2015),tfr,ls=":")
tt.plot([1960,2015],[2.07,2.07])
#plt.show()
fig.show()
"""
t = np.linspace(-np.pi, np.pi, 1000)

x1 = np.sin(2*t)
x2 = np.cos(2*t)

fig, (axL, axR) = plt.subplots(ncols=2, figsize=(10,4))

axL.plot(t, x1, linewidth=2)
axL.set_title(' sin' )
axL.set_xlabel(' t' )
axL.set_ylabel(' x' )
axL.set_xlim(-np.pi, np.pi)
axL.grid(True)

axR.plot(t, x2, linewidth=2)
axR.set_title(' cos' )
axR.set_xlabel(' t' )
axR.set_ylabel(' x' )
axR.set_xlim(-np.pi, np.pi)
axR.grid(True)

fig.show()

n = 300
x = np.random.randn(n)
y = np.sin(x) + np.random.randn(n) * 0.3

fig = plt.figure()

# サブプロットを8:2で分割
ax1 = fig.add_axes((0, 0.2, 1, 0.8))
ax2 = fig.add_axes((0, 0, 1, 0.2), sharex=ax1)

# 散布図のx軸のラベルとヒストグラムのy軸のラベルを非表示
ax1.tick_params(labelbottom="off")
ax2.tick_params(labelleft="off")

ax1.plot(x, y, "x")
ax2.hist(x, bins=20)
fig.show()
#fig.pause(100)

x = np.linspace(-3, 3, 20)
y1 = x
y2 = x ** 2
 
# figure は 1 つ
plt.figure(figsize=(3, 4))
  
plt.subplot(2,1,1)
plt.plot(x, y1)
   
plt.subplot(2,1,2)
plt.plot(x, y2)
    
plt.show()
