#!/usr/bin/env bash

if [ $(swaync-client -D) = "false" ]; then
  play '/home/xuhan/.config/swaync/sounds/kernel.ogg'
fi
