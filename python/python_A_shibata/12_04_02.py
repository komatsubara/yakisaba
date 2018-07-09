from matplotlib import gridspec
import matplotlib.pyplot as plt
import numpy as np
from ipywidgets import interact,IntSlider,fixed
"""
from __future__ import print_function
from IPython.html.widgets import interact,i
from Ipython.html import widgets
"""
p_male=np.loadtxt("male_1944_2014.csv",delimiter=",",skiprows=1,usecols=range(1,22))
p_female=np.loadtxt("female_1944_2014.csv",delimiter=",",skiprows=1,usecols=range(1,22))
p_total=p_male+p_female
p_yearly=p_total.sum(axis=1)

def show_pgraph(year,arr1,arr2,arr3,ymin,ymax,ydim=1):
    #人口ピラミッド
    idx=int((year-ymin)/ydim)   #表示する人口のインデックス
    gs=gridspec.GridSpec(2,2,height_ratios=(3,2))   #人口ピラミッドと人口グラフのグリッドを生成
    ax=[plt.subplot(gs[0,0]),plt.subplot(gs[0,1]),plt.subplot(gs[1,:])]     #グラフの配置を決める
    print(ax)
    ax[0].barh(range(0,101,5),arr1[idx],height=3)
    #ax[0].set(ylim(0,100),xlim(0,6000))
    ax[0].invert_xaxis()
    ax[0].yaxis.tick_right()

    
    ax[1].barh(range(0,101,5),arr1[idx],height=3)
    ax[1].tick_params(labelleft="off")
#    ax[1].set(ylim(0,100),xlim(0,6000))

    ax[2].plot(range(ymin,ymax+1,ydim),arr3,ls=":")
    ax[2].plot([year,year],[0,140000])
    
    t=interact(show_pgraph,year=IntSlider(min=1944,max=2014,step=5),arr1=fixed(p_male),arr2=fixed(p_female),arr3=fixed(p_yearly),ymin=fixed(1944),ymax=fixed(2014),tdim=fixed(1))
    plt.show()
show_pgraph(1994,p_male,p_female,p_yearly,1944,2014)
    
