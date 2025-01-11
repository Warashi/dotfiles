SRC_FNL := $(shell find . -name '*.fnl')
OUT_LUA := $(patsubst %.fnl,%.lua,$(SRC_FNL))

.PHONY: all
all: link-apply

%.lua: %.fnl
	fennel --compile $< > $@

.PHONY: link-plan
link-plan:
	go run github.com/Warashi/dotlink/cmd/dotlink@latest plan
.PHONY: link-apply
link-apply:
	go run github.com/Warashi/dotlink/cmd/dotlink@latest apply
.PHONY: link-import
link-import:
	go run github.com/Warashi/dotlink/cmd/dotlink@latest import
.PHONY: format
format: format-nix format-toml format-fennel
.PHONY: format-nix
format-nix:
	fd --hidden '.nix$$' -X nixfmt
.PHONY: format-toml
format-toml:
	fd --hidden '.toml$$' -X taplo format
.PHONY: format-fennel
format-fennel:
	fd --hidden '.fnl$$' -x fnlfmt --fix
.PHONY: nixos-rebuild
nixos-rebuild:
	nixos-rebuild switch --flake '$(FLAKE)'
.PHONY: darwin-rebuild
darwin-rebuild:
	if which darwin-rebuild; then darwin-rebuild switch --flake '$(FLAKE)'; else nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake '$(FLAKE)'; fi
.PHONY: home-manager
home-manager:
	if which home-manager; then home-manager switch --flake '$(FLAKE)'; else nix --extra-experimental-features 'nix-command flakes' run home-manager -- switch --flake '$(FLAKE)'; fi
.PHONY: nixos-rebuild/duna
nixos-rebuild/duna:
	$(MAKE) nixos-rebuild FLAKE='./nix#duna'
.PHONY: nixos-rebuild/workbench
nixos-rebuild/workbench:
	$(MAKE) nixos-rebuild FLAKE='./nix#workbench'
.PHONY: nixos-rebuild/orbstack
nixos-rebuild/orbstack:
	$(MAKE) nixos-rebuild FLAKE='./nix#orbstack'
.PHONY: nixos-rebuild/parallels
nixos-rebuild/parallels:
	$(MAKE) nixos-rebuild FLAKE='./nix#parallels'
.PHONY: darwin-rebuild/tisza
darwin-rebuild/tisza:
	$(MAKE) darwin-rebuild FLAKE='./nix#tisza'
.PHONY: darwin-rebuild/warashi
darwin-rebuild/warashi:
	$(MAKE) darwin-rebuild FLAKE='./nix#warashi'
.PHONY: home-manager/parallels
home-manager/parallels:
	$(MAKE) home-manager FLAKE='./nix#parallels'
.PHONY: home-manager/tisza
home-manager/tisza:
	$(MAKE) home-manager FLAKE='./nix#tisza'
.PHONY: home-manager/warashi
home-manager/warashi:
	$(MAKE) home-manager FLAKE='./nix#warashi'
.PHONY: nix-flake-update
nix-flake-update:
	cd nix && nix flake update
.PHONY: setup-dotlink
setup-dotlink:
	nix --extra-experimental-features 'nix-command flakes' shell 'nixpkgs#go' 'nixpkgs#gnumake' --command $(MAKE) link-import link-apply
.PHONY: update-cspell-dict
update-cspell-dict:
	cspell --words-only --unique --dot . | sort -u --ignore-case | tr '[:upper:]' '[:lower:]' > ./.cspell/project-words.txt
.PHONY: lock-emacs-deps
lock-emacs-deps:
	cd nix && nix develop --command nix run '.#lock' --impure
.PHONY: update-emacs-deps
update-emacs-deps: lock-emacs-deps
	cd nix && nix develop --command nix run '.#update' --impure
