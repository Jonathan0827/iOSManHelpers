#!/bin/bash
open -a Terminal
osascript \
    -e "tell application \"Terminal\"" \
    -e "do script \"exit\" in tab 1 of front window" \
    -e "end tell" > /dev/null
