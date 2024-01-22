EMACS ?= emacs
all: init.elc
init.el: init.org
	$(EMACS) -Q -q --batch --eval \
		"(progn \
			(require 'ob-tangle) \
			(org-babel-tangle-file \"$<\" \"$@\" \"emacs-lisp\"))"
	$(EMACS) -q -l init.el --batch --eval "(run-hooks 'after-init-hook)"
%.elc: %.el
	$(EMACS) -q -l init.el --batch -f batch-byte-compile $<
