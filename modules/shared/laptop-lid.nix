{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.laptopLid;
in
{
  options.dots.shared.laptopLid.enable = mkEnableOption "Enable laptop lid config";
  config = mkIf cfg.enable {
    services = {
      upower.enable = true;
      logind = {
        settings.Login.HandleLidSwitch = "suspend";
      };
    };
  };
}
