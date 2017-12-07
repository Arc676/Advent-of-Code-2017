#!/usr/bin/python

def findMax(arr):
	i = 0
	j = 0
	maxVal = arr[0]
	for val in arr:
		if val > maxVal:
			maxVal = val
			i = j
		j += 1
	return i, maxVal

filename = raw_input("Enter filename: ")
file = open(filename, 'r')
banks = [int(i) for i in file.readline().split('\t')]

states = []
reallocations = 0
toRepeat = []
while True:
	index, bankCount = findMax(banks)
	banks[index] = 0
	while bankCount > 0:
		index += 1
		bankCount -= 1
		banks[index % len(banks)] += 1
	reallocations += 1
	if banks in states:
		if len(toRepeat) == 0:
			toRepeat = banks[:]
			reallocations = 0
		else:
			if banks == toRepeat:
				break
	states.append(banks[:])
print reallocations, "reallocations needed"
