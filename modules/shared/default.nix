{ ... }:
{
  imports = [
    ./quietboot.nix
    ./bluetooth.nix
    ./sound.nix
    ./laptop-lid.nix
    ./wireless.nix
    ./persist.nix
    ./printing.nix
    ./zapret.nix
    ./doh.nix
    ./diff.nix
    ./wireguard.nix
    ./kdeconnect.nix
    ./virt.nix
    ./yggdrasil.nix
  ];
}
