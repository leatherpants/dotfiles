#!/bin/sh

MODE="$1"
DARK_THEME="Gruvbox Dark"       # <--- CHANGE THIS to your preferred dark theme name
LIGHT_THEME="Adwaita Light" # <--- CHANGE THIS to your preferred light theme name

if [ "$MODE" = "dark" ]; then
    THEME="$DARK_THEME"
elif [ "$MODE" = "light" ]; then
    THEME="$LIGHT_THEME"
else
    exit 1
fi

# The command to switch the theme in all running Kitty instances
kitten themes --reload-in=all "$THEME"
