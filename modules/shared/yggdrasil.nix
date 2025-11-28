{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.yggdrasil;
in
{
  options.dots.shared.yggdrasil.enable = mkEnableOption "Enable Yggdrasil network";
  config = mkIf cfg.enable {
    services.yggdrasil = {
      enable = true;
      package = pkgs.yggdrasil;
      settings.Peers = [
        # Yekaterinburg peers
        "tcp://ekb.itrus.su:7991"
        "tls://ekb.itrus.su:7992"
        "quic://ekb.itrus.su:7993"

        # Additional Russian peers for redundancy
        "tcp://itcom.multed.com:7991" # Krasnoyarsk
        "tcp://msk1.neonxp.ru:7991" # Moscow
      ];
      settings.IfName = "yggd";
    };
  };
}
