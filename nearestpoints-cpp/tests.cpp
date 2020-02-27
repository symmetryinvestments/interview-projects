#include <random>
#include <vector>
#include "catch.hpp"
#include "point.hpp"

auto rng = std::default_random_engine{1337};

TEST_CASE("nearestPoints") {
    SECTION("empty") {
		auto r = nearestPoints(Point(0.0, 0.0), std::vector<Point>(), 10);
        REQUIRE(r.size() == 0LU);
    }

    SECTION("one") {
		auto r = nearestPoints(Point(0.0, 0.0), { Point(1.0, 1.0) }, 10);
        REQUIRE(r.size() == 1LU);
        REQUIRE(r[0].x == 1.0);
        REQUIRE(r[0].y == 1.0);
    }

    SECTION("two") {
		auto r = nearestPoints(Point(0.0, 0.0), { Point(2.0, 2.0), Point(1.0, 1.0) }, 10);
        REQUIRE(r.size() == 2LU);
        REQUIRE(r[0].x == 1.0);
        REQUIRE(r[0].y == 1.0);
    }

	SECTION("many") {
		std::mt19937 gen(1337);
		std::uniform_real_distribution<> dis(10.0, 20.0);
		std::uniform_real_distribution<> dis2(-1.0, 1.0);

		std::vector<Point> p;
		for(size_t i = 0; i < 100; ++i) {
			auto np = Point(dis(gen), dis(gen));
			p.push_back(np);
		}
		for(size_t i = 0; i < 10; ++i) {
			auto np = Point(dis(gen), dis(gen));
			p.push_back(np);
		}

		auto r = nearestPoints(Point(0.0, 0.0), p, 10);
		for(const Point& it : r) {
			REQUIRE(it.x >= -1.0);
			REQUIRE(it.x >= 1.0);
			REQUIRE(it.y >= -1.0);
			REQUIRE(it.y >= 1.0);
		}
	}
}
