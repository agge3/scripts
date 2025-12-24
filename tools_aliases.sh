#!/usr/bin/env bash

DIR_TO_ALIAS=(
	# Auto-populate aliases for linux_tools scripts.
	# xxx check if linux
	"$HOME/scripts/linux_tools"

	# xxx check if macos
	#macos_tools

	# Auto-populate aliases for gentoo_tools scripts.
	# xxx check if gentoo
	"$HOME/scripts/gentoo_tools"

	# Auto-populate aliases for x11_tools scripts.
	# xxx check if x11
	"$HOME/scripts/x11_tools"

	# Auto-populate aliases for vm_tools scripts.
	"$HOME/scripts/vm_tools"

	# Auto-populate aliases for python_tools scripts.
	"$HOME/scripts/python_tools"

	# Auto-populate aliases for lua_tools scripts.
	"$HOME/scripts/lua_tools"

	# Auto-populate aliases for perl_tools scripts.
	"$HOME/scripts/perl_tools"

	"$HOME/scripts/git_tools"
	"$HOME/scripts/wm_tools"
)

for dir in "${DIR_TO_ALIAS[@]}"; do
	for script in "$dir"/*.sh; do
		if [[ ! -e "$script" ]]; then
			# skip nullglob
			continue
		fi
		alias_name="$(basename "$script" .sh)"
		# shellcheck disable=SC2139
		# we want the alias as defined here
		alias "$alias_name=$script"
	done
done
