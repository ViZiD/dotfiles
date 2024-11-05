{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.wireguard;
in
{
  options.dots.shared.wireguard.enable = mkEnableOption "Enable wg stuff";
  config = mkIf cfg.enable {
    networking.wg-quick.interfaces = {
      wg0 = {
        address = [
          "10.42.0.95/23"
        ];
        dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        privateKeyFile = config.age.secrets."wireguard_nlpg".path;

        peers = [
          {
            publicKey = "d1YzMRzOibCXEBGaJyxW4Kvucii+nNgs/PYVo1qa7D0=";
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            endpoint = "vpn1-nl.stark-industries.solutions:58100";
          }
        ];
      };
    };
  };
}
