#include "emmintrin.h"
#include "xmmintrin.h"
#include <stdio.h>

__m128 a;

int main() {
	a = _mm_set_epi32(0xF0F0F0F0u, 0xF0F0F0F0u, 0xF0F0F0F0u, 0xF0F0F0F0u);
	int r = _mm_movemask_epi8(a);
	printf("%x\n", r);
	return 0;
}
