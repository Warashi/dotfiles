;; -*- lexical-binding: t -*-
(setq vc-follow-symlinks t)
(when load-file-name
    (setq user-emacs-directory (file-name-directory load-file-name)))
(custom-set-variables
     '(package-archives '(("melpa" . "https://melpa.org/packages/")
                          ("gnu"   . "https://elpa.gnu.org/packages/"))))
    (package-initialize)
(org-babel-load-file (locate-user-emacs-file "emacs-config.org"))
