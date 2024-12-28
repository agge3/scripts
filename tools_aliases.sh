#!/usr/bin/env bash

# Auto-populate aliases for linux_tools scripts.
linux_tools="$HOME/scripts/linux_tools"
for script in "$linux_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for gentoo_tools scripts.
gentoo_tools="$HOME/scripts/gentoo_tools"
for script in "$gentoo_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for x11_tools scripts.
x11_tools="$HOME/scripts/x11_tools"
for script in "$x11_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for vm_tools scripts.
vm_tools="$HOME/scripts/vm_tools"
for script in "$vm_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for python_tools scripts.
python_tools="$HOME/scripts/python_tools"
for script in "$python_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for lua_tools scripts.
lua_tools="$HOME/scripts/lua_tools"
for script in "$lua_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done

# Auto-populate aliases for perl_tools scripts.
perl_tools="$HOME/scripts/perl_tools"
for script in "$perl_tools"/*.sh; do
	alias_name=$(basename "$script" .sh)
	alias "$alias_name"="$script"
done
