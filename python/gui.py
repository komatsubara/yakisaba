import os, sys,time
import tkinter as tk

class CsvOutput:
#	def __init__(self):
#		print("init")
		
	def __button_func(self):
#	sys.exit(1)		
		f=open("output_name.csv","w")
		f.write(self.name)
		f.close()
		self.entry()
		self.count +=1

#"""エントリー
	def entry(self):
		EditBox=tk.Entry()
		EditBox.insert(tk.END,self.count)
		EditBox.pack()
#"""
	def main(self):
		root=tk.Tk()
		root.title(u"title")
		root.geometry("800x600")
		self.count=0    
		self.name="myname"        
		button=tk.Button(root,text="team A", command= self.__button_func) #ボタン
		button2=tk.Button(root,text="team B", command= self.__button_func) #ボタン
		button.pack()
		button2.pack()
		root.mainloop()

c = CsvOutput()
#c.count=0
c.main()
#c.__button_func()
