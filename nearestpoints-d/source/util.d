import impl: Point;
import std.random: Random;


PointRng pointRng(long cnt, uint seed) {
	PointRng ret;
	ret.rnd = Random(seed);
	ret.cnt = cnt;
	ret.front = rndPoint(ret.rnd);
	return ret;
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


private Point rndPoint(ref Random rnd) {
	import std.random : uniform;
	return Point(uniform(-20.0, 20.0, rnd), uniform(-20.0, 20.0, rnd));
}
