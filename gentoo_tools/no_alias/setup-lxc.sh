#!/usr/bin/env bash

# Always have man page documentation.
if [ -f "/etc/portage/package.use/package.use" ]; then
	echo "app-containers/lxc man" >> /etc/portage/package.use/package.use
elif [ -f "/etc/portage/package.use/package.use" ]; then
	echo "app-containers/lxc man" >> /etc/portage/package.use
else
	echo "app-containers/lxc man" >> /etc/portage/package.use/lxc
fi

emerge app-containers/lxc

useradd -m -G lxc "lxc-$1"

mkdir --parents ~/.config/lxc
# xxx cat /etc/subuid and append to ~/.config/lxc/default.conf

# xxx lxc-create -t download -n ubuntu-guest -- -d ubuntu -r oracular -a amd64

mkdir -p /sys/fs/cgroup/systemd
mount -t cgroup -o none,name=systemd systemd /sys/fs/cgroup/systemd
chmod 777 /sys/fs/cgroup/systemd
