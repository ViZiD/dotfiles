{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.kdeconnect;
  user = config.dots.user;
in
{
  options.dots.shared.kdeconnect.enable = mkEnableOption "Enable kdeconnect";

  config = mkIf cfg.enable {
    networking.firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };

    home-manager.users.${user.username} = mkIf user.enable {
      services.kdeconnect.enable = true;
    };
  };
}
