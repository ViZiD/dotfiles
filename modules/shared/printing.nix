{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.printing;
  captdriver = pkgs.nixpkgs-24-05.callPackage ./captdriver.nix { };
in
{
  options.dots.shared.printing.enable = mkEnableOption "Enable printer stuff";
  disabledModules = [
    "services/printing/cupsd.nix"
    "services/printing/ipp-usb.nix"
    "services/printing/cups-pdf.nix"
  ];

  imports =
    map
      (
        m:
        lib.modules.importApply m {
          pkgs = pkgs.nixpkgs-24-05;
          inherit lib config;
        }
      )
      [
        "${inputs.nixpkgs-24-05}/nixos/modules/services/printing/cupsd.nix"
        "${inputs.nixpkgs-24-05}/nixos/modules/services/printing/ipp-usb.nix"
        "${inputs.nixpkgs-24-05}/nixos/modules/services/printing/cups-pdf.nix"
      ];

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
        drivers = [
          captdriver
        ];
      };
    };
  };
}
