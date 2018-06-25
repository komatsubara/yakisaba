#OrderedDictを使う
from collections import OrderedDict
od=OrderedDict()											#OrderedDictインスタンスを作る
od["a"]="A"														#要素を追加
od["c"]="C"														#要素を追加
od["b"]="B"														#要素を追加
print(od)

d={}																	#ディクショナリを作る
d["a"]="A"
d["c"]="C"
d["b"]="B"
print(d)

#デフォルト値を持つディクショナリ
print("")
animals=[("猫","三毛"),("犬","コーギー"),("猫","シャム"),("犬","ダックス"),("犬","黒ラブ")]
d={}
for k,v in animals:										#タプルからディクショナリを作る
	if k not in d:
		d[k]=[v]													#キーが存在しなかったのでリストで初期化
	else:
		d[k].append(v)
print(d)

from collections import defaultdict
dd=defaultdict(list)									#空のリストを初期値に持つディクショナリを作る
print(dd)
for k,v in animals:
	dd[k].append(v)
print(dd)
