#!/usr/bin/env bash

if [ "$#" -eq 0 ]; then
	echo "No application to swallow! Call with application as argument."
fi

nohup "./$1" &> /dev/null & disown
exit
