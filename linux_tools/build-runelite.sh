#!/usr/bin/env bash

# error handling
#if [ $(pwd) != "/home/bee/RuneLite/runelite" ]; then
#    echo "Error: Must be in runelite source directory"
#else

echo "Building RuneLite..."
cd ~/RuneLite/runelite
mvn clean install -Dskip_tests=true
#echo "In RuneLite home!"

#cd ~/RuneLite
#echo $(pwd)
