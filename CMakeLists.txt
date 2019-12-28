cmake_minimum_required(VERSION 3.10)
project(median)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(CMAKE_CXX_FLAGS "-Wall -Wextra -Werror -g -O0")
add_executable(ut test-main.cpp tests.cpp median.cpp)

set(CMAKE_CXX_FLAGS "-Wall -Wextra -Werror -g -O2")
add_executable(app median.cpp app.cpp)
