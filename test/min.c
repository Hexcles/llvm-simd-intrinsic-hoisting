#include "emmintrin.h"
#include <stdio.h>

__m128i a, b, c;

int main() {
	a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
	b = _mm_set_epi16(5, 3, 2, 1, 4, 6, 1, 2);
	c = _mm_min_epi16(a, b);
	/* __m128i is also an uint64_t[2]
	 * Expected: 6 4
	 */
	printf("%llx %llx", c[1], c[0]);
	return 0;
}
