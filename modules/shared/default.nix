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
    ./wireguard.nix
    ./zapret.nix
  ];
}