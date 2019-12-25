if status is-interactive; and not set -q TMUX
    exec direnv exec / tmux attach
end
if status is-interactive; and not set -q REATTACHED
    exec env REATTACHED=1 reattach-to-user-namespace -l $SHELL
end
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

set -x PIPENV_VENV_IN_PROJECT true

set -x EDITOR emacsclient

set -x GO111MODULE on

alias k kubectl
alias v vim
alias e emacsclient
alias ls exa
alias git hub
alias g git
alias p gopass
alias tmux 'direnv exec / tmux'

source /usr/local/opt/asdf/asdf.fish
source ~/.asdf/plugins/java/set-java-home.fish
if status --is-interactive
    eval (direnv hook fish)
    eval (starship init fish)
end
