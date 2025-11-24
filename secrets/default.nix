{
  config,
  ...
}:
let
  username = config.dots.user.username;
  root = {
    owner = "root";
    group = "users";
  };
  user = {
    owner = username;
    group = "users";
  };
in
{
  vaultix = {
    secrets = {
      rootPass = {
        file = ./common/root.age;
      }
      // root;
      vpn_tcp = {
        file = ./vpn/nl4t.age;
      }
      // root;
      vpn_udp = {
        file = ./vpn/nl4u.age;
      }
      // root;
      wg_key = {
        file = ./vpn/wg_key.age;
      }
      // root;

      userPass = {
        file = ./common/user.age;
      }
      // user;
      email_vizqq = {
        file = ./email/privatemail.age;
      }
      // user;
      email_vizid1337 = {
        file = ./email/vizid1337.age;
      }
      // user;
      email_userjs = {
        file = ./email/userjs.age;
      }
      // user;
      openrouter = {
        file = ./tokens/openrouter.age;
      }
      // user;
    };
    beforeUserborn = [
      "rootPass"
      "userPass"
    ];
  };
}
