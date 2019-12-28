#include "catch.hpp"
#include "median.hpp"
#include <random>


auto rng = std::default_random_engine{1337};


TEST_CASE("median") {

    SECTION("empty") {
        REQUIRE_THROWS_WITH(median({}), "No median for empty vector");
    }

    SECTION("one") {
        REQUIRE(median({-1}) == -1);
        REQUIRE(median({0}) == 0);
        REQUIRE(median({1}) == 1);
        REQUIRE(median({42}) == 42);
    }

    SECTION("two") {
        REQUIRE(median({1, 2}) == 1.5);
        REQUIRE(median({2, 1}) == 1.5);
        REQUIRE(median({2, 3}) == 2.5);
        REQUIRE(median({3, 2}) == 2.5);
    }

    SECTION("three") {
        REQUIRE(median({1, 2, 3}) == 2);
        REQUIRE(median({2, 3, 4}) == 3);
        REQUIRE(median({-1, -2, -3}) == -2);
        REQUIRE(median({3, 1, 2}) == 2);

        std::vector<int> numbers{-2000, 0, 2000};
        std::uniform_int_distribution<int> distribution(1, 1000);

        for(int i = 0; i < 10; ++i) {
            numbers[1] = distribution(rng);
            REQUIRE(median(numbers) == numbers[1]);
        }
    }

    SECTION("more") {
        REQUIRE(median({2, 4, 1, 3}) == 2.5);
        REQUIRE(median({1, 2, 3, 5}) == 2.5);
        REQUIRE(median({1, 3, 4, 2, 6, 5, 8, 7}) == 4.5);
    }

    SECTION("shuffle") {

        const std::vector<std::vector<int>> vectors{
            {1, 2, 3, 5, 8, 13},
            {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
            {0, 0, 0, 0, 0},
            {1, 1, 1, 1, 1, 1},
            {1, 2, 1, 2, 1, 2, 1, 2},
            {1, -1, 2, -2, 3, -3}
        };

        for(const auto& numbers: vectors) {
            const auto expectedMedian = median(numbers);
            auto copy = numbers;
            for(int i = 0; i < 10; ++i) {
                shuffle(copy.begin(), copy.end(), rng);
                REQUIRE(median(copy) == expectedMedian);
            }
        }
    }

}
