#!/usr/bin/env bash

state=$(cat ~/.config/waybar/scripts/hyprsunset/state)

if [[ $state = "day" ]];then
  echo "󰖨 "
else
  echo "󱩌 "
fi

