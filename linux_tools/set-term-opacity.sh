#!/usr/bin/env bash

opacity=$1
kitty_config="$HOME/.config/kitty/kitty.conf"

# CREDIT: https://stackoverflow.com/a/13790836, float regex.
float_re="^[-+]?[0-9]+\.?[0-9]*$"

reload_kitty() {
	# SIGUSR1 reloads kitty.
	kill -SIGUSR1 "$(pidof kitty)"
}

if [ "$TERM" != "xterm-kitty" ]; then
	echo "Only supports kitty terminal."
	exit 1
fi

if [ $# -ne 1 ] || ! [[ $opacity =~ $float_re ]]; then
	echo "Invalid opacity, must be a float."
	exit 1
fi

if [ ! -f "$kitty_config" ]; then
	echo "kitty.conf not in expected location, expected: $kitty_config"
	exit 1
fi

# Replace current background opacity with specified opacity and reload kitty.
sed -i "s/^background_opacity .*/background_opacity $opacity/" "$kitty_config"
reload_kitty
