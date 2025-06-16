{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.user.xdg;
  user = config.dots.user;
  username = user.username;
  homeDir = "/home/${username}";
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.user.xdg = {
    enable = mkEnableOption "Enable xdg dir";
  };

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf (user.enable && isPersistEnabled) {
      directories = [
        "documents"
        "downloads"
        "music"
        "pictures"
        "share"
        "templates"
        "videos"
        "tmp"
      ];
    };
    home-manager.users.${username}.xdg.userDirs = mkIf user.enable {
      enable = true;
      createDirectories = true;
      desktop = "${homeDir}/";
      documents = "${homeDir}/documents/";
      download = "${homeDir}/downloads/";
      music = "${homeDir}/music/";
      pictures = "${homeDir}/pictures/";
      publicShare = "${homeDir}/share/";
      templates = "${homeDir}/templates/";
      videos = "${homeDir}/videos/";
      extraConfig = {
        XDG_TMP_DIR = "${homeDir}/tmp/";
        XDG_CACHE_HOME = "${homeDir}/.cache";
        XDG_CONFIG_HOME = "${homeDir}/.config";
        XDG_DATA_HOME = "${homeDir}/.local/share";
        XDG_STATE_HOME = "${homeDir}/.local/state";
      };
    };
  };
}
