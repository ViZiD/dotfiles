{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.cli.yazi;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.cli.yazi.enable = mkEnableOption "Enable yazi file manager";
  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled {
        yazi.enable = true;
      };
      programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
