{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.printing;
  captdriver = pkgs.stable.callPackage ./captdriver.nix { };
in
{
  options.dots.shared.printing.enable = mkEnableOption "Enable printer stuff";

  config = mkIf cfg.enable {
    hardware.printers.ensurePrinters = [
      {
        name = "L11121E";
        location = "Home";
        deviceUri = "usb://Canon/LBP2900?serial=0000A27773TO";
        model = "canon/CanonLBP-2900-3000.ppd";
        ppdOptions = {
          PageSize = "A4";
          captTonerSave = "False";
          captManualDuplex = "True";
        };
      }
    ];
    services = {
      printing = {
        enable = true;
        logLevel = "debug";
        package = pkgs.stable.cups;
        drivers = [
          captdriver
        ];
      };
    };
  };
}
