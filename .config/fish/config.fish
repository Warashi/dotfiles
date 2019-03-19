if status is-interactive; and not set -q TMUX
    exec direnv exec / tmux attach
end
set fish_complete_path /usr/local/share/fish/vendor_completions.d $fish_complete_path

set -x EMAIL 6warashi9@gmail.com

set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/go/bin $PATH
set -x PATH $HOME/.local/bin $PATH

set -x FZF_TMUX 1
set -x FZF_HISTORY_SYNC 1
set -x FZF_DEFAULT_OPTS "--reverse --color dark"

set -x PIPENV_VENV_IN_PROJECT true

set -x EDITOR emacsclient

set -x GO111MODULE on

alias v nvim
alias e 'emacsclient -nw -c'
alias ls exa
alias git hub
alias g git
alias p gopass
alias tmux 'direnv exec / tmux'

source /usr/local/opt/asdf/asdf.fish
if status --is-interactive
    source (direnv hook fish|psub)
end
