{
  inputs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.shared.persist;
  user = config.dots.user;
in
{
  options.dots.shared.persist =
    let
      options = param: prefix: {
        directories = mkOption {
          type = types.listOf types.anything;
          default = [ ];
          description = "Directories to pass to environment.persistence attribute for ${param} under ${prefix}";
        };
        files = mkOption {
          type = types.listOf types.anything;
          default = [ ];
          description = "Files to pass to environment.persistence attribute for ${param} under ${prefix}";
        };
      };
    in
    rec {
      enable = mkEnableOption "Enable persist stuff";
      persistRoot = mkOption {
        type = types.path;
        default = "/persist";
      };
      system = options "system" persistRoot;
      user = options "user" persistRoot;
      root = options "root" persistRoot;
    };

  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  config = mkIf cfg.enable {
    # Work around https://github.com/nix-community/impermanence/issues/229
    boot.initrd.systemd.suppressedUnits = [ "systemd-machine-id-commit.service" ];
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

    environment.persistence.${cfg.persistRoot} = {
      directories = [
        "/var/lib/nixos"
      ] ++ cfg.system.directories;
      files = [
        "/etc/machine-id"
      ] ++ cfg.system.files;

      users.root = {
        inherit (config.users.users.root) home;
        inherit (cfg.root) directories files;
      };

      users.${user.username} = mkIf user.enable {
        inherit (cfg.user) directories files;
      };
    };
  };
}
