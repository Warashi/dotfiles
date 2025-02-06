#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search with multiple search engines and AIs
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/agenda.png
# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true}
# @raycast.packageName 

# Documentation:
# @raycast.description Search with multiple engines and AIs
# @raycast.author Warashi
# @raycast.authorURL https://warashi.dev

open "https://perplexity.ai/search/new?q=$1"
open "https://felo.ai/ja/search?q=$1"
open "https://www.genspark.ai/search?query=$1"

echo "opening search pages completed"
