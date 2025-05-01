{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  hmLib = inputs.home-manager.lib;
  cfg = config.dots.graphical.tools;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
  isPersistEnabled = config.dots.shared.persist.enable;

  associations = {
    "inode/directory" = "nemo.desktop";
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
      stylix.targets = mkIf isStylesEnabled {
        fuzzel.enable = true;
        mako.enable = true;
      };

      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            terminal = "${pkgs.kitty}/bin/kitty";
            width = 50;
            layer = "overlay";
          };
        };
      };

      services.mako = {
        enable = true;
        borderRadius = 12;
        defaultTimeout = 5000;
        ignoreTimeout = true;
        height = 150;
      };

      home.packages = with pkgs; [
        (nemo-with-extensions.override { extensions = [ nemo-fileroller ]; })
        file-roller
        swayimg
      ];

      dconf.settings = {
        "org/nemo/preferences" = {
          default-folder-viewer = "list-view";
          show-hidden-files = true;
          start-with-dual-pane = true;
          date-format-monospace = true;
          thumbnail-limit = hmLib.hm.gvariant.mkUint64 (100 * 1024 * 1024);
        };
        "org/nemo/window-state" = {
          sidebar-bookmark-breakpoint = 0;
          sidebar-width = 180;
        };
        "org/nemo/preferences/menu-config" = {
          selection-menu-make-link = true;
          selection-menu-copy-to = true;
          selection-menu-move-to = true;
        };
      };

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
