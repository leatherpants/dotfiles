#!/usr/bin/env bash

sleep 3

state=$(cat ~/.config/waybar/scripts/hyprsunset/state)

if [[ $state = "day" ]];then
  hyprctl hyprsunset identity > /dev/null
else
  hyprctl hyprsunset temperature 6000 > /dev/null
fi
