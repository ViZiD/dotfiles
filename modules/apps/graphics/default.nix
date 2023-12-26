{ pkgs, ... }: {
  home-manager.users.radik = {
    home.packages = with pkgs; [
      inkscape-with-extensions
      krita
    ];
  };
}
