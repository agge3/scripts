#!/usr/bin/env bash

if [ "$#" -eq 0 ]; then
	echo "No application to swallow! Call with application as argument."
fi

./"$1" & disown
