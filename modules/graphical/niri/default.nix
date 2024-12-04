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
    ./waybar
  ];

  options.dots.graphical.niri.enable = mkEnableOption "Enable niri wm settings";

  config = mkIf cfg.enable {

    environment.systemPackages = [ pkgs.kdePackages.qtwayland ];

    dots.graphical = {
      wofi.enable = true;
      waybar.enable = true;
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    niri-flake.cache.enable = false;

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${lib.getExe pkgs.greetd.tuigreet} --remember --asterisks --time --cmd niri-session";
          user = "greeter";
        };
        default_session = initial_session;
      };
    };

    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = with pkgs; [
        wev
        wl-clipboard
      ];
      stylix.targets = mkIf isStylesEnabled { niri.enable = true; };
      dconf = {
        enable = true;
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };
      };
      programs.niri = {
        settings = {
          environment = {
            DISPLAY = ":0";
            NIXOS_OZONE_WL = "1";

            _JAVA_AWT_WM_NONREPARENTING = "1";

            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "gtk3";

            TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = mkIf config.dots.graphical.telegram.enable "1";

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
          ];
          window-rules = [
            {
              matches = [
                { app-id = "^firefox$"; }
                { app-id = "^kitty$"; }
                { app-id = "^Spotify$"; }
                { app-id = "^org\\.telegram\\.desktop$"; }
                { app-id = "^vesktop$"; }
                { app-id = "^mpv$"; }
                { app-id = "^FreeTube$"; }
                { title = "(?i)Visual\\s+Studio\\s+Code"; }
              ];
              open-maximized = true;
              border.enable = false;
            }
            {
              matches = [
                { app-id = "^org\\.gnupg\\.pinentry-qt$"; }
                { app-id = "^org\\.telegram\\.desktop$"; }
              ];
              block-out-from = "screencast";
            }
            # {
            #   matches = [
            #     { app-id = "^org\\.telegram\\.desktop$"; }
            #   ];
            #   border.enable = false;
            # }
          ];
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
              "wofi"
              "--show"
              "run"
            ];
          };
        };
      };
    };
  };
}
