# -*- coding: utf-8 -*-

import tkinter
from tkinter import messagebox
#from tkinter 
import tkFileDialog

root=tkinter.Tk()
root.withdraw()

fTyp=[('テキストファイルとExcelファイル','*.txt;*.csv')]
#複数のタイプを指定することも可能。

iDir='c:/'

#askopenfilename 一つのファイルを選択する。
filename=tkFileDialog.askopenfilename(filetypes=fTyp,initialdir=iDir)

messagebox.showinfo('FILE NAME is ...',filename)

#askopenfilenames 複数ファイルを選択する。
filenames=tkFileDialog.askopenfilenames(filetypes=fTyp,initialdir=iDir)

for f in filenames:
    messageBox.showinfo('FILE NAME is ...',f)

#askdirectory ディレクトリを選択する。
dirname=tkFileDialog.askdirectory(initialdir=iDir)

messagebox.showinfo('SELECTED DIRECROTY is ...',dirname)

#このコードはutf-8で保存する。