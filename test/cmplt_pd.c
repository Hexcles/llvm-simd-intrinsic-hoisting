#include "emmintrin.h"
#include <stdio.h>

__m128i a, b, c;

int main() {
	a = _mm_set_epi32(1, 2, 3, 4);
	b = _mm_set_epi32(5, 3, 2, 1);
	c = _mm_cmplt_pd(a, b);

	printf("%llx %llx\n", c[1], c[0]);
	return 0;
}
