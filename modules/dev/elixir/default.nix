{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.dev;
  user = config.dots.user;
in
{
  options.dots.dev.elixir.enable = mkEnableOption "Enable elixir dev packages";
  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = with pkgs; [
        elixir
        gigalixir
      ];
    };
  };
}
