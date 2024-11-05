{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.spotify;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.graphical.spotify.enable = mkEnableOption "Enable spotify app";

  config = mkIf cfg.enable {

    home-manager.users.${user.username} = mkIf user.enable {
      programs.ncspot = {
        enable = true;
        # wait merge in stable
        package = pkgs.master.ncspot;
        settings = {
          username_cmd = "echo vizidd@gmail.com";
          device_name = config.networking.hostName;
          password_cmd = "${pkgs.coreutils}/bin/cat ${config.age.secrets."spotify".path}";
        };
      };
      stylix.targets = mkIf isStylesEnabled { ncspot.enable = true; };
    };
  };
}
