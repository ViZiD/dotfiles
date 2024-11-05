{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.base.htop;
  user = config.dots.user;
  base = {
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
in
{
  options.dots.base.htop.enable = mkEnableOption "Enable htop";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.htop ];

    home-manager.users.${user.username} = mkIf user.enable base;

    home-manager.users.root = base;
  };
}
