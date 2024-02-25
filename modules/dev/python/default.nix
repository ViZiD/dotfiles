{ pkgs, ... }:
{
  home-manager.users.radik = {
    home.packages = with pkgs; [
      (python312.withPackages (ps: [ pipenv virtualenv pdm ]))
    ];
  };
}
