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
      sshKeys = [ "4B4E301406294B81FED02CA5DB6837BB5463F58E" ];
    };
    programs.gpg = {
      enable = true;
      homedir = "${config.home-manager.users.radik.xdg.dataHome}/gnupg";
    };
  };
}
