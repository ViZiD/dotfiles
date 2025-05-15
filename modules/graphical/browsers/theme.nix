{ config, ... }:
with config.stylix.fonts;
{
  colors = {
    webpage.preferred_color_scheme = config.stylix.polarity;
  };
  fonts = {
    default_family = sansSerif.name;
    default_size = "${toString sizes.applications}pt";

    web = {
      family = {
        cursive = serif.name;
        fantasy = serif.name;
        fixed = monospace.name;
        sans_serif = sansSerif.name;
        serif = serif.name;
        standard = sansSerif.name;
      };

      # https://github.com/danth/stylix/blob/b460904a6fc6273345d5e2525dc89ec033d68be9/modules/qutebrowser/hm.nix#L254C5-L272C11
      # TODO: Use the pixel unit:
      # https://github.com/danth/stylix/issues/251.
      size.default = builtins.floor (sizes.applications * 4 / 3 + 0.5);
    };
  };
}
