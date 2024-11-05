{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.quietboot;
in
{
  options.dots.shared.quietboot.enable = mkEnableOption "Enable fast and quiet boot loading";

  config = mkIf cfg.enable {
    console.earlySetup = false;
    # console.useXkbConfig = true;

    boot = {
      loader.timeout = 0;
      kernelParams = [
        "quiet"
        "loglevel=3"
        "systemd.show_status=auto"
        "udev.log_level=3"
        "rd.udev.log_level=3"
        "vt.global_cursor_default=0"
      ];
      consoleLogLevel = 0;
      initrd.verbose = false;
    };
  };
}
