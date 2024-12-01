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
        ];

        trusted-substituters = [
          "https://numtide.cachix.org"
          "https://vizqq.cachix.org"
        ];

        trusted-public-keys = [
          "vizqq.cachix.org-1:ISG8APk0+grmLJkB7KgWJ6L/bmF2Uu2f8L0uJuGsKoI="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        ];
        flake-registry = "";
      };
      registry = mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      channel.enable = false;
    };
  };
}
