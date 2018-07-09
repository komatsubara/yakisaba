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

print("i3インスタンスのvalueアトリビュート:")#インスタンスのアトリビュートを表示
print(i3.value)#インスタンスノアトリビュートを表示
print("\n角柱")
class Prism:
	def __init__(self,width,height,depth):#初期化メソッドを定義
		self.width=width#アトリビュートを追加
		self.height=height
		self.__depth=depth
		self.depth=depth
	def content(self):
		return self.width*self.height*self.__depth
p1=Prism(10,20,30)
print(p1.content())
p1.height=50
print(p1.content())

print("\n")
p=Prism(10,20,30)
print(p.width)
p.__depth="30"
p.depth="30"
print(p.content())
print(p.depth*p.width*p.height)
