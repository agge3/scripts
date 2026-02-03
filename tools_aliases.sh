#!/usr/bin/env bash

#
# FILE: tools_aliases.sh
# AUTHOR: agge3
# DATE: 2025-06-09
#
# Auto-populates shell aliases for tools scripts, as script basename.
#

# Save previous globbing and restore after safe globbing, to allow sourcing
# without changing parent shell environment.
# bash
if [[ -n "$BASH_VERSION" ]]; then
	prev_extglob=$(setopt -p extglob)
	prev_nullglob=$(setopt -p nullglob)
	setopt -s extglob nullglob
	shell_type="bash"
# zsh
elif [[ -n "$ZSH_VERSION" ]]; then
	prev_extglob=$(( $options[EXTENDED_GLOB] == on ? 1 : 0 ))
	prev_nullglob=$(( $options[NULL_GLOB] == on ? 1 : 0 ))
	setopt EXTENDED_GLOB NULL_GLOB
	shell_type="zsh"
else
	echo "Unsupported shell: only bash or zsh are supported" >&2
	exit 1
fi

# Populate aliases as script basename for each tools script.
populate_aliases() {
	local dir="$1"
	for script in "$dir"/*.sh; do
		[[ -f "$script" ]] || continue
		alias_name=$(basename "$script" .sh)
		alias "$alias_name"="$script"
	done
}

# BSD/macOS
if [[ $(uname -s) != "Linux" ]]; then
	# Auto-populate aliases for macos_tools scripts.
	macos_tools="$HOME/scripts/macos_tools"
	populate_aliases "$macos_tools"
# Linux
else
	# Auto-populate aliases for linux_tools scripts.
	linux_tools="$HOME/scripts/linux_tools"
	populate_aliases "$linux_tools"

	# Gentoo: Auto-populate aliases for gentoo_tools scripts.
	dist=$(cat /etc/os-release | grep -E ^NAME= | cut -d= -f2 | tr -d '"')
	if [[ "$dist" == "Gentoo" ]]; then
		gentoo_tools="$HOME/scripts/gentoo_tools"
		populate_aliases "$gentoo_tools"
	fi
	
	# X11: Auto-populate aliases for x11_tools scripts.
	if [[ -n "$DISPLAY" && -S "/tmp/.X11-unix/X${DISPLAY#:}" ]]; then
		x11_tools="$HOME/scripts/x11_tools"
		populate_aliases "$x11_tools"
	fi
fi

# Auto-populate aliases for vm_tools scripts.
vm_tools="$HOME/scripts/vm_tools"
populate_aliases "$vm_tools"

# Auto-populate aliases for python_tools scripts.
python_tools="$HOME/scripts/python_tools"
populate_aliases "$python_tools"

# Auto-populate aliases for lua_tools scripts.
lua_tools="$HOME/scripts/lua_tools"
populate_aliases "$lua_tools"

# Auto-populate aliases for perl_tools scripts.
perl_tools="$HOME/scripts/perl_tools"
populate_aliases "$perl_tools"

# Done: restore previous globbing.
if [[ "$shell_type" == "bash" ]]; then
	eval "$prev_extglob"
	eval "$prev_nullglob"
elif [[ "$shell_type" == "zsh" ]]; then
	[[ $prev_extglob -eq 0 ]] && unsetopt EXTENDED_GLOB
	[[ $prev_nullglob -eq 0 ]] && unsetopt NULL_GLOB
fi
