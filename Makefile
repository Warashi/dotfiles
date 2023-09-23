.PHONY: link-plan
link-plan:
	go run github.com/Warashi/dotlink/cmd/dotlink@latest plan
.PHONY: link-apply
link-apply:
	go run github.com/Warashi/dotlink/cmd/dotlink@latest apply
.PHONY: link-import
link-import:
	go run github.com/Warashi/dotlink/cmd/dotlink@latest import
.PHONY: format-stylua
format-stylua:
	fd --hidden '.lua$$' -x stylua
.PHONY: darwin-rebuild
darwin-rebuild:
	nix run nix-darwin -- switch --flake '$(CURDIR)/nix#warashi'
.PHONY: home-manager
home-manager/warashi:
	nix run home-manager/master -- switch --flake '$(CURDIR)/nix#warashi'
home-manager/workbench:
	nix run home-manager/master -- switch --flake '$(CURDIR)/nix#workbench'
.PHONY: nix-flake-update
nix-flake-update:
	cd nix && nix flake update
.PHONY: setup-dotlink
setup-dotlink:
	nix --extra-experimental-features 'nix-command flakes' shell 'nixpkgs/nixos-unstable#go_1_21' 'nixpkgs#gnumake' --command $(MAKE) link-apply
