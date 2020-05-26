Nearest points (C++)
============

This project contains an implementation of finding the N nearest points  in C++.

```c++
struct Point {
	double x;
	double y;
};

std::vector<Point> nearestPoints(const Point& center, const std::vector<Point>& points, const size_t n);
```

The task is to develop the function `nearestPoints` such that the functions
returns a new vector containing the `n` points nearest (euclidean distance) to
`center`;

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
