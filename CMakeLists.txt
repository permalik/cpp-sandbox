# CMakeLists.txt

cmake_minimum_required(VERSION 3.10)
project(c_sandbox CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(SOURCES
    ./src/main.cpp
)

# set(HEADERS
#     ./header.h
# )

add_executable(c_sandbox ${SOURCES})

add_library(c_sandbox_lib SHARED ${SOURCES})

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(COMMON_COMPILE_OPTIONS -g -Wall -Wextra -Werror -O0)
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(COMMON_COMPILE_OPTIONS -O3)
endif()

target_compile_options(c_sandbox PRIVATE ${COMMON_COMPILE_OPTIONS})
target_compile_options(c_sandbox_lib PRIVATE ${COMMON_COMPILE_OPTIONS})

set_target_properties(c_sandbox PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
)

set_target_properties(c_sandbox_lib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

#set_target_properties(c_sandbox PROPERTIES VERSION )

# target_include_directories(c_sandbox PRIVATE src)
