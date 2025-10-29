#!/usr/bin/env bash
if [ $(iwgetid -r) == AC-130-5G ]; then
  nmcli device wifi connect 10-08
else 
  nmcli device wifi connect AC-130-5G
fi
