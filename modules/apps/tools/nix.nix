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
    nodePackages.node2nix
  ];
}
