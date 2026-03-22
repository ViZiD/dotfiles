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
        delay = 5;
        show_cpu_frequency = true;
        show_cpu_usage = true;
        tree_view = true;
        hide_userland_threads = true;
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
