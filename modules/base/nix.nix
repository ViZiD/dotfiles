{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.base.nix;
  flakeInputs = filterAttrs (_: isType "flake") inputs;
in
{
  # TODO: add extra options
  options.dots.base.nix = {
    enable = mkEnableOption "Enable base nix settings";
    autoGC = mkEnableOption "Enable auto GC";
    package = mkOption {
      type = types.package;
      default = pkgs.nixVersions.latest;
    };
  };

  config = mkIf cfg.enable {
    nix = {
      inherit (cfg) package;
      gc = {
        automatic = cfg.autoGC;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      settings = {
        warn-dirty = false; # i hate this so much...

        auto-optimise-store = true;

        substituters = [
          "https://nix-community.cachix.org"

          # my nur repos
          "https://vizqq.cachix.org"
          "https://picokeys-nix.cachix.org"

          # proxy
          "https://ncproxy.vizqq.cc"
        ];

        trusted-substituters = [
          "https://numtide.cachix.org"
          "https://vizqq.cachix.org"
          "https://picokeys-nix.cachix.org"
        ];

        trusted-public-keys = [
          "vizqq.cachix.org-1:5BPw8jRDFrVEuN3mTiG7mdC6Cezeid4n5KTj5xiLX/s="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "picokeys-nix.cachix.org-1:mJT1GjmwrXB+eiBDAsXYc3vHrwz0Wj/Vh6Do5YDvS+o="
        ];
        flake-registry = "";
      };
      registry = mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      channel.enable = false;
    };
  };
}
