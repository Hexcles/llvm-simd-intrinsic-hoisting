#include <xmmintrin.h>
#include <stdio.h>

int main(void)
{
    __m128i resultLo = _mm_setr_epi16(800, 700, 600, 500, 400, 300, 200, 100);
    __m128i resultHi = _mm_setr_epi16(0, -100, -200, -300, -400, -500, -600, -700);
    __m128i result = _mm_packus_epi16(resultLo, resultHi);
    printf("resultLo = %vhd\n", resultLo);
    printf("resultHi = %vhd\n", resultHi);
    printf("result   = %vu\n", result);
    return 0;
}