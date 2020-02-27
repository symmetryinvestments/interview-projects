cmake_minimum_required(VERSION 3.10)
project(nearestPoints)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(CMAKE_CXX_FLAGS "--std=c++17 -Wall -Wextra -Werror -g -O0")
add_executable(ut test-main.cpp tests.cpp point.cpp)

set(CMAKE_CXX_FLAGS "--std=c++17 -Wall -Wextra -Werror -g -O2")
add_executable(app point.cpp app.cpp)
