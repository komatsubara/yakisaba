from functools import lru_cache

def execute(func,arg):
	return func(arg)

print(execute(int,"100"))

print("\n")

def logger(func):
	def inner(*args):
		print("引数:",args)
		return func(*args)
	return inner
#print(logger())



def accumulate(a,b):
	return a+b

print(accumulate(1,2))

newfunc=logger(accumulate)
print(newfunc(1,2))

print(accumulate(3,4))
@logger
def accumulate(a,b):
	return a+b
print(accumulate(2,3))
print("\n")

@lru_cache(maxsize=None)
def fib(n):
	if n < 2:
		return n
	return fib(n-1)+fib(n-2)

print([fib(n) for n in range(16)])
