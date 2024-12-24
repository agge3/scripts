#!/usr/bin/env bash

kill %$(jobs -s | tail -n 1 | awk '{print $1}' | tr -d '[]')
