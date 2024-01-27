;; -*- lexical-binding: t -*-

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(setq custom-file (locate-user-emacs-file "customize.el"))
(when (file-readable-p custom-file)
  (load-file custom-file))

(add-to-list 'load-path (locate-user-emacs-file "site-lisp"))

(define-key key-translation-map (kbd "C-h") (kbd "DEL"))
(define-key key-translation-map (kbd "M-h") (kbd "M-DEL"))

(defalias 'exit 'save-buffers-kill-emacs)

(substitute-key-definition 'dabbrev-expand 'hippie-expand global-map)

(menu-bar-mode -1)
(when (fboundp #'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp #'scroll-bar-mode)
  (scroll-bar-mode -1))

(setq-default truncate-lines nil)
(setq truncate-partial-width-windows t)

(defvar my-show-delay 0.125)

(setq-default indent-tabs-mode nil)

(setq kill-whole-line t)

(setq require-final-newline t)

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

(auto-compression-mode t)

(setq backup-directory-alist `((".*" . ,(locate-user-emacs-file "backup"))))

(setq vc-follow-symlinks t)
(setq auto-revert-check-vc-info t)

(setq scroll-preserve-screen-position :always)

(add-hook 'emacs-startup-hook #'column-number-mode)

(add-hook 'emacs-startup-hook #'line-number-mode)

(add-hook 'emacs-startup-hook #'global-display-line-numbers-mode)

(add-hook 'emacs-startup-hook #'electric-pair-mode)

(add-hook 'emacs-startup-hook #'global-prettify-symbols-mode)

(add-hook 'emacs-startup-hook #'show-paren-mode)

(add-hook 'emacs-startup-hook #'recentf-mode)
