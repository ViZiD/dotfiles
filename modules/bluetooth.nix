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
    let headphones = "18:B9:6E:07:8F:B7";
    in
    {
      programs.zsh.shellAliases = {
        "hpc" = "bluetoothctl connect ${headphones}";
        "hpd" = "bluetoothctl disconnect ${headphones}";
      };
    };
}
