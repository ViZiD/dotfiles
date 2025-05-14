{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.games;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.games.enable = mkEnableOption "Enable some games";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".local/share/PrismLauncher"
      ];
    };
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = [ pkgs.prismlauncher ];
    };
  };
}
