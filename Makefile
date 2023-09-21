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
	nix run nix-darwin -- switch --flake '$(CURDIR)/.config/nix-darwin#warashi'
.PHONY: home-manager
home-manager:
	nix run home-manager/master -- switch
.PHONY: nix-flake-update
nix-flake-update:
	cd .config/home-manager && nix flake update
	cd .config/nix-darwin && nix flake update
.PHONY: setup-dotlink
setup-dotlink:
	nix-shell -p go_1_21 --pure --run '$(MAKE) link-apply'
