#!/usr/bin/env bash

script=true

path=$(pwd)
# Captures everything from the last "/" onward, to get project name.
regex="[^/]+$"
if [[ $path =~ $regex && script ]]; then
	name="${BASH_REMATCH[0]}"
else
	read -p "Enter the project name: " name
fi

# Read in user input and store in variables
if [ ! script ]; then
	read -p "Enter the project description:" desc
	read -p "Enter the CXX version:" cxx
else
	desc="milestone"
	cxx=17
fi

cat > CMakeLists.txt <<EOF
# Tested CMake versions:
cmake_minimum_required(VERSION 3.14...3.27)

# Project name, description, language, etc.
project($name
    DESCRIPTION $desc
    LANGUAGES CXX)

# Use CXX 17+.
set(CMAKE_CXX_STANDARD $cxx)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Version numbers:
set(VERSION_MAJOR 0)
set(VERSION_MINOR 0)
set(VERSION_PATCH 0)

# Executable(s):
add_executable($name)

# Debug build compiler flags.
set(CMAKE_CXX_FLAGS_DEBUG_INIT "-Wall")

# Release build compiler flags.
set(CMAKE_CXX_FLAGS_RELEASE_INIT "")

# Add source files to target(s).
file(GLOB SRC *.cpp)
target_sources($name PRIVATE ${SRC})

# Add include directories to target(s).
# Local include directory.
target_include_directories($name PRIVATE 
	${CMAKE_CURRENT_SOURCE_DIR}/include/
)

# Copy necessary directories into build directory, for executable root access.
add_custom_command(TARGET $name PRE_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_SOURCE_DIR}/*.json $<TARGET_FILE_DIR:$name>)
EOF

if [[ ! -f ".gitignore" ]]; then
	echo "build" > .gitignore
else
	echo "build" >> .gitignore
fi
