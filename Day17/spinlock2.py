#!/usr/bin/python

step = int(raw_input("Enter step size: "))

pos = 0
state = [0]
for i in range(50000000):
	pos = (pos + step) % len(state) + 1
	state.insert(pos, i + 1)

pos = 0
for i in state:
	if i == 0:
		break
	pos += 1
print state[(pos + 1) % len(state)]
