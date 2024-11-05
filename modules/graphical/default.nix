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
    ./brave
    ./niri
    ./wofi
    ./telegram
    ./spotify
    ./discord
  ];
  options.dots.graphical.enable = mkEnableOption "Enable graphical settings";

  config = mkIf cfg.enable {

    stylix.targets = mkIf isStylesEnabled {
      gtk.enable = true;
    };

    home-manager.users.${user.username} = mkIf (user.enable && isStylesEnabled) {
      stylix.targets.gtk.enable = true;
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
      graphical.brave.enable = true;
      graphical.niri.enable = true;
      graphical.telegram.enable = true;
      graphical.spotify.enable = true;
      graphical.discord.enable = true;
    };
  };
}
