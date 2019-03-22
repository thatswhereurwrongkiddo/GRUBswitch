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

if user_choice.lower() == "random":
    pass
else:
    pass
