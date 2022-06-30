{ home, programs, pkgs, ... }: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./config/zsh.nix
    ./config/zellij.nix
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];

  programs.bash = {
    enable = true;
    initExtra = "exec zsh --login";
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "g";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
    extraConfig = ''
      set -g set-titles on
      set -g set-titles-string '#W \ #{pane_current_path}'

      # TrueColor 表示
      set -g default-terminal "screen-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      # C-w で window 一覧を開く
      bind C-w choose-tree -Zw

      # C-c でwindow作成
      bind C-c new-window

      # C-t で現在のwindowを一番左へ移動
      bind C-t move-window -t 0

      # C-h, C-v で画面分割
      bind C-h split-window -h
      bind C-v split-window -v

      # H, V で pane 再配置
      bind H select-layout main-horizontal
      bind V select-layout main-vertical

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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd j" ];
  };
}
