{
  home-manager.users.radik.programs.kitty = {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      size = 12.0;
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

      # shell_integration = "no-cursor";
    };

    extraConfig = ''
      background #191919
      foreground #c4c4b5
      cursor #f6f6ec
      selection_background #343434
      color0 #191919
      color8 #615e4b
      color1 #f3005f
      color9 #f3005f
      color2 #97e023
      color10 #97e023
      color3 #fa8419
      color11 #dfd561
      color4 #9c64fe
      color12 #9c64fe
      color5 #f3005f
      color13 #f3005f
      color6 #57d1ea
      color14 #57d1ea
      color7 #c4c4b5
      color15 #f6f6ee
      selection_foreground #191919
    '';
    keybindings = {
      "ctrl+shift+c" = "copy_or_interrupt";
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+v" = "paste_from_clipboard";
    };
  };
}
