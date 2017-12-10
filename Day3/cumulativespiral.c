#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** squares;
int width;

int sumAdjacent(int x, int y) {
	int sum = 0;
	if (x > 0) {
		sum += squares[y][x - 1];
	}
	if (x < width - 1) {
		sum += squares[y][x + 1];
	}
	if (y > 0) {
		sum += squares[y - 1][x];
	}
	if (y < width - 1) {
		sum += squares[y + 1][x];
	}
	if (x > 0 && y > 0) {
		sum += squares[y - 1][x - 1];
	}
	if (x > 0 && y < width - 1) {
		sum += squares[y + 1][x - 1];
	}
	if (x < width - 1 && y > 0) {
		sum += squares[y - 1][x + 1];
	}
	if (x < width - 1 && y < width - 1) {
		sum += squares[y + 1][x + 1];
	}
	if (sum == 0) {
		return 1;
	}
	return sum;
}

int main(int argc, char* argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Usage: cs width\n");
		return 1;
	}
	width = 1 + 2 * (int)strtol(argv[1], (char**)NULL, 0);
	int x = width / 2, y = x;
	squares = malloc(width * sizeof(int));
	for (int i = 0; i < width; i++) {
		squares[i] = malloc(width * sizeof(int));
		memset(squares[i], 0, width * sizeof(int));
	}
	int edge = 0;
	while (x != width && y != 0) {
		squares[y][x] = sumAdjacent(x, y);
		x++;
		edge++;
		for (int i = 0; i < edge; i++) {
			squares[y][x] = sumAdjacent(x, y);
			y--;
		}
		edge++;
		for (int i = 0; i < 3; i++) {
			int delta[] = {-1, 0};
			for (int j = 0; j < edge; j++) {
				x += delta[0];
				y += delta[1];
				squares[y][x] = sumAdjacent(x, y);
			}
			//turn left
			int tmp = delta[0];
			delta[0] = -delta[1];
			delta[1] = tmp;
		}
	}
	for (int y = 0; y < width; y++) {
		for (int x = 0; x < width; x++) {
			printf("%6d ", squares[y][x]);
		}
		free(squares[y]);
		printf("\n");
	}
	free(squares);
	return 0;
}
