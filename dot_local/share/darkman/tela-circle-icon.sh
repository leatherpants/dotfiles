#!/bin/env bash

CURRENT_THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
NEW_THEME=$(echo "$CURRENT_THEME" | sed -E 's/-(light|dark)$//')
NEW_THEME="${NEW_THEME}-$1"
gsettings set org.gnome.desktop.interface icon-theme "$NEW_THEME"
