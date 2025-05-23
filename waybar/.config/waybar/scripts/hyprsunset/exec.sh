#!/usr/bin/env bash

state=$(cat ~/.config/waybar/scripts/hyprsunset/state)

if [[ $state = "day" ]];then
  hyprctl hyprsunset temperature 6000 > /dev/null
  echo night > ~/.config/waybar/scripts/hyprsunset/state
  echo "󰖔 "
else
  hyprctl hyprsunset identity > /dev/null
  echo day > ~/.config/waybar/scripts/hyprsunset/state
  echo " "
fi

