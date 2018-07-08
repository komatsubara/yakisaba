from matplotlib import pyplot as plt
import numpy as np

p_male=np.loadtxt("male_1944_2014.csv",delimiter=",",skiprows=1,usecols=range(1,22))
p_female=np.loadtxt("female_1944_2014.csv",delimiter=",",skiprows=1,usecols=range(1,22))
p_total=p_male+p_female
p_yearly=p_total.sum(axis=1)
lifechart=np.loadtxt("lifechart2014.csv",delimiter=",",usecols=[3])
rev_lifechart=np.ones(lifechart.size)-lifechart

rep_level=np.array([0.0041,0.107,0.19,0.0697,0.017,0.0021,0.0001])
high_rate=np.array([0.0036,0.0514,0.1593,0.0927,0.0187,0.0023,0.0001])

#男女の人口データを推定するarray
#print(p_male)
#print(p_male[-2:])
fp_male=np.array(p_male[-2:])   #-1:うしろからかぞえて
fp_female=np.array(p_female[-2:])

#人口置き換え水準に戻る期間
recover_in=5

for i in range(20):
#5年ごと100年間分繰り返す
#直近の5歳階級別で新しい人口を初期化
    new_fp_male=fp_male[-1]
 #   print(new_fp_male)
    new_fp_female=fp_female[-1]
#出生率を設定
    if i>recover_in:
        f_rate=rep_level
    else:
        f_rate=high_rate
#15-49歳の女性人口に出生率をかけて新生児数を計算
    newborn=np.sum(new_fp_female[3:10]*f_rate)*5
#直近5歳階級別人口のインデックスを右にずらし新生児を左に連結
    new_fp_male=np.hstack(([newborn*0.4878],new_fp_male[:-1]))
    new_fp_female=np.hstack(([newborn*0.5122],new_fp_female[:-1]))
#各階級の人口に死亡率を適応
    new_fp_male *=rev_lifechart
    new_fp_female *=rev_lifechart
    fp_male=np.vstack((fp_male,new_fp_male))
    fp_female=np.vstack((fp_female,new_fp_female))
#男女合算の5歳階級別人口、5年ごとの推定総人口のarray
fp_total=fp_male+fp_female
fp_sum=np.array([np.sum(x) for x in fp_total])

t=plt.plot(range(2013,2120,5),fp_sum)
t=plt.ylim([0,130000])
plt.grid(True)
t=plt.plot(range(2013,2120,5),fp_sum)
t=plt.ylim([0,130000])
plt.grid(True)
plt.show()

t=interact(show_pgraph,year=IntSlider(min=2013,max=2113,step=5),arr1=fixed(fp_male),arr2=fixed(fp_male),arr3=fixed(fp_sum),ymin=fixed(2013),ymax=fixed(2120),ydim=fixed(5))
