#!/usr/bin/env bash

eix-sync # runs a bunch of sync commands, see gentoo cheatsheet
emerge --oneshot sys-apps/portage # FIRST: make sure portage is up-to-date
eclean-kernel --all # clean all BUT active kernel
emerge --verbose --update --deep --newuse --keep-going @world
emerge --depclean # NOTE: doesn't ASK, be careful!

# run all rebuilds after depclean
emerge @module-rebuild
emerge @rust-rebuild
emerge @golang-rebuld
emerge @x11-module-rebuild
emerge @preserved-rebuild

# other updates
nvim --headless "+Lazy! sync" +qa # update nvim headless
perl-cleaner --all # clean perl modules
#haskell-update # TODO: not working
