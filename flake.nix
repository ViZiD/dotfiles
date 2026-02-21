{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    nixpkgs-master.url = "github:nixos/nixpkgs?ref=master";

    nixpkgs-stable.url = "https://channels.nixos.org/nixos-25.05/nixexprs.tar.xz";

    utils.url = "github:numtide/flake-utils";

    nixos-hardware.url = "github:NixOS/nixos-hardware?ref=master";

    sops-nix = {
      url = "github:Mic92/sops-nix";
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

    nixcord.url = "github:kaylorben/nixcord";

    stylix.url = "github:danth/stylix";

    impermanence.url = "github:nix-community/impermanence";

    nur.url = "github:nix-community/NUR";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    llm-agents-nix.url = "github:numtide/llm-agents.nix";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
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
          overlays = [
            inputs.nur.overlays.default
          ]
          ++ (builtins.attrValues self.overlays)
          ++ extraOverlays;

          pkgs = import nixpkgs {
            inherit system overlays;
            config = {
              allowUnfree = true;
              permittedInsecurePackages = [ ];
            };
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./hosts/${hostname}
            ./secrets
            self.nixosModules.default
            home-manager.nixosModules.home-manager
          ]
          ++ extraModules;

          specialArgs = {
            inherit
              self
              inputs
              hostname
              ;
          }
          // extraArgs;
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
    }
    // utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.nur.overlays.default
          ]
          ++ (builtins.attrValues self.overlays);
        };
      in
      {
        checks.pre-commit-check = inputs.pre-commit-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style.enable = true;
            deadnix.enable = true;
          };
        };
        packages = import ./pkgs { inherit pkgs; } // pkgs.nur.repos.vizqq;

        devShells.default = pkgs.mkShell {
          inherit (self.checks.${pkgs.stdenv.hostPlatform.system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${pkgs.stdenv.hostPlatform.system}.pre-commit-check.enabledPackages;
          packages = with pkgs; [
            sops
            ssh-to-age
          ];
        };
      }
    );
}
