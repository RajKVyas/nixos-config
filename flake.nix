# File: ~/nixos-config/flake.nix
{
  description = "Raj's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak?ref=v0.6.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Add NixOS-WSL input
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # Bare metal PC
      "r-pc" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          systemType = "nvidia"; # Set based on your hardware
        };
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.default
          ./hosts/r-pc

          # Home-manager configuration for the main user
          {
            home-manager.users.raj = import ./home/raj/home.nix;
          }
        ];
      };

      # Generic VM configuration
      "vm-generic" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          systemType = "vm";
        };
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.default
          ./hosts/vm-generic
          {
            home-manager.users.raj = import ./home/raj/home.nix;
          }
        ];
      };

      # WSL configuration
      "wsl" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          hostType = "wsl";
        };
        modules = [
          ./configuration.nix
          ./hosts/wsl
        ];
      };
    };

    devShells.x86_64-linux.default = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        nil
        git
        nh
        sops
      ];
    };
  };
}
