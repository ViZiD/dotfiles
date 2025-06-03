{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.waybar;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
  niri = getExe config.home-manager.users.${user.username}.programs.niri.package;
  sway = config.home-manager.users.${user.username}.wayland.windowManager.sway.package;
in
{
  options.dots.graphical.waybar.enable = mkEnableOption "Enable waybar";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled { waybar.enable = true; };
      programs.waybar = {
        enable = true;
        style = mkAfter ''
          ${builtins.readFile ./style.css}
        '';
        settings = [
          {
            layer = "top";
            position = "top";
            margin-top = 0;
            margin-bottom = 0;
            height = 25;

            modules-left = [
              "memory"
              "disk"
            ];
            modules-right =
              [
                "network"
                "keyboard-state"
              ]
              ++ lib.optional config.dots.graphical.niri.enable "niri/language"
              ++ lib.optional config.dots.graphical.sway.enable "sway/language"
              ++ [
                "pulseaudio"
                "backlight"
                "battery"
                "clock"
              ];
            "niri/workspaces" = {
              format = "{icon}";
              format-icons = {
                default = "";
                active = "";
              };
            };
            "memory" = {
              interval = 30;
              "format" = " {used:0.1f}G/{total:0.1f}G";
            };
            disk = {
              interval = 30;
              format = " {specific_used:0.1f}G/{specific_total:0.1f}G";
              unit = "GB";
            };
            "keyboard-state" = {
              capslock = true;
              format = {
                capslock = "{icon}";
              };
              format-icons = {
                locked = "󰌎";
                unlocked = "";
              };
            };
            "sway/language" = {
              format = "{shortDescription}";
              on-click = "${sway}/bin/swaymsg input type:keyboard xkb_switch_layout next";
            };
            "niri/language" = {
              format = "{shortDescription}";
              on-click = "${niri} msg action switch-layout next";
            };
            network = {
              format-icons = [
                "󰣴"
                "󰣶"
                "󰣸"
                "󰣺"
              ];
              format-wifi = "{icon}";
              format-ethernet = "{icon}";
              format-disconnected = "󰣼";
              format-linked = "󰣹";
              tooltip-format-wifi = "󰤨 {essid} - {signalStrength}";
              tooltip-format-ethernet = " {ipaddr} - {netmask}";
              tooltip-format-disconnected = "Disconnected :(";
            };
            pulseaudio = {
              format = "{format_source} {icon} {volume}%";
              format-source = " {volume}%";
              format-source-muted = "";
              format-bluetooth = "{icon} 󰂯 {volume}%";
              format-muted = "󰝟";
              format-icons = {
                headphone = "";
                headset = "";
                default = [
                  "󰕿"
                  "󰖀"
                  "󰕾"
                ];
              };
              max-volume = 100;
              on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ --limit 1";
              on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
              on-click = lib.getExe pkgs.pavucontrol;
              tooltip = false;
            };
            backlight = {
              device = "intel_backlight";
              format = "{icon} {percent}%";
              format-icons = [ "󰃝" ];
              tooltip = false;
            };
            battery = {
              full-at = 100;
              tooltip = false;
              format = "{icon} {capacity}%";
              format-charging = "{icon} {capacity}%";
              "states" = {
                low-at = 30;
              };
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
              format-plugged = " {capacity}%";
            };
            clock = {
              format = "󱛡 {:%B %d %A  %I:%M %p}";
              # format-alt = "󱛡 {:%Y-%m-%d  %I:%M %p}";
              tooltip = false;
            };
          }
        ];
      };
    };
  };
}
