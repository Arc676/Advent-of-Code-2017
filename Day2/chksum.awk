#!/usr/bin/awk -f

BEGIN	{ sum = 0 }
	{
		max = $1
		min = $1
		for (i = 1; i <= NF; i++) {
			if ($i > max) {
				max = $i
			}
			if ($i < min) {
				min = $i
			}
		}
		sum += max - min
	}
END	{ print "Checksum: " sum }
