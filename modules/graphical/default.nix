{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.graphical;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  imports = [
    ./terminal
    ./vscode
    ./browsers
    ./niri
    ./wofi
    ./telegram
    ./spotify
    ./discord
    ./mpv
    ./youtube
    ./reading
  ];
  options.dots.graphical.enable = mkEnableOption "Enable graphical settings";

  config = mkIf cfg.enable {

    stylix.targets = mkIf isStylesEnabled {
      gtk.enable = true;
    };

    home-manager.users.${user.username} = mkIf user.enable {
      xdg.mimeApps.enable = true;
      stylix.targets.gtk.enable = mkIf isStylesEnabled true;
      # fix
      # https://github.com/nix-community/home-manager/issues/2064
      systemd.user.targets.tray = {
        Unit = {
          Description = "Home Manager System Tray";
          Requires = [ "graphical-session-pre.target" ];
        };
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

    dots = {
      graphical.terminal.enable = true;
      graphical.vscode.enable = true;
      graphical.browser.enable = true;
      graphical.niri.enable = true;
      graphical.telegram.enable = true;
      graphical.spotify.enable = true;
      graphical.discord.enable = true;
      graphical.mpv.enable = true;
      graphical.youtube.enable = true;
      graphical.reading.enable = true;
    };
  };
}
