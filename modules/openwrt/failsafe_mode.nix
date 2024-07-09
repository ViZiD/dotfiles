{ lib, ... }:
{
  services.tftpd.enable = true;
  networking = {
    interfaces = {
      eth0.useDHCP = lib.mkDefault false;
      eth0.ipv4.addresses = lib.mkDefault [
        {
          address = "192.168.1.2";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = lib.mkDefault {
      address = "192.168.1.1";
      interface = "eth0";
    };
  };
}
