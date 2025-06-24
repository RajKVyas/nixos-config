{ config, pkgs, lib, systemType, ... }:
{
  imports = [
    ../../hardware-configuration.nix
    ../../system.nix
    ../../hardware.nix
  ];

  # Host-specific settings
  networking.hostName = "r-pc";
  system.stateVersion = "25.05";

  # Hardware-specific settings
  hardware.bluetooth.enable = true;
  
  # Conditionally enable NVIDIA
  services.xserver.videoDrivers = lib.mkIf (systemType == "nvidia") [ "nvidia" ];
}
