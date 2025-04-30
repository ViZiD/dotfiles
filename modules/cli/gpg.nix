{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.cli.gpg = {
    enable = mkEnableOption "Enable gpg";
    smartCardsFeature = mkEnableOption "Enable smart card support";
    sshSupport = mkEnableOption "Enable ssh support";
    sshKeys = mkOption {
      type = types.nullOr (types.listOf types.str);
      default = null;
    };
    pinentryPackage = mkOption {
      type = types.package;
      default = pkgs.pinentry-tty;
    };
  };

  config = mkIf cfg.cli.gpg.enable {

    dots.shared.persist.user = mkIf (user.enable && isPersistEnabled) {
      directories = [
        # ".gnupg"
        {
          directory = ".gnupg";
          mode = "0700";
        }
      ];
    };

    home-manager.users.${user.username} = mkIf user.enable {
      services.gpg-agent = {
        enable = true;
        enableSshSupport = mkIf cfg.cli.gpg.sshSupport true;
        pinentry.package = cfg.cli.gpg.pinentryPackage;
        sshKeys = mkIf (cfg.cli.gpg.sshSupport) (
          [ user.signingKey ] ++ (if cfg.cli.gpg.sshKeys != null then cfg.cli.gpg.sshKeys else [ ])
        );
      };
      programs.gpg = {
        enable = true;
        scdaemonSettings = mkIf cfg.cli.gpg.smartCardsFeature {
          disable-ccid = true;
        };
        publicKeys = [
          (
            let
              keySource =
                if builtins.isPath user.trustedKey then
                  { source = user.trustedKey; }
                else
                  { text = user.trustedKey; };
            in
            keySource
            // {
              trust = 5;
            }
          )
        ];
      };
    };

    services.pcscd.enable = mkIf cfg.cli.gpg.smartCardsFeature true;
    hardware.gpgSmartcards.enable = mkIf cfg.cli.gpg.smartCardsFeature true;
  };
}
