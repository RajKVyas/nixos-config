# /etc/nixos/configuration.nix
# This is the main NixOS configuration file.
# It imports other modules for better organization.
# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  hostType = config.specialArgs.hostType or "desktop";
in {
  imports =
    [
      ./system.nix
      ./users.nix
      ./packages.nix
    ] 
    ++ lib.optionals (hostType != "wsl") [
      ./desktop.nix
      ./hardware.nix
    ];

  system.stateVersion = "25.05";
}
