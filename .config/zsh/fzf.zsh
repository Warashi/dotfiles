function fzf-ghq() {
	ghq list --full-path --vcs=git | sk | read RBUFFER
	CURSOR=${#BUFFER}
}
zle -N fzf-ghq
bindkey '^x' fzf-ghq
