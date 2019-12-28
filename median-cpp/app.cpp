#include "median.hpp"
#include <vector>
#include <random>
#include <chrono>
#include <iostream>
#include <algorithm>


static void run();


int main() {
    try {
        run();
        return 0;
    } catch(...) {
        return 1;
    }
}


void run() {

    auto rng = std::default_random_engine{1337};

    std::vector<std::vector<int>> vectors{
        {0},
        {1},
        {2, 3, 1},
        {1, 2, 3, 5, 8, 13, 21, 34},
    };

    std::vector<int> fortyTwos;
    constexpr auto numFortyTwos = 1000;
    fortyTwos.reserve(numFortyTwos);
    for(int i = 0; i < numFortyTwos; ++i) fortyTwos.emplace_back(42);
    vectors.push_back(fortyTwos);

    constexpr auto numRandomVectors = 100'000;
    vectors.reserve(numRandomVectors + vectors.size());

    std::uniform_int_distribution<int> randomLength(1, 1000);
    for(int i = 0; i < numRandomVectors; ++i) {
        std::vector<int> numbers;
        const auto len = randomLength(rng);
        numbers.reserve(len);
        for(int j = 0; j < len; ++j)
            numbers.emplace_back(randomLength(rng));
        vectors.emplace_back(numbers);
    }

    std::vector<double> results(vectors.size());

    using clock = std::chrono::high_resolution_clock;
    constexpr auto numIterations = 10;
    std::vector<int> times(numIterations);

    for(int i = 0; i < numIterations; ++i) {
        const auto start = clock::now();

        int j{};
        for(const auto& numbers: vectors) {
            results[j++] = median(numbers);
        }

        const auto end = clock::now();
        const auto diff = end - start;
        const auto ms = std::chrono::duration_cast<std::chrono::milliseconds>(diff);
        times[i] = ms.count();
    }

    const auto min = std::min_element(times.cbegin(), times.cend());

    std::cout << "Milliseconds: " << *min << std::endl;;
}
