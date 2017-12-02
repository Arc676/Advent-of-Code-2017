#include <stdio.h>
#include <stdlib.h>

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
	fseek(file, 0, SEEK_END);
	long len = ftell(file);
	char* numbers = malloc(len);
	fseek(file, 0, 0);

	char c = 0;
	for (int i = 0; (c = fgetc(file)) != EOF; i++) {
		numbers[i] = c;
	}

	int sum = 0;
	for (int i = 0; i < len; i++) {
		if (numbers[i] == numbers[(i + len/2) % len]) {
			sum += (int)numbers[i] - 48;
		}
	}
	fclose(file);
	printf("Solution: %d\n", sum);
	return 0;
}
