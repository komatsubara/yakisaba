from sklearn.metrics import mean_squared_error
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import make_pipeline
import matplotlib.pyplot as plt
from sklearn.cross_validation import train_test_split

train_error=np.empty(10)
test_error=np.empty(10)

np.orig=np.linspace(0,1,100)
np.random.seed(9)
x_orig=np.linspace(0,1,100)
def f(x):
    return np.sin(2*np.pi*x)
x=np.random.uniform(0,1,size=100)[:,np.newaxis]
y=f(x)+np.random.normal(scale=0.3,size=100)[:,np.newaxis]

x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.8)

for deg in range(10):
    e=make_pipeline(PolynomialFeatures(deg),LinearRegression())
    e.fit(x_train,y_train)

    train_error[deg]=mean_squared_error(y_train,e.predict(x_train))
    test_error[deg]=mean_squared_error(y_test,e.predict(x_test))
plt.plot(np.arange(10),train_error,ls=":",label="train")
plt.plot(np.arange(10),test_error,ls="-",label="test")
plt.ylim((0,1))
plt.legend(loc="upper left")
plt.show()
