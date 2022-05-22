{ programs, pkgs, ... }: {
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
}
