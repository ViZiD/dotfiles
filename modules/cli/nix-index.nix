{
  inputs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.cli.nix-index;
in
{
  imports = [ inputs.nix-index-database.nixosModules.nix-index ];
  options.dots.cli.nix-index.enable = mkEnableOption "Enable nix-index database";

  config = mkIf cfg.enable {
    programs = {
      command-not-found.enable = false;
      nix-index.enable = true;
      nix-index-database.comma.enable = true;
    };
  };
}
