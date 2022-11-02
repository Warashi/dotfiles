{
  home,
  programs,
  pkgs,
  ...
}: let
  warashiPkgs = import <warashi> {};
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./zsh.nix
  ];

  # home-manager と nix-darwin で同じoverlaysを使うための方策
  nixpkgs.overlays = import ./overlays.nix;

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];

  programs.bash = {
    enable = true;
    initExtra = "exec zsh --login";
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "base16-256";
    };
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
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      tmux-thumbs
      {
        plugin = warashiPkgs.tmux-statusline-themes;
        extraConfig = "set -g @tmux-statusline-theme 'gruvbox-dark'";
      }
    ];
    extraConfig = ''
      # SSH_AUTH_SOCK を symlink に向ける
      set-environment -g 'SSH_AUTH_SOCK' ~/.ssh/ssh_auth_sock

      # C-g 2回で C-g が送られるようにする
      bind C-g send-prefix

      # マウスを有効化
      set-option -g mouse on

      # title設定
      set -g set-titles on
      set -g set-titles-string '#T'

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

      # vim-tpipeline
      set -g focus-events on
      set -g status-style bg=default
      set -g status-left-length 90
      set -g status-right-length 90
      set -g status-justify absolute-centre
      set -g visual-activity off
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
    defaultOptions = ["--color=dark"];
    tmux.enableShellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = ["--cmd j"];
  };
}
