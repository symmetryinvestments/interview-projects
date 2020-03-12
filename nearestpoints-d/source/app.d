import std.algorithm.iteration : map;
import std.algorithm.sorting : isSorted;
import std.format : format;
import std.math : approxEqual;
import std.random;
import std.stdio;

struct Point {
	double x;
	double y;

	bool opEquals(const Point other) const {
		return approxEqual(this.x, other.x) && approxEqual(this.y, other.y);
	}
}

struct PointDis {
	Point p;
	double d;
}

double distance(const(Point) a, const(Point) b) {
	import std.math : pow, sqrt;
	return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
}

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

Point[] nearestPoint(Input)(Input input, const(Point) center, size_t n) {
	import std.algorithm.sorting : sort;
	import std.array : array;

	PointDis[] tmp;

	foreach(Point it; input) {
		PointDis pd = PointDis(it, distance(center, it));
		if(tmp.length < n) {
			tmp ~= pd;
			sort!((a, b) => a.d < b.d)(tmp);
		} else {
			foreach(ref p; tmp) {
				if(pd.d < p.d) {
					p = pd;
					break;
				}
			}
		}
	}

	return tmp.map!(it => it.p).array;
}

Point rndPoint(ref Random rnd) {
	return Point(uniform(-20.0, 20.0, rnd), uniform(-20.0, 20.0, rnd));
}

struct PointRng {
	long cnt;
	Point front;
	Random rnd;
	
	@property bool empty() const {
		return this.cnt <= 0;
	}

	void popFront() {
		this.front = rndPoint(this.rnd);
		this.cnt--;
	}
}

PointRng pointRng(long cnt, uint seed) {
	PointRng ret;
	ret.rnd = Random(seed);
	ret.cnt = cnt;
	ret.front = rndPoint(ret.rnd);
	return ret;
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

void main() {
	auto center = Point(0.0, 0.0);
	auto rslt = nearestPoint(pointRng(2000, 1338), center, 10);
	writeln(rslt);
	writeln(rslt.map!(it => distance(center, it)));
}
