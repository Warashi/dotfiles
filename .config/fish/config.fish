if ! set -q HOMEBREW_SETUP_DONE
  # homebrew
  ## Intel
  test -x /usr/local/bin/brew && /usr/local/bin/brew shellenv | source
  ## M1
  test -x /opt/homebrew/bin/brew && /opt/homebrew/bin/brew shellenv | source

  set -x HOMEBREW_SETUP_DONE 1
end

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
set -x ORG_JETBRAINS_PROJECTOR_SERVER_AUTO_KEYMAP false
set -x ORG_JETBRAINS_PROJECTOR_SERVER_PIXEL_PER_UNIT 30

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

if status --is-login
  type -q pyenv ;and source (pyenv init --path | psub)
end
if status --is-interactive
  type -q direnv ;and direnv hook fish | source
  type -q pyenv ;and pyenv init - | source
  type -q jump; ;and jump shell fish | source
  type -q starship ;and starship init fish | source
  fish_vi_key_bindings
  set fish_vi_force_cursor true
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_replace_one underscore
  set fish_cursor_visual block
end
