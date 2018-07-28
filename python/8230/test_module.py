#from ADCMT8230 import Adcmt8230 
import tkinter as tk
from tkinter import ttk
from tkinter import *
import random
import os
import datetime

"""
class Test:
    def adcmt8230_part(self):
        self.wavelength=1030
        self.measurement_range=20
        self.smoothing=1
#        self.c=ADCMT8230(self.wavelength,self.measurement_range,self.smoothing)
#        self.c.main()

    def main(self):
        self.adcmt8230_part()
"""
"""
class Csvoutput:
    def __button_func_csv(self):
        self.value=self.EditBox.get()
        f=open("test.csv","w")
        f.write(self.value)
        f.close()
    def __button_func_adcmt(self):
        self.EditBox.insert(tk.END,str(random.randint(1,10))+"\n")
        self.EditBox.pack()        
    def main(self):
        root=tk.Tk()
        root.title(u"title")
        root.geometry("800x600")
        self.EditBox=tk.Entry(width=50)
        self.EditBox.pack()
        button_adcmt=tk.Button(root,text="measure",command=self.__button_func_adcmt)
        button_adcmt.pack()

        button_csv=tk.Button(root,text="output",command=self.__button_func_csv)
        button_csv.pack()
        root.mainloop()
"""
class testtest:
    def __button_func_value(self):
        self.value_entry.insert(tk.END,str(random.randint(1,10))+"\n")

    def __button_func_csv(self):
        f=open(str(self.filename.get())+".csv","w")
        f.write(self.value.get())
        f.close()
        cmd="open "+str(self.filename.get())+".csv"
        os.system(cmd)

    def __button_func_delete(self):
        self.value_entry.delete(0,tk.END)
        
    def main(self):
        #root の定義
        root2=tk.Tk()
        root2.title("Test")


        frame1=ttk.Frame(root2,padding=10)
        frame1.grid()
#label
        label1=ttk.Label(frame1,text="value",padding=(5,2))
        label1.grid(row=2,column=0,sticky=E)
        label2=ttk.Label(frame1,text="filename",padding=(5,2))
        label2.grid(row=0,column=0,sticky=E)
#entry
        self.value=StringVar()
        self.value_entry=ttk.Entry(frame1,textvariable=self.value,width=30)
        self.value_entry.grid(row=2,column=1)
        self.wavelength=StringVar()

        self.wavelength_entry=ttk.Entry(frame1,textvariable=self.wavelength,width=4)
        self.wavelength_entry.insert(tk.END,str(1030))
        self.wavelength_entry.grid(row=1,column=1)
        

        self.filename=StringVar()
        self.filename_entry=ttk.Entry(frame1,textvariable=self.filename,width=30)
        today1=datetime.date.today()
        today2="{0:%Y%m%d}".format(today1)
        self.filename_entry.insert(tk.END,str(today2)+"_data001")
        self.filename_entry.grid(row=0,column=1)
#button
        frame2=ttk.Frame(frame1,padding=(0,5))
        frame2.grid(row=3,column=1,sticky=W)

        value_button=ttk.Button(frame2,text="get value",command=self.__button_func_value)
        value_button.pack(side=LEFT)
        csv_button=ttk.Button(frame2,text="csv output",command=self.__button_func_csv)
        csv_button.pack(side=LEFT)
        delete_button=ttk.Button(frame2,text="clear",command=self.__button_func_delete)
        delete_button.pack(side=LEFT)
        
        combo=ttk.Combobox(frame2,state="readonly")
        combo["values"]=("1","2")
        combo.current(0)
        combo.pack(side=LEFT)
#root2
        root2.mainloop()
#d=Test()
#d.main()
#c=Csvoutput()
c=testtest()
c.main()
