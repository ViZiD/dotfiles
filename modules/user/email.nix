{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.user;
  hm = config.home-manager.users.${cfg.username};
  mbsync = "${hm.programs.mbsync.package}/bin/mbsync";

  isPersistEnabled = config.dots.shared.persist.enable;

  signature = {
    showSignature = "append";
    text = ''
      ${cfg.realName}

      https://vizqq.cc
    '';
  };

  common = {
    inherit (cfg) realName;
    inherit signature;
    msmtp.enable = true;
    neomutt.enable = true;
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };
    folders = {
      inbox = "inbox";
      drafts = "drafts";
      sent = "sent";
      trash = "trash";
    };
  };
in
{
  options.dots.user.mail = {
    enable = mkEnableOption "Enable email accounts";
    mailDir = mkOption {
      type = types.str;
      default = ".maildir";
    };
  };

  config = mkIf cfg.mail.enable {

    dots.shared.persist.user = mkIf (cfg.enable && isPersistEnabled) {
      directories = [
        ".maildir"
      ];
    };

    home-manager.users.${cfg.username} = mkIf cfg.enable {
      programs = {
        neomutt = {
          enable = true;
          vimKeys = true;
          sidebar = {
            enable = true;
          };
          editor = "nvim";
        };
        msmtp.enable = true;
        mbsync.enable = true;
      };
      accounts.email = {
        maildirBasePath = cfg.mail.mailDir;
        accounts = {
          vizqq = {
            address = cfg.email;
            primary = true;
            flavor = "plain";
            userName = cfg.email;
            imap = {
              host = "mail.privateemail.com";
              port = 143;
              tls.useStartTls = true;
            };
            smtp = {
              host = "mail.privateemail.com";
              port = 587;
              tls.useStartTls = true;
            };
            passwordCommand = "${pkgs.coreutils}/bin/cat ${config.age.secrets."email_vizqq".path}";
          } // common;
          vizid1337 = {
            address = "vizid1337@gmail.com";
            flavor = "gmail.com";
            userName = "vizid1337@gmail.com";
            passwordCommand = "${pkgs.coreutils}/bin/cat ${config.age.secrets."email_vizid1337".path}";
          } // common;
          userjs = {
            address = "userjs@ya.ru";
            flavor = "yandex.com";
            userName = "userjs@ya.ru";
            passwordCommand = "${pkgs.coreutils}/bin/cat ${config.age.secrets."email_userjs".path}";
          } // common;
        };
      };

      systemd.user.services.mbsync = {
        Unit = {
          Description = "Mailbox synchronization service";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${mbsync} -Va";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
      systemd.user.timers.mbsync = {
        Unit = {
          Description = "Mailbox synchronization timer";
        };
        Timer = {
          OnBootSec = "2m";
          OnUnitActiveSec = "5m";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };

      home.activation =
        let
          mbsyncAccounts = lib.filter (a: a.mbsync.enable) (lib.attrValues hm.accounts.email.accounts);
          hmLib = inputs.home-manager.lib;
        in
        lib.mkIf (mbsyncAccounts != [ ]) {
          createMaildir = lib.mkForce (
            hmLib.hm.dag.entryAfter [ "linkGeneration" ] ''
              run mkdir -m700 -p $VERBOSE_ARG ${lib.concatMapStringsSep " " (a: a.maildir.absPath) mbsyncAccounts}
            ''
          );
        };
    };
  };
}
