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

        # fuck rkn
        connect-timeout = 4;
        stalled-download-timeout = 4;

        substituters = [
          "https://ncproxy.vizqq.cc"
          "https://vizqq.cachix.org"
          "https://cache.nixos.org"
          "https://mirror.yandex.ru/nixos"
          "https://cache.nixos.kz"
          "https://nixos-cache-proxy.cofob.dev"
          "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" # REF: https://github.com/dramforever/mirror-web/blob/d7e263d4fe9a9e3078f819468cec18e1c11cf832/_posts/help/2019-02-17-nix.md
        ];

        extra-trusted-substituters = [
          "https://vizqq.cachix.org"
          "https://nix-community.cachix.org"
        ];
        extra-substituters = [
          "https://cache.numtide.com"
        ];

        extra-trusted-public-keys = [
          "vizqq.cachix.org-1:5BPw8jRDFrVEuN3mTiG7mdC6Cezeid4n5KTj5xiLX/s="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
        flake-registry = "";
      };
      registry = mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      channel.enable = false;
    };
  };
}
