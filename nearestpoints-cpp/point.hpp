#pragma once

#include <vector>

struct Point {
	double x;
	double y;

	Point(double xi, double yi) : x(xi), y(yi) {
	}
};

std::vector<Point> nearestPoints(const Point& center, const std::vector<Point>& points, const size_t n);
