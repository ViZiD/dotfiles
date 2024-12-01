{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.zapret;
in
{
  disabledModules = [ "services/networking/zapret.nix" ];
  imports = [ "${inputs.nixpkgs-master}/nixos/modules/services/networking/zapret.nix" ];

  options.dots.shared.zapret.enable = mkEnableOption "Enable zapret dpi bypass";
  config = mkIf cfg.enable {
    services.zapret = {
      enable = true;
      httpSupport = false;
      udpSupport = true;
      udpPorts = [
        "50000:50099"
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
