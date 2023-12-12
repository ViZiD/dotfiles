.PHONY: setup/t440p update

setup/t440p:
	sudo nixos-rebuild switch --flake ".#t440p"

update:
	nix flake update --commit-lock-file
