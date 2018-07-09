import random

print(random.random())
print(random.randint(0,8))
a_list=[0,1,2,3,4,5]
random.shuffle(a_list)
print(a_list)
print(random.choice(a_list))

print('from import')
from statistics import median

monk_fish_team=[158,157,163,157,145]
volleyball_team=[143,167,170,165]
print(median(monk_fish_team))
print(median(volleyball_team))
