# /etc/nixos/configuration.nix
# This is the main NixOS configuration file.
# It imports other modules for better organization.
# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [

      # Custom modularized configurations:
      ./system.nix
      ./desktop.nix
      ./users.nix
      ./packages.nix
      ./hardware.nix

    ];

  system.stateVersion = "25.05";
}
