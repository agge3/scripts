#!/usr/bin/env bash

resolution="1280x720"

#set -o xtrace
set -o errexit -o nounset -o pipefail -o errtrace
IFS=$'\n\t'

eval $(luarocks path --bin)

disp_num=1
disp=:$disp_num
Xephyr -screen $resolution $disp -ac -br -sw-cursor &
pid=$!
while [ ! -e /tmp/.X11-unix/X${disp_num} ] ; do
    sleep 0.1
done

export DISPLAY=$disp
awesome -c ~/.config/awesome/rc.lua &
instance=$! &
awesome-client

# xxx automatic reload broken https://wiki.archlinux.org/title/Awesome
while inotifywait -r -e close_write ~/.config/awesome; do
	kill -s SIGHUP $instance

kill $pid
exit 0
