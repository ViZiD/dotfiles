{
  config,
  pkgs,
  lib,
  ...
}:
let
  enableGpg = true;
in
with lib;
mkIf enableGpg {
  home-manager.users.radik = {
    services.gpg-agent = rec {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
      defaultCacheTtl = 60480000;
      maxCacheTtl = 60480000;
      defaultCacheTtlSsh = defaultCacheTtl;
      maxCacheTtlSsh = maxCacheTtl;
      sshKeys = [
        "4B4E301406294B81FED02CA5DB6837BB5463F58E"
        "BA59AF6DA2E351C1EF48AAE02F5D0F71AFE4DA6A"
      ];
    };
    programs.gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
      homedir = "${config.home-manager.users.radik.xdg.dataHome}/gnupg";
      publicKeys = [
        {
          source = ./pgp.asc;
          trust = 5;
        }
      ];
    };
  };
  services = {
    pcscd.enable = true;
    udev = {
      packages = [
        pkgs.yubikey-personalization
      ];
    };
  };
  hardware.gpgSmartcards.enable = true;
}
