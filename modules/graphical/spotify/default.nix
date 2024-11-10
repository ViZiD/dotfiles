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
  isPersistEnabled = config.dots.shared.persist.enable;

  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  options.dots.graphical.spotify.enable = mkEnableOption "Enable spotify app";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".config/spotify"
      ];
    };

    home-manager.users.${user.username} = mkIf user.enable {
      imports = [ inputs.spicetify-nix.homeManagerModules.default ];

      programs = {
        spicetify = {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            autoSkipVideo
            shuffle
          ];
          spotifyLaunchFlags = "--enable-features=WaylandWindowDecorations";
        };
        ncspot = {
          enable = true;
          # wait merge in stable
          package = pkgs.master.ncspot;
          settings = {
            username_cmd = "echo vizidd@gmail.com";
            device_name = config.networking.hostName;
            password_cmd = "${pkgs.coreutils}/bin/cat ${config.age.secrets."spotify".path}";
          };
        };

      };
      stylix.targets = mkIf isStylesEnabled {
        spicetify.enable = true;
        ncspot.enable = true;
      };
    };
  };
}
