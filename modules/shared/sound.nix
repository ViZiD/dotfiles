{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.shared.sound;
  user = config.dots.user;
in
{
  options.dots.shared.sound.enable = mkEnableOption "Enable sound support";

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = lib.mkForce false;

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = with pkgs; [
        alsa-utils
        playerctl
        pavucontrol
        alsa-oss
      ];
    };
  };
}
