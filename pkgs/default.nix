{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  age-plugin-openpgp-card = pkgs.callPackage ./age-plugin-openpgp-card { };
}
