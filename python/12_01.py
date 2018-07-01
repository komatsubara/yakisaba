import csv
import random
import numpy as np
test=[1]                                                                            
test2=[1]
for cnt in range(100):				#ランダムな配列を作る
		test2[0]=random.uniform(0,1)
		test=test+test2
print(2)

#for cnt in len(test):
writer=csv.writer(test)
#for cnt in test:
f=open("test.csv","w",encoding="UTF-8")
for cnt in test:
	writer.writerow(cnt)
#	f.writerow(cnt)
	f.close()

