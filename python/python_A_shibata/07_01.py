#----------------------------------classの練習-------------------------------
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


#---------------------------------角柱class----------------------------------------
print("\n角柱")
class Prism:
	def __init__(self,width,height,depth):#初期化メソッドを定義
		self.width=width#アトリビュートを追加
		self.height=height
		self.__depth=depth
		self.depth=depth
	def content(self):
		return self.width*self.height*self.depth
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

#---------------------------------スーパークラス------------------------------------
print("\n スーパークラス")
class Cube(Prism):
	def __init__(self,length):#__init__()を再定義
		self.width=self.height=self.depth=length
c=Cube(20)#lengthに20を渡す
print(c.content())


class Prism2:
	def __init__(self,width,height,depth,unit="cm"):
		self.width=width
		self.height=height
		self.depth=depth
		self.unit=unit
		print("a")
	def content(self):
		return self.width*self.height*self.depth
	def unit_content(self):
		return print(str(self.content())+self.unit)

#----------------------------スーパークラスの書き換え-------------------------------
print("\nスーパークラスを上書きすると厄介なことになりうる")

class Cube2(Prism2):
	def __init__(self,length):#initを再定義
		super().__init__(length,length,length)#スーパークラスのinitメソッドを呼び出してる
c2=Cube2(20)
print(c2.content())
c2.unit_content()

#--------------------------スロット------------------------------------------------
print("\n スロット")
class Klass:
	__slots__=["a","b"]
	def __init__(self):
		self.a=1
	
i=Klass()  #インスタンスを作る
print(i.a)
i.b=2
print(i.b)
#------------------------プロパティ---------------------------------------------
print("\n　プロパティ")
class Prop:
	def __init__(self):
		self.__x=0#アトリビュートを作る
	def getx(self):
		return self.__x
	def setx(self,x):
		self.__x=x
	x=property(getx,setx)  #プロパティを作る

i=Prop()#インスタンスを作る
print(i.x)
i.x=10
print(i.x)
print(i._Prop__x)
