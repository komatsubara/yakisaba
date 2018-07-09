import numpy as np

reactions_in_ms=np.loadtxt("test.txt")
print(reactions_in_ms.size)
print(reactions_in_ms[:20])

print("")
reactions_in_sec=reactions_in_ms
print("平均値 :",np.mean(reactions_in_sec))
print("中央値 :",np.median(reactions_in_sec))
print("標準偏差 :",np.std(reactions_in_sec))
print("最小値 :",np.min(reactions_in_sec))
print("最大値 :",np.max(reactions_in_sec))

print("\n pandas ")
import pandas as pd
reactions_df=pd.DataFrame(reactions_in_sec)
print(reactions_df.head())
print(reactions_df.describe())

import matplotlib.pyplot as plt
h=plt.hist(reactions_in_sec)
plt.show()
