#from ADCMT8230 import Adcmt8230 
import tkinter as tk
import random
class Test:
    def adcmt8230_part(self):
        self.wavelength=1030
        self.measurement_range=20
        self.smoothing=1
#        self.c=ADCMT8230(self.wavelength,self.measurement_range,self.smoothing)
#        self.c.main()

    def main(self):
        self.adcmt8230_part()
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
        self.EditBox=tk.Entry(width=50,texvariable=a)
        self.EditBox.pack()
        button_adcmt=tk.Button(root,text="measure",command=self.__button_func_adcmt)
        button_adcmt.pack()

        button_csv=tk.Button(root,text="output",command=self.__button_func_csv)
        button_csv.pack()
        root.mainloop()
#d=Test()
#d.main()
c=Csvoutput()
c.main()
