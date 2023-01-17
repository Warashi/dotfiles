{
  programs,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = false;
    enableSyntaxHighlighting = false;
    enableVteIntegration = false;
    defaultKeymap = "viins";

    history = {
      extended = true;
      expireDuplicatesFirst = true;
    };

    sessionVariables = {
      DENO_NO_UPDATE_CHECK = "1";
      EDITOR = "nvredit";
      KEYTIMEOUT = "1";
      LANG = "en_US.UTF-8";
      MANPAGER = "nvim +Man!";
      NIXPKGS_ALLOW_UNFREE = "1";
      NVIM = "$XDG_RUNTIME_DIR/nvim.socket";

      # zeno config
      ZENO_HOME = "~/.config/zeno";
      ZENO_ENABLE_FZF_TMUX = "1";
      ZENO_FZF_TMUX_OPTIONS = "-p 80%";
      ZENO_ENABLE_SOCK = "1";
      ZENO_GIT_CAT = "bat --color=always";
      ZENO_GIT_TREE = "exa --tree";
    };

    shellAliases = {
      e = "nvredit";
      ee = "nvr --remote-tab-silent";
      eui = "tmux move-window -t 0 && nvim --server $XDG_RUNTIME_DIR/nvim.socket --remote-ui";
      ls = "exa --icons";
      ":q" = "exit";
    };

    completionInit = ''
      _compinit() {
        autoload -Uz compinit
        setopt extended_glob
        local zcompdumpfile="''${ZDOTDIR:-$HOME}/.zcompdump"
        if [[ ! -e $zcompdumpfile.zwc(#qN.mh-24) ]]; then
          echo "update $zcompdumpfile.zwc" >&2
          compinit
          zcompile $zcompdumpfile
        else
          compinit -C
        fi
      }
      _compinit
    '';

    initExtraFirst =
      ''
        [[ "$SHELL" == "/bin/bash" || "$SHELL" == "/bin/zsh" ]] && SHELL=${pkgs.zsh}/bin/zsh exec ${pkgs.zsh}/bin/zsh --login
        (( ''${+NVIM_LOG_FILE} )) || (( ''${+TMUX} )) || exec direnv exec / tmux new-session -A
        [[ "$TMUX_PANE" == "%0" ]] && tmux new-window && nvim --server $XDG_RUNTIME_DIR/nvim.socket --remote-ui
      ''
      + import ./p10k.nix;

    localVariables = {
      POWERLEVEL9K_TERM_SHELL_INTEGRATION = true;
    };

    initExtra =
      ''
        setopt ignore_eof
        test -f "$HOME/.sdkman/bin/sdkman-init.sh" && . "$HOME/.sdkman/bin/sdkman-init.sh"
      ''
      + import ./sheldon.nix
      + import ./zsh-binds.nix
      + import ./zeno-bind.nix
      + import ./zprof.nix;

    envExtra =
      ''
        # zshの起動profileを取る時はここを有効にする
        # zmodload zsh/zprof && zprof
        test -f $HOME/.cargo/env && . $HOME/.cargo/env
        test -d /opt/homebrew/bin && export PATH=/opt/homebrew/bin:$PATH
        test -S $XDG_RUNTIME_DIR/docker.sock && export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
        test -S $HOME/.ssh/ssh_auth_sock && export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
        test -f "$HOME/.config/ripgrep/config" && export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
      ''
      + import ./zsh-tmux-popup.nix;
  };
}
