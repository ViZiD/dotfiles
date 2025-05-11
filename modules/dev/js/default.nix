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
  options.dots.dev.js.enable = mkEnableOption "Enable js dev packages";
  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages =
        with pkgs;
        with pkgs.nur.repos.vizqq;
        [
          nodejs_latest
          yarn
          pnpm
          webcrack
        ];
    };
  };
}
