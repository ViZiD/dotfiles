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
        spotify-player = {
          enable = true;
          settings = {
            device = {
              volume = 100;
              autoplay = true;
            };
          };
          keymaps = [
            {
              command = "Repeat";
              key_sequence = "g .";
            }
          ];
        };
        spicetify = {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            autoSkipVideo
            shuffle
            history
          ];
          spotifyLaunchFlags = mkIf config.dots.graphical.wayland.enable "--enable-features=WaylandWindowDecorations";
        };
      };
      stylix.targets = mkIf isStylesEnabled {
        spicetify.enable = true;
        spotify-player.enable = true;
      };
    };
  };
}
