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
          identity = "${self}/secrets/identities/default.hmac";
          pubkey = "age132r4gm5v8cay0whlysvrlygjhcv7dew6sx6ursv9vx0000jvzu4qkjcahj";
        }
        {
          identity = "${self}/secrets/identities/second.hmac";
          pubkey = "age12d5ysuhhd3trx3fhw6s85crfsf5l8x3yg4hetgsj0tweawkvrurqx9fhrv";
        }
      ];
      storageMode = "local";
      localStorageDir = "${self}/secrets/rekeyed/${config.networking.hostName}";
      agePlugins = [
        pkgs.age-plugin-fido2-hmac
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
    };
  };
}
