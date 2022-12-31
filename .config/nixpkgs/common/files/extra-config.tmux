#!/usr/bin/env bash
# SSH_AUTH_SOCK を symlink に向ける
set-environment -g 'SSH_AUTH_SOCK' ~/.ssh/ssh_auth_sock

# C-g 2回で C-g が送られるようにする
bind C-g send-prefix

# window numberが飛び飛びにならないようにする
set-option -g renumber-windows on

# マウスを有効化
set-option -g mouse on

# title設定
set-option -g set-titles on
set-option -g set-titles-string '#T'

# TrueColor 表示
set-option -g default-terminal "screen-256color"
set-option -ga terminal-overrides ",xterm-256color:Tc"

# C-w で window 一覧を開く
bind C-w choose-tree -Zw

# C-c でwindow作成
bind C-c new-window

# C-t で現在のwindowを一番左へ移動
bind C-t move-window -t 0

# C-\ で popup window
bind C-\\ run-shell "zsh -c \"tmuxpopup\""

# g で tig in popup window
bind g popup -d "#{pane_current_path}" -xC -yC -w80% -h80% -E tig

# C-h, C-v で画面分割
bind C-h split-window -h -c "#{pane_current_path}"
bind C-v split-window -v -c "#{pane_current_path}"

# H, V で pane 再配置
bind H select-layout main-vertical
bind V select-layout main-horizontal

# C-o, M-o で分割した画面をRotate
bind -r C-o rotate-window -D
bind -r M-o rotate-window -U

# vim っぽいキーバインドでpaneを移動
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R