{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.bluetooth;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
  headphones = "18:AA:0F:C9:D0:29";
in
{
  options.dots.shared.bluetooth.enable = mkEnableOption "Enable bluetooth support";
  config = mkIf cfg.enable {
    dots.shared.persist.system = mkIf isPersistEnabled {
      directories = [
        "/var/lib/bluetooth"
      ];
    };

    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez;

      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
    home-manager.users.${user.username} = {
      programs.zsh.shellAliases = mkIf (user.enable && config.dots.base.zsh.enable) {
        "hpc" = "bluetoothctl connect ${headphones}";
        "hpd" = "bluetoothctl disconnect ${headphones}";
      };
    };
  };
}
