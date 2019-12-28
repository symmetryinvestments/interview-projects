#include "median.hpp"
#include <stdexcept>
#include <algorithm>


double median(const std::vector<int>& numbers) {
    if(numbers.size() == 0)
        throw std::invalid_argument("No median for empty vector");

    auto mutableNumbers = numbers;
    std::sort(mutableNumbers.begin(), mutableNumbers.end());

    const bool isOdd = numbers.size() % 2;

    return isOdd
        ? mutableNumbers[numbers.size() / 2]
        : (mutableNumbers[numbers.size() / 2 - 1] + mutableNumbers[numbers.size() / 2]) / 2.0;
}
