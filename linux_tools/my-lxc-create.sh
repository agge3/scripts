#!/usr/bin/env bash

distro="ubuntu"
release="oracular"

lxc-create -t download -n ubuntu-guest -- -d "$distro" -r "$release" -a amd64
