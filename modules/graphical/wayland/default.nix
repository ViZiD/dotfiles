{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.wayland;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  imports = [
    ./waybar
    ./niri
    ./sway
  ];

  options.dots.graphical.wayland.enable = mkEnableOption "Enable wayland config";

  config = mkIf cfg.enable {
    dots.graphical = {
      niri.enable = true;
      waybar.enable = true;
      sway.enable = false;
    };

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = ''${lib.getExe pkgs.greetd.tuigreet} --remember --asterisks --time --cmd ${
            if config.dots.graphical.niri.enable then "niri-session" else "'dbus-run-session sway'" # not work xdg mime
          }'';
          user = "greeter";
        };
        default_session = initial_session;
      };
    };

    dots.shared.persist.user = mkIf (user.enable && isPersistEnabled) {
      directories = [
        # gnome
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
      ];
    };

    home-manager.users.${user.username} = mkIf user.enable {
      services.gnome-keyring.enable = true;
      home.packages = with pkgs; [
        wev
        wl-clipboard
      ];
    };
  };
}
