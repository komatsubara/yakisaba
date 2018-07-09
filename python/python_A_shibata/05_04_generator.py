def get_primes(x=2):
	while True:
		for i in range(2,x):
			if x%i == 0:
				break
		else:
			yield x
		x+=1
	
i=get_primes()
for c in range(10):
	print(next(i))

print("\n ジェネレータ式")
list=[x**2 for x in range(1,10)]
print(list)

list_ite=(x**2 for x in range(1,10))

print(next(list_ite))
print(next(list_ite))
print(next(list_ite))
print(next(list_ite))
