#include "emmintrin.h"
#include <stdio.h>

__m128i a, b, c;

int main() {
	a = _mm_set_epi16(1, 2, 3, 4, 5, 5, 6, 4);
	b = _mm_set_epi16(5, 3, 2, 1, 4, 3, 6, 1);
	c = _mm_sad_epu8(a, b);

	printf("%llx %llx\n", c[1], c[0]);
	return 0;
}
