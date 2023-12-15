{ pkgs, ... }:
let
  run_polybar = pkgs.writeShellScriptBin "run_polybar" ''
    killall -q polybar

    polybar -q main
  '';

  run_wallpaper = pkgs.writeShellScriptBin "run_wallpaper" ''
    killall -q feh

    feh --bg-fill ${../wallpaper/bgg.jpg}
  '';
in
{
  services.xserver.displayManager.startx.enable = true;

  home-manager.users.radik = {
    home.packages = with pkgs; [
      run_polybar
      run_wallpaper
    ];

    home.activation.bspwm = ''
      $DRY_RUN_CMD mkdir -p "$XDG_DATA_HOME/.npm-packages"
    '';

    # run bspwm without dm
    home.file.".xinitrc".text = ''
      systemctl --user import-environment DISPLAY XAUTHORITY
      xsetroot -cursor_name coffee_mug

      exec bspwm
    '';

    xsession.windowManager.bspwm = {
      enable = true;

      extraConfigEarly = "bspc monitor -d 1 2 3 4 5 6 7 8 9 10";

      startupPrograms = [
        "sxhkd"
        "flameshot"
        "run_wallpaper"
        "run_polybar"
      ];

      settings = {
        border_width = 0;
        window_gap = 0;
        split_ratio = 0.52;
        borderless_monocle = true;
        gapless_monocle = true;
      };

      rules = {
        "Thunar" = {
          state = "floating";
          sticky = true;
          follow = false;
          focus = true;
        };
        "Spotify" = {
          desktop = "^4";
          state = "floating";
          rectangle = "970x740+0+28-396+28-396-0+0-0";
        };
        "discord" = {
          desktop = "^5";
          state = "floating";
        };
        "Google-chrome" = {
          desktop = "^2";
          state = "floating";
        };
        "firefox" = {
          desktop = "^2";
          state = "floating";
        };
        "Code" = {
          desktop = "^3";
          state = "floating";
        };
        "TelegramDesktop" = {
          desktop = "^5";
          state = "floating";
          rectangle = "396x740+970+28-0+28-0-0+970-0";
        };
        "PolyMC" = {
          desktop = "^6";
          state = "floating";
        };
        "Zathura" = {
          state = "fullscreen";
        };
        "feh" = {
          state = "floating";
          sticky = true;
          follow = false;
          focus = true;
        };
        "File-roller" = {
          state = "floating";
          sticky = true;
          follow = false;
          focus = true;
        };
      };
    };
  };
}
