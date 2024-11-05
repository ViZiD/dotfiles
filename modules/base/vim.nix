{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.base.vim;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.base.vim.enable = mkEnableOption "Enable vim editor";
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.neovim
    ];

    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled {
        neovim.enable = true;
      };
      programs.neovim = {
        enable = true;

      };
    };
  };
}
