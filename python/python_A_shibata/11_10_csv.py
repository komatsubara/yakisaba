import csv 

csvfile=open("1fileneme.csv",encoding="utf-8")
for row in csv.reader(csvfile):
	print(row)

import csv
csvfile2=open("test2.csv","w",encoding="utf-8")

seq=["1","2"]
writer=csv.writer(csvfile2)
for row in seq:
	writer.writerow(row)
