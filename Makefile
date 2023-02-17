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
