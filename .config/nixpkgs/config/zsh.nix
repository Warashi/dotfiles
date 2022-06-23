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
      f = ''e -c ":VFiler $(pwd)"'';
      z = "exec direnv exec / zellij attach --create";
      m = "mosh workbench";
    };

    initExtraFirst = ''
      [[ "$SHELL" == "/bin/bash" || "$SHELL" == "/bin/zsh" ]] && SHELL=${pkgs.zsh}/bin/zsh exec ${pkgs.zsh}/bin/zsh
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
