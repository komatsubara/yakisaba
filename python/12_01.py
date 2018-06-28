import random
test=[1]                                                                            
test2=[1]
for cnt in range(100):
		test2[0]=random.uniform(0,1)
		test=test+test2
#		print(cnt)	
print(test)
