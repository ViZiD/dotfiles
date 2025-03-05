{
  self,
  config,
  pkgs,
  lib,
  ...
}:
let
  username = config.dots.user.username;
  persist = config.dots.shared.persist;
  basePath = if persist.enable then "${persist.persistRoot}/etc/ssh" else "/etc/ssh";
in
{
  dots.shared.persist.system = lib.mkIf persist.enable {
    files = [
      "/etc/ssh/id_rsa"
      "/etc/ssh/id_rsa.pub"
      "/etc/ssh/id_ed25519"
      "/etc/ssh/id_ed25519.pub"
    ];
  };
  age = {
    identityPaths = [
      "${basePath}/id_rsa"
      "${basePath}/id_ed25519"
    ];
    rekey = {
      masterIdentities = [
        {
          identity = "${self}/secrets/identities/master.pub";
          pubkey = "age1aft8jxhvmv4cunzc7gxywpd7j0wf90gk79qmha9lmg3v9zc4ypmssxhn8x";
        }
      ];
      storageMode = "local";
      localStorageDir = "${self}/secrets/rekeyed/${config.networking.hostName}";
      agePlugins = with pkgs.nur.repos.vizqq; [
        age-plugin-openpgp-card
      ];

    };
    secrets = {
      rootPass.rekeyFile = ./common/root.age;
      userPass = {
        rekeyFile = ./common/user.age;
        owner = username;
      };
      wireless = {
        rekeyFile = ./common/wireless.age;
      };
      email_vizqq = {
        rekeyFile = ./email/privatemail.age;
        owner = username;
      };
      email_vizid1337 = {
        rekeyFile = ./email/vizid1337.age;
        owner = username;
      };
      email_userjs = {
        rekeyFile = ./email/userjs.age;
        owner = username;
      };
      spotify = {
        rekeyFile = ./socials/spotify.age;
        owner = username;
      };
    };
  };
}
