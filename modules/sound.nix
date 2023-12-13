{ pkgs, lib, ... }: {
  hardware.pulseaudio.enable = lib.mkForce false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  home-manager.users.radik.home.packages = with pkgs; [
    alsa-utils
    playerctl
  ];
}
