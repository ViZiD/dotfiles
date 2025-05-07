{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.wireless;
  persist = config.dots.shared.persist;
in
{
  options.dots.shared.wireless.enable = mkEnableOption "Enable wireless";
  config = mkIf cfg.enable {
    dots.shared.persist = mkIf persist.enable {
      system = {
        directories = [
          {
            directory = "/var/lib/iwd";
            mode = "0700";
          }
        ];
      };
    };

    networking.wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
        Network = {
          EnableIPv6 = false;
        };
        Scan = {
          DisablePeriodicScan = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      iwgtk
      impala
    ];
  };
}
