#!/bin/env bash

# if [ "$1" = "light" ]; then
#   MODE="-l"
# fi

WALL="$HOME/.cache/matugen/wal"
matugen -t scheme-vibrant -m $1 image "$WALL"
