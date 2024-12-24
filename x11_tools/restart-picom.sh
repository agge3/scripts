#!/usr/bin/env bash

sudo killall picom
sleep 1
picom --daemon --config ~/.config/picom/picom.conf
