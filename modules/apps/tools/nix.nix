{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cachix

    # nix lsp
    nil
    nixd

    nixpkgs-fmt

    nixpkgs-review

    # generators
    nix-init
    nodePackages.node2nix
  ];
}
