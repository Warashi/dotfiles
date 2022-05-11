#!/bin/sh
cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1
DOTPATH="$(pwd)"

git ls-files | grep -vF "link.sh" | while read -r file; do
	mkdir -p "$(dirname "$HOME/$file")"
	ln -fvns "$DOTPATH/$file" "$HOME/$file"
done

