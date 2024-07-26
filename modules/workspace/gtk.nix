{ config, pkgs, ... }:
{

  programs.dconf.enable = true;

  home-manager.users.radik = {
    # TODO: make own theme
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      theme = {
        name = "amarena";
        package = (pkgs.spacx-gtk-theme.override { theme = "amarena"; });
      };

      font = {
        name = with config.themes.fonts; main.family;
        size = with config.themes.fonts; main.size;
      };
    };
    home.sessionVariables.GTK_THEME = "amarena";
  };
}
