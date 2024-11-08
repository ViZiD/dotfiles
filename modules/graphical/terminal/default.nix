{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.terminal;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.graphical.terminal = {
    enable = mkEnableOption "Enable graphical terminal settings";
    terminalPackage = mkOption {
      type = types.package;
      default = pkgs.kitty;
      description = "Terminal package to use";
    };
    terminalPath = mkOption {
      type = types.path;
      default = "${cfg.terminalPackage}/bin/${cfg.terminalName}";
      description = "Path to terminal binary";
      readOnly = true;
    };
    terminalName = mkOption {
      type = types.str;
      default = cfg.terminalPackage.meta.mainProgram;
      description = "Binary name of the terminal";
      readOnly = true;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {

      stylix.targets = mkIf isStylesEnabled {
        kitty.enable = true;
      };

      programs.kitty = {
        enable = true;

        environment = {
          TERM = "xterm-256color";
          TERMINAL = cfg.terminalName;
        };

        settings = {
          disable_ligatures = "cursor";

          cursor_shape = "underline";
          cursor_underline_thickness = "1.5";

          scrollback_lines = 5000;

          url_style = "dotted";

          enable_audio_bell = "no";

          tab_title_max_length = 10;

          window_margin_width = 1;

          hide_window_decorations = "yes";

          window_border_width = 0.0;

          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";
          # shell_integration = "no-cursor";
        };

        keybindings = {
          "ctrl+shift+c" = "copy_or_interrupt";
          "ctrl+c" = "copy_to_clipboard";
          "ctrl+v" = "paste_from_clipboard";
        };
      };
    };
  };
}
