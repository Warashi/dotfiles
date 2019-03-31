;;; emacs -q -lした時に、user-emacs-directoryが変わるように
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; C-hをbackspaceとして使う
(define-key key-translation-map (kbd "C-h") (kbd "DEL"))
(define-key key-translation-map (kbd "M-h") (kbd "M-DEL"))

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'meta)
(setq backup-directory-alist `((".*" . ,(locate-user-emacs-file "backup"))))

;; menu-bar-mode off
(menu-bar-mode -1)
;; tool-bar-mode off
(tool-bar-mode -1)
;; scroll-bar-mode off
(scroll-bar-mode -1)

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

(straight-use-package '(org :local-repo nil))
(straight-use-package 'org-plus-contrib)

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package doom-themes
  :config
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package go-mode)
(use-package dockerfile-mode)
(use-package yaml-mode)
(use-package fish-mode)

(use-package lsp-mode :commands lsp
  :hook ((go-mode dockerfile-mode) . lsp)
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("docker-langserver" "--stdio"))
                    :major-modes '(dockerfile-mode)
                    :server-id 'docker-langserver)))
(use-package lsp-ui
  :after lsp-mode
  :init
  (add-hook 'lsp-mode-hook #'lsp-ui-mode))
(use-package company-lsp :commands company-lsp
  :after (lsp-mode company))
(use-package flycheck)

(use-package company
  :init
  (setq company-idle-delay 0.01)
  (setq completion-ignore-case t)
  (global-company-mode 1))
(use-package company-posframe
  :after company
  :init
  (company-posframe-mode))

(use-package counsel
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :bind (("C-s" . swiper)
	 ("C-c k" . counsel-rg))
  :config
  (setq ivy-height 30))

(use-package ivy-posframe
  :after ivy
  :init
  (setq ivy-display-function #'ivy-posframe-display-at-frame-center)
  (ivy-posframe-enable))

(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package yasnippet
  :init
  (add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
  (add-hook 'prog-mode-hook #'yas-minor-mode))
(use-package yasnippet-snippets
  :after yasnippet)

(require 'server)
(unless (server-running-p)
  (server-start))
