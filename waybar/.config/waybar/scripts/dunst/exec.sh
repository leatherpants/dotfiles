#!/usr/bin/env bash

# COUNT=$(dunstctl count waiting)
PAUSED=$(dunstctl is-paused)

if [[ $PAUSED = false ]]; then
  echo " "
else
  echo " "
fi
