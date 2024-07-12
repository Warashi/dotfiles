{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;
    enableVteIntegration = false;
    defaultKeymap = "emacs";

    history = {
      extended = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
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
      # [[ "$SHELL" == "/bin/bash" || "$SHELL" == "/bin/zsh" ]] && SHELL=${pkgs.zsh}/bin/zsh exec ${pkgs.zsh}/bin/zsh --login
    '';

    initExtra =
      ''
        setopt ignore_eof
      ''
      + import ./sheldon.nix
      + import ./binds.nix
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
        test -S $XDG_RUNTIME_DIR/docker.sock && export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
        test -S $HOME/.ssh/ssh_auth_sock && export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock

        # wezterm の socket を tmux のセッションを越えてもちゃんと使えるようにしたい
        if [ "$XDG_RUNTIME_DIR/wezterm.sock" != "$WEZTERM_UNIX_SOCKET" ] && [ -S "$WEZTERM_UNIX_SOCKET" ]; then
          ln -sf $WEZTERM_UNIX_SOCKET $XDG_RUNTIME_DIR/wezterm.sock && export WEZTERM_UNIX_SOCKET=$XDG_RUNTIME_DIR/wezterm.sock
        fi
      '';
  };
}
