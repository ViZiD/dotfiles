{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.base.ssh;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.base.ssh.enable = mkEnableOption "Enable ssh config";
  config = mkIf cfg.enable {

    dots.shared.persist = mkIf isPersistEnabled {
      system = {
        files = [
          "/etc/ssh/id_rsa"
          "/etc/ssh/id_rsa.pub"
          "/etc/ssh/id_ed25519"
          "/etc/ssh/id_ed25519.pub"
        ];
      };
      user = mkIf user.enable {
        directories = [
          {
            directory = ".ssh";
            mode = "0700";
          }
        ];
      };
    };
    home-manager.users.${user.username} = mkIf user.enable {
      programs.ssh = {
        enable = true;
        addKeysToAgent = "yes";
      };
    };
  };
}
