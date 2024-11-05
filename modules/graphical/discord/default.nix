{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.discord;
  isPersistEnabled = config.dots.shared.persist.enable;
  isStylesEnabled = config.dots.styles.enable;
  user = config.dots.user;
in
{
  options.dots.graphical.discord.enable = mkEnableOption "Enable discord";

  config = mkIf cfg.enable {
    dots.user.userPackages = [ pkgs.vesktop ];
    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled { vesktop.enable = true; };
    };
    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".config/vesktop"
      ];
    };
  };
}
