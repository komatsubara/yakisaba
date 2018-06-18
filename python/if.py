v_str=input()#km/h
v=int(v_str)
if v<28400:
	print("第1宇宙速度以下")
if v>= 28400 and v<40300:
	print("第1宇宙速度以上、第2宇宙速度未満")
if v>= 40300 and v <60100:
	print("第2宇宙速度以上、第3宇宙速度未満")
if v>=60100:
	print("第3宇宙速度以上")
