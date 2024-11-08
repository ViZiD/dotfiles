{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.styles;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  options.dots.styles.enable = mkEnableOption "Enable stylix config";

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      dejavu_fonts
      twemoji-color-font
    ];
    stylix = {
      enable = true;
      autoEnable = false;
      image = ./bgg.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
      polarity = "dark";
      cursor = {
        package = pkgs.simp1e-cursors;
        name = "Simp1e";
        size = 16;
      };
      fonts = {
        serif = {
          package = pkgs.nerdfonts.override {
            fonts = [
              "Hack"
              "VictorMono"
              "FiraCode"
              "IBMPlexMono"
            ];
          };
          name = "BlexMono Nerd Font";
        };

        sansSerif = config.stylix.fonts.serif;

        monospace = {
          inherit (config.stylix.fonts.serif) package;
          name = "BlexMono Nerd Font Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          terminal = 12;
        };
      };
    };
  };
}
