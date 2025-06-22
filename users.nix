# /etc/nixos/users.nix
# User account definitions and user-specific packages.
{ config, pkgs, lib, ... }:

{
  users.users.raj = {
    isNormalUser = true;
    description = "R";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ]; # Common groups for admin, network, audio, video
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGku7xDIheKjNz7RYXaImOiEb+QcPR+43IgZC7dv1WF5"
    ];
    hashedPasswordFile = config.sops.secrets.raj_password.path;
  };

  # Home Manager configuration for the user 'raj'

  # If you want Home Manager to use the system's nixpkgs, which is a good practice:
  home-manager.useGlobalPkgs = true;

  # If you want packages installed by Home Manager to be available system-wide
  # (e.g., in /etc/profiles/per-user/raj) rather than just ~/.nix-profile.
  # This can be useful for consistency and for tools that expect system-wide paths.
  home-manager.useUserPackages = true;

  # You can also pass specialArgs to your home-manager configurations if needed
  # home-manager.extraSpecialArgs = { inherit inputs; }; # 'inputs' would need to be passed to this module
  # However, specialArgs from flake.nix are already available.

  home-manager.backupFileExtension = "hm-bak";
}
