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
  hmConfig = config.home-manager.users.${user.username};
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
      programs.neovim =
        {
          enable = true;
          extraConfig = ''
            syntax on
            filetype plugin on
          '';
        }
        // optionalAttrs (user.mail.enable) {
          plugins = with pkgs.vimPlugins; [
            {
              plugin = himalaya-vim;
              config = ''
                let g:himalaya_executable = "${getExe hmConfig.programs.himalaya.package}"
                let g:himalaya_config_path = "$HOME/.config/himalaya/config.toml"
              '';
            }
          ];
        };
    };
  };
}
