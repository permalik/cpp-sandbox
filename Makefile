cmake_minimum_required(VERSION 3.10)

project(
  out
  VERSION 1.0
  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(out main.cpp)

set(CMAKE_CXX_COMPILER "clang++")
