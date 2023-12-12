{ authorizedKeys, ... }:

{
  isNormalUser = true;
  uid = 1000;
  description = "Радик Исламов";
  home = "/home/radik";
  extraGroups = [
    "wheel"
    "video"
    "audio"
    "jackaudio"
    "networkmanager"
    "input"
    "scanner"
    "lp"

    # access to the serial and USB ports
    "dialout"

    # grant access to Android Debug Bridge (ADB)
    "adbusers"

    "vboxusers"
    "docker"
    "render"
  ];

  createHome = true;
  initialPassword = "whatever";
  useDefaultShell = true;
  openssh.authorizedKeys.keys = authorizedKeys;
}
