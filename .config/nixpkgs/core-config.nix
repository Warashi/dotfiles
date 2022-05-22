{ programs, pkgs, ... }: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    initExtra = "exec zsh --login";
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    history = {
      extended = true;
      expireDuplicatesFirst = true;
    };

    sessionVariables = {
      EDITOR = "nvr -cc ToggleTermClose --remote-wait-silent";
    };

    shellAliases = {
      e = "nvr -s -cc ToggleTermClose";
      g = "git";
      ls = "exa";
      ll = "ls -l";
      la = "ll -a";
      f = ''e -c ":Neotree $(pwd)"'';
    };

    initExtraFirst = ''
      [[ "$SHELL" == "/bin/bash" ]] && export SHELL=${pkgs.zsh}/bin/zsh
      [[ ! -v ZELLIJ ]] && whence zellij > /dev/null && exec direnv exec / zellij attach --create
      [[ ! -v REATTACHED ]] && whence reattach-to-user-namespace > /dev/null && exec env REATTACHED=1 reattach-to-user-namespace -l $SHELL
    '';

    plugins = with pkgs; [
      {
        name = "zsh-fzf-ghq";
        file = "zsh-fzf-ghq.plugin.zsh";
        src = fetchFromGitHub {
          owner = "subaru-shoji";
          repo = "zsh-fzf-ghq";
          rev = "850ad834b1b140886ded159947b4b8d5588757e6";
          sha256 = "SsRWsA0JuRC4e9ojwt1MQEdFU1tad0Sr2K4ajHjXDTY=";
        };
      }
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      time.disabled = false;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd j" ];
  };

  programs.zellij = {
    enable = true;
    settings = {
      default_mode = "locked";
      copy_command = "muscat copy";
      theme = "nord";
      themes.nord = {
        fg = [ 216 222 233 ]; #D8DEE9
        bg = [ 46 52 64 ]; #2E3440
        black = [ 59 66 82 ]; #3B4252
        red = [ 191 97 106 ]; #BF616A
        green = [ 163 190 140 ]; #A3BE8C
        yellow = [ 235 203 139 ]; #EBCB8B
        blue = [ 129 161 193 ]; #81A1C1
        magenta = [ 180 142 173 ]; #B48EAD
        cyan = [ 136 192 208 ]; #88C0D0
        white = [ 229 233 240 ]; #E5E9F0
        orange = [ 208 135 112 ]; #D08770
      };
      ui.pane_frames.rounded_corners = true;
    };
  };
}
