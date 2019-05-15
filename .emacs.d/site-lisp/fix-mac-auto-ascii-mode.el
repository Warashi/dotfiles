;; -*- lexical-binding: t -*-
;; basically written by conao3
;; Author: conao3 and warashi

(defvar conao3/mac-last-input-method nil)
(defun conao3/mac-save-input-source (&rest args)
  (when (not (equal (mac-input-source)
                    (mac-input-source 'ascii-capable-keyboard)))
    (setq conao3/mac-last-input-method (mac-input-source))))

(defun conao3/mac-restore-input-source ()
  (when (and conao3/mac-last-input-method
             (not (minibufferp)))
    (mac-select-input-source conao3/mac-last-input-method)
    (setq conao3/mac-last-input-method nil)))

(defun warashi/mac-auto-ascii-mode-advice (&rest args)
  (if mac-auto-ascii-mode
      (progn
        (advice-add 'mac-auto-ascii-select-input-source :before #'conao3/mac-save-input-source)
        (add-hook 'post-command-hook #'conao3/mac-restore-input-source))
    (advice-remove 'mac-auto-ascii-select-input-source #'conao3/mac-save-input-source)
    (remove-hook 'post-command-hook #'conao3/mac-restore-input-source)))

(advice-add 'mac-auto-ascii-mode :after #'warashi/mac-auto-ascii-mode-advice)
(provide 'fix-mac-auto-ascii-mode)
