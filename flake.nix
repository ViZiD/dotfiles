{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixpkgs-master.url = "github:nixos/nixpkgs?ref=master";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    utils.url = "github:numtide/flake-utils";

    agenix.url = "github:yaxitech/ragenix";

    nixos-hardware.url = "github:NixOS/nixos-hardware?ref=master";

    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-ext = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    impermanence.url = "github:nix-community/impermanence";

    nur.url = "github:nix-community/NUR";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
      agenix,
      agenix-rekey,
      home-manager,
      nixos-hardware,
      ...
    }@inputs:
    let
      mkSystem =
        {
          hostname,
          system ? "x86_64-linux",
          extraArgs ? { },
          extraModules ? [ ],
          extraOverlays ? [ ],
        }:
        let
          overlays =
            [
              agenix-rekey.overlays.default
              inputs.nur.overlays.default
            ]
            ++ (builtins.attrValues self.overlays)
            ++ extraOverlays;

          pkgs = import nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./hosts/${hostname}
            ./secrets
            self.nixosModules.default
            agenix.nixosModules.default
            agenix-rekey.nixosModules.default
            home-manager.nixosModules.home-manager
          ] ++ extraModules;

          specialArgs = {
            inherit
              self
              inputs
              hostname
              ;
          } // extraArgs;
        };
    in
    {
      nixosConfigurations = {
        t440p = mkSystem {
          hostname = "t440p";
          extraModules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t440p
          ];
        };
      };

      overlays = import ./overlays {
        inherit inputs;
        inherit (self) outputs;
      };

      nixosModules.default = ./modules;

      agenix-rekey = agenix-rekey.configure {
        userFlake = self;
        nixosConfigurations = self.nixosConfigurations;
        agePackage = p: p.age;
      };
    }
    // utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            agenix-rekey.overlays.default
            inputs.nur.overlays.default
          ] ++ (builtins.attrValues self.overlays);
        };
      in
      {
        packages = import ./pkgs { inherit pkgs; };
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            age
            openpgp-card-tools
            nur.repos.vizqq.age-plugin-openpgp-card
            pkgs.agenix-rekey
          ];
        };
        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
