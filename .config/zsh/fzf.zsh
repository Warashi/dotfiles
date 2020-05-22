function fzf-ghq() {
	ghq list --full-path --vcs=git | sk --preview="exa -alh {}" | read RBUFFER
	CURSOR=${#BUFFER}
}
zle -N fzf-ghq
bindkey '^x' fzf-ghq
