{ pkgs, ... }:
{
  home-manager.users.radik = {
    home.packages = with pkgs; [
      (python3.withPackages (ps: [ pipenv virtualenv ]))
    ];
  };
}
