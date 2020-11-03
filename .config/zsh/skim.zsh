function skim-ghq() {
	ghq list --full-path --vcs=git | sk --preview="exa -alh {}" | read RBUFFER
	CURSOR=${#BUFFER}
}
function skim-history() {
	history -n -r 1 | sk --no-sort --query "$LBUFFER" | read BUFFER
	CURSOR=${#BUFFER}
}

zle -N skim-ghq
zle -N skim-history
bindkey '^x' skim-ghq
bindkey '^r' skim-history
