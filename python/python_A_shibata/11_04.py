#正規表現
import re
from urllib import request
ur1="https://www.python.org/news/"
src=request.urlopen(ur1).read()
src=src.decode("utf-8")						#bytes型を文字列型に変換

pat=re.compile(r'href="(/download/releases/.+?)"')

for match in pat.finditer(src):
	print(match.group(1))
