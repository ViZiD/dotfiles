{
  home-manager.users.radik.programs.zsh = {
    profileExtra = ''
      if [ -z "''${DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
       exec startx
      fi
    '';
  };
}
