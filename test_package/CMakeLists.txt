cmake_minimum_required(VERSION 3.1.2)
project(PackageTest
  LANGUAGES CXX
  VERSION 1.0.1
  )

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(package_test package_test.cpp)
