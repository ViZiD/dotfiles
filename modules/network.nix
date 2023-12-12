{
  networking = {
    networkmanager.enable = true;
    interfaces = {
      eth0.useDHCP = true;
      wlan0.useDHCP = true;
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 8080 443 ];
    };
  };
  programs.nm-applet.enable = true;
}
