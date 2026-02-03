#!/usr/bin/env bash

opacity=$1
kitty_config="$HOME/.config/kitty/kitty.conf"
ghostty_config="$HOME/.config/ghostty/config"

# CREDIT: https://stackoverflow.com/a/13790836, float regex.
float_re="^[-+]?[0-9]+\.?[0-9]*$"

reload_kitty() {
	pid=$(ps aux | grep '[k]itty' | awk '{print $2}')
	# SIGUSR1 reloads kitty.
	kill -SIGUSR1 "$pid"
}

reload_ghostty() {
	pid=$(ps aux | grep '[g]hostty' | awk '{print $2}')
	# SIGUSR2 reloads ghostty.
	# SEE: https://github.com/ghostty-org/ghostty/pull/7759
	kill -SIGUSR2 "$pid"
}

if [[ "$TERM" != "xterm-kitty" && "$TERM" != "xterm-ghostty" ]]; then
	echo "Only supports ghostty or kitty terminal."
	exit 1
fi

# NOTE: Don't quote regex variable, because XXX...
if [[ $# -ne 1 || ! "$opacity" =~ $float_re ]]; then
	echo "Invalid opacity, must be a float."
	exit 1
fi

# Supports Linux or BSD/macOS: choose sed implementation per OS.
if [[ $(uname -s) != "Linux" ]]; then
	# BSD sed
	mysed="sed -i ''"
else
	# GNU sed
	mysed="sed -i"
fi

if [[ "$TERM" == "xterm-kitty" ]]; then
	if [[ ! -f "$kitty_config" ]]; then
		echo "kitty.conf not in expected location, expected: $kitty_config"
		exit 1
	fi

	# Replace current background opacity with specified opacity and reload
	# kitty.
	# NOTE: No quotes, to allow bash to word split: to not execute as one
	# string/command.
	$mysed "s/^background_opacity .*/background_opacity $opacity/" \
		"$kitty_config"
	reload_kitty
elif [[ "$TERM" == "xterm-ghostty" ]]; then
	if [[ ! -f "$ghostty_config" ]]; then
		echo "ghostty config not in expected location, expected: "	\
			"$ghostty_config"
		exit 1
	fi

	# Replace current background opacity with specified opacity and reload
	# ghostty (two syntax variants).
	$mysed \
		"s/^background-opacity[[:space:]]*=[[:space:]]*.*/background-opacity=$opacity/" \
		"$ghostty_config"
	reload_ghostty
fi
