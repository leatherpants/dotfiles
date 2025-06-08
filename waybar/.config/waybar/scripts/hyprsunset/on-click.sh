#!/usr/bin/env bash

state=$(cat ~/.config/waybar/scripts/hyprsunset/state)

if [[ $state = "day" ]];then
  echo night > ~/.config/waybar/scripts/hyprsunset/state
  hyprctl hyprsunset temperature 5500 > /dev/null
else
  echo day > ~/.config/waybar/scripts/hyprsunset/state
  hyprctl hyprsunset identity > /dev/null
fi
