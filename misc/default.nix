{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.styles;
  fontsCfg = config.dots.styles.fonts;

  colorType = types.addCheck types.str (x: !isNull (builtins.match "[0-9a-fA-F]{6}" x));
  color = mkOption { type = colorType; };

  fontOptions = {
    options = {
      family = mkOption { type = types.str; };
      size = mkOption { type = types.int; };
    };
  };

  defaultFontsModule = {
    options = {
      main = mkOption {
        type = types.submodule fontOptions;
      };
      serif = mkOption {
        type = types.submodule fontOptions;
      };
      mono = mkOption {
        type = types.submodule fontOptions;
      };
      emoji = mkOption {
        type = types.listOf types.str;
        default = [
          "Noto Color Emoji"
          "Twitter Color Emoji"
        ];
      };
    };
  };

  fontsModule = {
    options = {
      enable = mkEnableOption "Enable fonts";
      packages = mkOption {
        type = types.listOf types.package;
        description = "List of font packages that will be installed on the system";
        default = with pkgs; [
          dejavu_fonts
          noto-fonts-emoji
          twemoji-color-font
          ibm-plex
          (nerdfonts.override {
            fonts = [
              "Hack"
              "VictorMono"
              "FiraCode"
            ];
          })
        ];
      };
      defaultFonts = mkOption {
        type = types.submodule defaultFontsModule;
      };
    };
  };
in
{
  options.dots.styles = {
    fonts = mkOption {
      type = types.submodule fontsModule;
    };
    colors = builtins.listToAttrs (
      map
        (name: {
          inherit name;
          value = color;
        })
        [
          "base00"
          "base01"
          "base02"
          "base03"
          "base04"
          "base05"
          "base06"
          "base07"
          "base08"
          "base09"
          "base0A"
          "base0B"
          "base0C"
          "base0D"
          "base0E"
          "base0F"
        ]
    );
  };

  config = {
    fonts = mkIf fontsCfg.enable {
      enableDefaultPackages = true;
      fontDir.enable = true;
      packages = cfg.fonts.packages;
      fontconfig = {
        enable = true;
        defaultFonts = with fontsCfg.defaultFonts; {
          inherit emoji;
          sansSerif = [ "${main.family} ${toString main.size}" ];
          monospace = [ "${mono.family} ${toString mono.size}" ];
          serif = [ "${serif.family} ${toString serif.size}" ];
        };
      };
    };
  };
}
