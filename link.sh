#!/bin/sh
DOTPATH="$(cd "$(dirname "${BASH_SOURCE:-$0}")"; pwd)"
find "$DOTPATH" -type f -and -not -path "$DOTPATH/.git/*" -and -not -path "$DOTPATH/link.sh" | while read -r f; do
	mkdir -p "$(dirname "$HOME/${f#"$DOTPATH/"}")"
	ln -fvns "$f" "$HOME/${f#"$DOTPATH/"}"
done

