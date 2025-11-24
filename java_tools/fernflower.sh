#!/usr/bin/env bash

FERNFLOWER_ROOT="$HOME/repos/fernflower"
java -jar "$FERNFLOWER_ROOT/build/libs/fernflower.jar" -hes=0 -hdc=0 "$@"
