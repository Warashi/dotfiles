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
	nix run nix-darwin -- switch --flake './.config/nix-darwin#warashi'
.PHONY: nix-flake-update
nix-flake-update:
	cd .config/home-manager && nix flake update
	cd .config/nix-darwin && nix flake update
