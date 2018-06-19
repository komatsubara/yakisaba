def bar(a,b,**args):
	print(a,b,args)

bar(1,2,c=3,d=4)

def guess_encodong(s):
	"""
	バイト型の文字列を引数として受け取り、エンコードを簡易に判定
	"""
#判定を行うエンコードをリストに保存
	encodings=["ascii","utf-8","shift-jis","euc-jp"]
	for enc in encodings:
		try:
			s.decode(enc)
		except UnicodeDecodeError:
			continue
		else:
			return enc
	else:
		return ""
