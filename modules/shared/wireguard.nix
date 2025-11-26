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
        type = "amneziawg";
        autostart = false;
        address = [
          "10.0.0.3/32"
        ];
        privateKeyFile = config.sops.secrets.wg_key.path;

        extraOptions = {
          H1 = 256;
          H2 = 512;
          H3 = 1024;
          H4 = 2048;
          Jc = 4;
          Jmax = 32;
          Jmin = 16;
          S1 = 16;
          S2 = 17;
        };

        peers = [
          {
            publicKey = "NzVCWTgGNTb6IwJRu62+iScLfviFRn8toj8r156d8GA=";
            allowedIPs = [
              "10.0.0.0/24"
            ];
            endpoint = "light.vizqq.cc:62048";
          }
        ];
      };
    };
  };
}
