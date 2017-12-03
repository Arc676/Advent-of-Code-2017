#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#ifndef DEBUG
	#define DEBUG 0
#else
	#define DEBUG 1
#endif

int min(int a, int b) {
	if (a < b) {
		return a;
	}
	return b;
}

int max(int a, int b) {
	if (a > b) {
		return a;
	}
	return b;
}

int main(int argc, char* argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Usage: ts number\n");
		return 1;
	}
	int num = (int)strtol(argv[1], (char**)NULL, 0);
	if (num < 1) {
		return 2;
	}
	int solution = 0;
	if (num != 1) {
		int dx = 0, dy = 0;
		int root = (int)floor(sqrt(num));
		if (root % 2 == 0) {
			dx = -(root / 2 - 1);
			dy = 1 - dx;
		} else {
			dx = (root - 1) / 2;
			dy = -dx;
		}
		if (root * root != num) {
			int distance = num - root * root;
			int direction = root % 2 == 0 ? -1 : 1;
			dx += direction;
			distance--;
			int edge = 2 * abs(max(abs(dx), abs(dy))) + 1;
			dy += direction * min(edge - 1, distance);
			distance -= edge - 1;
			if (distance > 0) {
				dx -= direction * distance;
			}
		}
		printf("dx: %d, dy: %d\n", dx, dy);
		solution = abs(dx) + abs(dy);
	}
	printf("Solution: %d\n", solution);
	return 0;
}
