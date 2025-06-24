# /etc/nixos/configuration.nix
# This is the main NixOS configuration file.
# It imports other modules for better organization.
# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, specialArgs ? {}, ... }:

let
  systemType = specialArgs.systemType or "desktop";
in {
imports =
  [
    ./system.nix
    ./users.nix
    ./packages.nix
  ]
  ++ lib.optionals (lib.elem systemType [ "nvidia" "vm" "wsl" ]) [
    ./desktop.nix
  ]
  ++ lib.optionals (systemType != "wsl") [
    ./hardware.nix
  ];

  system.stateVersion = "25.05";
}
