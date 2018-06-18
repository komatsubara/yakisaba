month_names=("January","February","March","April","May","June","July","August","September","October","Novenber","December")
print(month_names[1])
#tupleは要素の変更ができない
#month_names[0]="睦月"

pref_capitals={(43.06417,141.34694):"北海道(札幌)",(40.82444,140.74):"青森県(青森市)",(39.70361,141.1525):"岩手県(盛岡市)"}

loc=(39.70361,141.1525)
for key in pref_capitals:
	if loc ==key:
		print(pref_capitals[key])
		break
#最も近い地点の検索
loc2=(45,180)
nearest_cap=""
nearest_dist=10000
for key in pref_capitals:
	dist=(loc2[0]-key[0])**2+(loc[1]-key[1])**2
	if nearest_dist > dist:
		nearest_dist=dist
		nearest_cap=pref_capitals[key]
print(nearest_cap)
