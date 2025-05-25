# File: ~/nixos-config/flake.nix
{
  description = "Raj's NixOS Configuration";

  inputs = {
    # Define nixpkgs input. You can choose a specific branch.
    # 'nixos-24.05' is a stable branch. Use 'nixos-unstable' for more recent packages.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    # If you plan to use home-manager in the future, you'd add it here like so:
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs"; # Ensures home-manager uses the same nixpkgs
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Define your NixOS system configuration.
    # 'r-pc' should match your system's hostname defined in system.nix
    nixosConfigurations."r-pc" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Your system architecture
      specialArgs = {
        inherit inputs; # This makes flake inputs available to your modules
        # You can add other special arguments here if needed
      };
      modules = [
        # Path to your main configuration.nix
        ./configuration.nix

        # If you were using home-manager, you would add its module here:
        # inputs.home-manager.nixosModules.default
      ];
    };

    # You can define other outputs later, such as packages, devShells, etc.
    # For example:
    # packages.x86_64-linux.my-custom-package = nixpkgs.legacyPackages.x86_64-linux.hello;
  };
}
