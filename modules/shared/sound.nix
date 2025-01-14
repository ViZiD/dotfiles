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
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;

    };
    home-manager.users.${user.username} = mkIf user.enable {
      services.playerctld.enable = true;
      services.mpris-proxy.enable = true;
      home.packages = with pkgs; [
        pavucontrol
      ];
    };
  };
}
