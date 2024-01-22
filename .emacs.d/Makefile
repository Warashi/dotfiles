EMACS	?= emacs
.PHONY: clean
all: init.elc
clean:
	rm -f init.mk init.el init.elc
init.mk: init.org
	$(EMACS) -Q -q --batch --eval \
		"(progn \
			(require 'ob-tangle) \
			(org-babel-tangle-file \"$<\" \"$@\" \"makefile\"))"
init.elc: init.org init.mk
	$(MAKE) -f init.mk $@
