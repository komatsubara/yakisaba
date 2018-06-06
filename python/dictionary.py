purple={"ニックネーム":"れにちゃん","出身地":"神奈川県","キャッチフレーズ":"感電少女"}
print(purple["出身地"])
print(purple)

purple["キャッチフレーズ"]="鋼少女"
print(purple)

purple["生年月日"]="1993年6月21日"
print(purple)

del purple["ニックネーム"]
print(purple)
print("forで回す")
for key in purple:
	print(key,purple[key])
