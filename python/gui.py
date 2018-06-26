import os, sys,time
import tkinter as tk

class CsvOutput:
#	def __init__(self):
#		print("init")
		
	def __button_func(self,a):
#	sys.exit(1)		
		a.entry()
		a.count +=1

	def __button_read(self):
		self.value=self.EditBox.get()
		f=open(self.value+".csv","w")
		f.write(self.value)
		f.close()
#"""エントリー
	def entry(self):
		self.EditBox=tk.Entry(width=50)
		self.EditBox.insert(tk.END,str(self.count)+"fileneme")
		self.EditBox.pack()
#"""
	def main(self):
		root=tk.Tk()
		root.title(u"title")
		root.geometry("800x600")
		self.count=0    
#		self.name="myname"
		self.EditBox=tk.Entry(width=50)
		self.EditBox.pack()
		a=1
#		button=tk.Button(root,text="team A", command= self.__button_func) #ボタン
		button=tk.Button(root,text="test",commnand=lambda : self.__button_func(a))
		button2=tk.Button(root,text="read", command= self.__button_read) #ボタン
		button.pack()
		button2.pack()
		root.mainloop()

c = CsvOutput()
#c.count=0
c.main()
#c.__button_func()
