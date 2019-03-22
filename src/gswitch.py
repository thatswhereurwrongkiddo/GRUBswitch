#!/bin/python

#MIT License

#Copyright (c) 2019 thatswhereurwrongkiddo

#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

import os
import random


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
        global grub_th1
        global ruc
        rstr = str(random.random())
        ruc = rstr[7]
        if int(ruc) < len(list):
            grub_th1 = list[int(ruc)]
            Paths.gofor()
        else:
            rstr = str(random.random())
            ruc = rstr[7]
            Paths.random()
    def gofor():
        global grub_th1
        print("")
        print('"' + grub_th1 + '"' + " is the selected first theme.")
        input("Press ENTER to continue...")
        GSwitch.main()

class GSwitch:
    def main():
        os.system("clear")
        global ruc
        global grub_th1
        os.system("mv {0} grub_th1".format(grub_th1))
        amount = 1
        while int(ruc)+1 <= int(len(list)):
            amount = amount + 1
            os.system("mv {0} grub_th{1}".format(list[ruc], amount))
            ruc = ruc + 1
        print("Files renamed!")



if user_choice.lower() == "random":
    Paths.random()
#type(int(user_choice)) needed because if user_choice != "random" and != integer,
#python will throw "invalid literal" error, instead of proceeding user to Paths.selection(), which could lead
#to problems later on down the road
elif type(int(user_choice)) == int:
    global ruc
    ruc = int(user_choice) - 1
    grub_th1 = list[ruc]
    ruc = int(user_choice)
    Paths.gofor()
