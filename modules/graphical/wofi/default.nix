{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.wofi;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.graphical.wofi.enable = mkEnableOption "Enable wofi settings";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled { wofi.enable = true; };
      programs.wofi = {
        enable = true;
        settings = {
          hide_scroll = true;
        };
      };
    };
  };
}
