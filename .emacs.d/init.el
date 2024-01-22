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

;; (setq-default mode-line-format nil) ; 思ったより不便だったのでモードライン非表示はやめる
(menu-bar-mode -1)
(when (fboundp #'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp #'scroll-bar-mode)
  (scroll-bar-mode -1))
