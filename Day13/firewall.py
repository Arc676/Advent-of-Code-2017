#!/usr/bin/python

layerCount = int(raw_input("Enter layer count: "))

#each layer contains [current position, range, direction]
depths = [[0,0,1] for i in range(layerCount)]

filename = raw_input("Enter filename: ")
file = open(filename, 'r')

for line in file.readlines():
	parts = line.split(': ')
	depths[int(parts[0])][1] = int(parts[1])

file.close()

currentLayer = -1
severity = 0
for _ in range(layerCount):
	currentLayer += 1
	if depths[currentLayer][0] == 0:
		print "Caught in layer", currentLayer
		severity += currentLayer * depths[currentLayer][1]
	for layer in range(layerCount):
		depths[layer][0] += depths[layer][2]
		if depths[layer][0] == 0 or depths[layer][0] == depths[layer][1] - 1:
			depths[layer][2] *= -1
print "Severity:", severity
