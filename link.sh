#!/bin/sh
cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1
DOTPATH="$PWD"

find -L "$DOTPATH" \
  -type f \
  -and -not -path "$DOTPATH/.git/*" \
  -and -not -path "$DOTPATH/link.sh" \
  -and -not -path "$DOTPATH/.nlsp-settings/*" \
  | while read -r f; do
  mkdir -p "$(dirname "$HOME/${f#"$DOTPATH/"}")"
  ln -fvns "$f" "$HOME/${f#"$DOTPATH/"}"
done
