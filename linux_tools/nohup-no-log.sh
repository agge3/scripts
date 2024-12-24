#!/usr/bin/env bash

if [ "$#" -eq 0 ]; then
	echo "No application specified! Call with application as argument."

nohup "$!" &> /dev/null
