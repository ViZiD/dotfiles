{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixpkgs-master.url = "github:nixos/nixpkgs?ref=master";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    utils.url = "github:numtide/flake-utils";

    nixos-hardware.url = "github:NixOS/nixos-hardware?ref=master";

    vaultix.url = "github:milieuim/vaultix";

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
      home-manager,
      nixos-hardware,
      vaultix,
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
            home-manager.nixosModules.home-manager
            vaultix.nixosModules.default
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

      vaultix = vaultix.configure {
        nodes = self.nixosConfigurations;
        identity = self + "/secrets/identities/master.pub";
        extraRecipients = [
          "age1elc8znqzhk0tw2u35nm4wxqynkakms7d0jj68xrty2wmparwxvxqhu7xy9"
          "age1qgksmygv9aj2l907heyxlqtpyhvtecz84j52euxjrlfvtpt2h32sxt6xux"
        ];
        defaultSecretDirectory = "./secrets";
        cache = "./secrets/.cache";
      };
    }
    // utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.nur.overlays.default
          ] ++ (builtins.attrValues self.overlays);
        };
      in
      {
        packages = import ./pkgs { inherit pkgs; };
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            rage
            openpgp-card-tools
            nur.repos.vizqq.age-plugin-openpgp-card
          ];
        };
        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
