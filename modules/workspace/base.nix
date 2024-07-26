{ pkgs, ... }:
{
  home-manager.users.radik = {
    xdg = {
      enable = true;
      userDirs.enable = true;
    };
    home = {
      # deprecated...
      #   activation."mimeapps-remove" = {
      #     before = [ "linkGeneration" ];
      #     after = [ ];
      #     data = "rm -f /home/radik/.config/mimeapps.list";
      #   };
      packages = with pkgs; [ flameshot ];
    };
  };
}
