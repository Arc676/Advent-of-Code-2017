#!/usr/bin/python
import time
step = int(raw_input("Enter step size: "))
startTime = time.time()
pos = 0
state = [0]
for i in range(2017):
	pos = (pos + step) % len(state) + 1
	state.insert(pos, i + 1)
#	print state
print state[(pos + 1) % len(state)]
print (time.time() - startTime)
