import impl;
import std.math : approxEqual;
import std.format: format;
import std.algorithm.iteration: map;
import std.algorithm.sorting: isSorted;


unittest {
	Point a = Point(1.0, 2.0);
	Point b = Point(2.0, 1.0);
	Point c = Point(-1.0, 2.0);
	Point d = Point(-1.0, -2.0);
	Point e = Point(0.0, 0.0);

	{
		double r0 = distance(a, b);
		double r1 = distance(b, a);

		assert(approxEqual(r0, r1), format("%s %s", r0, r1));
	}

	{
		double r0 = distance(a, c);
		double r1 = distance(b, a);

		assert(!approxEqual(r0, r1), format("%s %s", r0, r1));
	}

	{
		double r0 = distance(e, d);
		double r1 = distance(e, a);

		assert(approxEqual(r0, r1), format("%s %s", r0, r1));
	}
}


unittest {
	import std.algorithm.comparison : equal;
	auto p1 = pointRng(10, 1337);
	auto p2 = pointRng(10, 1337);
	assert(equal(p1, p2));
}


unittest {
	auto center = Point(0.0, 0.0);
	auto rslt = nearestPoint(pointRng(2000, 1338), center, 10);
	assert(rslt.length == 10);
	assert(rslt.map!(it => distance(center, it)).isSorted);
}


unittest {
	auto center = Point(0.0, 0.0);
	auto rslt = nearestPoint(pointRng(7, 1338), center, 10);
	assert(rslt.length == 7);
	assert(rslt.map!(it => distance(center, it)).isSorted);
}
