def convert_number(num):
#アラビア数字とローマ数字の対応表をディク書なりに定義
	roman_nums={1:"I",2:"II",3:"III",4:"IV",5:"V",6:"VI",7:"VII",8:"VIII",9:"IX"}

	if num in roman_nums:
		return roman_nums[num]
	else:
		return "[変換できません]"
num_str=input()
num=int(num_str)
print(convert_number(num))
