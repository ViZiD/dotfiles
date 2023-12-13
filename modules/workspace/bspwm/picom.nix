{
  home-manager.users.radik = {
    services.picom = {
      enable = true;
      settings = {
        # fix this ugly shit
        # https://github.com/orgs/regolith-linux/discussions/949
        menu = { shadow = false; };
      };
    };
  };
}
