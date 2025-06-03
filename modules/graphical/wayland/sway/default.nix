{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.sway;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.graphical.sway.enable = mkEnableOption "Enable sway config";

  config = mkIf cfg.enable {
    security.polkit.enable = true;

    xdg.portal = {
      xdgOpenUsePortal = true;
      wlr.enable = true;
      config.common.default = "*";
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
    };

    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled { sway.enable = true; };

      home.sessionVariables = {
        GDK_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "sway";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      };

      wayland.windowManager.sway = {
        enable = true;
        package = pkgs.nur.repos.vizqq.sway-disable-titlebar;
        wrapperFeatures.gtk = true;
        extraConfig = ''
          default_border none
          disable_titlebar true
        '';
        config = {
          modifier = "Mod4";
          bindkeysToCode = true;
          workspaceLayout = "tabbed";
          defaultWorkspace = "workspace number 1";
          menu = "fuzzel";
          terminal = "${config.dots.graphical.terminal.terminalName}";
          startup = [
            {
              command = "${getExe config.home-manager.users.${user.username}.programs.waybar.package}";
            }
          ];
          bars = [ ];
          input = {
            "type:keyboard" = {
              xkb_layout = "us,ru";
              xkb_model = "pc105";
              xkb_options = "grp:alt_shift_toggle";
            };
            "type:touchpad" = {
              tap = "disabled";
              natural_scroll = "enabled";
              scroll_method = "two_finger";
              click_method = "clickfinger";
              tap_button_map = "lmr";
              dwt = "enabled";
            };
          };
          keybindings = lib.mkOptionDefault {
            "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ --limit 1";
            "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          };
        };
      };
    };
  };
}
