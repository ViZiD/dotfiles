{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.virt;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.shared.virt.enable = mkEnableOption "Enable virtualization stuff";
  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        "VirtualBox VMs"
      ];
    };
    users.extraGroups.vboxusers.members = [ user.username ];

    virtualisation = {
      virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = true;
        };
      };
    };
  };
}
