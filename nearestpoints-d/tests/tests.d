import impl;
import unit_threaded;
import std.math : approxEqual;
import std.format: format;
import std.algorithm.iteration: map;
import std.algorithm.sorting: isSorted;
import std.random : Random;


@("nearestPoint.0")
unittest {
	const center = Point(0.0, 0.0);
	const rslt = nearestPoint(pointRng(2000, 1338), center, 10);
	rslt.length.should == 10;
	assert(rslt.map!(it => distance(center, it)).isSorted);
}


@("nearestPoint.1")
unittest {
	const center = Point(0.0, 0.0);
	const rslt = nearestPoint(pointRng(7, 1338), center, 10);
	rslt.length.should == 7;
	assert(rslt.map!(it => distance(center, it)).isSorted);
}


@("distance")
unittest {
	const a = Point(1.0, 2.0);
	const b = Point(2.0, 1.0);
	const c = Point(-1.0, 2.0);
	const d = Point(-1.0, -2.0);
	const e = Point(0.0, 0.0);

	{
		const r0 = distance(a, b);
		const r1 = distance(b, a);
        r0.should ~ r1;
	}

	{
		const r0 = distance(a, c);
		const r1 = distance(b, a);
		r0.should.not ~ r1;
	}

	{
		const r0 = distance(e, d);
		const r1 = distance(e, a);
		r0.should ~ r1;
	}
}


private PointRng pointRng(long cnt, uint seed) {
	PointRng ret;
	ret.rnd = Random(seed);
	ret.cnt = cnt;
	ret.front = rndPoint(ret.rnd);
	return ret;
}


private struct PointRng {
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


@("pointRng")
unittest {
	import std.algorithm.comparison : equal;
	const p1 = pointRng(10, 1337);
	const p2 = pointRng(10, 1337);
	p1.should == p2;
}


private Point rndPoint(ref Random rnd) {
	import std.random : uniform;
	return Point(uniform(-20.0, 20.0, rnd), uniform(-20.0, 20.0, rnd));
}
