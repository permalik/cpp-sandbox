#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <build_type> <project_name>"
    exit 1
fi

build_type=$1
project_name=$2
build_dir="./build"

if [ -d "$build_dir" ]; then
    echo "tearing down build.."
    rm -rf ./build
    echo "creating build dir.."
    mkdir build
    cd build || return
    echo "generating build assets.."
    # Debug, Release, RelWithDebInfo, MinSizeRel
    cmake -DCMAKE_BUILD_TYPE="${build_type}" ..
    echo "compiling project.."
    cmake --build .
    echo "adding compile commands.."
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES ..
    echo "executing project.."
    ./"${project_name}"
else
    echo "creating build dir.."
    mkdir build
    cd ./build || return
    echo "generating build assets.."
    cmake -DCMAKE_BUILD_TYPE="${build_type}" ..
    echo "compiling project.."
    cmake --build .
    echo "excuting project.."
    ./"${project_name}"
fi
