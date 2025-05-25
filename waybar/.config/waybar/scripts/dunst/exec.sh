#!/usr/bin/env bash

HISTORY=$(dunstctl count history)
WAITING=$(dunstctl count waiting)
DISPLAYED=$(dunstctl count displayed)
PAUSED=$(dunstctl is-paused)

if [[ $PAUSED = false ]]; then
  if [[ $HISTORY > 0 || $DISPLAYED > 0 ]]; then
    echo "󰂚 $HISTORY"
  else
    echo "󰂜 "
  fi
else
  if [[ $WAITING > 0 ]]; then
    echo "󰂛 $WAITING"
  else
    echo "󰪑 "
  fi
fi
