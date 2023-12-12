{
  nix = {
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
      experimental-features = [ "nix-command" "flakes" ];

      # Detect files in the store that have identical contents,
      # and replace them with hard links to a single copy.
      auto-optimise-store = true;

      trusted-substituters = [
        "http://cache.nixos.org"

        "https://vizqq.cachix.org"
      ];

      trusted-public-keys = [
        "vizqq.cachix.org-1:ISG8APk0+grmLJkB7KgWJ6L/bmF2Uu2f8L0uJuGsKoI="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise = {
      # Automatically run the nix optimiser at a specific time
      automatic = true;
      dates = [ "07:00" ];
    };
  };

}
