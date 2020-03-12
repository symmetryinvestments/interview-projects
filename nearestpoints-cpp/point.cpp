#include "point.hpp"
#include <cmath>
#include <algorithm>

struct PointDis {
	size_t pointIdx;
	double distance;

	PointDis(size_t pIn, double dIn) : pointIdx(pIn), distance(dIn) {
	}
};

bool pointDisCmp(const PointDis& a, const PointDis& b) {
	return a.distance < b.distance;
}

double distance(const Point& a, const Point& b) {
	return std::sqrt(std::pow(a.x - b.x, 2) + std::pow(a.y - b.y, 2));
}

std::vector<Point> nearestPoints(const Point& center, 
		const std::vector<Point>& points, const size_t n) 
{
	std::vector<PointDis> dis;
	for(size_t i = 0; i < points.size(); ++i) {
		const double d = distance(center, points[i]);
		const PointDis pd = PointDis(i, d);
		if(dis.size() < n) {
			dis.push_back(pd);
			std::sort(dis.begin(), dis.end(), pointDisCmp);
		} else {
			for(size_t j = 0; j < dis.size(); ++j) {
				if(pointDisCmp(pd, dis[j])) {
					dis[i] = pd;
					break;
				}
			}
		}
	}

	std::vector<Point> ret;
	ret.reserve(dis.size());
	for(const PointDis& it : dis) {
		ret.push_back(points[it.pointIdx]);
	}
	return ret;
}
