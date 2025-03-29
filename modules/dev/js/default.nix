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

  nixPkgs = with pkgs.nodePackages; [
    eslint_d
    prettier
    typescript
    typescript-language-server
  ];
in
{
  options.dots.dev.js.enable = mkEnableOption "Enable js dev packages";
  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages =
        with pkgs;
        [
          nodejs_latest
          yarn
          pnpm
        ]
        ++ nixPkgs;
    };
  };
}
