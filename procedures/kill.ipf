#pragma rtGlobals=3		// Use modern global access method and strict wave access.
Macro kill()
variable i
string graphname,command
i=18
do
	graphname="Graph"+num2str(i)
//graphname="graph7"
	print graphname
//dowindow graphname;DelayUpdate
	command="Killwindow "+ graphname
	execute command
	i = i + 1
while (i<1200)