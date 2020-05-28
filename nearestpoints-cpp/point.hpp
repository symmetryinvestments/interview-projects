#include <vector>

/** Given the Point struct and the function nearestPoints please fill in the
 details. The function nearestPoints should return a new vector ( list ) with
 the `n` points out of the parameter `points` which are closed
 ( euclidean distance ) to `center`.

 Please include tests for your implementation.
*/

struct Point {
	double x;
	double y;
	Point(double x, double y): x{x}, y{y} {}
};

std::vector<Point> nearestPoints(const Point& center, const std::vector<Point>& points, const size_t n);
