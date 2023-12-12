{
  home-manager.users.radik = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;

      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
    };
  };
}
