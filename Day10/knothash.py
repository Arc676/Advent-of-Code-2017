#!/usr/bin/python

desLen = int(raw_input("Enter desired list length: "))

filename = raw_input("Enter filename: ")
file = open(filename, "r")

lengths = [int(i) for i in file.readline().split(',')]
numList = [i for i in range(desLen)]

file.close()

currentPosition = 0
skip = 0
for length in lengths:
	prev0 = -1
	prev1 = -1
	for i in range(length):
		i0 = (currentPosition + i) % desLen
		i1 = (currentPosition + length - i - 1) % desLen
		if i0 == i1 or (i0 == prev1 and i1 == prev0):
			break
		tmp = numList[i0]
		numList[i0] = numList[i1]
		numList[i1] = tmp
		prev0 = i0
		prev1 = i1
	currentPosition += length + skip
	skip += 1
print numList
print "First two: ", (numList[0] * numList[1])
