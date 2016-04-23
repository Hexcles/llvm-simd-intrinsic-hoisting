# Case 1: already implemented in C expressions in clang header
```
add 11
sub 11
div 2
mullo, mul_sd, mul_pd 3
and 4
xor 2
or 2
cast 6
cmp*_epi 9
set 21
extract 1
insert 1
load 11
store 11
shuffle 4
unpack 10
```

# Case 2: hoisted and compiled to efficient SIMD instructions
```
cmp*_pd 12
comi 12
shift 20
sqrt 2
min 4
max 4
```

# Case 3: hoisted but scalarized during compilation
```
cmp*_sd 12
avg 2
pmuludq, mulhi, madd 4
pack 3
movemask 3
move 4
sad 1
```

# Not researched
```
clflush 1
lfence 1
mfence 1
pause 1
stream 4
convert cvt 29
```
