{ pkgs, ... }:
{
  home-manager.users.radik = {
    home.packages = with pkgs; [
      (python312.withPackages (ps: [ virtualenv ]))
      pdm
    ];
  };
}
