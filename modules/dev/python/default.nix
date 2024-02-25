{ pkgs, ... }:
{
  home-manager.users.radik = {
    home.packages = with pkgs; [
      python312
      python312Packages.virtualenv
      pdm
    ];
  };
}
