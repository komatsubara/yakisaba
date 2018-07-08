import numpy as np

#乱数のシードを設定
np.random.seed(9)
#0から1まで100個の数値を生成、乱数要素を混ぜる前のx
x_orig=np.linspace(0,1,100)

def f(x):
    #xに対応するsinを返す関数
    return np.sin(2*np.pi*x)

#0から1まで100個のばらけたサンプルデータ(x)を生成
x=np.random.uniform(0,1,size=100)[:,np.newaxis]
#xに対応するsinに乱数値を足してサンプルデータ(y)を生成
y=f(x)+np.random.normal(scale=0.3,size=100)[:,np.newaxis]

import matplotlib.pyplot as plt
from sklearn.cross_validation import train_test_split

#学習用データとテスト用データに分ける
x_train,x_test,y_train,t_test=train_test_split(x,y,test_size=0.8)

#元のsinとさんp流データをplot
plt.plot(x_orig,f(x_orig),ls=":")
plt.scatter(x_train,y_train)
plt.xlim((0,1))
plt.show()

from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import make_pipeline

#2x2のグラフを書く準備
fog,axs=plt.subplots(2,2,figsize=(8,5))
#次数0,1,3,9について学習した結果を表示
for ax,deg in zip(axs.ravel(),[0,1,3,9]):
#パイプラインを作る
    e=make_pipeline(PolynomialFeatures(deg),LinearRegression())
#学習セット
    e.fit(x_train,y_train)

    px=e.predict(x_orig[:,np.newaxis])

    ax.scatter(x_train,y_train)
    ax.plot(x_orig,px)
    ax.set(xlim=(0,1),ylim=(-2,2),ylabel="y",xlabel="x",)


plt.tight_layout()
