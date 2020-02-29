set fish_complete_path /usr/local/share/fish/vendor_completions.d $fish_complete_path

set -x EMAIL 6warashi9@gmail.com

set -x GOPATH $HOME/go

set -x PATH /usr/local/sbin $PATH
set -x PATH /usr/local/opt/texinfo/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $GOPATH/bin $PATH
set -x PATH $HOME/.local/bin $PATH

set -x FZF_CMD sk
set -x FZF_HISTORY_SYNC 1
set -x FZF_DEFAULT_OPTIONS "--reverse --color dark --height 10"
set -x GHQ_OPTIONS "--vcs=git"

set -x EDITOR EDITOR.sh

alias k kubectl
alias v vim
alias e emacsclient
alias s subl
alias m smerge
alias ls exa
alias git hub
alias g git
alias p gopass
alias tmux 'direnv exec / tmux'

if status --is-interactive
    eval (direnv hook fish)
end
