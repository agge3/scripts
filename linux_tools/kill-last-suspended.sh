#!/usr/bin/env bash

######## Luna's Kill Last Suspended Command ##################################

# check that last suspended command actually exists
last_suspended_pid=$(jobs -l | awk '/suspended/ {print $3}' | tail -n 1)

if [ -z "$last_suspended_pid" ]; then
    echo "No suspended job found."
    exit 1
fi

# kill the last suspended command
kill -9 "$last_suspended_pid"
ret=$?

if [ "$ret" -ne 0 ]; then
	echo "Command failed with code $ret"
fi
