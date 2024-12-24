#!/usr/bin/env bash

# Auto-populate aliases for linux_tools scripts.
linux_tools="$HOME/scripts/linux_tools"
for script in "$linux_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for gentoo_tools scripts.
gentoo_tools="$HOME/scripts/linux_tools"
for script in "$linux_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for x11_tools scripts.
x11_tools="$HOME/scripts/linux_tools"
for script in "$linux_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

vm_tools="$HOME/scripts/linux_tools"
for script in "$linux_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for x11_tools scripts.
python_tools="$HOME/scripts/linux_tools"
for script in "$linux_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for x11_tools scripts.
lua_tools="$HOME/scripts/linux_tools"
for script in "$linux_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for x11_tools scripts.
perl_tools="$HOME/scripts/linux_tools"
for script in "$linux_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done
