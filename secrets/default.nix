{
  config,
  inputs,
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
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      root = {
        neededForUsers = true;
      }
      // root;
      user = {
        neededForUsers = true;
      }
      // user;
      wg_key = root;
      email_vizqq = user;
      email_userjs = user;
      email_vizid1337 = user;
      perplexity = user;
      claude = user;
      openrouter = user;
    };
  };
}
