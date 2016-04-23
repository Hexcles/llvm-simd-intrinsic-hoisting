#!/bin/sh

make -C ../build
for c_file in $(ls *.c); do
        echo $c_file
        original_ll=${c_file/%.c/_original.ll}
        hoisted_ll=${c_file/%.c/.ll}
        clang -emit-llvm -S $c_file -o $original_ll
        clang -Xclang -load -Xclang ../build/IntrinsicHoister/*.so -emit-llvm -S $c_file -o $hoisted_ll
        clang -S $original_ll $hoisted_ll
done
