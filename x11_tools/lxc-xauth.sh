#!/usr/bin/env bash

XAUTH=/tmp/lxc-xauth
touch "$XAUTH"
xauth nextract - "$DISPLAY" | sed -e 's/^..../ffff/' | xauth -f "$XAUTH" nmerge -
