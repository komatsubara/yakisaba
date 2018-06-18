#データ.メソッド(引数)
def find_index(the_list,target):
	idx=0
	for item in the_list:
		if target ==item:
			return idx
		idx += 1

mcz=["れに","かなこ","しおり","あやか","ももか"]
text=find_index(mcz,"しおり")
print(text)


text2=mcz.index("しおり")
print(text2)
text3=mcz.count("しおり")
print(text3)
