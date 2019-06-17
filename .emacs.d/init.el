;;; emacs -q -lした時に、user-emacs-directoryが変わるように
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
(add-to-list 'load-path (locate-user-emacs-file "site-lisp"))

;; C-hをbackspaceとして使う
(define-key key-translation-map (kbd "C-h") (kbd "DEL"))
(define-key key-translation-map (kbd "M-h") (kbd "M-DEL"))

;; command と option を meta として扱う
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'meta)

(setq custom-file (locate-user-emacs-file "customize.el"))
(add-hook 'after-init-hook #'(lambda () (load-file custom-file)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; 各種バーを消す
;; (menu-bar-mode -1) ;; native fullscreen にするために表示させる
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; 画面端で折り返し表示をする
(setq-default truncate-lines nil)
;; 左右に分割されている状態では折り返し表示をしない
(setq truncate-partial-width-windows t)
;; splash screen off
(setq inhibit-startup-message t)
;; いろいろなshowのdelay
(setq my-show-delay 0.125)

;; インデントにタブを使わない
(setq-default indent-tabs-mode nil)
;; 行の先頭で C-k を一回押すだけで行全体を消去する
(setq kill-whole-line t)
;; 最終行に必ず一行挿入する
(setq require-final-newline t)
;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
;; ファイル先頭に #!...があるファイルを保存すると実行権をつける。
(add-hook 'after-save-hook
  #'executable-make-buffer-file-executable-if-script-p)
;; gz ファイルも編集できるようにする
(auto-compression-mode t)

;; mac-auto-ascii-mode を有効にしていると、C-hでascii-modeになってしまうので (locate-user-emacs-file "site-lisp") 以下の fix-mac-auto-ascii-mode を
(when (fboundp #'mac-auto-ascii-mode)
  (require 'fix-mac-auto-ascii-mode)
  (mac-auto-ascii-mode 1))

;; IME patch の場合にはこっち
(when (fboundp #'mac-input-method-mode)
  (mac-input-method-mode 1))

(setq backup-directory-alist `((".*" . ,(locate-user-emacs-file "backup"))))

;; tool-bar-mode off
(when (fboundp #'tool-bar-mode)
  (tool-bar-mode -1))
;; scroll-bar-mode off
(when (fboundp #'scroll-bar-mode)
  (scroll-bar-mode -1))

;; シンボリックリンクの読み込みを許可
(setq vc-follow-symlinks t)
;; シンボリックリンク先のVCS内で更新が入った場合にバッファを自動更新
(setq auto-revert-check-vc-info t)
;; スクロール時にカーソルの相対位置を保つ
(setq scroll-preserve-screen-position :always)

;; 誤って終了しないようにする
(global-set-key (kbd "C-x C-C") 'server-edit)
(global-unset-key (kbd "C-z"))
(defalias 'exit 'save-buffers-kill-terminal)

(defvar my-font-size 180)
(set-face-attribute 'default nil :family "SF Mono Square" :height my-font-size)
(setq-default line-spacing 5)

;; builtin packages
(use-package outline
  :init (outline-minor-mode 1)
  :config
  (setq-default outline-level 'outline-level)
  (bind-keys :map outline-minor-mode-map
    ("<C-tab>" . outline-cycle)))

(use-package eldoc
  :config
  (setq eldoc-idle-delay my-show-delay)
  (setq eldoc-echo-area-use-multiline-p t))

(use-package files
  :config
  (when (and (eq system-type 'darwin) (executable-find "gls"))
    (setq insert-directory-program "gls")))

(use-package dired
  :config
  (require 'dired-x)
  (setq dired-listing-switches "-alh")
  ;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
  (setq dired-dwim-target t)
  ;; ディレクトリを再帰的にコピーする
  (setq dired-recursive-copies 'always)
  ;; diredバッファでC-sした時にファイル名だけにマッチするように
  (setq dired-isearch-filenames t))

(use-package hl-line
  :init
  (defun global-hl-line-timer-function ()
    (global-hl-line-unhighlight-all)
    (let ((global-hl-line-mode t))
      (global-hl-line-highlight)))
  (setq global-hl-line-timer
        (run-with-idle-timer my-show-delay t 'global-hl-line-timer-function)))

;; カーソルの位置が何文字目かを表示する
(add-hook 'after-init-hook #'column-number-mode)
;; カーソルの位置が何行目かを表示する
(add-hook 'after-init-hook #'line-number-mode)
;; 左に行番号を表示
(add-hook 'after-init-hook #'global-linum-mode)
;; electric-pair-mode
(add-hook 'after-init-hook #'electric-pair-mode)
;; prettify
(add-hook 'after-init-hook #'global-prettify-symbols-mode)
;; 対応する括弧を表示
(add-hook 'after-init-hook #'show-paren-mode)
;; emacsclientを使う
(add-hook 'after-init-hook #'server-start)
;; 最近開いたファイル
(add-hook 'after-init-hook #'recentf-mode)

;; non-builtin packages
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t))

(use-package exec-path-from-shell
  :config
  (add-to-list 'exec-path-from-shell-variables "EMAIL")
  (exec-path-from-shell-initialize))

(use-package go-mode)
(use-package rust-mode)
(use-package terraform-mode)
(use-package docker)
(use-package dockerfile-mode)
(use-package docker-compose-mode)
(use-package docker-tramp)
(use-package yaml-mode)
(use-package fish-mode)
(use-package markdown-mode)
(use-package browse-kill-ring
  :bind (("C-c y" . browse-kill-ring)))

;; ido-mode
(use-package ido
  :init
  (ido-mode 1)
  (setq ido-enable-flex-matching 1))
(use-package smex
  :bind (("M-x" . smex)))
(use-package ido-completing-read+
  :init (ido-ubiquitous-mode 1))
(use-package ido-at-point
  :init (ido-at-point-mode 1))
(use-package ido-vertical-mode
  :init (ido-vertical-mode 1)
  :config (setq ido-vertical-define-keys 'C-n-and-C-p-only))

(use-package eglot
  :init
  (add-hook 'go-mode-hook 'eglot-ensure)
  (add-hook 'rust-mode-hook 'eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(go-mode . ("gopls" "serve")))
  :bind
  (:map eglot-mode-map
	("C-c C-e a" . eglot-code-actions)
	("C-c C-e f" . eglot-format-buffer)
	("C-c C-e d" . flymake-show-diagnostics-buffer)))

(use-package elscreen
  :config
  ;; プレフィクスキーはC-t
  (setq elscreen-prefix-key (kbd "C-t"))
  ;; タブの先頭に[X]を表示しない
  (setq elscreen-tab-display-kill-screen nil)
  ;; header-lineの先頭に[<->]を表示しない
  (setq elscreen-tab-display-control nil)
  (elscreen-start))

(use-package editorconfig
  :init (editorconfig-mode 1))

(use-package outline-magic)

(use-package highlight-symbol
  :init (highlight-symbol-mode t))

(use-package jaword
  :init (global-jaword-mode))

(use-package volatile-highlights
  :init (volatile-highlights-mode t))

(use-package which-key
  :init (which-key-mode 1))

(use-package rainbow-delimiters
  :init  
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode-enable))

(use-package expand-region
  :bind (("C-c e" . er/expand-region)))

(use-package region-bindings-mode
  :init (region-bindings-mode 1)
  :bind (:map region-bindings-mode-map
	      ("a" . mc/mark-all-like-this)
	      ("p" . mc/mark-previous-like-this)
	      ("n" . mc/mark-next-like-this)
	      ("m" . mc/mark-more-like-this-extended)))

(use-package multiple-cursors)
(use-package visual-regexp)
(use-package visual-regexp-steroids
  :after visual-regexp
  :bind (:map global-map
	      ("C-c m" . vr/mc-mark)
	      :map esc-map
	      ("C-r" . vr/isearch-backward)
	      ("C-s" . vr/isearch-forward)))

(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package yasnippet
  :init
  (add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
  (add-hook 'prog-mode-hook #'yas-minor-mode))
(use-package yasnippet-snippets
  :after yasnippet)

(use-package magit
  :config
  (setq magit-completing-read-function 'magit-ido-completing-read)
  :bind (("C-c g" . magit-status)))

(use-package direnv
  :config
  (direnv-mode))

(use-package ace-window
  :bind (("C-c o" . ace-window))
  :config
  (set-face-attribute 'aw-leading-char-face nil :height (* my-font-size 10)))

(use-package org
  :ensure org-plus-contrib
  :commands (org-clock-is-active)
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda))
  :config
  (setq org-log-done 'time)
  (setq org-use-speed-commands t)
  (setq org-directory (locate-user-emacs-file "org"))
  (setq org-agenda-files `(,(locate-user-emacs-file "org/diary.org")))
  (setq org-capture-templates
	'(
	  ("m" "MEMO" entry (file+olp+datetree "diary.org" "Memo") "***** %U\n%?")
	  ("d" "DIARY" entry (file+olp+datetree "diary.org" "Diary") "***** %?\n")
	  ("t" "TRPG" entry (file+headline "diary.org" "TRPG") "** %?\n" :jump-to-captured t)
	  ("w" "TODO" entry (file+headline "diary.org" "Task") "** TODO %?\n")
	  )))

(use-package ox-hugo
  :after ox)
