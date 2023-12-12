{ pkgs, ... }:

let
  authorizedKeys = import ./authorized-keys.nix;
  radik = import ./radik.nix { inherit authorizedKeys; };
in
{
  users = {
    mutableUsers = true;

    defaultUserShell = pkgs.zsh;

    users = {
      root.openssh.authorizedKeys.keys = authorizedKeys;
      radik = radik;
    };
  };

  nix.settings.trusted-users = [ "root" "radik" ];

  security.sudo.wheelNeedsPassword = false;

  services.getty.autologinUser = "radik";
}
