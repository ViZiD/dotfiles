{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-media-tags-plugin
      thunar-archive-plugin
    ];
  };
}
