{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.cli.bw;
  user = config.dots.user;
in
{
  options.dots.cli.bw.enable = mkEnableOption "Enable bitwarden password manager";
  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      programs.rbw = {
        enable = true;
        settings = {
          base_url = "https://vault.vizqq.cc";
          email = "vizid1337@gmail.com";
          lock_timeout = 86400;
          pinentry = config.dots.cli.gpg.pinentryPackage;
        };
      };
    };
  };
}
