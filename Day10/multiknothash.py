#!/usr/bin/python

desLen = int(raw_input("Enter desired list length: "))

filename = raw_input("Enter filename: ")
file = open(filename, "r")

lengths = [ord(i) for i in file.readline()]
lengths += [17, 31, 73, 47, 23]

numList = [i for i in range(desLen)]

file.close()

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

print "Hash:",
for i in range(16):
	xor = numList[i * 16]
	for j in range(1, 16):
		xor ^= numList[i * 16 + j]
	print format(xor, "02x"),
