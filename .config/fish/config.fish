if status --is-interactive 
  ! set -q TMUX ;and type -q tmux ;and exec direnv exec / tmux -CC new-session -t 0
  ! set -q REATTACHED ;and type -q reattach-to-user-namespace; and exec env REATTACHED=1 reattach-to-user-namespace -l $SHELL
end

set fish_complete_path /usr/local/share/fish/vendor_completions.d $fish_complete_path

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
set -x PIPENV_VENV_IN_PROJECT 1
set -x DOCKER_BUILDKIT 1
set -x SUDO_PROMPT "[sudo] password for %p:"

set -x EDITOR nvim

alias k kubectl
alias kx kubectx
alias k9s 'command k9s --readonly'
alias s subl
alias m smerge
alias ls exa
alias g git
alias tmux 'direnv exec / tmux'
alias v nvim
alias t telepresence

if status --is-interactive
  type -q direnv ;and source (direnv hook fish | psub)
  type -q pyenv ;and source (pyenv init --path | psub)
  type -q jump; ;and source (jump shell fish | psub)
  fish_vi_key_bindings
  set fish_vi_force_cursor true
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_replace_one underscore
  set fish_cursor_visual block
end
