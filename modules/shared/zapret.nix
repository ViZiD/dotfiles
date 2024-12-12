{
  self,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.zapret;
in
{

  options.dots.shared.zapret.enable = mkEnableOption "Enable zapret dpi bypass";
  config = mkIf cfg.enable {
    services.zapret = {
      enable = true;
      udpSupport = true;
      udpPorts = [
        "50000:50099"
        "443"
      ];
      params = [
        "--filter-udp=50000-50099"
        "--dpi-desync=fake"
        "--dpi-desync-any-protocol"
        "--new"
        "--filter-udp=443"
        "--dpi-desync-fake-quic=${self}/modules/shared/quic_initial_www_google_com.bin"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=2"
        "--new"
        "--filter-tcp=80,443"
        "--dpi-desync=fake,multidisorder"
        "--dpi-desync-ttl=3"
      ];
    };
  };
}
