{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.wireless;
  isDesktop = config.dots.graphical.enable;
  user = config.dots.user;
in
{
  options.dots.shared.wireless.enable = mkEnableOption "Enable wireless";
  config = mkIf cfg.enable {
    networking.wireless = {
      enable = true;
      fallbackToWPA2 = false;
      secretsFile = config.age.secrets.wireless.path;
      networks = {
        "HUAWEI-scKJ" = {
          pskRaw = "ext:home_pass";
        };
      };
      allowAuxiliaryImperativeNetworks = true;
      userControlled = {
        enable = true;
        group = "network";
      };
    };

    users.groups.network = { };

    home-manager.users.${user.username}.home.packages = mkIf (isDesktop && user.enable) [
      pkgs.wpa_supplicant_gui
    ];
  };
}
