#!/bin/python

import os

list = []
root = "."
for item in os.listdir(root):
    if os.path.isdir(os.path.join(root, item)):
        list.append(item)

amount = 0


for x in range(len(list)):
    print("({0}) ".format(x+1) + list[x])

for i in list:
    amount = amount + 1

print()
print("Which would you like to be your next theme?")
user_choice = input("Type (random) for a random one: ")

class Paths:
    def random():
        pass
    def selection():
        pass

if user_choice.lower() == "random":
    Paths.random()
#type(int(user_choice)) needed because if user_choice != "random" and != integer,
#python will throw "invalid literal" error, instead of proceeding user to Paths.selection(), which could lead
#to problems later on down the road
elif type(int(user_choice)) == int:
    grub_th1 = int(user_choice)
    Paths.selection()
