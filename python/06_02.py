class Myclass:
	pass
i=Myclass()#Myclassからiインスタンスを作る
i.value=5 #iインスタンスにアトリビュートを追加して5を代入　そのインスタンス専用の変数
print(i.value)

class Myclass2: #クラスを作る
	def __init__(self):#初期化メソッドを定義
		self.value=0#インスタンスにアトリビュートを追加
		print("This is __init__() method")

i3=Myclass2()#インスタンスを作る

print("i3インスタンスのvalueアトリビュート:")#インスタンスノアトリビュートを表示
print(i3.value)#インスタンスノアトリビュートを表示
