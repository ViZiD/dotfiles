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
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.youtube.enable = mkEnableOption "Enable youtube stuff";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".config/FreeTube"
      ];
    };
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = with pkgs; [
        yt-dlp
        ytfzf
      ];
      programs.freetube = {
        enable = true;
        settings = {
          checkForUpdates = false;
          checkForBlogPosts = false;

          hideTrendingVideos = true;
          hidePopularVideos = true;
          hideVideoLikesAndDislikes = true;
          hideHeaderLogo = true;

          useSponsorBlock = true;
          useDeArrowTitles = true;
          useDeArrowThumbnails = true;

          externalPlayer = "mpv";
          defaultQuality = "1080";
          disableSmoothScrolling = true;
        };
      };
    };
  };
}
