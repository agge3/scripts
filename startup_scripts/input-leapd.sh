#!/usr/bin/env bash

set -x	# debug

/home/agge/pkg/input-leap/build/bin/input-leaps --daemon --no-tray \
	--address 24800 \
	--name gentoo --config ~/.config/input-leap.conf \
	--restart
