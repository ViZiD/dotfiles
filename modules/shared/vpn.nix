{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.vpn;
in
{
  options.dots.shared.vpn.enable = mkEnableOption "Enable vpn config";
  config = mkIf cfg.enable {
    services.openvpn.servers = {
      nl4tcp = {
        config = ''
          config ${config.vaultix.secrets.vpn_tcp.path}
        '';
        autoStart = false;
      };
      nl4udp = {
        config = ''
          config ${config.vaultix.secrets.vpn_udp.path}
        '';
        autoStart = false;
      };
    };
  };
}
