monk_fish_team=[158,157,163,157,145]

total=sum(monk_fish_team)
length=len(monk_fish_team)
mean=total/length

"""
for heigh in monk_fish_team:
	varianve=varianve+(height-mean)**2

variance=varianve/length
"""
variance=sum([(height-mean)**2 for height in monk_fish_team])/length
print(variance)

str_speeds="38 42 20 40 39"
speeds=[int(s) for s in str_speeds.split()]
print(speeds)

str_speeds02="38 42 20 40 a1 39"
speeds=[int(s) for s in str_speeds.split() if s.isdigit()]
print(speeds)

#ディク書なりの内包表記
tz={"GMT":"+000","BST":"+100","EET":"+200","JST":"+900"}
revtz={off:zone for zone,off in tz.items()}
print(revtz)
