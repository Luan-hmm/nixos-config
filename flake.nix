{
  description = "Configuração NixOS com suporte a múltiplas plataformas e unstable opcional";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        unstablePkgs = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        nixosConfigurations.desktop = pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/luanhmm/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.luanhmm = import ./hosts/luanhmm/home.nix;
            }
          ];
        };
      }
    );
}

