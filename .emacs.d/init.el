;;; emacs -q -lした時に、user-emacs-directoryが変わるように
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; C-hをbackspaceとして使う
(define-key key-translation-map (kbd "C-h") (kbd "DEL"))
(define-key key-translation-map (kbd "M-h") (kbd "M-DEL"))

;; command と option を meta として扱う
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'meta)

(setq custom-file (locate-user-emacs-file "customize.el"))
(add-hook 'after-init-hook #'(lambda () (load-file custom-file)))

;; 各種バーを消す
(menu-bar-mode -1)
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

;; mac-auto-ascii-mode を有効にしていると、C-hでascii-modeになってしまうのでoffにする
;; (when (fboundp #'mac-auto-ascii-mode)
;;     (mac-auto-ascii-mode 1))

;; かわりに、minibufferに入るときにascii-modeにする
(when (fboundp #'mac-auto-ascii-select-input-source)
  (add-hook 'minibuffer-setup-hook #'mac-auto-ascii-select-input-source))

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

;; 誤って終了しないようにする
(global-set-key (kbd "C-x C-C") 'server-edit)
(global-unset-key (kbd "C-z"))
(defalias 'exit 'save-buffers-kill-terminal)

(set-face-attribute 'default nil :family "Source Han Code JP" :height 140)

;; straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

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

(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
  (run-with-idle-timer my-show-delay t 'global-hl-line-timer-function))

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
(use-package doom-themes
  :config
  (load-theme 'doom-one t))

(use-package exec-path-from-shell
  :config
  (add-to-list 'exec-path-from-shell-variables "EMAIL")
  (exec-path-from-shell-initialize))

(use-package go-mode)
(use-package docker)
(use-package dockerfile-mode)
(use-package docker-compose-mode)
(use-package docker-tramp)
(use-package yaml-mode)
(use-package fish-mode)
(use-package markdown-mode)

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(go-mode . ("gopls" "serve")))
  (add-hook 'go-mode-hook 'eglot-ensure)
  :bind
  (:map eglot-mode-map
	("C-c a" . eglot-code-actions)
	("C-c f" . eglot-format-buffer)
	("C-c d" . flymake-show-diagnostics-buffer)))

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
  :init (region-bindings-mode-enable)
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
  :bind (("C-c g" . magit-status)))

(use-package direnv
  :config
  (direnv-mode))

(straight-use-package '(org :local-repo nil))
(straight-use-package 'org-plus-contrib)
(use-package org
  :bind (("C-c c" . org-capture))
  :config
  (setq org-use-speed-commands t)
  (setq org-directory "~/org")
  (setq org-capture-templates
	'(
	  ("m" "MEMO" entry (file+olp+datetree "diary.org" "Memo") "***** %U\n%?")
	  ("d" "DIARY" plain (file+olp+datetree "diary.org" "Diary") "" :empty-lines-after 2)
	  ("t" "TRPG" entry (file+headline "diary.org" "TRPG") "** %?\n" :jump-to-captured t)
	  )))

;; Local Variables:
;; eval: (flycheck-mode -1)
;; End:
