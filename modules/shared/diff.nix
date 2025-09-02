{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.diff;
in
{
  options.dots.shared.diff.enable = mkEnableOption "Show diff between generations on activation";
  config = mkIf cfg.enable {
    system.activationScripts.diff = {
      supportsDryActivation = true;
      text = ''
        if [[ -e /run/current-system ]]; then
          ${lib.getExe pkgs.dix} /run/current-system "$systemConfig"
        fi
      '';
    };
  };
}
