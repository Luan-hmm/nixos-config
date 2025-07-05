{
  description = "Configuração NixOS com pkgs estável + sub-árvore unstable";

  inputs = {
    nixpkgs          .url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable .url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";

    overlayUnstable = import ./overlays/unstable.nix { inherit inputs system; };

    # pkgs base = canal 25.05 + overlay
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ overlayUnstable ];
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations.desktop = pkgs.lib.nixosSystem {
      inherit system pkgs;

      modules = [
        ./hosts/luanhmm/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs     = true;
          home-manager.useUserPackages  = true;
          home-manager.users.luanhmm    = import ./hosts/luanhmm/home.nix;
        }
      ];
    };
  };
}
