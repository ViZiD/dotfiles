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

    "image/bmp" = "swayimg.desktop";
    "image/gif" = "swayimg.desktop";
    "image/jpeg" = "swayimg.desktop";
    "image/jpg" = "swayimg.desktop";
    "image/pjpeg" = "swayimg.desktop";
    "image/png" = "swayimg.desktop";
    "image/svg+xml" = "swayimg.desktop";
    "image/tiff" = "swayimg.desktop";
    "image/webp" = "swayimg.desktop";
    "image/x-bmp" = "swayimg.desktop";
    "image/x-emf" = "swayimg.desktop";
    "image/x-freehand" = "swayimg.desktop";
    "image/x-ico" = "swayimg.desktop";
    "image/x-pcx" = "swayimg.desktop";
    "image/x-png" = "swayimg.desktop";
    "image/x-portable-anymap" = "swayimg.desktop";
    "image/x-portable-bitmap" = "swayimg.desktop";
    "image/x-portable-graymap" = "swayimg.desktop";
    "image/x-portable-pixmap" = "swayimg.desktop";
    "image/x-tga" = "swayimg.desktop";
    "image/x-wmf" = "swayimg.desktop";
    "image/x-xbitmap" = "swayimg.desktop";
    "image/xpm" = "swayimg.desktop";
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
      home.packages = with pkgs; [
        file-roller
        swayimg
      ];

      xdg = {
        configFile."swayimg/config".source = ./swayimgrc;
        mimeApps = {
          defaultApplications = associations;
          associations.added = associations;
        };
      };
    };
  };
}
