def fizzbuzz(count=100,fizzmod=3,buzzmod=5):
	for cnt in range(1,count+1):
		if cnt%fizzmod==0 and cnt%buzzmod==0:
			print("FizzBuzz")
		elif cnt%fizzmod==0:
			print("Fizz")
		elif cnt%buzzmod==0:
			print("Buzz")
		else: 
			print(cnt)

fizzbuzz()

local_var=1

def test_func(an_arg):
	local_var=an_arg
	print("test_fun()の中=",local_var)

test_func(200)
print("test_func()の外",local_var)

"""print



sdsdsdsds"""
