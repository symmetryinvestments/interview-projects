import std.range.primitives: isInputRange, ElementEncodingType;
import std.traits: Unqual;

struct Point {
	double x;
	double y;

	bool opEquals(in Point other) @safe pure const {
		import std.math: approxEqual;
		return approxEqual(this.x, other.x) && approxEqual(this.y, other.y);
	}
}


Point[] nearestPoint(Range)(Range points, in Point center, size_t n)
	if(isInputRange!Range && is(Unqual!(ElementEncodingType!Range) == Point))
{
	return [];
}


double distance(in Point a, in Point b) {
	import std.math : pow, sqrt;
	return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
}
