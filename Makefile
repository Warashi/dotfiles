.PHONY: link-plan
link-plan:
	go run github.com/Warashi/dotlink/cmd/dotlink@latest plan
.PHONY: link-apply
link-apply:
	go run github.com/Warashi/dotlink/cmd/dotlink@latest apply
.PHONY: link-import
link-import:
	go run github.com/Warashi/dotlink/cmd/dotlink@latest import
.PHONY: format-nix
format-nix:
	fd --hidden '.nil$$' -x nixpkgs-fmt
.PHONY: format-stylua
format-stylua:
	fd --hidden '.lua$$' -x stylua
.PHONY: nixos-rebuild
nixos-rebuild:
	nixos-rebuild switch --flake '$(FLAKE)'
.PHONY: darwin-rebuild
darwin-rebuild:
	if which darwin-rebuild; then darwin-rebuild switch --flake '$(FLAKE)'; else nix run nix-darwin -- switch --flake '$(FLAKE)'; fi
.PHONY: home-manager
home-manager:
	if which home-manager; then home-manager switch --flake '$(FLAKE)'; else nix run home-manager -- switch --flake '$(FLAKE)'; fi
.PHONY: nixos-rebuild/parallels
nixos-rebuild/parallels:
	$(MAKE) nixos-rebuild FLAKE='./nix#parallels'
.PHONY: darwin-rebuild/warashi
darwin-rebuild/warashi:
	$(MAKE) darwin-rebuild FLAKE='./nix#warashi'
.PHONY: home-manager/parallels
home-manager/parallels:
	$(MAKE) home-manager FLAKE='./nix#parallels'
.PHONY: home-manager/warashi
home-manager/warashi:
	$(MAKE) home-manager FLAKE='./nix#warashi'
.PHONY: home-manager/workbench
home-manager/workbench:
	$(MAKE) home-manager FLAKE='./nix#workbench'
.PHONY: nix-flake-update
nix-flake-update:
	cd nix && nix flake update
.PHONY: setup-dotlink
setup-dotlink:
	nix --extra-experimental-features 'nix-command flakes' shell 'nixpkgs/nixos-unstable#go_1_21' 'nixpkgs#gnumake' --command $(MAKE) link-import link-apply
