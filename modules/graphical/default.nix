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
    ./messaging
    ./spotify
    ./discord
    ./mpv
    ./youtube
    ./reading
    ./tools
  ];
  options.dots.graphical.enable = mkEnableOption "Enable graphical settings";

  config = mkIf cfg.enable {

    stylix.targets = mkIf isStylesEnabled {
      gtk.enable = true;
      qt.enable = true;
    };

    home-manager.users.${user.username} = mkIf user.enable {
      xdg.mimeApps.enable = true;
      stylix.targets.gtk.enable = mkIf isStylesEnabled true;
      stylix.targets.qt.enable = mkIf isStylesEnabled true;
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
      graphical.messaging.enable = true;
      graphical.spotify.enable = true;
      graphical.discord.enable = true;
      graphical.mpv.enable = true;
      graphical.youtube.enable = true;
      graphical.reading.enable = true;
      graphical.tools.enable = true;
    };
  };
}
