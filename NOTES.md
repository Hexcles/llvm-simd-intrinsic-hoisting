# Categories of SSE2 operations

## Automatically hoisted by clang (via header file)

See `include/emmintrin.h` provided by clang.

Characteristics:

* Can be expressed by standard C operators (arithmetic & bit operations)
* Mostly pure vertical operations
* Special case: shuffle & unpack (element selection with immediate operands or constant/hard-coded
  patterns) via shufflevector

Examples:

* add, sub, and, or, div, cast
* shuffle & unpack

Anomaly:

* shift (different semantics from C shifting operators)
* multiply (saturation or change of field width)
* pack (change of field width)

## Compiled to optimal SIMD operation after manual hoisting

Characteristics:

* Can be represented by a short sequence of LLVM IR or ISD Ops
* Mostly pure vertical operations

LLVM processing behind the scene:

Peephole expansion in the first step in SelectionDAG (instruction selection), DAG initialization,
would do pattern matching and recognize some common IR sequences.

Examples:

* shift (IR: shl, shr)
* min, max (IR: icmp + select; ISD: (S|U)(MIN|MAX) )

## Degraded (scalarized) after manual hoisting

Characteristics:

* Saturated operations
* Horizontal operations
* Field width changed

Issues:

* Saturation support
* DAG Combiner (SelectionDAG optimizer) generates suboptimal code.

Examples:

* multiply
* pack
* movemask
* sad (sum of absolute difference)

# Problems and Potential Solutions

* Would native saturation support in LLVM help?
* Shall we add more, longer patterns in the peephole expansion when building DAG?
* What happens in DAG Combiner?
