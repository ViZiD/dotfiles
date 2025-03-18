{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.tools;
  user = config.dots.user;
  # isStylesEnabled = config.dots.styles.enable;
  isPersistEnabled = config.dots.shared.persist.enable;

  associations = {
    "application/zip" = "org.gnome.FileRoller";
    "application/rar" = "org.gnome.FileRoller";
    "application/7z" = "org.gnome.FileRoller";
    "application/*tar" = "org.gnome.FileRoller";
  };
in
{
  options.dots.graphical.tools.enable = mkEnableOption "Enable tools packages";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf (user.enable && isPersistEnabled) {
      directories = [
      ];
    };
    home-manager.users.${user.username} = mkIf user.enable {
      # stylix.targets = mkIf isStylesEnabled { };
      home.packages = with pkgs; [ file-roller ];

      xdg.mimeApps = {
        defaultApplications = associations;
        associations.added = associations;
      };
    };
  };
}
