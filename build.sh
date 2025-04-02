#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

project_name=$1

cmake_content=$(cat <<EOL
# CMakeLists.txt

cmake_minimum_required(VERSION 3.10)
project(${project_name} CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(SOURCES
    src/${project_name}.cpp
)

# set(HEADERS
#     ./header.h
# )

add_executable(${project_name} \${SOURCES})

add_library(${project_name}_lib SHARED \${SOURCES})

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(COMMON_COMPILE_OPTIONS -g -Wall -Wextra -Werror -O0)
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(COMMON_COMPILE_OPTIONS -O3)
endif()

target_compile_options(${project_name} PRIVATE \${COMMON_COMPILE_OPTIONS})
target_compile_options(${project_name}_lib PRIVATE \${COMMON_COMPILE_OPTIONS})

set_target_properties(${project_name} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY \${CMAKE_BINARY_DIR}
)

set_target_properties(${project_name}_lib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY \${CMAKE_BINARY_DIR}/lib
    RUNTIME_OUTPUT_DIRECTORY \${CMAKE_BINARY_DIR}/bin
)

#set_target_properties(${project_name} PROPERTIES VERSION ${PROJECT_VERSION})

# target_include_directories(${project_name} PRIVATE src)
EOL
)

mkdir -p src

echo "$cmake_content" > ./CMakeLists.txt

echo "int main() { return 0; }" > src/"${project_name}".cpp

echo "boilerplate CMakeLists.txt and source file created"
