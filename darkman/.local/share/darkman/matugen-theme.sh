#!/bin/env bash

# if [ "$1" = "light" ]; then
#   MODE="-l"
# fi
source "$HOME/.cache/matugen/config.env"
matugen -t $MATUGEN_COLOR_SCHEME -m $1 image "$WALLPAPER"
