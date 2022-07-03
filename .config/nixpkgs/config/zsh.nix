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
          rev = "a3a489781d37522fa1336672441e48fd36bf41bd";
          sha256 = "0h7srf64l78dpy7jqdlvji6yplg8qh6k69p1pvgdg6symfyl853n";
        };
      }
    ];
  };
}
