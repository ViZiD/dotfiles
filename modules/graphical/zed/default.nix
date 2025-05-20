{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.zed;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.zed.enable = mkEnableOption "Enable zed editor";

  config = mkIf cfg.enable {

    dots.shared.persist.user = mkIf isPersistEnabled {
      directories =
        [
        ];
    };

    home-manager.users.${user.username} = mkIf user.enable {

      stylix.targets =
        mkIf isStylesEnabled
          {
          };

      programs.zed-editor = {
        enable = true;
        extensions = [
          "nix"
          "git-firefly"
          "zedokai"
        ];
        extraPackages = with pkgs; [
          nixd
          nixfmt-rfc-style
        ];
        userSettings = rec {
          vim_mode = true;
          telemetry = {
            metrics = false;
          };

          load_direnv = "shell_hook";

          languages = {
            Nix = {
              formatter.external.command = "nixfmt";
              language_servers = [
                "nixd"
                "!nil"
              ];
            };
          };

          # fonts
          buffer_font_family = "FiraCode Nerd Font";
          buffer_font_size = 14.5;
          ui_font_family = buffer_font_family;
          terminal = {
            font_family = "FiraCode Nerd Font Mono";
            font_size = buffer_font_size;
          };

          # ui
          minimap.show = "never";
          scrollbar = {
            axes.horizontal = false;
          };
          cursor_blink = false;

          #theme
          theme = {
            mode = config.stylix.polarity;
            dark = "Zedokai Classic";
            light = "Zedokai Classic";
          };
        };
      };
    };
  };
}
