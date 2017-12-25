#!/usr/bin/python
import re

def match(line, regex):
	reg = re.compile(regex)
	return reg.findall(line)[0]

filename = raw_input("Enter filename: ")

file = open(filename, 'r')

lines = file.readlines()

state = match(lines.pop(0), '\W(\w)\W*$')

stepLimit = match(lines.pop(0), '\W(\d+) steps\W*$')

states = {}

while len(lines) > 0:
	lines.pop(0)
	newState = [{},{}];
	stateName = match(lines.pop(0), '\W(\w):\W*$')

	for i in range(2):
		lines.pop(0)
		newState[i]["write"] = int(match(lines.pop(0), 'value (\d+)\W*$'))

		dir = match(lines.pop(0), 'the (\w+)\W*$')
		newState[i]["dir"] = 1;
		if dir == "left":
			newState[i]["dir"] = -1;

		newState[i]["next"] = match(lines.pop(0), 'state (\w)\W*$')
	states[stateName] = newState

file.close()

print "Allocating memory...",
tape = [0 for _ in range(10000000)]
pos = 5000000
print "Done"

def move(dir):
	global pos
	global tape
	if pos + dir < 0:
		tape.insert(0, 0)
	elif pos + dir >= len(tape):
		tape.append(0)
	pos += dir

for _ in range(int(stepLimit)):
	instructions = states[state][tape[pos]]
	tape[pos] = instructions["write"]
	move(instructions["dir"])
	state = instructions["next"]

print "1's:", sum(tape)
