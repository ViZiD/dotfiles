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

  common = {
    inherit (cfg) realName;
    msmtp.enable = true;
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };
    aerc = {
      enable = true;
      extraAccounts = {
        check-mail-cmd = "${mbsync} -a";
        check-mail = "2m";
        check-mail-timeout = "2m";
      };
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
      home.packages = [
        pkgs.w3m
        pkgs.urlscan
      ];

      programs = {
        msmtp.enable = true;
        mbsync.enable = true;
        aerc = {
          enable = true;
          templates = {
            forward_as_body = ''
              X-Mailer: aerc {{version}}

              {{- with .Signature }}
              {{.}}
              {{- end }}

              ---------- Forwarded message ---------
              From: {{.OriginalFrom | persons | join ", "}}
              Date: {{dateFormat .OriginalDate "Mon Jan 2, 2006 at 3:04 PM"}}

              {{.OriginalText}}
            '';
            quoted_reply = ''
              X-Mailer: aerc {{version}}

              {{- with .Signature }}
              {{.}}
              {{- end }}

              On {{dateFormat (.OriginalDate | toLocal) "Mon Jan 2, 2006 at 3:04 PM MST"}}, {{.OriginalFrom | names | join ", "}} wrote:
              {{ if eq .OriginalMIMEType "text/html" -}}
              {{- exec `html` .OriginalText | trimSignature | quote -}}
              {{- else -}}
              {{- trimSignature .OriginalText | quote -}}
              {{- end}}
            '';
          };
          extraConfig = {
            general = {
              unsafe-accounts-conf = true;
              pgp-provider = "gpg";
              enable-osc8 = true;
            };

            ui = {
              index-columns = "date<20,name<20,flags>4,subject<*";
              timestamp-format = "2006-01-02 15:04";
              sidebar-width = 25;
              mouse-enabled = true;
              fuzzy-complete = true;
            };
            compose = {
              reply-to-self = false;
              # edit-headers = true;
              address-book-cmd = "${pkgs.khard}/bin/khard email --parsable --remove-first-line --search-in-source-files '%s'";
              file-picker-cmd = "${pkgs.yazi}/bin/yazi --chooser-file %f";
            };

            viewer = {
              alternatives = "text/plain,text/html";
              header-layout = "From|To,Cc|Bcc,Date,Subject,DKIM+|SPF+|DMARC+";
            };

            filters = ''
              .headers = ${pkgs.aerc}/libexec/aerc/filters/colorize
              text/calendar = ${pkgs.gawk}/bin/awk -f ${pkgs.aerc}/libexec/aerc/filters/calendar
              text/html = ${pkgs.aerc}/libexec/aerc/filters/html -o display_link_number=true | ${pkgs.aerc}/libexec/aerc/filters/colorize
              text/plain = ${pkgs.aerc}/libexec/aerc/filters/colorize
              text/* = ${pkgs.bat}/bin/bat -fP --file-name="$AERC_FILENAME "
              message/delivery-status = ${pkgs.aerc}/libexec/aerc/filters/colorize
              message/rfc822 = ${pkgs.aerc}/libexec/aerc/filters/colorize
              application/pdf = ${pkgs.zathura}/bin/zathura -
              application/x-sh = ${pkgs.bat}/bin/bat -fP -l sh
              audio/* = ${pkgs.mpv}/bin/mpv -
            '';
          };

          extraBinds = {
            global = {
              "<C-p>" = ":prev-tab<Enter>";
              "<C-n>" = ":next-tab<Enter>";
              "?" = ":help keys<Enter>";
            };

            messages = {
              q = ":quit<Enter>";
              j = ":next<Enter>";
              k = ":prev<Enter>";
              J = ":next-folder<Enter>";
              K = ":prev-folder<Enter>";
              "<Enter>" = ":view<Enter>";
              d = ":delete<Enter>";
              c = ":compose<Enter>";
              r = ":reply -q<Enter>";
              R = ":reply -aq<Enter>";
              "/" = ":search<Enter>";
              gi = ":cf Inbox<Enter>";
              gs = ":cf \"Sent Items\"<Enter>";
            };

            view = {
              q = ":close<Enter>";
              S = ":save<space>";
              f = ":forward<Enter>";
              r = ":reply -q<Enter>";
              R = ":reply -aq<Enter>";
              V = ":pipe -m cat<Enter>";
              u = ":pipe -m urlscan<Enter>";
            };

            compose = {
              "<C-k>" = ":prev-field<Enter>";
              "<C-j>" = ":next-field<Enter>";
              "<Tab>" = ":next-field<Enter>";
            };

            "compose::editor" = {
              "$noinherit" = "true";
              "$ex" = "<C-x>";
            };

            "compose::review" = {
              y = ":send<Enter>";
              n = ":abort<Enter>";
              e = ":edit<Enter>";
              a = ":attach<space>";
              s = ":sign<Enter>";
              E = ":encrypt<Enter>";
            };
          };
        };
      };
      accounts.email = {
        maildirBasePath = cfg.mail.mailDir;
        accounts = {
          vizqq = common // {
            address = cfg.email;
            primary = true;
            flavor = "plain";
            userName = cfg.email;
            gpg = {
              key = cfg.signingKey;
              signByDefault = false;
              encryptByDefault = false;
            };
            imap = {
              host = "mail.vizqq.cc";
              port = 993;
              tls.enable = true;
            };
            smtp = {
              host = "mail.vizqq.cc";
              port = 465;
              tls.enable = true;
            };
            passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets."email_vizqq".path}";
            folders = {
              inbox = "Inbox";
              drafts = "Drafts";
              sent = "Sent Items";
              trash = "Deleted Items";
            };
            mbsync = {
              enable = true;
              create = "maildir";
              expunge = "both";
              patterns = [
                "INBOX"
                "Drafts"
                "Sent Items"
                "Deleted Items"
                "Junk Mail"
              ];
            };
          };
          vizid1337 = {
            address = "vizid1337@gmail.com";
            flavor = "gmail.com";
            userName = "vizid1337@gmail.com";
            passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets."email_vizid1337".path}";
            folders = {
              inbox = "inbox";
              drafts = "[Gmail]/Drafts";
              sent = "[Gmail]/Sent Mail";
              trash = "[Gmail]/Trash";
            };
          }
          // common;
          userjs = {
            address = "userjs@ya.ru";
            flavor = "yandex.com";
            userName = "userjs@ya.ru";
            passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets."email_userjs".path}";
            folders = {
              inbox = "Inbox";
              drafts = "Drafts";
              sent = "Sent";
              trash = "Trash";
            };
          }
          // common;
          placvoljher = {
            address = "placvoljher@gmail.com";
            flavor = "gmail.com";
            userName = "placvoljher@gmail.com";
            passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets."email_placvoljher".path}";
            folders = {
              inbox = "inbox";
              drafts = "[Gmail]/Drafts";
              sent = "[Gmail]/Sent Mail";
              trash = "[Gmail]/Trash";
            };
          }
          // common;
          vizidd = {
            address = "vizidd@gmail.com";
            flavor = "gmail.com";
            userName = "vizidd@gmail.com";
            passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets."email_vizidd".path}";
            folders = {
              inbox = "inbox";
              drafts = "[Gmail]/Drafts";
              sent = "[Gmail]/Sent Mail";
              trash = "[Gmail]/Trash";
            };
          }
          // common;
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
