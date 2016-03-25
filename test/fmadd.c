#include "emmintrin.h"
#include "immintrin.h"
#include <stdio.h>

__m128d a, b, c, d;

int main() {
	a = _mm_set_pd(20.1, 30.1);
    b = _mm_set_pd(2.1, 3.1);
    c = _mm_set_pd(10.1, 40.1);

    
	d = _mm_fmadd_pd(a, b, c);

	printf("%f %f\n", d[1], d[0]);
	return 0;
}
