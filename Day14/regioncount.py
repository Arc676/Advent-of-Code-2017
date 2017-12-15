#!/usr/bin/python

desLen = 256

filename = raw_input("Enter filename: ")
file = open(filename, "r")

key = file.readline()
keylist = [[ord(i) for i in key + "-" + str(j)] + [17, 31, 73, 47, 23] for j in range(128)]

file.close()

regionCount = 0

for lengths in keylist:
	numList = [i for i in range(desLen)]
	currentPosition = 0
	skip = 0
	for hashRound in range(64):
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
	for i in range(16):
		xor = numList[i * 16]
		for j in range(1, 16):
			xor ^= numList[i * 16 + j]
		bin = str(format(xor, "b"))
		for digit in bin:
			if digit == "1":
				regionCount += 1
print "Region count:", regionCount
