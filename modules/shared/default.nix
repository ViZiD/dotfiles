{ ... }:
{
  imports = [
    ./quietboot.nix
    ./android.nix
    ./bluetooth.nix
    ./sound.nix
    ./laptop-lid.nix
    ./wireless.nix
    ./persist.nix
    ./printing.nix
    ./zapret.nix
    ./vpn.nix
    ./doh.nix
    ./diff.nix
    ./wireguard.nix
    ./kdeconnect.nix
    ./virt.nix
  ];
}
