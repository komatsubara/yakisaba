#%matplotlib inline
import matplotlib.pyplot as plt
import numpy as np
x = np.linspace(0,5*np.pi, 500)
plt.plot(x, np.sin(x**2))
plt.show()
