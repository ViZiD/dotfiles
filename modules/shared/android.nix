{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.android;
in
{
  options.dots.shared.android.enable = mkEnableOption "Enable android debug support";

  config = mkIf cfg.enable {
    programs.adb.enable = true;
    services.udev.packages = [ pkgs.android-udev-rules ];
  };
}
