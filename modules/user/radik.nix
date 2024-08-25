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
  hashedPassword = "$y$j9T$gNjWUanV5/x8SEzTHU.80.$8.JskQA9.fmDxgAr3I1T78.DKYQmr0gKQEC9yFqKWl6";
  useDefaultShell = true;
  openssh.authorizedKeys.keys = authorizedKeys;
}
