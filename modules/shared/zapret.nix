{
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
      httpSupport = false;
      udpSupport = true;
      udpPorts = [
        "50000:50099"
      ];
      blacklist = [
        "ru-board.com"
      ];
      params = [
        "--dpi-desync-repeats=2" # fix youtube
        "--dpi-desync-ttl=3" # fix ssl
        "--dpi-desync=syndata,fake,split2"
        "--dpi-desync-fooling=md5sig"
        "--dpi-desync-any-protocol"
      ];
    };
  };
}
