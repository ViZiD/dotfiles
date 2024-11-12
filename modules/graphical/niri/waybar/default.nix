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
            height = 28;

            modules-left = [
              # "niri/workspaces"
            ];
            modules-right = [
              "network"
              "niri/language"
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
              format = "{icon} {volume}%";
              format-muted = "󰝟";
              format-icons = {
                default = [
                  "󰕿"
                  "󰖀"
                  "󰕾"
                ];
                max-volume = 100;
                on-scroll-up = "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%";
                on-scroll-down = "${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%";
                tooltip = false;
              };
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
              format = " {:%I:%M %p}";
              format-alt = "󱛡 {:%Y-%m-%d  %I:%M %p}";
              tooltip = false;
            };
          }
        ];
      };
    };
  };
}
