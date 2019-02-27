if status is-interactive; and not set -q TMUX
    exec direnv exec / tmux attach
end
set fish_complete_path /usr/local/share/fish/vendor_completions.d $fish_complete_path

set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/go/bin $PATH
set -x PATH $HOME/.ghg/bin $PATH
set -x PATH $HOME/.local/bin $PATH

set -x FZF_TMUX 1
set -x FZF_HISTORY_SYNC 1
set -x FZF_DEFAULT_OPTS --reverse

set -x PIPENV_VENV_IN_PROJECT true

set -x EDITOR nvim

alias v nvim
alias ls exa
alias git hub
alias g git
alias p gopass
alias tmux 'direnv exec / tmux'

if status --is-interactive
    source /usr/local/opt/asdf/asdf.fish
    source (direnv hook fish|psub)
end
