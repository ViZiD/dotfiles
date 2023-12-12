{ config, lib, ... }:
let
  enableGpg = true;
  gpgPkg = config.home-manager.users.radik.programs.gpg.package;
  gpgInitStr = ''
    GPG_TTY="$(tty)"
    export GPG_TTY
    ${gpgPkg}/bin/gpg-connect-agent updatestartuptty /bye > /dev/null
  '';
in
with lib;
mkIf enableGpg {
  home-manager.users.radik = {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "qt";
      defaultCacheTtl = 60;
      maxCacheTtl = 120;
      sshKeys = [
        "C7703403B4FC67BD217F364A62F025EBBFDCEB84"
        "4B4E301406294B81FED02CA5DB6837BB5463F58E"
        "90B204569E840D26B0744856E6DB5688813BAC91"
      ];
    };
    systemd.user.services.gpg-agent = {
      Service = {
        Environment = lib.mkForce [
          "GPG_TTY=/dev/tty1"
          "DISPLAY=:0"
          "GNUPGHOME=${config.home-manager.users.radik.xdg.dataHome}/gnupg"
        ];
      };
    };
    programs.gpg = {
      enable = true;
      homedir = "${config.home-manager.users.radik.xdg.dataHome}/gnupg";
    };

    programs.zsh.initExtra = gpgInitStr;
    home.sessionVariablesExtra = ''
      if [[ -z "$SSH_AUTH_SOCK" ]]; then
        export SSH_AUTH_SOCK="$(${gpgPkg}/bin/gpgconf --list-dirs agent-ssh-socket)"
      fi
    '';
  };
}
