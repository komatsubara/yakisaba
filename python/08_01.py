#モジュールのインポートの例
#そのいち
import bookmark

b=bookmark.Bookmark("タイトル","http://path.to/site")

#そのに
from bookmark import Bookmark
b=Bookmark("タイトル","http://path.to/site")

#クラスの継承
import bookmark

class Blogmark(bookmark.Bookmark):
	.......

#継承の書き方そのに
from bookmark import Bookmark

classBlogmark(Bookmark)
