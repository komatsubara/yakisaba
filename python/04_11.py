imgfile=open("Figure_1.png","rb")
imgsrc=imgfile.read()
if imgsrc[1:4]==b"PNG":
	print("image/png")
