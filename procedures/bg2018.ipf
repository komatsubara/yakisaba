#pragma rtGlobals=3		// Use modern global access method and strict wave access.
function bg()
string wave1,bgwave,cmd,j
variable i
i=2//�d��
//j="002"//�t�@�C�����̒ʂ��ԍ�
do
wave1="data0"+num2str(i)+"_y"
bgwave="data001"+"_y"
sprintf cmd "%s -=%s",wave1,bgwave
execute cmd
print wave1
    i+=1
while(i<=10)
end



