{ programs, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = false;
    enableVteIntegration = false;
    defaultKeymap = "emacs";

    history = {
      extended = true;
      expireDuplicatesFirst = true;
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      EDITOR = "nvim";
    };

    shellAliases = {
      e = "nvim";
      neovide = "/Applications/Neovide.app/Contents/MacOS/neovide";
      ls = "exa";
      f = ''e -c ":VFiler $(pwd)"'';
      tnc = "exec direnv exec / tmux -CC new-session -t 0";
    };

    initExtraFirst = ''
      [[ "$SHELL" == "/bin/bash" || "$SHELL" == "/bin/zsh" ]] && SHELL=${pkgs.zsh}/bin/zsh exec ${pkgs.zsh}/bin/zsh --login
    '' + import ./p10k.nix + import ./zeno.nix;

    initExtra = import ./zeno-bind.nix;

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
    ];
  };
}
