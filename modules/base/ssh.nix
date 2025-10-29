{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.base.ssh;
  user = config.dots.user;
  persist = config.dots.shared.persist;
  basePath = if persist.enable then "${persist.persistRoot}/etc/ssh" else "/etc/ssh";
  socketDir = "/run/user/%i/gnupg";
  forwardGpg = {
    forwardAgent = true;
    remoteForwards = [
      {
        bind.address = "${socketDir}/S.gpg-agent";
        host.address = "${socketDir}/S.gpg-agent.extra";
      }
      {
        bind.address = "${socketDir}/S.gpg-agent.ssh";
        host.address = "${socketDir}/S.gpg-agent.ssh";
      }
    ];
  };
in
{
  options.dots.base.ssh.enable = mkEnableOption "Enable ssh config";
  config = mkIf cfg.enable {

    dots.shared.persist = mkIf persist.enable {
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
    services.openssh.hostKeys = [
      {
        bits = 4096;
        path = "${basePath}/id_rsa";
        type = "rsa";
      }
      {
        path = "${basePath}/id_ed25519";
        type = "ed25519";
      }
    ];
    home-manager.users.${user.username} = mkIf user.enable {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "debian-vm" = {
            hostname = "192.168.122.144";
            user = "radik";
          }
          // forwardGpg;
          "git-hosts" = {
            host = "github.com gitlab.com codeberg.org";
            user = "git";
          };
          "light-vps" = {
            hostname = "light.vizqq.cc";
            user = "radik";
          };
          "*" = {
            compression = false;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
            hashKnownHosts = false;
            userKnownHostsFile = "~/.ssh/known_hosts";
            controlMaster = "no";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "no";
          };
        };
      };
    };
  };
}
