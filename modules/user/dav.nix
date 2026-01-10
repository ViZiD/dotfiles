{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.user;
  homeDir = config.users.users.${cfg.username}.home;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.user.dav = {
    enable = mkEnableOption "Enable dav accounts";
  };

  config = mkIf cfg.dav.enable {

    dots.shared.persist.user = mkIf (cfg.enable && isPersistEnabled) {
      directories = [
        ".local/share/contacts"
        ".local/share/calendars"
        ".local/share/vdirsyncer"
      ];
    };

    home-manager.users.${cfg.username} = mkIf cfg.enable {
      services.vdirsyncer.enable = true;
      programs = {
        khal = {
          enable = true;
          settings.default.default_calendar = "Personal Calendar (mail@vizqq.cc)";
        };
        khard = {
          enable = true;
          settings.general.default_action = "list";
        };
        vdirsyncer.enable = true;
        todoman = {
          enable = true;
          glob = "vizqq/*";
          extraConfig = ''
            default_list = "default"
            default_due = 0
          '';
        };
      };

      accounts.calendar = {
        basePath = "${homeDir}/.local/share/calendars";
        accounts.vizqq = {
          local = {
            type = "filesystem";
            fileExt = ".ics";
            path = "${homeDir}/.local/share/calendars/vizqq";
          };
          remote = {
            passwordCommand = [
              "${pkgs.coreutils}/bin/cat"
              config.sops.secrets."email_vizqq".path
            ];
            type = "caldav";
            url = "https://jmap.vizqq.cc/dav/cal/mail@vizqq.cc/default/";
            userName = cfg.email;
          };
          khal = {
            enable = true;
            type = "discover";
          };
          vdirsyncer = {
            enable = true;
            collections = [ "default" ];
            conflictResolution = null;
            metadata = [
              "color"
              "displayname"
            ];
          };
        };
      };

      accounts.contact = {
        basePath = "${homeDir}/.local/share/contacts";
        accounts.vizqq = {
          local = {
            type = "filesystem";
            fileExt = ".vcf";
            path = "${homeDir}/.local/share/contacts/vizqq";
          };
          remote = {
            passwordCommand = [
              "${pkgs.coreutils}/bin/cat"
              config.sops.secrets."email_vizqq".path
            ];
            type = "carddav";
            url = "https://jmap.vizqq.cc/dav/card/mail@vizqq.cc/default/";
            userName = cfg.email;
          };
          khard = {
            enable = true;
            type = "discover";
            glob = "*";
          };
          vdirsyncer = {
            enable = true;
            collections = [ "default" ];
            conflictResolution = null;
            metadata = [ "displayname" ];
          };
        };
      };
    };
  };
}
