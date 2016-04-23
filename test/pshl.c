#include <emmintrin.h>

int main() {
	__m128i a, b, count;
	b = _mm_sll_epi64(a, count);
	return 0;
}
