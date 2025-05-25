# /etc/nixos/users.nix
# User account definitions and user-specific packages.
{ config, pkgs, lib, ... }:

{
  users.users.raj = {
    isNormalUser = true;
    description = "R";
    extraGroups = [ "networkmanager" "wheel" "audio" ]; # Common groups for admin, network, audio
  };

  # Home Manager configuration for the user 'raj'
  home-manager.users.raj = import ../home/raj/home.nix; # Adjusted path

  # If you want Home Manager to use the system's nixpkgs, which is a good practice:
  home-manager.useGlobalPkgs = true;

  # If you want packages installed by Home Manager to be available system-wide
  # (e.g., in /etc/profiles/per-user/raj) rather than just ~/.nix-profile.
  # This can be useful for consistency and for tools that expect system-wide paths.
  home-manager.useUserPackages = true;

  # You can also pass specialArgs to your home-manager configurations if needed
  # home-manager.extraSpecialArgs = { inherit inputs; }; # 'inputs' would need to be passed to this module
  # However, specialArgs from flake.nix are already available.
}
