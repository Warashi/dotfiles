
### Added by Zinit's installer
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/zsh/.zinit" && command chmod g-rwX "$HOME/.config/zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.config/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice depth=1

zinit light-mode for \
	zsh-users/zsh-autosuggestions \
    zdharma/fast-syntax-highlighting \
    romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

[[ -f ~/.config/zsh/fzf.zsh ]] && source ~/.config/zsh/fzf.zsh

eval "$(direnv hook zsh)"

export EDITOR=EDITOR.sh
export PIPENV_VENV_IN_PROJECT=1
export GOPATH=$HOME/go
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

alias k=kubectl
alias s=subl
alias m=smerge
alias ls=exa
alias g=hub
alias git=hub

autoload -Uz compinit; compinit; zinit cdreplay -q 
