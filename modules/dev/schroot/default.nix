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
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.dev.schroot.enable = mkEnableOption "Enable schroot config";
  config = mkIf cfg.enable {
    dots.shared.persist.system = mkIf (isPersistEnabled && user.enable) {
      directories = [
        "/srv/chroot"
      ];
    };
    programs.schroot = {
      enable = true;
      settings = {
        "trixie" = {
          type = "directory";
          description = "Debian Trixie 13";
          directory = "/srv/chroot/trixie";
          users = "radik";
          root-users = "radik";
          personality = "linux";
          preserve-environment = true;
          profile = "default";
          shell = "/bin/bash";
          command-prefix = "${pkgs.libeatmydata}/bin/eatmydata";
        };
      };
      profiles.default = {
        nssdatabases = [
          "passwd"
          "shadow"
          "group"
          "services"
          "protocols"
          "hosts"
        ];
        fstab = pkgs.writeText "fstab" ''
          /nix            /nix            none    ro,bind         0       0
          /proc           /proc           none    rw,bind         0       0
          /sys            /sys            none    rw,bind         0       0
          /dev            /dev            none    rw,bind         0       0
          /dev/pts        /dev/pts        none    rw,bind         0       0
          /home           /home           none    rw,bind         0       0
          /tmp            /tmp            none    rw,bind         0       0
        '';
        copyfiles = [
          "/etc/resolv.conf"
          "/etc/locale.conf"
        ];
      };
    };
  };
}
