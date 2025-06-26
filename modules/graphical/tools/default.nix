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
      directories = [
        ".config/goldendict"
        ".config/obs-studio"
      ];
    };

    environment.systemPackages = [ pkgs.piper ];

    services.ratbagd.enable = true;

    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled {
        fuzzel.enable = config.dots.graphical.wayland.enable;
        # mako.enable = true;
      };

      programs = {
        obs-studio = {
          enable = true;
          plugins = with pkgs.obs-studio-plugins; [
            obs-composite-blur
            obs-gradient-source
            obs-retro-effects
          ];
        };
        fuzzel = {
          enable = config.dots.graphical.wayland.enable;
          settings = {
            main = {
              terminal = "${config.dots.graphical.terminal.terminalPath}";
              width = 50;
              layer = "overlay";
            };
          };
        };
      };
      # FIXME: criteria deprecated
      # wait stylix fix
      services.mako =
        let
          makoOpacity = lib.toHexString (((builtins.ceil (config.stylix.opacity.popups * 100)) * 255) / 100);
          inherit (config.stylix) fonts;
        in
        with config.lib.stylix.colors.withHashtag;
        {
          enable = true;
          settings = {
            background-color = base00 + makoOpacity;
            border-color = base0D;
            text-color = base05;
            progress-color = "over ${base02}";
            font = "${fonts.sansSerif.name} ${toString fonts.sizes.popups}";
            "urgency=low" = {
              background-color = "${base00}${makoOpacity}";
              border-color = base0D;
              text-color = base0A;
            };
            "urgency=high" = {
              background-color = "${base00}${makoOpacity}";
              border-color = base0D;
              text-color = base08;
            };

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
        goldendict-ng
        anki
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
