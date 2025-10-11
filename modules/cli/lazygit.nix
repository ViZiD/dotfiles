{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.cli.lazygit;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.cli.lazygit.enable = mkEnableOption "Enable lazygit";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {

      stylix.targets = mkIf isStylesEnabled {
        lazygit.enable = true;
      };

      programs.lazygit = {
        enable = true;
      };
    };
  };
}
