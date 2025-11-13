#!/bin/sh

case "$1" in
dark) THEME=adw-gtk3-dark ;;
light) THEME=adw-gtk3 ;;
default) exit 1 ;;
esac

gsettings set org.gnome.desktop.interface gtk-theme "$THEME"
