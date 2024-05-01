{ pkgs, config, ... }:
{
  fonts = {
    enableDefaultPackages = true;

    fontDir.enable = true;

    packages = with pkgs; [
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

    # source https://github.com/balsoft/nixos-config/
    fontconfig =
      let
        fonts = config.themes.fonts;
      in
      {
        enable = true;
        defaultFonts = {
          monospace = [ "${fonts.mono.family} ${toString fonts.mono.size}" ];
          sansSerif = [ "${fonts.main.family} ${toString fonts.main.size}" ];
          serif = [ "${fonts.serif.family} ${toString fonts.serif.size}" ];
          emoji = [
            "Noto Color Emoji"
            "Twitter Color Emoji"
          ];
        };
      };
  };
  themes.fonts = {
    main = {
      family = "IBM Plex Sans";
      size = 12;
    };
    serif = {
      family = "IBM Plex Serif";
      size = 12;
    };
    mono = {
      family = "IBM Plex Mono";
      size = 12;
    };
  };
}
