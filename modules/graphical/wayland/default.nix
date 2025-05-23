{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.wayland;
  user = config.dots.user;
in
{
  imports = [
    ./waybar
    ./niri
  ];

  options.dots.graphical.wayland.enable = mkEnableOption "Enable wayland config";

  config = mkIf cfg.enable {
    dots.graphical = {
      niri.enable = true;
      waybar.enable = true;
    };

    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = with pkgs; [
        wev
        wl-clipboard
      ];
    };
  };
}
