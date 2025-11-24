#!/usr/bin/env bash

#sudo btrfs balance start -dusage=50 / & while :; do sudo btrfs balance status -v / ; sleep 60; done
sudo btrfs balance start -dusage=85 / & while :; do sudo btrfs balance status -v / ; sleep 60; done
