{
  home-manager.users.radik = {
    programs.htop = {
      enable = true;
      settings = {
        vimMode = true;
        delay = 5;
        showCpuFrequency = true;
        showCpuUsage = true;
        treeView = true;
        hideUserlandThreads = true;
      };
    };
  };
}