{
  pkgs,
  programs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = false;
    syntaxHighlighting.enable = false;
    enableVteIntegration = false;
    defaultKeymap = "emacs";

    history = {
      extended = true;
      expireDuplicatesFirst = true;
    };

    sessionVariables = {
      DENO_NO_UPDATE_CHECK = "1";
      EDITOR = "nvim";
      KEYTIMEOUT = "1";
      LANG = "en_US.UTF-8";
      MANPAGER = "nvim +Man!";
      XDG_CONFIG_HOME = "$HOME/.config";
      LS_COLORS = "$(${pkgs.vivid}/bin/vivid generate catppuccin-latte)";
      MOCWORD_DATA = "${pkgs.mocword-data}/mocword.sqlite";

      # zeno config
      ZENO_HOME = "$HOME/.config/zeno";
      ZENO_ENABLE_FZF_TMUX = "1";
      ZENO_FZF_TMUX_OPTIONS = "-p 80%";
      ZENO_ENABLE_SOCK = "1";
      ZENO_GIT_CAT = "bat --color=always";
      ZENO_GIT_TREE = "eza --tree";
    };

    shellAliases = {
      e = ''''${(@s/ /)EDITOR}'';
      fd = "fd -a";
      ls = "eza --icons";
      tmux = "direnv exec / tmux"; # 自動でtmuxを起動はしないので、起動する時にdirenvの影響を受けないようにこれを定義する。
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
      # _compinit
    '';

    initExtraFirst = ''
      [[ "$SHELL" == "/bin/bash" || "$SHELL" == "/bin/zsh" ]] && SHELL=${pkgs.zsh}/bin/zsh exec ${pkgs.zsh}/bin/zsh --login
    '';

    initExtra =
      ''
        setopt ignore_eof
        test -f "$HOME/.sdkman/bin/sdkman-init.sh" && source "$HOME/.sdkman/bin/sdkman-init.sh"
      ''
      + import ./sheldon.nix
      + import ./binds.nix
      + import ./zeno-bind.nix
      + import ./zoxide.nix {inherit pkgs;}
      + import ./direnv.nix {inherit pkgs;}
      + import ./zprof.nix;

    envExtra =
      ''
        # zshの起動profileを取る時はここを有効にする
        # zmodload zsh/zprof
      ''
      + import ./ensure-zcompiled.nix
      + ''
        test -f $HOME/.cargo/env && source $HOME/.cargo/env
        test -d /opt/homebrew/bin && export PATH=/opt/homebrew/bin:$PATH
        test -S $XDG_RUNTIME_DIR/docker.sock && export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
        test -S $HOME/.ssh/ssh_auth_sock && export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock

        # wezterm の socket を tmux のセッションを越えてもちゃんと使えるようにしたい
        if [ "$XDG_RUNTIME_DIR/wezterm.sock" != "$WEZTERM_UNIX_SOCKET" ] && [ -S "$WEZTERM_UNIX_SOCKET" ]; then
          ln -sf $WEZTERM_UNIX_SOCKET $XDG_RUNTIME_DIR/wezterm.sock && export WEZTERM_UNIX_SOCKET=$XDG_RUNTIME_DIR/wezterm.sock
        fi

        zmodload zsh/zpty # used by Shougo/ddc-source-zsh
      '';
  };
}
