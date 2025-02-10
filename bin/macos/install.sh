#!/usr/bin/env bash

# Installs all scripts located in this directory to `/opt/bin`. Make sure 
# `/opt/bin` is in `$PATH`.

# `ln` will fail to overwrite existing symlinks, which is what we want. We don't
# want to continuously recreate already existing symlinks.
find . -maxdepth 1 -type f ! -name 'install.sh' -exec ln -s "$PWD/{}" /opt/bin/ \;
