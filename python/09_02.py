class Aklass:					#簡単なクラスを定義
	def __init__(self):	
		self.spam=1				#初期化メソッドでアトリビュートを定義

i=Aklass()						#インスタンスを作る
print(dir(i))

i.egg=1
print(dir(i))

print("\n")
#メソッドをアトリビュートに代入する
class Atomklass:
	def foo(self):								#メソッドを定義
		print("this is foo method")

i1=Atomklass()									#インスタンスを作成
i2=Atomklass()									#もう１つインスタンス
i1.bar=i1.foo										#メソッドを新しいアトリビュートに代入
i1.bar()

print("\n")
#型を調べる
print(type(1))
print(type("愛餓えを"))
print(type(b"abcd"))
import sys
print(type(sys))


print("")
print(isinstance(1,type(1)))		#整数型かどうか調べる
print(isinstance(1,str))
print(isinstance("愛う",object))


print("")
s="abcde"												#文字列を定義
print(dir(s))
getattr(s,"find")
print(getattr(s,"find"))							#findアトリビュートを取り出す
print(s.find("cd"))
print(getattr(s,"find")("cd"))

print("")
#オブジェクトと変数
import math											#mathモジュールをインポート
m=math													#モジュールを変数に代入
s=m.sin													#sin()関数を変数に代入
print(s(0.5))
