(setq gc-cons-threshold most-positive-fixnum)

(menu-bar-mode -1)
(when (fboundp #'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp #'scroll-bar-mode)
  (scroll-bar-mode -1))
