{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.printing;
  isPersistEnable = config.dots.shared.persist.enable;
in
{
  options.dots.shared.printing.enable = mkEnableOption "Enable printer stuff";
  config = mkIf cfg.enable {

    dots.shared.persist.user = mkIf (config.dots.graphical.enable && isPersistEnable) {
      files = [
        ".config/skanliterc"
      ];
    };

    dots.user.userPackages = mkIf config.dots.graphical.enable [
      pkgs.kdePackages.skanlite
    ];

    hardware.sane = {
      enable = true;
      extraBackends = with pkgs; [
        sane-airscan
        hplipWithPlugin
      ];
      netConf = "172.16.1.2";
    };
    services = {
      printing = {
        enable = true;
        drivers = with pkgs; [ hplipWithPlugin ];
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
      };
    };
  };
}
