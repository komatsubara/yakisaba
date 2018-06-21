import os, sys,time
import tkinter as tk

class CsvOutput:
	def __init__(self):
		print("init")
		

	def __button_func(self):
#	sys.exit(1)		
		f=open("output_name.csv","w")
		f.write(self.name)
		f.close()

	def main(self):
		root=tk.Tk()
		root.title(u"title")
		root.geometry("800x600")

#ボタン
		button=tk.Button(root,text="button", command= self.__button_func)
#button.text="test"
#button.place(x=150,y=200)
#button.configure(text="yakisaba")
		self.name="myname"
		button.pack()


#"""#エントリー
		EditBox=tk.Entry()
		EditBox.insert(tk.END,"Entry")
		EditBox.pack()
#"""
		root.mainloop()

c = CsvOutput()
c.main()
c.__button_func()
