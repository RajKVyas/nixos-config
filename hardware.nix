# /etc/nixos/hardware.nix
# Specific hardware configurations (e.g., NVIDIA, Bluetooth).
{ config, pkgs, lib, systemType, ... }:

{
  # --- Bluetooth ---
  hardware.bluetooth.enable = true;

  imports = [
    # Only import the nvidia module if the systemType is "nvidia"
    (lib.mkIf (systemType == "nvidia") ./nvidia.nix) 
  ];
}
