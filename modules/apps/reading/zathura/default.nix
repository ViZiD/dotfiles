{
  home-manager.users.radik = {
    programs.zathura = {
      enable = true;

      options = {
        selection-clipboard = "clipboard";
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        statusbar-home-tilde = true;
        page-padding = 0;
      };

      extraConfig = ''
        map u scroll half-up
        map d scroll half-down
        map D toggle_page_mode
        map r reload
        map R rotate
        map K zoom in
        map J zoom out
        map i recolor
        map p print
      '';
    };
  };
}
