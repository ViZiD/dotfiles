{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cachix

    # nix lsp
    nil
    nixd

    nixpkgs-fmt

    # generators
    nodePackages.node2nix
  ];
}
