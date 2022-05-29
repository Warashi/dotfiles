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

    shellAliases = {
      ls = "exa";
      f = ''e -c ":Neotree $(pwd)"'';
    };

    initExtraFirst = ''
      [[ "$SHELL" == "/bin/bash" ]] && export SHELL=${pkgs.zsh}/bin/zsh
      [[ ! -v ZELLIJ ]] && whence zellij > /dev/null && exec direnv exec / zellij attach --create
      [[ ! -v REATTACHED ]] && whence reattach-to-user-namespace > /dev/null && exec env REATTACHED=1 reattach-to-user-namespace -l $SHELL
    '';

    initExtra = ''
      if [[ -v NVIM_LISTEN_ADDRESS ]]; then
        export EDITOR="nvr -cc ToggleTermClose --remote-wait-silent"
        alias e="nvr -cc ToggleTermClose"
      else
        export EDITOR="nvim"
        alias e="nvim"
      fi
      eval "$(zabrze init --bind-keys)"
    '';
  };
}
