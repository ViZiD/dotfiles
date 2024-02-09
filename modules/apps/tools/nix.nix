{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cachix

    nixpkgs-fmt

    # generators
    nodePackages.node2nix
  ];
}
