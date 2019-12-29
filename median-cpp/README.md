median (C++)
============

This project contains an implementation of finding the median of a set of integers in C++,
with the very simple API in `median.hpp`:

```c++
double median(const std::vector<int>& numbers);
```

The implementation is in `median.cpp`.

The task is to optimise the runtime of the implementation whilst not breaking the
unit tests.

To generate a build system, one can use `cmake .`, then to build use `cmake --build .`
from this directory. It is recommended however to use instead:

```
mkdir bin
cd bin
cmake -G Ninja --DCMAKE_CXX_COMPILER=clang++ ..
ninja
```

That will build two executables: `ut` and `app`. The `ut` binary runs the tests,
while the `app` binary times the implementation.
