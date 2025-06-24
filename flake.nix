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
    };
    # Add NixOS-WSL input
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
commonModules = [
  ./configuration.nix
  inputs.home-manager.nixosModules.default
  { home-manager.users.raj = import ./home/raj/home.nix; }
  inputs.nix-flatpak.nixosModules.nix-flatpak
];
in {
    nixosConfigurations = {
      # Bare metal PC
    "r-pc" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        systemType = "nvidia"; # Set based on your hardware
      };
      modules = commonModules ++ [ ./hosts/r-pc ];
    };

      # Generic VM configuration
    "vm-generic" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        systemType = "vm";
      };
      modules = commonModules ++ [ ./hosts/vm-generic ];
    };

      # WSL configuration
    "wsl" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
specialArgs = {
  inherit inputs;
  systemType = "wsl";
  # Make nix-flatpak available to all configurations
  nix-flatpak = inputs.nix-flatpak;
};
      modules = commonModules ++ [ ./hosts/wsl ];
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
        ];
    };
  };
}
