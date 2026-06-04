#!/usr/bin/env bash

usage() {
	echo "Usage: $(basename "$0") <proc_name>" 2>&1
}

if [[ $# -ne 1 || -z "$1" ]]; then
	usage
	exit 1
fi

ps aux | grep "$1" | grep -v grep | grep -v "$(basename "$0")"
