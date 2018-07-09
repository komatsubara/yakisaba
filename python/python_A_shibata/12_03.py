#matplotを使う
import numpy as np
import matplotlib.pyplot as plt
plt.rcParams['font.family']=' Osaka'
import matplotlib.font_manager as fm
#print(fm.findSystemFonts())

s=np.sin(np.pi*np.arange(0.0,2.0,0.01))
t=plt.plot(s)
plt.show()
x=np.random.randn(5000)
y=np.random.randn(5000)
tt=plt.plot(x,y,'o',alpha=0.1)
plt.show()

x=np.array([1.628, 3.363, 5.898,11.678,46.189])
y=np.array([1.234,4.898,4.899,9.287,10.378])

a=np.array([x,np.ones(x.size)])
a=a.T
m,c=np.linalg.lstsq(a,y)[0]
ttt=plt.plot(x,y,'o')
ttt=plt.plot(x,(m*x+c))
#plt.show()

s=np.sin(np.pi*np.arange(0.0,2.0,0.01))
tttt=plt.plot(s,linestyle="-",linewidth=4)
plt.xlabel("x軸ダヨーーーー")
plt.ylabel("y軸ダッテ〜〜〜〜")
plt.text(10,10,"ここ")
plt.xticks([11,21,31],["8","9","10"])

#plt.yticks(1,"1")
plt.show()
    
