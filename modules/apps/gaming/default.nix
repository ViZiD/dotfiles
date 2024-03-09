{ pkgs, config, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extraCompatPackages = with pkgs.nix-gaming; [
      proton-ge
    ];
  };

  home-manager.users.radik = {
    home.packages = with pkgs; [
      config.nur.repos.materus.polymc
      steamguard-cli
    ];
  };
}
