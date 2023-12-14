{
  home-manager.users.radik = {
    services.picom = {
      enable = true;
      fade = true;
      fadeSteps = [ 1 1 ];
      fadeDelta = 50;
      settings = {
        # fix this ugly shit
        # https://github.com/orgs/regolith-linux/discussions/949
        menu = { shadow = false; };
      };
    };
  };
}
