import std.random : Random;


struct Point {
	double x;
	double y;

	bool opEquals(const Point other) const {
		import std.math: approxEqual;
		return approxEqual(this.x, other.x) && approxEqual(this.y, other.y);
	}
}


Point[] nearestPoint(Input)(Input input, const(Point) center, size_t n) {
	import std.algorithm.sorting : sort;
	import std.array : array;
	import std.algorithm.iteration : map;

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


struct PointDis {
	Point p;
	double d;
}


double distance(const(Point) a, const(Point) b) {
	import std.math : pow, sqrt;
	return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
}


Point rndPoint(ref Random rnd) {
	import std.random : uniform;
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
