{ config, pkgs, lib, ... }:

{
  imports = [
    ../../hardware-configuration.nix
  ];
  
  # Keep hardware-specific overrides minimal since we're using modules
}
