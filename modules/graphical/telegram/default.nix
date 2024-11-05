{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.telegram;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.telegram.enable = mkEnableOption "Enable telegram messenger";

  config = mkIf cfg.enable {
    dots.user.userPackages = [
      pkgs.telegram-desktop
    ];

    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".local/share/TelegramDesktop/tdata"
      ];
    };
  };
}
