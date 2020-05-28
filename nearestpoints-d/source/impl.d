struct Point {
	double x;
	double y;

	bool opEquals(const Point other) const {
		import std.math: approxEqual;
		return approxEqual(this.x, other.x) && approxEqual(this.y, other.y);
	}
}


Point[] nearestPoint(Input)(Input input, const(Point) center, size_t n) {
	return [];
}


double distance(const(Point) a, const(Point) b) {
	import std.math : pow, sqrt;
	return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
}
