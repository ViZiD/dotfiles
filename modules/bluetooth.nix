{ pkgs, ... }:
{
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

  home-manager.users.radik =
    let headphones = "41:42:17:F0:AB:04";
    in
    {
      programs.zsh.shellAliases = {
        "hpc" = "bluetoothctl connect ${headphones}";
        "hpd" = "bluetoothctl disconnect ${headphones}";
      };
    };
}
