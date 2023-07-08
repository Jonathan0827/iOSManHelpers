#!/bin/bash
open -a Terminal
osascript \
  -e "tell application \"Terminal\"" \
  -e "do script \"sleep 1 && gh auth login -p https -w && exit\" in tab 1 of front window" \
  -e "end tell"
#osascript \
#    -e "quit app \"Terminal\""
