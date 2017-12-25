#!/usr/bin/python

filename = raw_input("Enter filename: ")
file = open(filename, 'r')

tubes = [[" "] + list(line) + [" "] for line in file.readlines()]

file.close()

y = 0
x = tubes[0].index("|")
delta = (0, 1)

letters = []

while True:
	x += delta[0]
	y += delta[1]
	if tubes[y][x] == " ":
		break
	if tubes[y][x] in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
		letters.append(tubes[y][x])
	elif tubes[y][x] == "+":
		rdelta = (delta[1], -delta[0])
		ldelta = (-delta[1], delta[0])
		if tubes[y + rdelta[1]][x + rdelta[0]] == " ":
			delta = ldelta
		else:
			delta = rdelta
print ''.join(letters)
