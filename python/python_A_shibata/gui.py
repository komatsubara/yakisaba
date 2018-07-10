import os, sys,time
import tkinter as tk

class CsvOutput:        #main class
#   def __init__(self):
#       print("init")

    def __button_get_value(self):    #button function
        self.entry()
        self.count +=1

    def __button_read(self):    #
        self.value=self.EditBox.get()
        f=open(self.value+".csv","w")
        f.write(self.value)
        f.close()
"""
    def entry(self):            #textbox function
        if self.count==0:
            #self.EditBox=tk.Entry(width=50)
            self.value=str(self.count)+"filename"
            self.EditBox_get_value.insert(tk.END,self.value)
        else:
            self.EditBox_get_value.delete(0,tk.END)
            self.a=self.EditBox_get_value.get()
            print(self.a)
            selfvalue+=str(self.count)+"filename"
            self.EditBox_get_value.insert(tk.END,str(self.value)
    #        self.EditBox_get_value.pack()
"""
    def main(self):
        root=tk.Tk()
        root.title(u"title")
        root.geometry("800x600")
        #"""
        self.count=0    
        self.value=""
#       self.name="myname"

        self.EditBox_get_value=tk.Entry(width=50)
#        self.a=self.EditBox_get_value.get()
        self.EditBox_get_value.pack()

        button=tk.Button(root,text="get value", command= self.__button_get_value) #button which get the value of powermeter
#       button=tk.Button(root,text="test",commnand=lambda : self.__button_func())
#       button=tk.Button(root,text="team A", command= self.__button_func) #ボタン
#       button=tk.Button(root,text="test",commnand=lambda a: self.__button_func(a))
        button2=tk.Button(root,text="read", command= self.__button_read) #ボタン
        button.pack()
        button2.pack()
        root.mainloop()

c = CsvOutput()
c.main()
