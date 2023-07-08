#!/bin/bash
open -a Terminal
osascript \
  -e "tell application \"Terminal\"" \
  -e "do script \"/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\" && exit\" in tab 1 of front window" \
  -e "end tell"
#osascript \
#    -e "quit app \"Terminal\""
