{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix

    ../../modules/nixos/core.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/gnome.nix
    # We will add more here later, like hyprland.nix, nvidia.nix, etc.
  ];
  
  users.users.raj = {
    isNormalUser = true;
    description = "Raj Kumar Vyas";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      raj = import ../../modules/home-manager/raj;
    };    
  };

  networking.hostName = "raj-pc";
  system.stateVersion = "25.05";
}
