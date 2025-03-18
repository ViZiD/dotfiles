{
  config,
  lib,
  # pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.reading;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
  isPersistEnabled = config.dots.shared.persist.enable;

  associations = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "application/epub+zip" = "org.pwmt.zathura.desktop";
    "application/postscript" = "org.pwmt.zathura.desktop";
    "application/vnd.comicbook-rar" = "org.pwmt.zathura.desktop";
    "image/vnd.djvu" = "org.pwmt.zathura.desktop";
  };
in
{
  options.dots.graphical.reading.enable = mkEnableOption "Enable reading stuff";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf (user.enable && isPersistEnabled) {
      directories = [
        ".local/share/zathura"
      ];
    };
    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled { zathura.enable = true; };
      programs = {
        zathura = {
          enable = true;

          options = {
            selection-clipboard = "clipboard";
            statusbar-h-padding = 0;
            statusbar-v-padding = 0;
            statusbar-home-tilde = true;
            page-padding = 0;
          };

          extraConfig = ''
            map u scroll half-up
            map d scroll half-down
            map D toggle_page_mode
            map r reload
            map R rotate
            map K zoom in
            map J zoom out
            map i recolor
            map p print
          '';
        };
      };
      xdg.mimeApps = {
        defaultApplications = associations;
        associations.added = associations;
      };
    };
  };
}
