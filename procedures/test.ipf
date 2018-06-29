#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#include <WindowBrowser>
macro testtest()
test(2)
make/O/N=6/D wave0={1,2,3,4,5,6}
endmacro

function test(n)
variable n
string s
print n
make/O/N=6/D wave1={1,2,3,4,5,10}
testtesttest(5)
end

function testtesttest(a)
variable a
make/O/N=6/D wavetesttesttest={3,4,5,5,6,7,8}
wavetesttesttest[0]=a
end

