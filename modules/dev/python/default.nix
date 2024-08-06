{ pkgs, ... }:
{
  home-manager.users.radik = {
    home.packages = with pkgs; [
      (python311.withPackages (ps: [ virtualenv ]))
      pdm
      poetry
      # mypy
    ];
  };
}
