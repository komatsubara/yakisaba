import csv
import random
import numpy as np
test=[random.uniform(0,1)]                                                                            
test2=[1]
for cnt in range(10):				#ランダムな配列を作る
		test2[0]=random.uniform(0,1)
		test=test+test2

#print(test)
#print(str(test))
#for cnt in len(test):
#tt=csv.writer(test)
#for cnt in test:
f=open("test.csv","w",encoding="UTF-8")
writer=csv.writer(f)
for cnt in range(len(test)):
	writer.writerow(str(test))
	print(cnt)
#	f.writerow(cnt)
#	f.close()
print("txt")
ff=open("test.txt","w")
for cnt in test:
	ff.writelines(str(cnt)+"\n")
	print(cnt)
ff.close
	
fff=open("test2.txt","w")
fff.write("test")
fff.close()

a=[1,2,3,4]
ffff=open("test2.txt","w")
for x in a:
	ffff.write(str(x)+"\n")
ffff.close()
