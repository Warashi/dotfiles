EMACS	?= emacs
all: init.elc
init.mk: README.org
	$(EMACS) -Q -q --batch --eval \
		"(progn \
			(require 'ob-tangle) \
			(org-babel-tangle-file \"$<\" \"$@\" \"makefile\"))"
init.elc: init.mk
	$(MAKE) -f $< $@
