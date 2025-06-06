{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.niri;
  user = config.dots.user;
  defaultKeyBind = import ./defaultKeyBind.nix;
  isStylesEnabled = config.dots.styles.enable;
in
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.dots.graphical.niri.enable = mkEnableOption "Enable niri wm settings";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.kdePackages.qtwayland ];

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    xdg.portal = {
      config = {
        niri = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.Access" = [ "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
          "org.freedesktop.impl.portal.RemoteDesktop" = [ "gnome" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
      };
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    niri-flake.cache.enable = false;

    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled { niri.enable = true; };

      programs.niri = {
        settings =
          let
            floating-config = {
              geometry-corner-radius = {
                bottom-left = 12.0;
                bottom-right = 12.0;
                top-left = 12.0;
                top-right = 12.0;
              };
              default-column-width.proportion = 0.9;
              default-window-height.proportion = 0.9;
            };
          in
          {
            environment = {
              DISPLAY = ":0";
              NIXOS_OZONE_WL = "1";

              ELECTRON_OZONE_PLATFORM_HINT = "auto";

              _JAVA_AWT_WM_NONREPARENTING = "1";

              QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
              QT_QPA_PLATFORM = "wayland";
              QT_QPA_PLATFORMTHEME = "gtk3";

              TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = mkIf config.dots.graphical.messaging.enable "1";

              XDG_CURRENT_DESKTOP = "niri";
              XDG_SESSION_DESKTOP = "niri";
              XDG_SESSION_TYPE = "wayland";
            };
            spawn-at-startup = [
              {
                command = [
                  "${getExe pkgs.swaybg}"
                  "-i"
                  "${config.home-manager.users.${user.username}.stylix.image}"
                ];
              }
              {
                command = [
                  (getExe pkgs.xwayland-satellite)
                ];
              }
              {
                command = [
                  (getExe config.home-manager.users.${user.username}.programs.waybar.package)
                ];
              }
              {
                command = [
                  (config.dots.graphical.terminal.terminalPath)
                ];
              }
            ];
            window-rules = [
              {
                matches = [
                  { is-floating = true; }
                ];
                inherit (floating-config) geometry-corner-radius;
                clip-to-geometry = true;
              }
              {
                matches = [
                  { app-id = "^chromium-browser$"; }
                  { app-id = "^kitty$"; }
                  { app-id = "^Alacritty$"; }
                  { app-id = "^spotify$"; }
                  { app-id = "^org\.telegram\.desktop$"; }
                  # { app-id = "^vesktop$"; }
                  { app-id = "^discord$"; }
                  { app-id = "^mpv$"; }
                  { app-id = "^org.qbittorrent.qBittorrent$"; }
                  { app-id = "^org.qutebrowser.qutebrowser$"; }
                  { app-id = "^org.prismlauncher.PrismLauncher$"; }
                  { app-id = "^dev.zed.Zed$"; }
                  { title = "(?i)Visual\\s+Studio\\s+Code"; }
                ];
                open-maximized = true;
                border.enable = false;
              }
              {
                matches = [
                  { app-id = "^org\.gnupg\.pinentry-qt$"; }
                  { app-id = "^org\.telegram\.desktop$"; }
                ];
                block-out-from = "screencast";
              }
              {
                matches = [
                  { app-id = "^org.pwmt.zathura$"; }
                  { app-id = "^Shattered.Pixel.Dungeon$"; }
                  { app-id = "^Minecraft\\*.*$"; }
                ];
                open-fullscreen = true;
                border.enable = false;
              }
              {
                matches = [
                  { app-id = "^org.gnome.FileRoller$"; }
                ];
                inherit (floating-config) default-column-width default-window-height;
                open-floating = true;
              }
              {
                matches = [
                  { app-id = "^\.blueman-services-wrapped$"; }
                  { app-id = "^\.blueman-sendto-wrapped$"; }
                  { app-id = "^\.blueman-adapters-wrapped$"; }
                  { app-id = "^\.blueman-applet-wrapped$"; }
                  { app-id = "^\.blueman-manager-wrapped$"; }
                  { app-id = "^org\.gnupg\.pinentry-qt$"; }
                  { app-id = "^wpa_gui$"; }
                  { app-id = "^org\.pulseaudio\.pavucontrol$"; }
                  { app-id = "^org\.twosheds\.iwgtk$"; }
                  { app-id = "^qute-filepicker$"; }
                  { app-id = "^GoldenDict-ng$"; }
                  { app-id = "^anki$"; }
                ];
                inherit (floating-config) default-column-width default-window-height;
                open-floating = true;
              }
              {
                matches = [
                  {
                    app-id = "^xdg-desktop-portal-gtk$";
                    title = "^Open.File.?$";
                  }
                  {
                    app-id = "^\.telegram-desktop-wrapped$";
                    title = "^Choose.Files$";
                  }
                ];
                inherit (floating-config) default-column-width default-window-height;
              }
            ];
            layer-rules = [
              {
                matches = [
                  { namespace = "^launcher$"; }
                ];
                opacity = 0.95;
              }
              {
                matches = [
                  {
                    namespace = "^notifications$";
                  }
                ];
                block-out-from = "screencast";
              }
            ];
            prefer-no-csd = true;
            input = {
              keyboard = {
                xkb = {
                  layout = "us,ru";
                  model = "pc105";
                  options = "grp:alt_shift_toggle";
                };
              };
              touchpad = {
                tap-button-map = "left-middle-right";
                click-method = "clickfinger";
                scroll-method = "two-finger";
                natural-scroll = true;
                dwt = true;
                tap = false;
              };
              trackpoint = {
                natural-scroll = true;
                accel-profile = "flat";
              };
              mouse = {
                accel-profile = "flat";
              };
            };
            layout = {
              gaps = 0;
              always-center-single-column = true;
              border.width = 1;
            };
            cursor = {
              hide-on-key-press = true;
            };
            binds = defaultKeyBind // {
              "Mod+W".action.close-window = { };
              "Mod+Return".action.spawn = "${config.dots.graphical.terminal.terminalName}";
              "Mod+Space".action.spawn = [
                "fuzzel"
              ];
            };
          };
      };
    };
  };
}
