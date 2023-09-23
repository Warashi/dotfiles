#!/usr/bin/env bash
# SSH_AUTH_SOCK を symlink に向ける
set-environment -g 'SSH_AUTH_SOCK' ~/.ssh/ssh_auth_sock

# C-g 2回で C-g が送られるようにする
bind C-g send-prefix

# window numberが飛び飛びにならないようにする
set-option -g renumber-windows on

# status line を上部に配置する
set-option -g status-position top

# マウスを有効化
set-option -g mouse on

# title設定
set-option -g set-titles on
set-option -g set-titles-string '#T'

# TrueColor 表示
set-option -g default-terminal "tmux-256color"
set-option -ga terminal-overrides ",xterm-256color:Tc,alacritty:RGB"

# C-w で window 一覧を開く
bind C-w choose-tree -Zw

# C-c でwindow作成
bind C-c new-window

# C-t で現在のwindowを一番左へ移動
bind C-t move-window -t 0

# h, v で画面分割
bind h split-window -h -c "#{pane_current_path}"
bind v split-window -v -c "#{pane_current_path}"

# H, V で pane 再配置
bind H run-shell "tmux-mvr"
bind V select-layout main-horizontal
set-option -g main-pane-height "50%"
set-option -g main-pane-width "50%"

# Enter キーで main-vertical-right
bind C-m run-shell "tmux-mvr"

# C-o, M-o で分割した画面をRotate
bind -r C-o rotate-window -D
bind -r M-o rotate-window -U

# vim っぽいキーバインドでpaneを移動
bind -r C-h select-pane -L
bind -r C-j select-pane -D
bind -r C-k select-pane -U
bind -r C-l select-pane -R
