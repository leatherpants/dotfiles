#!/usr/bin/env bash

UPDATES=$(checkupdates | wc -l)
MESSAGE=$(checkupdates --nocolor)

if [ $UPDATES -gt 0 ]; then
    notify-send -u critical "$UPDATES Updates available!" "$MESSAGE"
fi
