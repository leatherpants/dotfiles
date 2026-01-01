#!/bin/env bash

if [ "$1" = "light" ]; then
  MODE="-l"
fi

wal -i "$(cat /home/xuhan/.cache/wal/wal)" $MODE 
swaync-client -rs
