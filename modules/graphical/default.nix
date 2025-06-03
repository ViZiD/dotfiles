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
in
{
  imports = [
    ./terminal
    ./vscode
    ./browsers
    ./wayland
    ./messaging
    ./spotify
    ./discord
    ./mpv
    ./youtube
    ./reading
    ./tools
    ./games
    ./zed
  ];
  options.dots.graphical.enable = mkEnableOption "Enable graphical settings";

  config = mkIf cfg.enable {

    stylix.targets = mkIf isStylesEnabled {
      gtk.enable = true;
      qt.enable = true;
    };

    home-manager.users.${user.username} = mkIf user.enable {
      xdg.mimeApps.enable = true;
      stylix.targets = mkIf isStylesEnabled {
        gtk.enable = true;
        qt.enable = true;
        gnome.enable = true;
      };
    };

    dots = {
      graphical.terminal.enable = true;
      graphical.vscode.enable = false;
      graphical.browser.enable = true;
      graphical.wayland.enable = true;
      graphical.messaging.enable = true;
      graphical.spotify.enable = true;
      graphical.discord.enable = true;
      graphical.mpv.enable = true;
      graphical.youtube.enable = true;
      graphical.reading.enable = true;
      graphical.tools.enable = true;
      graphical.games.enable = true;
      graphical.zed.enable = true;
    };
  };
}
