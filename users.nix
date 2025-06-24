# /etc/nixos/users.nix
# User account definitions and user-specific packages.
{ config, pkgs, lib, ... }:

{
  users.users.raj = {
    isNormalUser = true;
    description = "Raj Kumar Vyas";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "audio" 
      "video" 
      "input"  # Needed for Wayland input devices
      "render" # Needed for GPU access
    ]; 
    shell = pkgs.zsh; # Set zsh as default shell
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGku7xDIheKjNz7RYXaImOiEb+QcPR+43IgZC7dv1WF5"
    ];
    initialHashedPassword = null;
  };


}
