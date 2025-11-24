#!/usr/bin/env bash

# XXX DOESNT WORK: USE OPENRC TO SUPERVISE

wm="Hyprland"

# Must be ran with superuser privileges.
if [[ $EUID -ne 0 ]]; then
        echo "$(basename "$0"): Must be ran with superuser privileges"
        exit 1
fi

openvt -c 2 --bash

nohup bash -c "
	kill -9 $(pgrep "$wm")
	sleep 5
	dbus-run-session "$wm"
" > /dev/null 2>&1 & disown
