{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.youtube;
  user = config.dots.user;
in
# isPersistEnabled = config.dots.shared.persist.enable;
{
  options.dots.graphical.youtube.enable = mkEnableOption "Enable youtube stuff";

  config = mkIf cfg.enable {
    # dots.shared.persist.user = mkIf isPersistEnabled {
    #   directories = [
    #     ".config/FreeTube"
    #   ];
    # };
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = with pkgs; [
        yt-dlp
        ytfzf
      ];
    };
  };
}
