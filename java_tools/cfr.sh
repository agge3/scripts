#!/usr/bin/env bash

CFR_ROOT="$HOME/repos/cfr"
java -cp "$CFR_ROOT/target/classes" org.benf.cfr.reader.Main "$@"
