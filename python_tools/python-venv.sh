#!/usr/bin/env bash

dir=$(pwd)
if [ ! -d "$dir/.venv" ]; then
	python -m venv "$dir/.venv"
fi
# xxx have the subshell pass the context to the spawning shell
