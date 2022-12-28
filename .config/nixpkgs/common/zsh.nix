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
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      LANG = "en_US.UTF-8";
      DENO_NO_UPDATE_CHECK = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      KEYTIMEOUT = "1";
    };

    shellAliases = {
      e = "nvim";
      ls = "lsd";
    };

    completionInit = ''
      _compinit() {
        autoload -Uz compinit
        setopt extended_glob
        zcompdump="''${ZDOTDIR:-$HOME}/.zcompdump"
        if [[ ! -e $zcompdump.zwc(#qN.mh-24) ]]; then
          echo "update $zcompdump.zwc" >&2
          compinit
          zcompile $zcompdump
        else
          compinit -C
        fi
      }
      _compinit
    '';

    initExtraFirst =
      ''
        [[ "$SHELL" == "/bin/bash" || "$SHELL" == "/bin/zsh" ]] && SHELL=${pkgs.zsh}/bin/zsh exec ${pkgs.zsh}/bin/zsh --login
        (( ''${+TMUX} )) || exec direnv exec / tmux new-session -t 0
      ''
      + import ./p10k.nix
      + import ./zeno.nix;

    localVariables = {
      POWERLEVEL9K_TERM_SHELL_INTEGRATION = true;
    };

    initExtra =
      ''
        setopt ignore_eof
      ''
      + import ./zsh-binds.nix
      + import ./zeno-bind.nix
      + import ./zprof.nix;

    envExtra =
      ''
        # zshの起動profileを取る時はここを有効にする
        # zmodload zsh/zprof && zprof
        test -f $HOME/.cargo/env && . $HOME/.cargo/env
        test -f "$HOME/.sdkman/bin/sdkman-init.sh" && . "$HOME/.sdkman/bin/sdkman-init.sh"
        test -d /opt/homebrew/bin && export PATH=/opt/homebrew/bin:$PATH
        test -S $XDG_RUNTIME_DIR/docker.sock && export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
        test -S $HOME/.ssh/ssh_auth_sock && export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
        test -f "$HOME/.config/ripgrep/config" && export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
      ''
      + import ./zsh-tmux-popup.nix;

    plugins = [
      {
        name = "zeno.zsh";
        file = "zeno.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "yuki-yano";
          repo = "zeno.zsh";
          rev = "9b95adcb8093e19bf22725265ae8248c166bc2e6";
          sha256 = "sha256-8whZ7PuYxk+MMyJcQb0/y41SqawoGl6ONRa95MXu3iI=";
        };
      }
      {
        name = "powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "powerlevel10k";
          rev = "cf67cad46557d57d5d2399e6d893c317126e037c";
          sha256 = "109k9kj4xjjrdzkd44sm5cdm97d6i81ljfbkfxryj098g5yi3995";
        };
      }
      {
        name = "terminal-title";
        src = pkgs.fetchFromGitHub {
          owner = "AnimiVulpis";
          repo = "zsh-terminal-title";
          rev = "6e5d156e155f0e17a9e10074d27a383c19794266";
          sha256 = "1rvfbinh4mr1fm5zizf2m397s43x46zq9cga6a1swzfhqlcmyw09";
        };
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "13dd94ba828328c18de3f216ec4a746a9ad0ef55";
          sha256 = "1l7szi9lc1b0g0c0p1c1pqhbvgz66wp1a1ib6rhsly4vdz8y5ksm";
        };
      }
    ];
  };
}
