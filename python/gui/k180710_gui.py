import os,sys,time
import tkinter as tk

class CsvOutput:
    def __init__(self):
        self.a=1
    def __button_get_value(self):
        self.entry()
        self.count +=1

    def __button_read(self):
        self.value=self.editbox_get_value.get()

    def __button_output(self):
        self.output_value=self.editbox_get_value.get()
        self.output_filename=self.editbox_output_filename.get()
        f=open(self.output_filename+".csv","w")
        f.write(self.output_value)
        f.close
    
    def entry(self):
        self.editbox_get_value.insert=(tk.END,str(self.count))

    def main(self):
        self.count=0
        self.value=""

        root=tk.Tk()
        root.title(u"title")
        root.geometry("800x600")
        
        self.editbox_get_value=tk.Entry(width=50)
        self.editbox_get_value.pack()
        self.editbox_output_filename=tk.Entry(width=50)
        self.editbox_output_filename.pack()
        button_get_value=tk.Button(root,text="get value",command=self.__button_get_value)
        button_get_value.pack()
        button_output=tk.Button(root,text="output",command=self.__button_output)
        button_output.pack()

        root.mainloop()
c=CsvOutput()
c.main()
