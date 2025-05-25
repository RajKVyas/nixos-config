# ~/nixos-config/flake.nix
{
  description = "Raj's NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; # Or nixos-unstable, or a specific revision
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05"; # Use a release matching your nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations."r-pc" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # Makes inputs available to your modules
      modules = [
        ./configuration.nix
        home-manager.nixosModules.default # Or home-manager.nixosModules.home-manager
      ];
    };
  };
}
