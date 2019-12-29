median (D)
============

This project contains an implementation of finding the median of a set of integers in C++,
with the very simple API and implementation in `median.d`:

```d
double median(R)(R numbers) if(isInputRange!R && is(Unqual!(ElementType!R) == int));
```

The task is to optimise the runtime of the implementation whilst not breaking the
unit tests.

To run the tests, use `dub test`.
To build the benchmark application, use `dub build --build=release --compiler=ldc`.
