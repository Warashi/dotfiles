#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Alacritty New Window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

alacritty="$HOME/Applications/Home Manager Apps/Alacritty.app/Contents/MacOS/alacritty"
"$alacritty" msg create-window &> /dev/null || open -a Alacritty.app
