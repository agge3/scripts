#!/usr/bin/env bash

sudo wg-quick down "$WG"
sudo ifconfig en0 down
sleep 1
sudo ifconfig en0 up
sleep 1
sudo wg-quick up "$WG"
