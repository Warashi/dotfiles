#!/bin/bash
set -euo pipefail
window=$1
id=$(chunkc tiling::query --window id)
chunkc tiling::window --send-to-monitor $window
chunkc tiling::window --focus $id
