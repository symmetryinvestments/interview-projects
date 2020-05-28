import impl;
import std.stdio: writeln;
import std.algorithm.iteration: map;

void main() {
	auto center = Point(0.0, 0.0);
	auto rslt = nearestPoint(pointRng(2000, 1338), center, 10);
	writeln(rslt);
	writeln(rslt.map!(it => distance(center, it)));
}
