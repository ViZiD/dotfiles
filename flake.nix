{
  description = "ViZiD nixos flake configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nurpkgs.url = github:nix-community/NUR;

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-utils.url = github:gytis-ivaskevicius/flake-utils-plus;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-ext.url = "github:nix-community/nix-vscode-extensions";

  };
  outputs = { self, nixpkgs, nurpkgs, nixos-hardware, flake-utils, home-manager, ... }@inputs:
    let
      pkgs = self.pkgs.x86_64-linux.nixpkgs;
      modules = import ./modules { inherit flake-utils; };
    in
    with modules;
    flake-utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];
      channelsConfig = {
        allowUnfree = true;
        allowBroken = true;
        android_sdk.accept_license = true;
      };

      sharedOverlays = [
        self.overlay
      ];

      hostDefaults.modules = [
        home-manager.nixosModules.home-manager
        nurpkgs.nixosModules.nur
      ]
      ++ base;

      hosts.t440p.modules = [ ./hosts/t440p nixos-hardware.nixosModules.lenovo-thinkpad-t440p ]
        ++ desktop-bspwm;

      outputsBuilder = channels: with channels.nixpkgs;{
        devShell = mkShell {
          buildInputs = [ git gnumake ];
        };
      };

      overlay = import ./overlays inputs;

    };
}
