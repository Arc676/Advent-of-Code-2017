#!/usr/bin/python

factorA = 16807
factorB = 48271
div = 2147483647

filename = raw_input("Enter filename: ")

valA = 0
valB = 0

with open(filename, 'r') as file:
	lines = file.readlines()
	valA = int(lines[0])
	valB = int(lines[1])

matches = 0
for _ in range(int(5e6)):
	valA = (valA * factorA) % div
	while valA % 4 != 0:
		valA = (valA * factorA) % div
	valB = (valB * factorB) % div
	while valB % 8 != 0:
		valB = (valB * factorB) % div

	binA = format(valA, "032b")
	binB = format(valB, "032b")

	if binA[16:] == binB[16:]:
		matches += 1
print "Matches:", matches
