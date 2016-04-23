#include "emmintrin.h"

__m128i a, b, c;

int main() {
	c = _mm_madd_epi16(a, b);
	return 0;
}
