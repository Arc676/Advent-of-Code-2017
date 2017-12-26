#!/usr/bin/python

filename = raw_input("Enter filename: ")

file = open(filename, 'r')
lines = file.readlines()
expansion = 1000
nodes = []
for _ in range(expansion):
	nodes.append(["." for _ in range(expansion + len(lines[0]))])
for line in lines:
	nodes.append(["." for _ in range(expansion/2)] + list(line.rstrip()) + ["." for _ in range(expansion/2)])
for _ in range(expansion):
	nodes.append(["." for _ in range(expansion + len(lines[0]))])
file.close()

x = (len(nodes[0]) - 1) / 2
y = len(nodes) / 2
delta = (0, 1)

infections = 0
for _ in range(10000):
	try:
		if nodes[y][x] == "#":
			delta = (delta[1], -delta[0])
			nodes[y][x] = "."
		else:
			delta = (-delta[1], delta[0])
			nodes[y][x] = "#"
			infections += 1
		x += delta[0]
		y -= delta[1]
	except:
		print x, y
		for row in nodes:
			print ''.join(row)
		break

print infections, "infections"
