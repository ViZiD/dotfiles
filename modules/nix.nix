{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixVersions.stable;
    # !!!flake-utils-plus custome config!!!
    generateRegistryFromInputs = true;
    generateNixPathFromInputs = true;
    linkInputs = true;

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      cores = 2
      connect-timeout = 3
      max-jobs = 2
    '';

    settings = {
      # enable nix flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Detect files in the store that have identical contents,
      # and replace them with hard links to a single copy.
      auto-optimise-store = true;

      trusted-substituters = [
        "http://cache.nixos.org"

        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
        "https://numtide.cachix.org"

        "https://vizqq.cachix.org"
      ];

      trusted-public-keys = [
        "vizqq.cachix.org-1:ISG8APk0+grmLJkB7KgWJ6L/bmF2Uu2f8L0uJuGsKoI="

        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };

    optimise = {
      # Automatically run the nix optimiser at a specific time
      automatic = true;
      dates = [ "07:00" ];
    };
  };
}
