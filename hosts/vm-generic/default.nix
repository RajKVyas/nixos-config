{ config, pkgs, lib, ... }:

{
  # VM-specific configuration
  networking.hostName = "r-vm";
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = false;

  # Generic networking
  networking.useDHCP = lib.mkDefault true;

  # Filesystem setup for VMs
  fileSystems."/" = {
    device = "/dev/vda"; # Common VM disk name
    fsType = "ext4";
  };

  # VM hardware configuration
  boot.extraModulePackages = [ ];

  # Virtualization settings
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Disable CPU microcode updates in VM
  hardware.cpu.intel.updateMicrocode = lib.mkDefault false;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault false;
}
