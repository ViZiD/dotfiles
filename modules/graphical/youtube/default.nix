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
{
  options.dots.graphical.youtube.enable = mkEnableOption "Enable youtube stuff";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = with pkgs; [
        yt-dlp
        ytfzf
      ];
    };
  };
}
