{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cachix

    rnix-lsp
    nixpkgs-fmt

    # generators
    nodePackages.node2nix
  ];
}
