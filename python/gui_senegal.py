import os, sys,time
import tkinter as tk

class CsvOutput:
#	def __init__(self):
#		print("init")
		
	def __button_func(self):
#	sys.exit(1)		
		self.entry()
		self.count +=1

	def __button_read(self):
		self.value=self.EditBox.get()
		f=open(self.value+".csv","w")
		f.write(self.value)
		f.close()
#"""エントリー
	def entry(self):
		if self.count==0:
			#self.EditBox=tk.Entry(width=50)
			self.EditBox.insert(tk.END,str(self.count)+"fileneme")
		else:
			self.EditBox.delete(0,tk.END)
			self.EditBox.insert(tk.END,str(self.count)+"filename")
			self.EditBox.pack()
#"""
	def main(self):
		root=tk.Tk()
		root.title(u"title")
		root.geometry("800x600")
		self.count=0    
#		self.name="myname"
		self.EditBox=tk.Entry(width=50)
		self.EditBoxJP=tk.Entry(width=50)
		self.EntryBoxsenegal=tk.Entry(width=50)
		self.EditBox.pack()
		self.EditBoxJP.pack()
		self.EntryBoxsenegal.pack()
		self.button=tk.Button(root,text="team A", command= self.__button_func) #ボタン
#		button=tk.Button(root,text="test",commnand=lambda : self.__button_func())
		button2=tk.Button(root,text="read", command= self.__button_read)
		self.button.pack()
		button2.pack()
		button2=tk.Button(root,text="read", command= self.__button_read) #ボタン
		buttonjp=tk.Button(root,text="Japan", command= self.__button_read) #ボタン
		buttonsenegal=tk.Button(root,text="Senegal", command= self.__senegal_button) #ボタン
		buttonjp.pack()
		buttonsenegal.pack()
		button2.pack()
		root.mainloop()
	def __senegal_button(self):
		self.EntryBoxsenegal.insert(tk.END,"セネガルとは引き分け")	
		self.EditBoxJP.insert(tk.END,"日本")
		self.EditBoxJP.pack()
		self.EntryBoxsenegal.pack()
c = CsvOutput()
#c.count=0
c.main()
#c.__button_func()
