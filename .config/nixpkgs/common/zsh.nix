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
    defaultKeymap = "emacs";

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
      XDG_CONFIG_HOME = "$HOME/.config";
      LS_COLORS = "$(${pkgs.vivid}/bin/vivid generate catppuccin-mocha)";

      # zeno config
      ZENO_HOME = "$HOME/.config/zeno";
      ZENO_ENABLE_FZF_TMUX = "1";
      ZENO_FZF_TMUX_OPTIONS = "-p 80%";
      ZENO_ENABLE_SOCK = "1";
      ZENO_GIT_CAT = "bat --color=always";
      ZENO_GIT_TREE = "exa --tree";
    };

    shellAliases = {
      ":q" = "exit";
      e = "nvredit";
      ee = "nvr --remote-tab-silent";
      eui = "tmux move-window -t 0 && nvim --server $XDG_RUNTIME_DIR/nvim.socket --remote-ui";
      fd = "fd -a";
      ls = "exa --icons";
      workbench = "wezterm cli spawn -- ssh workbench";
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
      + (builtins.readFile (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
          sha256 = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
        }
        + /themes/catppuccin_mocha-zsh-syntax-highlighting.zsh))
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

        # wezterm の socket を tmux のセッションを越えてもちゃんと使えるようにしたい
        if [ "$XDG_RUNTIME_DIR/wezterm.sock" != "$WEZTERM_UNIX_SOCKET" ] && [ -S "$WEZTERM_UNIX_SOCKET" ]; then
          ln -sf $WEZTERM_UNIX_SOCKET $XDG_RUNTIME_DIR/wezterm.sock && export WEZTERM_UNIX_SOCKET=$XDG_RUNTIME_DIR/wezterm.sock
        fi

        zmodload zsh/zpty # used by Shougo/ddc-source-zsh
      ''
      + import ./zsh-tmux-popup.nix;
  };
}
