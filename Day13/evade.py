#!/usr/bin/python
import signal
import sys

layerCount = int(raw_input("Enter layer count: "))

filename = raw_input("Enter filename: ")
file = open(filename, 'r')

#each layer contains [current position, range, direction]
firewall = [[0,0,1] for i in range(layerCount)]

for line in file.readlines():
	parts = line.split(': ')
	firewall[int(parts[0])][1] = int(parts[1])

file.close()

def check(delay, firewall):
	pos = 0
	for layer in firewall:
		if layer[1] == 0:
			pos += 1
			continue
		if (pos + delay) % ((layer[1] - 1) * 2) == 0:
			return False
		pos += 1
	return True

delay = int(raw_input("Enter starting delay: "))

def handle(signum, frame):
	global delay
	print "Delay on TERM:", delay
	sys.exit(0)

signal.signal(signal.SIGINT, handle)

while not check(delay, firewall):
	delay += 1

print "Lowest delay:", delay
