{ lib, ... }:
{
  services.tftpd.enable = true;
  networking = {
    interfaces = {
      eth0.useDHCP = lib.mkDefault false;
      eth0.ipv4.addresses = lib.mkDefault [
        {
          address = "192.168.0.225";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = lib.mkDefault {
      address = "192.168.0.1";
      interface = "eth0";
    };

    firewall = {
      enable = true;
      allowedTCPPorts = lib.mkDefault [ 69 ];
    };
  };
}
