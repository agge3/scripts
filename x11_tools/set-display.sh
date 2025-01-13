#!/usr/bin/env bash

# Set resolutions correctly.
xrandr --output DisplayPort-2 --mode 2560x1440
xrandr --output DisplayPort-0 --mode 1920x1080
xrandr --output HDMI-A-0 --mode 1920x1080

# Set primary display.
xrandr --output DisplayPort-2 --primary

# Arrange monitors correctly.
xrandr --output DisplayPort-0 --left-of DisplayPort-2
xrandr --output HDMI-A-0 --right-of DisplayPort-2
