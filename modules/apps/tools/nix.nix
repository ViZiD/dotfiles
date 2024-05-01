{ pkgs, ... }:
let
  toTOML = name: (pkgs.formats.toml { }).generate "${name}";
in
{
  home-manager.users.radik = {
    xdg.configFile."nix-init/config.toml".source = toTOML "config.toml" {
      commit = true;
      maintainers = [ "vizid" ];
    };
    home.packages = with pkgs; [
      cachix

      # nix lsp
      nil
      nixd

      nixfmt-rfc-style

      nixpkgs-review
      nix-update
      nix-init
      nurl

      nodePackages.node2nix
    ];
  };
}
