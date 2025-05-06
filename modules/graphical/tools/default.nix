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

    "image/bmp" = "imv.desktop";
    "image/gif" = "imv.desktop";
    "image/jpeg" = "imv.desktop";
    "image/jpg" = "imv.desktop";
    "image/pjpeg" = "imv.desktop";
    "image/png" = "imv.desktop";
    "image/svg+xml" = "imv.desktop";
    "image/tiff" = "imv.desktop";
    "image/webp" = "imv.desktop";
    "image/x-bmp" = "imv.desktop";
    "image/x-emf" = "imv.desktop";
    "image/x-freehand" = "imv.desktop";
    "image/x-ico" = "imv.desktop";
    "image/x-pcx" = "imv.desktop";
    "image/x-png" = "imv.desktop";
    "image/x-portable-anymap" = "imv.desktop";
    "image/x-portable-bitmap" = "imv.desktop";
    "image/x-portable-graymap" = "imv.desktop";
    "image/x-portable-pixmap" = "imv.desktop";
    "image/x-tga" = "imv.desktop";
    "image/x-wmf" = "imv.desktop";
    "image/x-xbitmap" = "imv.desktop";
    "image/xpm" = "imv.desktop";

    "application/x-bittorrent" = "qbittorrent.desktop";
  };
in
{
  options.dots.graphical.tools.enable = mkEnableOption "Enable tools packages";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf (user.enable && isPersistEnabled) {
      directories =
        [
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
        settings = {
          border-radius = 12;
          default-timeout = 5000;
          ignore-timeout = 1;
          border-size = 1;
        };
      };

      home.packages = with pkgs; [
        (nemo-with-extensions.override { extensions = [ nemo-fileroller ]; })
        webp-pixbuf-loader # for webp thumbnails
        xdg-terminal-exec
        file-roller
        imv
        qbittorrent
      ];

      dconf.settings = {
        # fix open in terminal
        "org/gnome/desktop/applications/terminal" = {
          exec = getExe pkgs.xdg-terminal-exec;
        };
        "org/cinnamon/desktop/applications/terminal" = {
          exec = getExe pkgs.xdg-terminal-exec;
        };
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
        mimeApps = {
          defaultApplications = associations;
          associations.added = associations;
        };
      };
    };
  };
}
