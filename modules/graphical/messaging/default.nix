{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.messaging;
  user = config.dots.user;

  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.messaging.enable = mkEnableOption "Enable messaging config";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      xdg.mimeApps = rec {
        defaultApplications = {
          "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
        };
        associations.added = defaultApplications;
      };
      home.packages = with pkgs; [
        telegram-desktop
        master.fluffychat
      ];
    };

    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".local/share/TelegramDesktop/tdata"
        ".local/share/chat.fluffy.fluffychat"
      ];
    };
  };
}
