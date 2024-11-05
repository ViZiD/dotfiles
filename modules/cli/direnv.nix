{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.cli.direnv;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.cli.direnv.enable = mkEnableOption "Enable direnv";
  config = mkIf cfg.enable {
    home-manager.users.${user.username}.programs.direnv = mkIf user.enable {
      enable = true;
      nix-direnv.enable = true;
    };
    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".local/share/direnv"
      ];
    };
  };
}
