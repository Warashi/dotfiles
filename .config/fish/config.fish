set -x SHELL (which fish)
if ! set -q HOMEBREW_SETUP_DONE
    # homebrew
    ## Intel
    test -x /usr/local/bin/brew && /usr/local/bin/brew shellenv | source
    ## M1
    test -x /opt/homebrew/bin/brew && /opt/homebrew/bin/brew shellenv | source

    set -x HOMEBREW_SETUP_DONE 1
end

if status --is-interactive
    ! set -q TMUX; and type -q tmux; and exec direnv exec / tmux new-session -t 0
    ! set -q REATTACHED; and type -q reattach-to-user-namespace; and exec env REATTACHED=1 reattach-to-user-namespace -l $SHELL
end

set fish_complete_path /usr/local/share/fish/vendor_completions.d $fish_complete_path

fish_add_path -g -m /usr/local/sbin
fish_add_path -g -m /usr/local/opt/texinfo/bin
fish_add_path -g -m $HOME/.cargo/bin
type -q go && fish_add_path -g -m (go env GOPATH)/bin
fish_add_path -g -m $HOME/.local/bin

set -x FZF_CMD sk
set -x FZF_HISTORY_SYNC 1
set -x FZF_DEFAULT_OPTIONS "--reverse --color dark --height 10"
set -x GHQ_OPTIONS "--vcs=git"
set -x PIPENV_VENV_IN_PROJECT 1
set -x DOCKER_BUILDKIT 1
set -x SUDO_PROMPT "[sudo] password for %p:"
set -x ORG_JETBRAINS_PROJECTOR_SERVER_AUTO_KEYMAP false
set -x ORG_JETBRAINS_PROJECTOR_SERVER_PIXEL_PER_UNIT 30

if set -q EDITOR
    set -x EDITOR (echo $EDITOR | string split ' ')
else
    set -x EDITOR nvim
end

abbr -a -g k kubectl
abbr -a -g kx kubectx
abbr -a -g k9s k9s --readonly
abbr -a -g g git
abbr -a -g at atcoder-tools
alias ls exa
alias et 'e -c :terminal'
alias f 'e -c ":Neotree $(pwd)"'
alias e '$EDITOR'

if status --is-login
    type -q pyenv; and source (pyenv init --path | psub)
end
if status --is-interactive
    type -q direnv; and direnv hook fish | source
    type -q pyenv; and pyenv init - | source
    type -q jump; and jump shell fish | source
    type -q starship; and starship init fish | source
end
