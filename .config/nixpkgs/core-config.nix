{ programs, pkgs, ... }: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # bash integration
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
      t = "tmux new-session -t 0";
      g = "git";
      ls = "exa";
      ll = "ls -l";
      la = "ll -a";
      f = ''e -c ":Neotree $(pwd)"'';
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "Space";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
    extraConfig = ''
      # C-w で window 一覧を開く
      bind C-w choose-tree -Zw
      # C-c でwindow作成
      bind C-c new-window
      # C-t で現在のwindowを一番左へ移動
      bind C-t move-window -t 0
      # C-h, C-v で画面分割
      bind C-h split-window -h
      bind C-v split-window -v

      # C-o, M-o で分割した画面をRotate
      bind -r C-o rotate-window -D
      bind -r M-o rotate-window -U

      # vim っぽいキーバインドでpaneを移動
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
    '';
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
}
