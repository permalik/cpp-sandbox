# CMakeLists.txt

cmake_minimum_required(VERSION 3.10)
project(cpp_curricula CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(SOURCES
    src/cpp_curricula.cpp
)

# set(HEADERS
#     ./header.h
# )

add_executable(cpp_curricula ${SOURCES})

add_library(cpp_curricula_lib SHARED ${SOURCES})

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(COMMON_COMPILE_OPTIONS -g -Wall -Wextra -Werror -O0)
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(COMMON_COMPILE_OPTIONS -O3)
endif()

target_compile_options(cpp_curricula PRIVATE ${COMMON_COMPILE_OPTIONS})
target_compile_options(cpp_curricula_lib PRIVATE ${COMMON_COMPILE_OPTIONS})

set_target_properties(cpp_curricula PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
)

set_target_properties(cpp_curricula_lib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

#set_target_properties(cpp_curricula PROPERTIES VERSION )

# target_include_directories(cpp_curricula PRIVATE src)
