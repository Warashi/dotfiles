{ programs, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = false;
    enableVteIntegration = false;

    history = {
      extended = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      ls = "exa";
      f = ''e -c ":VFiler $(pwd)"'';
      mm = "wezterm cli spawn --new-window -- mosh workbench --server=~/.nix-profile/bin/mosh-server";
    };

    initExtraFirst = ''
      [[ "$SHELL" == "/bin/bash" || "$SHELL" == "/bin/zsh" ]] && SHELL=${pkgs.zsh}/bin/zsh exec ${pkgs.zsh}/bin/zsh --login
      [[ ! -v TMUX ]] && whence tmux > /dev/null && exec direnv exec / tmux new-session -t 0
    '' + import ./zeno.nix;

    initExtra = ''
      if [[ -v NVIM_LISTEN_ADDRESS ]]; then
        export EDITOR="nvr -cc ToggleTermClose --remote-wait-silent"
        alias e="nvr -cc ToggleTermClose"
      else
        export EDITOR="nvim"
        alias e="nvim"
      fi
    '' + import ./zeno-bind.nix;

    plugins = [
      {
        name = "zeno.zsh";
        file = "zeno.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "yuki-yano";
          repo = "zeno.zsh";
          rev = "045d0b8eebad9202666a7da0d0a8093f4fbca418";
          sha256 = "0zx930psrbmbjxcrl4mbfcrvxqj9bdsybxmg02k013lm6r1i3rk8";
        };
      }
    ];
  };
}
