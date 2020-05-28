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

	static struct PointDis {
		Point p;
		double d;
	}

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


double distance(const(Point) a, const(Point) b) {
	import std.math : pow, sqrt;
	return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2));
}
