#pragma rtGlobals=3		// Use modern global access method and strict wave access.
function bg()
string wave1,bgwave,cmd,j
variable i
i=1//電圧
j="002"//ファイル名の通し番号
do
wave1="F06_"+j+"_5_"+num2str(i)+"0V_y"
bgwave="bg_"+j+"_y"
sprintf cmd "%s -=%s",wave1,bgwave
execute cmd
print wave1
    i+=1
while(i<=10)
end
