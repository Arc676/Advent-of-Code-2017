#include <stdio.h>

int main(int argc, char * argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Usage: ic filename\n");
		return 1;
	}
	FILE *file = fopen(argv[1], "r");
	if (file == NULL) {
		fprintf(stderr, "Failed to open file\n");
		return 2;
	}
	int sum = 0;
	char firstChar = fgetc(file);
	char curChar = firstChar;
	while (curChar != EOF) {
		char nextChar = fgetc(file);
		if (nextChar == EOF) {
			break;
		}
		if (curChar == nextChar) {
			sum += (int)curChar - 48;
		}
		curChar = nextChar;
	}
	fclose(file);
	if (firstChar == curChar) {
		sum += (int)firstChar - 48;
	}
	printf("Solution: %d\n", sum);
	return 0;
}
