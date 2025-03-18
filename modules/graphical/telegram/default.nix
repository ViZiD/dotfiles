{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.telegram;
  user = config.dots.user;

  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.telegram.enable = mkEnableOption "Enable telegram messenger";

  config = mkIf cfg.enable {
    dots.user.userPackages = [
      pkgs.telegram-desktop
    ];

    home-manager.users.${user.username} = mkIf user.enable {
      xdg.mimeApps = rec {
        defaultApplications = {
          "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
        };
        associations.added = defaultApplications;
      };
    };

    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".local/share/TelegramDesktop/tdata"
      ];
    };
  };
}
