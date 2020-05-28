# Nearest points (D)

In this project, please provide an implementation for the function
`nearestPoints` that passes the tests available without modifying the tests.
The signature is:

```d
struct Point { double x, y }
Point[] nearestPoints(Range)(Range points, in Point center, size_t n);
```

This function returns the `n` points nearest to `center` according
to euclidean distance.

The command to run the tests and verify your work is `dub test`.
