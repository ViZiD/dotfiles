{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.dev;
  user = config.dots.user;
in
{
  options.dots.dev.python.enable = mkEnableOption "Enable python dev packages";
  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = with pkgs; [
        (python312.withPackages (ps: [ virtualenv ]))
        pdm
        poetry
        uv
      ];
    };
  };
}
