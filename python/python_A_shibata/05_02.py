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

#ディクショナリ　の内包表記
tz={"GMT":"+000","BST":"+100","EET":"+200","JST":"+900"}
revtz={off:zone for zone,off in tz.items()}
print(revtz)

#set内包表記
print("\n")
names=["BOB","burton","dave","bob"]
unames={x.lower() for x in names}
print(unames)

#イテレータと遅延評価
print("\n イテレータ")
f=open("05_02.py")
body=f.read()
lines=body.split("\n")
print("\n".join(lines[:5]))

print("\n イテレータそのに")
line=""
for i in range(5):
	lines +=f.readline()
print(lines)

print("\n イテレータ本ちゃん")
for c,l in enumerate(open("05_02.py")):
	print(l,end="")
	if c==4:
		break
