{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.mpv;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.mpv.enable = mkEnableOption "Enable mpv player";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".local/state/mpv"
      ];
    };
    home-manager.users.${user.username} = mkIf user.enable {
      programs.mpv = {
        enable = true;
        package =
          with pkgs;
          let
            mpv' = mpv.override {
              scripts = with mpvScripts; [
                mpris
                mpv-cheatsheet

                autoload
                convert
                uosc
                thumbfast

                sponsorblock
                quality-menu
                webtorrent-mpv-hook
              ];
            };
          in
          mpv';
        bindings = {
          h = "seek -5";
          l = "seek 5";
          j = "cycle sub";
          J = "cycle sub down";
          k = "cycle audio";
          K = "cycle audio down";
          H = "seek -60";
          L = "seek 60";
          "Alt+h" = "add sub-delay +1";
          "Alt+l" = "add sub-delay -1";

          "Alt+k" = "add sub-scale +0.1";
          "Alt+j" = "add sub-scale -0.1";

          mbtn_right = "script-binding uosc/menu";
          a = "script-binding uosc/stream-quality";
          c = "script-binding uosc/chapters";
          s = "script-binding uosc/subtitles";

          WHEEL_UP = "ignore";
          WHEEL_DOWN = "ignore";
          WHEEL_LEFT = "ignore";
          WHEEL_RIGHT = "ignore";
        };
        config = {
          fullscreen = true;
          screenshot-directory = "~/pictures/mpv";
          osc = false;
          ignore-path-in-watch-later-config = true;
          save-position-on-quit = "yes";
          volume = 100;
          volume-max = 200;

          audio-file-auto = "fuzzy";

          ytdl = true;
        };
        profiles = {
          "protocol.http".force-window = "immediate";
          "protocol.https".profile = "protocol.http";

          "extension.gif" = {
            cache = false;
            loop-file = true;
          };
          "extension.png" = {
            profile = "extension.gif";
            video-aspect-override = 0;
          };
          "extension.jpeg".profile = "extension.png";
          "extension.jpg".profile = "extension.png";
        };
        scriptOpts = {
          uosc = {
            timeline_size = 25;
            timeline_persistency = "paused,audio";
            progress_size = 4;
            progress_line_width = 4;
            controls = "subtitles,<has_many_audio>audio,<has_many_video>video,<has_many_edition>editions,<stream>stream-quality,gap,space,speed,<has_playlist>playlist,space,fullscreen";
            top_bar = "never";
            refine = "text_width";
          };
          thumbfast = {
            spawn_first = true;
            network = true;
            hwdec = true;
          };
          webtorrent = {
            path = "~/downloads";
          };
        };
      };
      xdg.mimeApps.defaultApplications = {
        "video/mp4" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop";
        "video/x-ms-wmv" = "mpv.desktop";
        "video/x-flv" = "mpv.desktop";
        "video/x-m4v" = "mpv.desktop";
        "video/3gpp" = "mpv.desktop";
        "video/3gpp2" = "mpv.desktop";
        "video/x-matroska-3d" = "mpv.desktop";
        "video/x-ms-asf" = "mpv.desktop";
        "video/x-ms-wvx" = "mpv.desktop";
        "video/x-ms-wmx" = "mpv.desktop";
        "video/x-ms-wm" = "mpv.desktop";
        "video/x-ms-wmp" = "mpv.desktop";
        "video/x-ms-wmz" = "mpv.desktop";
      };
    };
  };
}
