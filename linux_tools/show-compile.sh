#!/usr/bin/env bash

#watch gcc -S "$@" -o -

# Name of the screen session
SESSION_NAME="watch_gcc"

# Start a detached screen session running watch
screen -dmS "$SESSION_NAME" bash -c "watch -n 60 gcc -S \"$@\" -o -"
echo "Screen session '$SESSION_NAME' started. Attach with:"
echo "  screen -r $SESSION_NAME"
