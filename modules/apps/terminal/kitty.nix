{
  home-manager.users.radik.programs.kitty = {
    enable = true;

    font = {
      name = "VictorMono Nerd Font";
    };

    extraConfig = ''
      /* Fonts */
      font_family      VictorMono Nerd Font Regular
      bold_font        VictorMono Nerd Font Bold
      italic_font      VictorMono Nerd Font Italic
      bold_italic_font VictorMono Nerd Font Bold Italic

      font_size 12.0

      force_ltr no

      disable_ligatures never

      /* Cursor */
      cursor #cccccc
      corsor_text_color #111111

      cursor_shape underline
      cursor_underline_thickness 1.5

      /* Scrollback */
      scrollback_lines 5000

      /* Mouse */
      url_style dotted

      /* Terminal bell */
      enable_audio_bell no

      /* Windows layout */

      remember_window_size  yes
      initial_window_width  640
      initial_window_height 400

      enabled_layouts *

      window_resize_step_cells 2
      window_resize_step_lines 2

      window_border_width 0.5pt

      draw_minimal_borders yes

      window_margin_width 0

      single_window_margin_width -1

      window_padding_width 0

      placement_strategy center


      active_border_color #00ff00

      inactive_border_color #cccccc


      bell_border_color #ff5a00

      inactive_text_alpha 1.0

      hide_window_decorations no

      window_logo_path none

      window_logo_position bottom-right

      window_logo_alpha 0.5

      resize_debounce_time 0.1

      resize_draw_strategy static

      resize_in_steps no

      visual_window_select_characters 1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ

      confirm_os_window_close -1

      /* Tab bar */

      tab_bar_edge bottom


      tab_bar_margin_width 0.0

      tab_bar_margin_height 0.0 0.0

      tab_bar_style fade

      tab_bar_align left


      tab_bar_min_tabs 2


      tab_switch_strategy previous

      tab_fade 0.25 0.5 0.75 1

      tab_separator " ┇"


      tab_powerline_style angled

      tab_activity_symbol none

      tab_title_max_length 10
      tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"

      active_tab_title_template none


      active_tab_foreground   #000
      active_tab_background   #eee
      active_tab_font_style   bold-italic
      inactive_tab_foreground #444
      inactive_tab_background #999
      inactive_tab_font_style normal


      tab_bar_background none

      tab_bar_margin_color none


      /* Color scheme */
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

      /* Settings */
      shell_integration no-cursor

    '';
    keybindings = {
      "ctrl+shift+c" = "copy_or_interrupt";
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+v" = "paste_from_clipboard";
    };
  };
}
