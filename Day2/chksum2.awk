#!/usr/bin/awk -f

BEGIN	{ sum = 0 }
	{
		for (i = 1; i <= NF; i++) {
			found = false
			for (j = 1; j <= NF; j++) {
				if (j == i) { continue }
				if ($i % $j == 0) {
					sum += $i / $j
					found = true
					break
				}
			}
			if (found) { break }
		}
	}
END	{ print "Checksum: " sum }
