{
  config,
  lib,
  pkgs,
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
      nl4 = {
        config = ''
          config ${config.age.secrets.vpn.path}
        '';
        autoStart = false;
      };
    };
  };
}
