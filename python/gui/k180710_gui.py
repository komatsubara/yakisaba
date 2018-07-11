import os,sys,time
from tkinter import ttk
import tkinter as tk

class CsvOutput:
    def __init__(self):
        self.a=1
    def __button_get_value(self):
        self.entry()
        self.count +=1

    def entry(self):
        self.editbox_get_value.insert(tk.END,"\n"+str(self.count))
        self.editbox_get_value.pack()
    def __button_output(self):
        self.output_value=self.editbox_get_value.get()
        self.output_filename=self.editbox_output_filename.get()
        f=open(self.output_filename+".csv","w")
        f.write(self.output_value)
        f.close
    
    def main(self):
        self.count=0
        self.value=""

        root=tk.Tk()
        root.title(u"title")
        root.geometry("800x600")
        
        self.editbox_get_value=tk.Entry(width=50)
        self.editbox_get_value.pack()
        self.editbox_output_filename=tk.Entry(width=50)
        self.editbox_output_filename.insert(tk.END,"filename")
        self.editbox_output_filename.pack()
        frame1=ttk.Frame(root,padding=10)
        self.output=ttk.Entry(frame1,textvariable="filename",width=30,show="*")
        button_get_value=tk.Button(root,text="get value",command=self.__button_get_value)
        button_get_value.pack()
        button_output=tk.Button(root,text="output",command=self.__button_output)
        button_output.pack()

        root.mainloop()
c=CsvOutput()
c.main()
